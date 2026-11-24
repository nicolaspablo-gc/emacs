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

(defvar my-x-dired-external-files-regexp nil
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
   (if (and my-x-dired-external-files-regexp
            (string-match-p my-x-dired-external-files-regexp
                            (dired-get-file-for-visit)))
       #'dired-do-open
     #'dired-find-file)))

(defun my-x-dired-do-find-all-files ()
  "Find all marked files in dired."
  (interactive)
  (seq-do (lambda (f) (find-file f))
          (nreverse (dired-get-marked-files))))

(defmacro my-x-dired--define-filter-from-marking-command (name docstring marking-command)
  "Define a dired filter command based on MARKING-COMMAND.

NAME is the name of the command.
DOCSTRING is the docstring of the command.
MARKING-COMMAND is a command that should mark dired lines."
  (declare (indent defun) (doc-string 2))
  `(defun ,name ()
     ,docstring
     (interactive)
     (call-interactively ,marking-command)
     (dired-toggle-marks)
     (dired-do-kill-lines)))

(my-x-dired--define-filter-from-marking-command my-x-dired-filter-by-extension
  "Filter to dired lines matching extension."
  #'dired-mark-extension)

(my-x-dired--define-filter-from-marking-command my-x-dired-filter-by-regexp
  "Filter to dired lines matching regexp."
  #'dired-mark-files-regexp)

(defvar my-x-dired-filter-map
  (define-keymap
    "." #'my-x-dired-filter-by-extension
    "/" #'my-x-dired-filter-by-regexp)
  "Keymap for `my-x-dired' filter commands.")


(provide 'my-x-dired)
;;; my-x-dired.el ends here
