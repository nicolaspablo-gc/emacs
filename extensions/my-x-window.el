;;; my-x-window.el --- My `window' extensions.       -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolas Pablo Gonzalez Carrasco

;; Author: Nicolas Pablo Gonzalez Carrasco <nico@laptop-nico>
;; Keywords:

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

;;

;;; Code:

(defun my-x-window-other-backward-window (count &optional all-frames interactive)
  "Like `other-window', but going in opposite direction."
  (interactive "p\ni\np")
  (other-window (- count)))

(defun my-x-window-quit-dwim ()
  "Try quitting in succession buffer, window, tab or frame."
  (interactive)
  (let ((function
         (cond
          ;; More than one buffer to close for this window?
          ((> (length
               ;; ensure the list always include the current buffer as
               ;; `window-prev-buffers' sometimes have it and sometimes don't.
               (delete-dups (cons (current-buffer)
                                  (mapcar #'car (window-prev-buffers)))))
              1)
           #'bury-buffer)
          ;; More than one window to close? (window has a parent)
          ((window-parent (selected-window))
           #'delete-window)
          ;; More than one tab to close?
          ((> (length (funcall tab-bar-tabs-function)) 1)
           #'tab-bar-close-tab)
          ;; More than one frame to close?
          ((> (length (visible-frame-list)) 1)
           #'delete-frame)
          (t
           (user-error "Nothing else to quit.")))))
    (message "%s" function)
    (call-interactively function)))

(defun my-x-window--move-buffer-direction (direction &optional select-new-window)
  "Move the current buffer into a new window in DIRECTION.
If SELECT-WINDOW is no nil, also select the new window."
  (unless (seq-contains-p '(right below) direction)
    (error "Invalid direction: `%s'" direction))
  (let (new-win)
    (save-selected-window
      (setq new-win
            (pcase direction
              ('right (split-window-right))
              ('below (split-window-below)))))
    (bury-buffer)
    (when select-new-window
      (select-window new-win))))

(defun my-x-window-move-buffer-right (&optional select-new-window)
  "Move the current buffer into a new window to the right.
If SELECT-WINDOW is no nil, also select the new window."
  (interactive "P")
  (my-x-window--move-buffer-direction 'right select-new-window))

(defun my-x-window-move-buffer-below (&optional select-new-window)
  "Move the current buffer into a new window below.
If SELECT-WINDOW is no nil, also select the new window."
  (interactive "P")
  (my-x-window--move-buffer-direction 'below select-new-window))

(provide 'my-x-window)
;;; my-x-window.el ends here
