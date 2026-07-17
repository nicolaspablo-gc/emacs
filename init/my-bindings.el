;;; my-bindings.el --- My elisp bindings.           -*- lexical-binding: t; -*-

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

;; You should have received a copy of the GNU General Public Licensen
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; One file for all bindings.  As this grows decomposition might
;; become necessary, but I don't want to decompose prematurely.

;;; Code:

;;;; Variables

(setq auto-dark-themes '((modus-vivendi-tinted ui-simple) (modus-operandi ui-simple)))
(setq breadcrumb-imenu-max-length 1.0
      breadcrumb-imenu-crumb-separator (propertize " > " 'face '(:height 0.5))) ;; dont ask 
(setq custom-file (locate-user-emacs-file "custom.el")
      custom-safe-themes t)
(setq kill-whole-line t)
(setq make-backup-files nil)
(setq nerd-icons-scale-factor 0.85)
(setq tab-line-tab-name-function #'tab-line-tab-name-truncated-buffer)
(setq vc-follow-symlinks t)
(setq theme-reload-themes '(ui-simple))
(setq tab-always-indent 'complete
      completion-styles '(initials partial-completion basic partial-completion emacs22 orderless)
      delete-pair-blink-delay 0
      create-lockfiles nil
      ring-bell-function #'ignore
      enable-recursive-minibuffers t
      inhibit-startup-screen t
      initial-buffer-choice #'vterm)
(setq-default indent-tabs-mode nil)

;; Dired

(setq dired-listing-switches "-alF --group-directories-first"
      dired-omit-files "\\`[.].*\\'"
      dired-subtree-use-backgrounds nil
      dired-subtree-line-prefix (format "  %s" (propertize " " 'face 'my-dired-subtree-line-prefix-face)))

;; Window

(setq
 display-buffer-base-action
 '((display-buffer-reuse-window
    display-buffer-in-previous-window
    display-buffer-same-window
    display-buffer-pop-up-window)
   (reusable-frames . nil))
 display-buffer-fallback-action
 '((display-buffer--maybe-same-window
    display-buffer-reuse-window
    display-buffer-same-window
    display-buffer-use-some-window
    display-buffer--maybe-pop-up-frame-or-window
    display-buffer-in-previous-window
    display-buffer-in-tab
    display-buffer-pop-up-frame)
   (reusable-frames . nil))
 display-buffer-alist
 `(("Rec Edit\\| ?\\*Capture\\|\\*agent-shell-diff\\*"
    display-buffer-same-window)     
   ("\\*\\(:?git-grep-transient-.*\\|grep\\|Occur\\|xref\\|Outline .*\\.pdf\\|image-dired\\)\\*"
    display-buffer-in-side-window (side . left))
   ("\\*\\(:?Agenda Commands\\|appt-buf\\)\\*"
    display-buffer-in-side-window (side . top))
   ("\\*\\(:?Server\\|Help\\|Messages\\|Telegram Animations\\| ?docker[- ]containers?.*\\|Password-Store\\|info.*\\|Man .*\\)\\*"
    display-buffer-same-window)
   ("magit-diff\\|\\*\\(:?Org Src.*\\|Typescript\\|PLANTUML Preview\\|eldoc.*\\|Python\\|SQL:.*\\|nodejs\\|git-gutter:diff\\)\\*\\|bash-fc.*"
    (display-buffer-in-direction)
    (inhibit-switch-frame . t)
    (inhibit-same-window . t)
    (direction . rightmost)
    (window-min-height . full-height)
    (reusable-frames . nil)
    (window-width . 0.5)
    (side . right))
   ("\\*\\(:?compilation.*\\|ejc-sql-output\\)\\*"
    display-buffer-in-side-window (side . bottom) (window-height . 0.5))
   ("\\*Calendar\\*"
    display-buffer-in-side-window (side . top) (window-height . 0.3))
   ("\\*\\(:?Completions\\|Backtrace\\)\\*"
    display-buffer-in-side-window (side . bottom) (window-height . 0.25))
   ("\\*\\(:?Warnings\\|Async Shell Command\\|sly-mrepl.*\\|Quail Completions\\|compile-git-hunks\\)\\*"
    display-buffer-no-window)
   ("\\*\\(:?Org Select\\|Occur\\|xref\\|undo-tree\\|plz-see-.*\\|ednc-log\\)\\*"
    display-buffer-in-side-window (side . right))))

;; Vertico

(setq
 vertico-flat-annotate nil ;; dont annotate by default
 vertico-resize t
 vertico-cycle t
 vertico-multiform-categories
 '((file (vertico-flat-annotate . t))
   (buffer (vertico-flat-annotate . t)))
 vertico-flat-format
 '( :multiple   ": %s"
    :single     #(": %s" 2 3 (face success))
    :prompt     ": %s"
    :separator  #(", " 0 1 (face minibuffer-prompt))
    :ellipsis   #("..." 0 3 (face minibuffer-prompt))
    :no-match   " [No match]")
 vertico-multiform-commands
 '(("consult-\\(completion-in-region\\|vterm\\|tab-line\\)" (vertico-flat-annotate . nil))
   ("consult-buffer")
   ("consult-\\(project-buffer\\|line\\|outline\\|imenu\\|org-heading\\)"
    buffer
    (:not flat)
    (vertico-buffer-display-action
     (display-buffer-in-side-window)
     (side . left)))
   ("consult.*" (:not flat))))

;;;; Keymaps

(with-eval-after-load 'dired
  (define-keymap :keymap dired-mode-map
    "SPC" #'dired-subtree-toggle
    "," #'dired-omit-mode))

(with-eval-after-load 'info
  (define-keymap :keymap Info-mode-map
    ")" #'Info-forward-node
    "(" #'Info-backward-node))

;;;; Hooks

(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(add-hook 'dired-mode-hook #'dired-omit-mode)
(add-hook 'prog-mode-hook #'corfu-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook #'corfu-mode)
(add-hook 'vertico-mode-hook #'my-vertico-maybe-enable-marginalia)

;;;; Lists

(with-eval-after-load 'corfu  
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(with-eval-after-load 'vterm
  (add-to-list 'vterm-eval-cmds (list "my-vterm-rename" #'my-vterm-rename)))

;;;; Advices

(advice-add #'dired-revert :after #'my-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-dired-omit-mode-refresh)

;;;; Faces

(custom-theme-set-faces
 'user

 '(default ((t :family "Iosevka Fixed" :width expanded)))
 
 ;; Avy prompt
 
 '(avy-lead-face-0
   ((t :inherit avy-lead-face
       :background nil)))
 '(avy-lead-face-1
   ((((min-colors 256))
     :inherit avy-lead-face-0
     :weight light
     :foreground "gray")
    (t :inherit avy-lead-face-0)))
 '(avy-lead-face-2
   ((t :inherit avy-lead-face-0
       :background nil)))
 '(avy-lead-face
   ((default
     :slant normal
     :weight bold
     :underline nil
     :width expanded
     :inverse-video nil
     :box ( :line-width (4 . -1)
            :color "royal blue")
     :background "royal blue"
     :foreground "white")
    (((background light) (min-colors 256))
     :underline ( :color "white" :position 0))
    (((background dark) (min-colors 256))
     :underline ( :color "black" :position 0))
    (((min-colors 8))
     :background "blue" :foreground "white" )))
 '(avy-background-face ((t :foreground "gray40")))
 '(aw-leading-char-face
   ((default
     :inverse-video nil
     :box (:line-width (20 . 10) :color "royal blue")
     :inherit avy-lead-face
     :height 4.0)
    (((background dark))
     :foreground "gray10")))

 ;; Rainbow delimiters
 
 '(rainbow-delimiters-base-error-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 8))
     :inherit show-paren-mismatch)))
 '(rainbow-delimiters-base-face ((t)))
 '(rainbow-delimiters-depth-1-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "deep sky blue")
    (((min-colors 256) (background light))
     :foreground "#0077c4")
    (((min-colors   8))
     :foreground "blue" :weight bold)))
 '(rainbow-delimiters-depth-2-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "turquoise")
    (((min-colors 256) (background light))
     :foreground "medium turquoise")
    (((min-colors   8))
     :foreground "cyan")))
 '(rainbow-delimiters-depth-3-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "lime green")
    (((min-colors 256) (background light))
     :foreground "#19b87a")
    (((min-colors   8))
     :foreground "green")))
 '(rainbow-delimiters-depth-4-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "OliveDrab1")
    (((min-colors 256) (background light))
     :foreground "#64e72f")
    (((min-colors   8))
     :foreground "green" :weight bold)))
 '(rainbow-delimiters-depth-5-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "tan1")
    (((min-colors 256) (background light))
     :foreground "gold3" :weight bold)
    (((min-colors   8))
     :foreground "yellow" :weight bold)))
 '(rainbow-delimiters-depth-6-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "tomato1")
    (((min-colors 256) (background light))
     :foreground "coral")
    (((min-colors   8))
     :foreground "red" :weight bold)))
 '(rainbow-delimiters-depth-7-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "brown1")
    (((min-colors 256) (background light))
     :foreground "firebrick1")
    (((min-colors 8))
     :foreground "magenta")))
 '(rainbow-delimiters-depth-8-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "#f36f8e")
    (((min-colors 256) (background light))
     :foreground "#f36f8e")
    (((min-colors   8))
     :foreground "magenta" :weight bold)))
 '(rainbow-delimiters-depth-9-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "#d249cc")
    (((min-colors 256) (background light))
     :foreground "#d249cc")
    (((min-colors   8))
     :foreground "blue"))))

(provide 'my-bindings)
;;; my-bindings.el ends here

;; Local Variables:
;; outline-regexp: " '(\\|;;;;* [^ \t\n]\\|(\\|\\(^;;;###\\(\\([-[:alnum:]]+?\\)-\\)?\\(autoload\\)\\)"
;; End:
