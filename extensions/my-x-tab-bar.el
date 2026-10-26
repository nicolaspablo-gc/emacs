;;; my-x-tab-bar.el --- My `tab-bar' extensions.     -*- lexical-binding: t; -*-

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

(defun my-x-tab-bar-kill-buffer-and-tab ()
  "Kill current buffer and current tab."
  (interactive)
  (kill-current-buffer)
  (tab-close))

(defun my-x-tab-bar-toggle ()
  "Toggle `tab-bar-mode' and hide it."
  (interactive)
  (let ((active tab-bar-mode))
    (tab-bar-mode (if active -1 1))
    (setopt tab-bar-show (not active))))

(defun my-x-tab-bar-current-tab-name ()
  "Get the name of the current tab."
  (cdr (assoc 'name (tab-bar--current-tab))))

(provide 'my-x-tab-bar)
;;; my-x-tab-bar.el ends here
