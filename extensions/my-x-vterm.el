;;; my-x-vterm.el --- My `vterm' extensions.         -*- lexical-binding: t; -*-

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

(defun my-x-vterm-rename (ps1-string)
  "Rename current buffer by ps1 string sent through vterm."
  (when (eq major-mode #'vterm-mode)
    (rename-buffer (format "*vterm:%s*" ps1-string) :unique)))

(provide 'my-x-vterm)
;;; my-x-vterm.el ends here
