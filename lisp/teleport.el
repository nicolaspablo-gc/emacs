;;; teleport.el --- Teleport to any displayed buffer.  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco <nicolaspablo.gc@gmail.com>
;; Keywords: convenience, frames

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; This package let you teleport to any displayed buffer, in any
;; frame, in any tab, in any window buffer.

;; By teleport we mean, to immediately navigate and possibly switch to
;; such buffer.

;;; Code:

(require 'tab-bar)

;; TODO: find a better way of doing this?
(defmacro teleport--save-current-window-configuration (&rest body)
  "Save window configuration, execute BODY, and restore it.
Used internally.  It's not recommended that BODY includes any
frame or tab switching."
  (declare (indent defun))
  `(let* ((current-window-configuration (current-window-configuration)))
     (unwind-protect
         (progn
           ,@body)
       (set-window-configuration current-window-configuration))))

(defun teleport-list-all-windows ()
  "Get a plist with all windows in all frames and tabs.

The plist has the following keywords:

:frame         The window's frame.
:frame-index   The index of the frame in the frame list.
:tab           The window's tab.
:tab-index     The index of the tab in it's frame's tab list.
:window        The window.
:window-index  The window's index in its window configuration.
:buffer        The buffer displayed in the window.
:buffers       The list of previous and next buffers displayed by the window.
"
  (teleport--save-current-window-configuration
    (let (window-list frame-index tab-index window-index)
      (setf frame-index 1)
      (dolist (frame (filtered-frame-list #'frame-visible-p))
        (setf tab-index 1)
        (dolist (tab (funcall tab-bar-tabs-function frame))
          (teleport--set-window-configuration frame tab)
          (setf window-index 1)
          (dolist (window (window-list frame))
            (when (window-live-p window)
              (select-window window :norecord)
              (push
               (list
                :frame frame
                :frame-index frame-index
                :tab tab
                :tab-index tab-index
                :window window
                :window-index window-index
                :buffer (current-buffer)
                :buffers (teleport--get-window-buffers window))
               window-list))
            (setf window-index (1+ window-index)))
          (setf tab-index (1+ tab-index)))
        (setf frame-index (1+ frame-index)))
      window-list)))

(defun teleport--set-window-configuration (frame tab)
  "Set window configuration to that of FRAME's TAB."
  (set-window-configuration
   (teleport--get-window-configuration frame tab)
   :dont-set-frame
   :dont-set-miniwindow))

(defun teleport--get-window-configuration (frame tab)
  "Get window configuration of FRAME's TAB."
  (if (eq (car tab) 'current-tab)
      (current-window-configuration frame)
    (alist-get 'wc tab)))

(defun teleport--get-window-buffers (window)
  "Get the list of window buffers of WINDOW."
  (mapcar
   (lambda (buffer-or-list)
     (if (bufferp buffer-or-list) buffer-or-list (car buffer-or-list)))
   (append
    (list (window-buffer window))
    (window-prev-buffers window)
    (window-next-buffers window))))

(defun teleport-list-all-windows-buffers ()
  "Get a plist of all the windows's buffers in all frames and tabs.

The plist has the same keywords as the plist returned by
`teleport-list-all-windows'.  See the documentation of that
function for more information."
  (let (window-buffer-list)
    (dolist (window-setting (teleport-list-all-windows))
      (dolist (window-buffer (plist-get window-setting :buffers))
        (push  `( :buffer ,window-buffer
                 ,@window-setting)
               window-buffer-list)))
    window-buffer-list))

(defvar teleport-list-windows-function #'teleport-list-all-windows
  "Function used by `teleport-read-buffer' to get a window list.

The function should return a plist like that of
`teleport-list-all-windows', having at least the keyword
elements `:frame', `:frame-index', `:tab', `:tab-index',
`:window', `:window-index' and `:buffer'.")

(defun teleport--make-completion-table ()
  (mapcar
   (lambda (window-setting)
     (cons (teleport-format-window-name window-setting)
           window-setting))
   (funcall teleport-list-windows-function)))

(defvar teleport--read-window-history-list '())

(defun teleport-read-window (prompt &optional predicate)
  "Read a window with PROMPT.

TODO: Improve next paragraph.

PREDICATE is a boolean function used to narrow the list of possible
completions.  PREDICATE recevies an frame-tab-window element, the
same type of the list returned by
`teleport-list-all-windows'.
"
  (interactive)
  (let* ((alist (teleport--make-completion-table))
         (first-element (cdar alist))
         ;; (completion-extra-properties
         ;;  (list
         ;;   :annotation-function
         ;;   (teleport--build-anotation-function alist)))
         (window-name
          (completing-read
           prompt
           alist
           predicate
           :require-match
           nil ; initial input
           teleport--read-window-history-list
           nil ; default value on empty input
           :inherit-input-method)))
    (alist-get window-name alist nil nil #'string=)))

(defun teleport-format-window-name (full-window-setting)
  "Return the window's display name."
  (let ((buffer (plist-get full-window-setting :buffer))
        (window-index (plist-get full-window-setting :window-index))
        (tab (plist-get full-window-setting :tab))
        (tab-index (plist-get full-window-setting :tab-index))
        (frame (plist-get full-window-setting :frame))
        (frame-index (plist-get full-window-setting :frame-index)))
    (format
     "%s <F%s%s/T%s%s/W%s>"
     (buffer-name buffer)
     frame-index
     (if (frame-parameter frame 'explicit-name)
         (format ":%s" (frame-parameter frame 'name))
       "")
     tab-index
     (if (alist-get 'explicit-name tab)
         (format ":%s" (alist-get 'name tab))
       "")
     window-index)))

;;;###autoload
(defun teleport-switch-to-window (window-setting)
  "Switch to any window in any frame and tab."
  (interactive (list (teleport-read-window "Select Window: ")))
  (select-frame-set-input-focus (plist-get window-setting :frame))
  (tab-bar-select-tab (plist-get window-setting :tab-index))
  (select-window (plist-get window-setting :window)))

;;;###autoload
(defun teleport-switch-to-window-buffer (window-setting)
  "Switch to any window's buffer in any frame and tab.
Each window's buffer list are the same of those returned by
`window-prev-buffers' and `window-next-buffers'."
  (interactive
   (let ((teleport-list-windows-function
          #'teleport-list-all-windows-buffers))
     (list (teleport-read-window "Select Window Buffer: "))))
  (teleport-switch-to-window window-setting)
  (switch-to-buffer (plist-get window-setting :buffer)))

(provide 'teleport)
;;; teleport.el ends here
