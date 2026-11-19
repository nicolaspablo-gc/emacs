;;; my-x-magit-delta.el --- My `magit-delta' extensions.  -*- lexical-binding: t; -*-

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


(defun my-x-magit-delta-add-features (args)
  (append args
          (list "--features"
                (if (eq (frame-parameter nil 'background-mode) 'dark)
                    "modus-vivendi" "modus-operandi"))))

(provide 'my-x-magit-delta)
;;; my-x-magit-delta.el ends here
