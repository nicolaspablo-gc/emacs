;;; my-x-hi-lock.el --- My `hi-lock' extensions.     -*- lexical-binding: t; -*-

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

(defun my-x-hi-lock-highlight-regexps (regexp-face-alist)
  "Highlight regexes in REGEXP-FACE-ALIST.
REGEXP-FACE-ALIST is an alist whose cars are regexps and cadrs are faces."
  (dolist (regexp-face regexp-face-alist)
    (let ((regexp (car regexp-face))
          (face  (cdr regexp-face)))
      (unhighlight-regexp regexp)
      (highlight-regexp regexp face))))

(provide 'my-x-hi-lock)
;;; my-x-hi-lock.el ends here
