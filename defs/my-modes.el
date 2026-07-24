;;; my-modes.el --- My elisp definitions.            -*- lexical-binding: t; -*-

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

;; Personal modes for editing and different contexts.

;;; Code:

(require 'exclusive-modes)
(require 'global-map-mode)

;;;; Helpers

(defun my-modes--supress-keymap (keymap)
  "Bind all printable keys in KEYMAP to `undefined'.
This is useful for avoiding unintentional falltrough."
  (let (;; ascii range for printable chars start at 33 and ends at 126
        (start 33)
        ;; end is exclussive
        (end 127))
    (dotimes (i (- end start))
      (keymap-set keymap (string (+ i start)) #'undefined))))

(defun my-modes--make-empty-keymap (&optional full)
  "Make a sparse keymap with `my-modes--supress-keymap'.
Use FULL to create a full keymap instead of an sparse one."    
  (let ((map (if full (make-keymap) (make-sparse-keymap))))
    (my-modes--supress-keymap map)
    map))

;;;; Maps

(defvar my-base-mode-map
  (let ((map (define-keymap :parent global-map)))
    (my-modes--supress-keymap map)
    map)
  "My main global map.

These are the defaults for all buffers.  As such, its focused on defaults
for buffer editing.

Emacs' defaults are to map all printable keys to `self-insert-command',
and to have a set of most used commands mapped to key sequences.  I
believe its better to do the opposite: have all printable keys bound to
meaningful commands, and have one \\=`self-insert-mode' reachable from
there.

Why?  Because emacs has a very good map shadowing system:

    minor modes
    major modes
    global map

With this system the global map can have \"k\" to mean something general
like `kill-line', and some major mode could have \"k\" to mean something
more specialized like \\=`kill-line-and-frobnicate'.

This is also the reason why minor modes (local or global) are not good
for this purpose: they sit on top, thus not allowing for intentional
shadowing.")

(define-minor-mode my-global-map-mode
  "Use `my-global-map' in place of `global-map'."
  :lighter " [*]"
  :global t
  (use-global-map (if my-global-map-mode my-global-map global-map)))

(defun my-global-map-mode-off ()
  "Unconditionally disable `my-global-map-mode'."
  (my-global-map-mode -1))


;;;; Mark

(defvar my-mark-mode-map (my-modes--make-empty-keymap)
  "Keymap for my mark mode.")

(defun my-mark-mode--deactivate-mark-hook ()
  (my-mark-mode -1)
  (remove-hook 'deactivate-mark-hook #'my-modes-mark-mode--deactivate-mark-hook))

(define-minor-mode my-mark-mode
  "Minor mode for mark commands."
  :keymap my-mark-mode-map
  :lighter " <MARK>"
  (if my-mark-mode
      (progn
	(push-mark)
	(add-hook 'deactivate-mark-hook #'my-mark-mode--deactivate-mark-hook)
	(activate-mark))
    (deactivate-mark)))


;;;; Sexp

(defvar my-sexp-mode-map (my-modes--make-empty-keymap)
  "Keymap for sexp editing.")

(define-minor-mode my-sexp-mode
  "Mode for sexp commands."
  :lighter " <SEXP>"
  :keymap my-sexp-mode-map)

(exclusive-modes-define my-modes my-sexp-mode my-mark-mode)


;;;; Navigation

(defvar my-nav-mode-map (my-modes--make-empty-keymap)
  "Keymap for `my-nav-mode'.")

(define-minor-mode my-nav-mode
  "Mode for ui navigation"
  :lighter " <NAV>"
  :global t)


(provide 'my-modes)
;;; my-modes.el ends here
