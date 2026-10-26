;;; my-x-echo-bar.el --- My `echo-bar' extensions.   -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nico

;; Author: Nico <nico@thinkpad-nico>
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

(defun my-x-echo-bar-fill-minibuf-0 (&rest _)
  "Keep ` *Minibuf-0*' non-empty so Emacs draws echo-bar's overlay.
This is a workaround, because emacs won't draw the echo area when the
minibuffer 0 is empty."
  (with-current-buffer (get-buffer-create " *Minibuf-0*")
    (when (= (point-min) (point-max))
      (let ((inhibit-read-only t))
        (insert " ")))))

(provide 'my-x-echo-bar)
;;; my-x-echo-bar.el ends here
