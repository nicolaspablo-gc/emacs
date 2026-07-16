;;; editing.el --- Editing commands.                 -*- lexical-binding: t; -*-

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

;;

;;; Code:

(require 'isearch)

(defun editing-isearch-change-direction ()
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-backward #'isearch-repeat-forward)))

(defun editing-isearch-repeat-direction ()
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-forward #'isearch-repeat-backward)))

(provide 'editing)
;;; editing.el ends here
