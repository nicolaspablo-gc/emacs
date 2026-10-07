;;; my-x-org.el --- My `org' extensions.             -*- lexical-binding: t; -*-

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

(defun my-x-org-ensure-two-lines-before-heading ()
  "Ensure at least 2 empty lines are before the org heading."
  (interactive)
  (save-excursion
    (if (org-at-heading-p)
        (beginning-of-line)
      (org-previous-visible-heading 1))
    (unless (= (point) (point-min))
      (let (start
            (end (point))
            (before (char-before)))
        (while (eq before ?\n)
          (backward-char)
          (setq start (point)
                before (char-before)))
        (when start
          (delete-region start end)
          (insert "\n\n\n"))))))

(defun my-x-org-goto-today-now ()
  (interactive)
  (org-agenda-list)
  (org-agenda-redo)
  (org-agenda-goto-today)
  (search-forward "← now"))

(provide 'my-x-org)
;;; my-x-org.el ends here
