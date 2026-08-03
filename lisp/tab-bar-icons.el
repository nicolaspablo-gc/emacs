;;; tab-bar-icons.el --- Icon format for `tab-bar'   -*- lexical-binding: t; -*-

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

(defvar tab-bar-icons-default "🗂️"
  "Default icon for tabs that don't match in `tab-bar-icons-alist'.")

(defvar tab-bar-icons-alist '()
  "Alist of names and icons for displaying in tab bar.")

(defvar tab-bar-icons-name-size 20
  "Size for the current tab name.")

(defun tab-bar-icons--format-current-tab-name (tab n)
  "Format the current tab TAB's indexed by N."
  (truncate-string-to-width
   (format
    (concat "%2i %-" (number-to-string tab-bar-icons-name-size) "s ")
    n
    (alist-get 'name tab))
   tab-bar-icons-name-size
   nil
   " "))

(defun tab-bar-icons--tab-icon-format-function (tab n)
  "Format one tab's icon."
  (propertize
   (format " %s " (alist-get (alist-get 'name tab)
                           tab-bar-icons-alist
                           tab-bar-icons-default
                           nil
                           #'string-match-p))
   'face
   (funcall tab-bar-tab-face-function tab)))

(defun tab-bar-icons-format-tabs ()
  "Construct for formatting current tab name followed by all tab icons.
Meant to be placed near the start of `tab-bar-format'."
  (let (name tabs (i 0))
    (dolist (tab (funcall tab-bar-tabs-function))
      (setq i (1+ i))
      (push (tab-bar-icons--tab-icon-format-function tab i) tabs)
      (when (eq (car tab) 'current-tab)
        (setq name (tab-bar-icons--format-current-tab-name tab i))))
    (format "%s %s" name (string-join (nreverse tabs) " "))))

(provide 'tab-bar-icons)
;;; tab-bar-icons.el ends here
