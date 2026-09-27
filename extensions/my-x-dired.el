;;; my-x-dired.el --- My dired extensions.           -*- lexical-binding: t; -*-

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

(defvar my-x-dired-external-files-regexp "\\.\\(?:png\\|jpe?g\\)\\'"
  "Regexp for files that should be opened with an external program.")

(defun my-x-dired-find-file ()
  "Do `find-file' with awareness of current dired line."
  (interactive)
  (let ((default-directory (dired-current-directory)))
    (call-interactively #'find-file)))

(defun my-x-dired-open-dwim ()
  "Open current file, either normally or with an external program."
  (interactive)
  (call-interactively
   (if (string-match-p my-x-dired-external-files-regexp
                       (dired-get-file-for-visit))
       #'dired-do-open
     #'dired-find-file)))

(defun my-x-dired-do-find-all-files ()
  "Find all marked files in dired."
  (interactive)
  (seq-do (lambda (f) (find-file f))
          (nreverse (dired-get-marked-files))))


(provide 'my-x-dired)
;;; my-x-dired.el ends here
