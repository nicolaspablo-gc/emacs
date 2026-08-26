;;; my-packages.el --- My `package' bootstrap.       -*- lexical-binding: t; -*-

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

(require 'package)

;; Add Melpa

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Set and install packages.

(setq
 package-selected-packages
 '(agent-recall
   agent-shell
   aggressive-indent
   auto-dark
   avy
   blow
   breadcrumb
   buffer-wrap
   corfu
   dired-subtree
   info-rename-buffer
   marginalia
   markdown-mode
   mwim
   nerd-icons
   nerd-icons-completion
   nerd-icons-corfu
   nerd-icons-dired
   nerd-icons-ibuffer
   nov
   openwith
   orderless
   rainbow-delimiters
   vertico
   visible-mark
   vterm))

(unless (seq-every-p #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (package-install-selected-packages :noconfirm))

;; Add extra autoloads.

(autoload 'nov-open-directory "nov" "Open EPUB buffer using DIR as directory of the document." 'interactive)
(autoload 'markdown-insert-gfm-code-block "markdown-mode" "Insert GFM code block for language LANG." 'interactive)

(provide 'my-packages)
;;; my-packages.el ends here
