;;; editing.el --- Editing commands.                 -*- lexical-binding: t; -*-

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

(require 'exclusive-modes)
(require 'simple)
(require 'helpers)
(require 'isearch)

;;;; Isearch

(defun editing-isearch-change-direction ()
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-backward #'isearch-repeat-forward)))

(defun editing-isearch-repeat-direction ()
  (interactive)
  (call-interactively
   (if isearch-forward #'isearch-repeat-forward #'isearch-repeat-backward)))


;;;; Modes

(defvar editing-insert-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (vector (cons ?\s (max-char))) #'self-insert-command)
    (define-key map (kbd "DEL") #'delete-backward-char)
    (define-key map (kbd "RET") #'newline)
    (define-key map (kbd "TAB") #'indent-for-tab-command)
    map)
  "Map for `editing-insert-mode'.")

(defun editing-insert-mode-off ()
  (editing-insert-mode -1))

(define-minor-mode editing-insert-mode
  "Keys iinsert text."
  :keymap editing-insert-mode-map
  :lighter " <INSERT>")

(defvar-keymap editing-mark-mode-map
  :doc "Keymap for editing mark mode."
  :suppress t
  "a" #'beginning-of-line
  "e" #'end-of-line
  "n" #'next-line
  "p" #'previous-line
  "f" #'forward-char
  "b" #'backward-char
  "s" #'isearch-forward
  "r" #'isearch-backward
  "d" #'delete-region
  "k" #'kill-region
  "w" #'kill-ring-save
  "t" #'transpose-regions
  "." #'set-mark-command
  "RET" #'editing-mark-mode)

(defun editing-mark-mode--deactivate-mark-hook ()
  (editing-mark-mode -1)
  (remove-hook 'deactivate-mark-hook #'editing-mark-mode--deactivate-mark-hook))

(define-minor-mode editing-mark-mode
  "Minor mode for mark commands."
  :keymap editing-mark-mode-map
  :lighter " <MARK>"
  (if editing-mark-mode
      (progn
	(push-mark)
	(add-hook 'deactivate-mark-hook #'editing-mark-mode--deactivate-mark-hook)
	(activate-mark))
    (deactivate-mark)))

(defvar-keymap editing-sexp-mode-map
  :doc "Keymap for sexp editing."
  "f" #'forward-sexp
  "b" #'backward-sexp
  "u" #'backward-up-list
  "d" #'down-list
  "z" (command (backward-up-list) (forward-sexp))
  "k" #'kill-sexp
  "t" #'transpose-sexps
  "p" #'delete-pair
  "RET" #'editing-sexp-mode)

(define-minor-mode editing-sexp-mode
  "Mode for sexp commands."
  :lighter " <SEXP>"
  :keymap editing-sexp-mode-map)

(exclusive-modes-define editing editing-sexp-mode editing-insert-mode editing-mark-mode)

(provide 'editing)
;;; editing.el ends here
