;;; org-diary.el --- `org' derived mode scoped to writting diaries.  -*- lexical-binding: t; -*-

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

(defun org-diary--insert-heading-hook ()
  "After inserting a header, insert immediately a timestamp."
  (org-insert-time-stamp nil :with-hm :inactive nil "\n\n"))

;;;###autoload
(define-derived-mode org-diary-mode org-mode "Org Diary"
  "`org-mode' variant for scopped to writting diaries."
  (add-hook 'org-insert-heading-hook #'org-diary--insert-heading-hook nil :local))

(provide 'org-diary)
;;; org-diary.el ends here
