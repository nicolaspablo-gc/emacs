;;; my-x-isearch.el --- Isearch extensions.          -*- lexical-binding: t; -*-

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

(defun my-x-isearch-change-direction ()
  "Change isearch direction."
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-backward #'isearch-repeat-forward)))

(defun my-x-isearch-repeat-direction ()
  "Repeat same isearch direction."
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-forward #'isearch-repeat-backward)))

(defun my-x-isearch-with-active-mark (&optional search-backward)
  "Activate mark and do isearch."
  (interactive "P")
  (when (not (region-active-p))
    (push-mark)
    (activate-mark))
  (let (this-command) ;; Don't let the call to isearch mutate `this-command'.
    (funcall (if search-backward #'isearch-backward #'isearch-forward)))
  (unless isearch-success (deactivate-mark)))

(defun my-x-isearch-copy-as-kill (&optional search-backward do-kill)
  "Copy region between isearch start and end position."
  (interactive "P")
  (my-x-isearch-with-active-mark search-backward)
  (when isearch-success
    (copy-region-as-kill (region-beginning) (region-end))))

(defun my-x-isearch-delete-region (&optional search-backward)
  "Use isearch to delete the selected region."
  (interactive "P")
  (my-x-isearch-with-active-mark search-backward)
  (when isearch-success
    (delete-region (region-beginning) (region-end))))()

(provide 'my-x-isearch)
;;; my-x-isearch.el ends here
