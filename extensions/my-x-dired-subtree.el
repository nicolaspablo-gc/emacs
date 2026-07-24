;;; my-x-dired-subtree.el --- My `dired-subtree' extensions.  -*- lexical-binding: t; -*-

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

(require 'ui-simple-theme)

(defface my-x-dired-subtree-line-prefix-face
  `((((type graphic) (background light)) :background ,ui-simple-light-border-bg)
    (((type graphic) (background dark)) :background ,ui-simple-dark-border-bg)
    (((type tty) (background dark)) :background "blue")
    (t :background "brightwhite"))
  "Face for prefixing dired subtree lines.")

(provide 'my-x-dired-subtree)
;;; my-x-dired-subtree.el ends here
