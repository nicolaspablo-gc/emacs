;;; exclusive-modes.el --- Minor modes that are mutually exclusive.  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco <nicolaspablo.gc@gmail.com>
;; Keywords: lisp

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

;; This package provides the macro `exclusive-modes-define', which allows you
;; to easily define a set of mutually exclusive minor modes: on every
;; exclusive mode activation, it ensures the rest are deactivated, so only one
;; of the exclusive modes is active at a time.

;; For more details, see the documentation of the macro.

;;; Code:

(defun exclusive-modes--activates-p (mode arg called-interactively-p)
  "Determine whether ARG would activate the minor-mode MODE.
MODE is the symbol of the mode, ARG is the value passed when activating
MODE, and CALLED-INTERACTIVELY-P is non-nil if MODE was called
interactively."
  ;; minor mode activation convention:
  ;; - (numberp arg): enable if > 0, disable if <= 0
  ;; - 'toggle or interactive call: enable iff mode is currently off
  ;; - everything else (including nil): enable
  (or
   ;; number case
   (and (numberp arg) (> arg 0))
   ;; toggle case
   (if (or called-interactively-p (eq arg 'toggle))
       ;; toggle would only activate if mode is off
       (null (symbol-value mode))
     ;; rest = activate
     t)))

(defun exclusive-modes--make-ensurer (mode modes)
  "Make a function that ensures only MODE of MODES is active.
MODE is the mode symbol, and MODES is the symbol that has the list of exclusive
modes."
  (lambda (&optional arg)
    (when (exclusive-modes--activates-p mode arg (called-interactively-p 'any))
      (dolist (other (symbol-value modes))
        (unless (eq other mode)
          (when (symbol-value other)
            (funcall other -1)))))))

(defun exclusive-modes--ensurer-symbol (package mode)
  "Return the symbol of the ensurer function generated for PACKAGE and MODE.
PACKAGE is the symbol of the package defining the minor mode, and MODE
is the mode symbol."
  (intern
   (format
    "%s--exclusive-mode-ensure-%s" (symbol-name package) (symbol-name mode))))

(defmacro exclusive-modes-define (package &rest modes)
  "Create machinery to manage exclusive minor modes in PACKAGE.

Optionally pass MODES, a list of mode symbols, to immediately register
them as exclusive.

This macro creates the following symbols:

- \\=`PACKAGE--exclusive-modes', a variable which is registry of
  exclusive mode symbols.

- \\=`PACKAGE--exclusive-mode-add' a function for adding a mode to the
  registry.

- \\=`PACKAGE--exclusive-mode-remove' a function for removing a mode
  from the registry.

- For each exclusive mode MODE, a \\=`PACKAGE--exclusive-mode-ensure-MODE'
  function, which is added as a `:before' advice to MODE.

For example, if a given package \\=`editing' defines
\\=`editing-insert-mode' and \\=`editing-mark-mode', to make them
exclusive it would call:

    (exclusive-modes-define editing editing-insert-mode editing-mark-mode)

Which would produce the following effects:

- It creates the variable \\=`editing--exclusive-modes'.
- It creates the function \\=`editing--exclusive-mode-add'.
- It creates the function \\=`editing--exclusive-mode-remove'.
- It creates two functions,
  \\=`editing--exclusive-mode-ensure-editing-insert-mode' and
  \\=`editing--exclusive-mode-ensure-editing-mark-mode', and it adds them as a
  `:before' advice to both \\=`editing-insert-mode' and \\=`editing-mark-mode'
  respectively.
"
  (let* ((package-name (symbol-name package))
         (package-exclusive-modes (intern (format "%s--exclusive-modes" package-name)))
         (package-exclusive-mode-add (intern (format "%s--exclusive-mode-add" package-name)))
         (package-exclusive-mode-remove (intern (format "%s--exclusive-mode-remove" package-name))))
    `(progn
       (defvar ,package-exclusive-modes '()
         ,(format "`%s' modes that are mutually exclusive."
                  package-name))
       (defun ,package-exclusive-mode-add (mode)
         ,(format "Add MODE (a symbol) to `%s'.
This adds `%s--exclusive-mode-ensure-MODE' as a \\=`:before' advice to MODE."
                  package-exclusive-modes
                  package)
         (add-to-list ',package-exclusive-modes mode nil #'eq)
         (advice-add mode :before (defalias (exclusive-modes--ensurer-symbol ',package mode)
                                    (exclusive-modes--make-ensurer mode ',package-exclusive-modes))))
       (defun ,package-exclusive-mode-remove (mode)
         ,(format "Remove MODE (a symbol) from `%s'.
This removes `%s--exclusive-mode-ensure-MODE' advice from MODE."
                  package-exclusive-modes
                  package)
         (setq ,package-exclusive-modes (delq mode ,package-exclusive-modes))
         (advice-remove mode (exclusive-modes--ensurer-symbol ',package mode)))
       (dolist (mode ',modes)
         (,package-exclusive-mode-add mode)))))

(provide 'exclusive-modes)
;;; exclusive-modes.el ends here
