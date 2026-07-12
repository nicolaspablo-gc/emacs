;;; modal.el --- Configurable modal bindings.  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco
;; Keywords: convenience, tools

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

;; This package provides a pair of simple modes for modal editing, without
;; imposing keybindings:

;; - `modal-mode':  Active for the current buffer only.
;; - `modal-global-mode':  Active across all buffers.

;; Use cases:

;; - `modal-mode' could be used for buffer local commands, such as
;;    editing, triggering commonly used commands, etc.

;; - `modal-global-mode' could be used for commands that work across different
;;   buffers, like switching windows, tabs, managing ui/workspaces, etc.

;;  `modal-global-mode' takes precedence over `modal-mode'.

;; See also `modal-variant' for modal variations per major mode.

;;; Code:

(defgroup modal nil
  "Configurable modal bindings."
  :group 'convenience)

(defun modal--make-map ()
  "Make an \"empty\" keymap used in modal modes."
  (let ((map (make-keymap)))
    (dolist (key (list [remap self-insert-command]
                       (kbd "RET")
                       (kbd "DEL")))
      (define-key map key #'undefined))
    map))

(defvar modal-mode-map (modal--make-map)
  "Keymap for `modal-mode'.
Empty, meant to be filled by user, works for the current buffer.")

(defvar modal-global-mode-map
  (let ((map (modal--make-map)))
    (define-key map (kbd "C-M-g") #'modal-global-mode)
    map)
  "Keymap for `modal-global-mode'.
Only binds \\[modal-global-mode] to exit `modal-global-mode', everything
else is meant to be filled by the user.  It works across all buffers.")

(defvar modal--mode-map-alist
  `((modal-global-mode . ,modal-global-mode-map)
    (modal-mode . ,modal-mode-map))
  "Mode-map alist used in `emulation-mode-map-alists' for modal modes.
`modal-global-mode' entry must be first to take precedence and truly work
across all buffers.")

(defcustom modal-mode-lighter " [.]"
  "Lighter for `modal-mode'."
  :type 'string)

(defcustom modal-global-mode-lighter " [*]"
  "Lighter for `modal-global-mode'."
  :type 'string)

(defcustom modal-minibuffer-disable t
  "Non-nil if `modal-global-mode' should be disabled when entering
minibuffer.

Minibuffer commands generally read text, and having
`modal-global-mode' on wouldn't help that purpose.

Beware, if you set this to nil and clear `C-M-g' from
`modal-global-mode-map' you might get stuck in `global-modal-mode'
without being able to exit."
  :type 'boolean)

(defun modal--maybe-minibuffer-disable ()
  "Disable `modal-global-mode' in minibuffer based on
`modal-minibuffer-disable'."
  (when modal-minibuffer-disable (modal-global-mode -1)))

(define-minor-mode modal-mode
  "User customizable modal mode for the current buffer."
  :lighter modal-mode-lighter
  :keymap modal-mode-map)

(define-minor-mode modal-global-mode
  "User customizable modal mode that works across all buffers."
  :lighter modal-global-mode-lighter
  :keymap modal-global-mode-map
  :global t
  ;; Maybe disable when activating minibuffer
  (funcall (if modal-global-mode #'add-hook #'remove-hook)
           'minibuffer-setup-hook
           #'modal--maybe-minibuffer-disable)
  ;; Refresh the mode line to display in all buffers global mode is active.
  (force-mode-line-update :all))

;; Register modal mode in `emulation-mode-map-alists'.
(add-to-list 'emulation-mode-map-alists modal--mode-map-alist)

(provide 'modal)
;;; modal.el ends here
