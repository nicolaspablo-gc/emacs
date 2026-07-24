;;; global-map-mode.el --- Modal global maps. -*- lexical-binding: t; -*-

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

;; This package provides `global-map-mode-define', a macro that allows
;; defining a global minor mode that when active changes the current
;; global map.

;; This is helpful when you want to have a custom global map without
;; touching the already existing global map.  Being a minor mode, it
;; becomes a toggle (on/off) which makes it easy to go back to
;; the default state.

;; Use this specifically for when you need to set the current global
;; map.  For "global" bindings, consider if you'd be better served by
;; using a regular global minor mode with its own keymap.

;;; Code:

(require 'cl-macs)

(cl-defmacro global-map-mode-define (map-name doc &key inherit lighter)
  "Define MAP-NAME-mode that sets MAP-NAME as the current global map.

When MAP-NAME-mode is enabled, `use-global-map' is called with MAP-NAME,
replacing the active global map.  When disabled, the default
`global-map' is restored.

If INHERIT is non-nil, MAP-NAME inherits from `global-map', so all
default bindings remain available unless explicitly overridden.

LIGHTER is passed to `define-minor-mode' as the mode-line string.

For example, the invocation

    (global-map-mode-define my-global-map)

Creates the global minor mode \\=`my-global-map-mode', that when
activated sets \\=`my-global-map' as the current global map."
  (declare (doc-string 2) (indent defun))
  (let ((mode (intern (format "%s-mode" (symbol-name map-name)))))
    `(progn
       (defvar-keymap ,map-name
         :doc ,(format "%s\nThis is a global map and is set by `%s'." doc mode)
         ,@(when inherit
             `(:parent global-map)))
       (define-minor-mode ,mode
         ,(format "Use `%s' as the current global map." map-name)
         :lighter ,lighter
         :global t
         (use-global-map (if ,mode ,map-name global-map))))))

(provide 'global-map-mode)
;;; global-map-mode.el ends here
