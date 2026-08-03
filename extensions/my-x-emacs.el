;;; my-x-emacs.el --- My emacs extensions.           -*- lexical-binding: t; -*-

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

(defvar my-x-emacs-mode-line-modes
  (seq-filter
   (lambda (elt)
     (or (not (stringp elt))
         (seq-every-p
          (lambda (paren) (not (string= elt paren)))
          (list "(" ")"))))
   mode-line-modes)
  "Mode line construct for active modes display.
Its made by taking `mode-line-modes' and removing the parenthesis.")
(put 'my-x-emacs-mode-line-modes 'risky-local-variable t)

(defun my-x-emacs-set-header-line-as-buffer-name ()
  "Sets `header-line-format' to display the buffer name."
  (setq header-line-format '" %b"))

(provide 'my-x-emacs)
;;; my-x-emacs.el ends here
