;;; my-x-sh-script.el --- My `sh-script' extensions.  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolas Pablo Gonzalez Carrasco

;; Author: Nicolas Pablo Gonzalez Carrasco <nico@localhost.localdomain>
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

(defun my-x-sh-send-region (start end)
  "Send a region to the shell process."
  (interactive "r")
  (let* ((process (sh-shell-process t))
         (text (buffer-substring-no-properties start end)))
    (save-window-excursion
      ;; Probably a HACK?  We need to select the window so the comint
      ;; buffer scrolls to the bottom.
      (with-selected-window
          (get-buffer-window (pop-to-buffer (process-buffer process)))
        (goto-char (process-mark process))
        (insert (string-trim text "[ \n]+"))
        (comint-send-input)))))

(defun my-x-sh-send-line-or-region ()
  "Send a region or a line to the shell process."
  (interactive)
  (let ((use-region (use-region-p)))
    (my-x-sh-send-region (if use-region (region-beginning) (line-beginning-position))
                         (if use-region (region-end) (line-end-position)))))

(defun my-x-sh-send-paragraph ()
  "Send current paragraph to the shell process."
  (interactive)
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'paragraph)))
    (when bounds
      (my-x-sh-send-region (car bounds) (cdr bounds)))))

(provide 'my-x-sh-script)
;;; my-x-sh-script.el ends here
