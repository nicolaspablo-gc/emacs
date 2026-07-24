;;; my-x-lisp.el --- My `lisp' extensions.           -*- lexical-binding: t; -*-

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

(defun my-x-lisp-forward-up-list ()
  "Like `backward-up-list' but going forward."
  (interactive)
  ;; Hacky implementation
  (let ((start (point)))
    (with-demoted-errors "%s"
      (call-interactively #'backward-up-list))
    ;; Heuristic: if point moved, we upped list, thus need to move to end.
    (when (/= start (point))
      (forward-sexp))))

(provide 'my-x-lisp)
;;; my-x-lisp.el ends here
