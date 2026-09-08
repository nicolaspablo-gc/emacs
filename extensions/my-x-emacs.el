;;; my-x-emacs.el --- My emacs extensions.           -*- lexical-binding: t; -*-

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

(defvar my-x-emacs-mode-line-modes
  (seq-filter
   (lambda (elt)
     (or (not (stringp elt))
         (seq-every-p
          (lambda (paren) (not (string= elt paren)))
          (list "(" ")"))))
   mode-line-modes)
  "Mode line construct for active modes display.
Its made by taking `mode-line-modes' and removing the parenthesis.")
(put 'my-x-emacs-mode-line-modes 'risky-local-variable t)

(defvar my-x-emacs-mode-line-mule-info
  `(""
    (3
     (current-input-method
      (:propertize ("" current-input-method-title)
                   help-echo (concat
                              ,(purecopy "Current input method: ")
                              current-input-method
                              ,(purecopy "\n\
mouse-2: Disable input method\n\
mouse-3: Describe current input method"))
                   local-map ,mode-line-input-method-map
                   mouse-face mode-line-highlight)))
    ,(propertize
      "%z"
      'help-echo 'mode-line-mule-info-help-echo
      'mouse-face 'mode-line-highlight
      'local-map mode-line-coding-system-map)
    (:eval (mode-line-eol-desc)))
  "Like `mode-line-mule-info' but with fixed space for input method.")
(put 'my-x-emacs-mode-line-mule-info 'risky-local-variable t)

(defun my-x-emacs-truncate-lines ()
  "Sets `truncate-lines' to `t'."
  (setq truncate-lines t))

(defun my-x-emacs-set-header-line-as-buffer-name ()
  "Sets `header-line-format' to display the buffer name."
  (setq header-line-format '" %b"))

(defun my-x-emacs-copy-current-file-name ()
  "Copies current file name to kill ring."
  (interactive)
  (kill-new (message "%s" (or (buffer-file-name)
                              default-directory))))

(defun my-x-emacs-toggle-cursor ()
  "Toggles cursor visibility."
  (interactive)
  (setq cursor-type (not cursor-type)))

(provide 'my-x-emacs)
;;; my-x-emacs.el ends here
