;;; convenience.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco <nicolaspablo.gc@gmail.com>
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

;; Convinience commands and functions.

;;; Code:

(require 'window)
(require 'frame)
(require 'dired)

;;;###autoload
(defun set-frame-alpha-background (alpha &optional frame)
  (interactive "nAlpha Background: ")
  (set-frame-parameter frame 'alpha-background alpha))

;;;###autoload
(defun other-side-window-prefix (side &optional slot dedicated)
 "Display following command buffer in a side window.\n
SIDE is either \\+`top', \\+`bottom', \\+`left' or \\+`right'.\n
SLOT is a number.  If 0, the window is displayed toward the
center.  If negative, its displayed before other side windows,
and if positive is displayed after other side windows.\n
DEDICATED indicates this is a dedicated window to the buffer.\n
For more info see Info node `(elisp)Side Windows'\n
Interactively, with a prefix argument read a number for SLOT.
Interactively, with two prefix arguments mark the window as dedicated."
 (interactive
  (list (read (completing-read "Side: " '("top" "bottom" "left" "right") nil t))
        (if (>= (prefix-numeric-value current-prefix-arg) 4)
          (read-number "Slot (0->at the middle, negative->before others, positive->after others): " 0)
         0)
        (when (>= (prefix-numeric-value current-prefix-arg) 16) t)))
 (display-buffer-override-next-command
  `(lambda (buffer alist)
    (cons (display-buffer-in-side-window
           buffer
           (append '((side . ,side)
                     (slot . ,slot)
                     (dedicate . ,dedicated))
                   alist))
          'window))
  nil
  "[other-side-window]")
 (message "Display next command buffer in a %s side window..." side))

;;;###autoload
(defun dired-side-window-dwim ()
  "Display dired in a side window.
Defaults to project root, else the current directory."
  (interactive)
  (let ((current-dired-window
         (let ((current-default-directory default-directory))
           (car-safe
            (seq-filter
             (lambda (win)
               (with-current-buffer (window-buffer win)
                 (and (eq major-mode #'dired-mode)
                      (or
                       (string= default-directory
                                (and (project-current)
                                     (project-root (project-current))))
                       (string= default-directory
                                current-default-directory)))))
             (window-list))))))
    (if current-dired-window
        (with-selected-window current-dired-window
          (bury-buffer))
      (progn
        (other-side-window-prefix 'left)
        (dired (or (and (project-current)
                        (project-root (project-current)))
                   default-directory))
        (dired-hide-details-mode)))))


(provide 'convenience)
;;; convenience.el ends here
