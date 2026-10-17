;;; my-x-rect.el --- My `rect' extensions.           -*- lexical-binding: t; -*-

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

(defun my-x-rect-string-rectangle ()
  "Call `string-rectangle' but empty string doesn't insert a default.
This allows for string-rectangle to delete text when you pass an empty
string."
  (interactive)
  (let ((string-rectangle-history '("")))
    (call-interactively #'string-rectangle)))

(provide 'my-x-rect)
;;; my-x-rect.el ends here
