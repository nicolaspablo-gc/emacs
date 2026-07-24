;;; my-init-bindings.el --- My init bindings.           -*- lexical-binding: t; -*-

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

;; One file for all bindings.

;;; Code:

(require 'my-init-helpers)
(require 'my-faces)

;;;; Variables



;; Do this before anything that could write to custom file.
(setq custom-file my-custom-file) 

(setq auto-dark-themes '((modus-vivendi ui-simple) (modus-operandi ui-simple)))
(setq breadcrumb-imenu-crumb-separator (propertize " > " 'face '(:height 0.5))) ;; dont ask 
(setq breadcrumb-imenu-max-length 1.0)
(setq completion-styles '(initials partial-completion basic partial-completion emacs22 orderless))
(setq create-lockfiles nil)
(setq custom-file (locate-user-emacs-file "custom.el"))
(setq custom-safe-themes t)
(setq delete-pair-blink-delay 0)
(setq enable-recursive-minibuffers t)
(setq inhibit-startup-screen t)
(setq initial-buffer-choice #'vterm)
(setq kill-whole-line t)
(setq make-backup-files nil)
(setq nerd-icons-scale-factor 0.85)
(setq ring-bell-function #'ignore)
(setq tab-always-indent 'complete)
;; (setq tab-line-tabs-function #'tab-line-tabs-fixed-window-buffers)
(setq tab-line-tab-name-function #'tab-line-tab-name-truncated-buffer)
(setq theme-reload-themes '(ui-simple))
(setq vc-follow-symlinks t)

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

(with-eval-after-load 'isearch
  (define-keymap :keymap isearch-mode-map
    "TAB" #'my-x-isearch-repeat-direction
    "<Hangul>" #'my-x-isearch-change-direction))

(with-eval-after-load 'vertico
  (define-keymap :keymap vertico-map
    "M-SPC" #'vertico-quick-jump))

(with-eval-after-load 'dired
  (define-keymap :keymap dired-mode-map
    "<remap> <find-file>" #'my-x-dired-find-file))

(require 'modal)
(require 'modal-variant)

;; In and out of modal mode
(keymap-set global-map "<Hangul>" #'modal-mode)
(keymap-set modal-mode-map "RET" #'modal-mode)

;; In and out of modal global mode.
(keymap-set modal-mode-map "<Hangul>" #'modal-global-mode)
(keymap-set modal-global-mode-map "<Hangul>" #'modal-global-mode)
(keymap-set modal-global-mode-map "RET" (command (modal-global-mode -1) (modal-mode -1)))

(define-keymap :keymap modal-mode-map
  "'" #'pop-to-mark-command
  "," #'duplicate-dwim
  "." #'set-mark-command
  "/" #'undo
  "?" #'vundo
  ":" #'comment-dwim
  "<" #'beginning-of-buffer
  ">" #'end-of-buffer
  "\"" #'my-x-simple-unpop-to-mark-command
  "\\" #'cycle-spacing
  "a" #'mwim-beginning
  "b" #'backward-char
  "c" #'undefined
  "d" #'delete-char
  "e" #'mwim-end
  "f" #'forward-char
  "g" #'my-x-simple-keyboard-quit-dwim
  "h" help-map
  "i" #'undefined
  "j" #'my-x-simple-forward-delete-indentation
  "k" #'kill-sexp
  "l" #'kill-line
  "m" #'undefined
  "n" #'next-line
  "o" #'newline
  "p" #'previous-line
  "q" search-map
  "r" #'isearch-backward
  "s" #'isearch-forward
  "t" #'undefined
  "u" #'universal-argument
  "v" #'undefined
  "x" #'exchange-point-and-mark
  "y" #'my-x-simple-yank-dwim
  "z" #'repeat
  "|" #'shell-command-on-region
  "SPC" #'execute-extended-command)

(define-keymap :keymap modal-global-mode-map
  "," #'tab-bar-history-back
  "-" #'text-scale-adjust
  "." #'tab-bar-history-forward
  "0" #'delete-window
  "1" #'delete-other-windows
  "2" #'split-window-below
  "3" #'split-window-right
  "4" ctl-x-4-map
  "5" ctl-x-5-map
  "6" #'enlarge-window
  "=" #'text-scale-adjust
  "(" #'shrink-window-horizontally
  ")" #'enlarge-window-horizontally
  "a" #'tab-bar-switch-to-prev-tab
  "b" #'switch-to-buffer
  "c" #'undefined
  "d" #'dired-jump
  "e" #'tab-bar-switch-to-next-tab
  "f" #'find-file
  "g" #'my-x-simple-keyboard-quit-dwim
  "h" help-map
  "i" #'my-x-window-other-backward-window
  "j" #'undefined
  "k" #'kill-current-buffer
  "l" #'my-x-tab-line-switch-to-buffer-tab
  "m" #'link-hint-open-link
  "n" #'tab-line-switch-to-next-tab
  "o" #'other-window
  "p" #'tab-line-switch-to-prev-tab
  "q" #'my-x-window-quit-window-dwim
  "r" #'revert-buffer-quick
  "R" #'recentf
  "s" #'save-buffer
  "SPC" #'execute-extended-command
  "t" tab-prefix-map
  "u" #'universal-argument
  "v" #'undefined
  "w" #'undefined
  "x" #'undefined
  "z" #'repeat)

;;;; Hooks

(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(add-hook 'dired-mode-hook #'dired-omit-mode)
(add-hook 'prog-mode-hook #'corfu-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook #'corfu-mode)
(add-hook 'vertico-mode-hook #'my-vertico-maybe-enable-marginalia)
(add-hook 'telega-chat-mode-hook #'my-x-input-methods-set-spanish-prefix)
(add-hook 'telega-chat-mode-hook #'abbrev-mode)

;;;; Lists

(with-eval-after-load 'corfu  
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(with-eval-after-load 'vterm
  (add-to-list 'vterm-eval-cmds (list "my-x-vterm-rename" #'my-x-vterm-rename)))

;;;; Advices

(advice-add #'dired-revert :after #'my-x-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-x-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-x-dired-x-omit-mode-refresh)

;;;; Faces

(custom-theme-set-faces 'user
                        
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
     :foreground "blue")))

 ;; Vertico

 '(vertico-quick1 ((t :inherit my-select-char-face :background unspecified)))
 '(vertico-quick2 ((t :inherit my-select-char-face :background unspecified)))

 )

(provide 'my-init-bindings)
;;; my-init-bindings.el ends here

;; Local Variables:
;; outline-regexp: " '(\\|;;;;* [^ \t\n]\\|(\\|\\(^;;;###\\(\\([-[:alnum:]]+?\\)-\\)?\\(autoload\\)\\)"
;; End:
