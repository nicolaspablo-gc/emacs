;;; my-x-files.el --- My `files' extensions.         -*- lexical-binding: t; -*-

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

(require 'ffap)

(defun my-x-files-copy-file-name (file)
  (interactive (list (read-file-name "File: " nil nil nil (ffap-file-at-point))))
  (kill-new (message "%s" (expand-file-name file))))

(provide 'my-x-files)
;;; my-x-files.el ends here
