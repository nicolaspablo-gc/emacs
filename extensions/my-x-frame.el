;;; my-x-frame.el --- My `frame' extensions.         -*- lexical-binding: t; -*-

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

(defun my-x-frame-set-frame-alpha-background (alpha)
  "Set current frame's  \\=`alpha' parameter."
  (interactive "nAlpha Background: ")
  (set-frame-parameter nil 'alpha-background alpha))

(defun my-x-toggle-frame-undecorated (&optional frame)
  "Toggle frame's \\=`undecorated' parameter."
  (interactive)
  (let* ((frame (or frame (selected-frame)))
         (status (frame-parameter frame 'undecorated)))
    (set-frame-parameter frame 'undecorated (not status))))

(provide 'my-x-frame)
;;; my-x-frame.el ends here
