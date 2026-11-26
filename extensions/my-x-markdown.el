;;; my-x-markdown.el --- My `markdown' extensions.  -*- lexical-binding: t; -*-

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

(defmacro my-x-markdown--with-widen (&rest body)
  "Widen the buffer under execution of BODY and restore narrowing."
  `(let ((narrowed (buffer-narrowed-p)))
     (when narrowed (widen))
     ,@body
     (when narrowed
       ;; fine enough for my use case
       (markdown-narrow-to-subtree))))

(defun my-x-markdown-outline-next ()
  "Like `markdown-outline-next', but working in narrowed buffers."
  (interactive)
  (my-x-markdown--with-widen (call-interactively #'markdown-outline-next)))

(defun my-x-markdown-outline-previous ()
  "Like `markdown-outline-previous', but working in narrowed buffers."
  (interactive)
  (my-x-markdown--with-widen (call-interactively #'markdown-outline-previous)))

(provide 'my-x-markdown)
;;; my-x-markdown.el ends here
