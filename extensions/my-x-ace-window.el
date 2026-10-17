;;; my-x-ace-window.el --- My `ace-window' extensions.  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolas Pablo Gonzalez Carrasco

;; Author: Nicolas Pablo Gonzalez Carrasco <nico@asus-zenbook-13>
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

(require 'my-x-window)

(defmacro my-x-ace--with-ace-window (&rest forms)
  "Execute FORMS within an ace selected window."
  `(save-selected-window
     (with-selected-window (ace-select-window)
       ,@forms)))

(defun my-x-ace-window-fit-to-buffer ()
  "`fit-window-to-buffer' trough `ace-window'ing."
  (interactive)
  (my-x-ace--with-ace-window (fit-window-to-buffer)))

(defun my-x-ace-window-fit-to-fill-column ()
  "Use ace to set the size of a window to its buffer's fill column."
  (interactive)
  (my-x-ace--with-ace-window (my-x-window-fit-to-fill-column)))

(defun my-x-ace-window-set-dedicated ()
  "Use ace to set a window dedicated."
  (interactive)
  (my-x-ace--with-ace-window (toggle-window-dedicated)))


(provide 'my-x-ace-window)
;;; my-x-ace-window.el ends here
