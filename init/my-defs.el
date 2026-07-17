;;; my-defs.el --- My elisp definitions.            -*- lexical-binding: t; -*-

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

;; One file for my definitions.  

;;; Code:

(require 'global-map-mode)
(require 'ui-simple-theme)

;;;; Faces

(defface my-dired-subtree-line-prefix-face
  `((((type graphic) (background light)) :background ,ui-simple-light-border-bg)
    (((type graphic) (background dark)) :background ,ui-simple-dark-border-bg)
    (((type tty) (background dark)) :background "blue")
    (t :background "brightwhite"))
  "Face for prefixing dired subtree lines.")

;;;; Functions

(defun my-dired-omit-mode-refresh (&rest _)
    "Refresh `dired-omit-mode'.
Implementation taken from the mode activation function."
    (require 'dired-x)
    (when dired-omit-mode
      (let ((dired-omit-size-limit  nil)
            (file-count 0))
        (setq file-count (dired-omit-expunge))
        (when dired-omit-lines
          (dired-omit-expunge dired-omit-lines 'LINEP file-count)))))

(defun my-nerd-icons-dired--resfresh-advice (&rest args)
  "Refresh `nerd-icons-dired-mode' if enabled."
  (require 'nerd-icons-dired)
  (when nerd-icons-dired-mode (nerd-icons-dired--refresh)))

(defun my-vertico-maybe-enable-marginalia ()
  "Enable or disable marginalia based on vertico state."
  (marginalia-mode
   (cond ((and vertico-mode
	       (not vertico-flat-mode))
	  1)
	 (t -1))))

(defun my-vterm-rename (ps1-string)
  "Rename current buffer by ps1 string sent through vterm."
  (rename-buffer (format "*vterm:%s*" ps1-string) :unique))

;;;; Modes

(global-map-mode-define my-global-map
  "My main global map."
  :inherit t
  :lighter " *")



(provide 'my-defs)
;;; my-defs.el ends here
