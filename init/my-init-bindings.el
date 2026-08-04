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
(require 'ui-simple-theme)
(require 'tab-bar-icons)
(require 'eglot)

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

(setq ediff-merge-split-window-function #'split-window-horizontally)
(setq ediff-split-window-function #'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(setq major-mode-remap-alist (alistq python-mode python-ts-mode))

(setq magit-format-file-function #'magit-format-file-nerd-icons)
(setq modal-global-mode-cursor-color "red")

;; Org

(setq org-use-speed-commands t)
(setq org-agenda-restore-windows-after-quit t)
(setq org-agenda-search-view-max-outline-level 1)
(setq org-agenda-sort-notime-is-late nil)
(setq org-agenda-span 14)
(setq org-agenda-sticky t)
(setq org-agenda-tags-column 0)
(setq org-agenda-time-leading-zero t)
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-use-time-grid t)
(setq org-agenda-window-setup 'current-window)
(setq org-appear-autoemphasis t)
(setq org-appear-autolinks t)
(setq org-appear-autosubmarkers t)
(setq org-archive-location ".archive/%s::")
(setq org-babel-no-eval-on-ctrl-c-ctrl-c t)
(setq org-capture-bookmark nil)
(setq org-clock-into-drawer "LOG")
(setq org-confirm-babel-evaluate nil)
(setq org-confirm-elisp-link-function #'y-or-n-p)
(setq org-cycle-separator-lines 0)
(setq org-deadline-warning-days 1)
(setq org-directory "~/.nico/home/agenda")
(setq org-default-notes-file (concat org-directory "/agenda.org"))
(setq org-ellipsis (format " (%s)" (if (display-graphic-p) "…" "...")))
(setq org-fontify-done-headline t)
(setq org-fontify-todo-headline nil)
(setq org-hide-emphasis-markers t)
(setq org-hide-leading-stars nil)
(setq org-indirect-buffer-display 'current-window)
(setq org-list-allow-alphabetical t)
(setq org-list-demote-modify-bullet (alistq "+" "-"))
(setq org-hide-drawer-startup nil)
(setq org-log-into-drawer "LOG")
(setq org-outline-path-complete-in-steps nil)
(setq org-priority-default ?C)
(setq org-priority-lowest ?E)
(setq org-refile-allow-creating-parent-nodes t)
(setq org-refile-targets (list (cons 'org-agenda-files nil)))
(setq org-refile-use-outline-path 'full-file-path)
(setq org-return-follows-link t)
(setq org-special-ctrl-a t)
(setq org-src-window-setup 'plain)
(setq org-startup-folded t)
(setq org-tags-column 0)
(setq org-todo-keywords '((sequence "HACER" "PAUSA" "|" "HECHO" "YA_NO")))
(setq org-use-speed-commands t)

(setq org-agenda-prefix-format
      (alistq agenda " %i %?-12t% s"
              todo " %i "
              tags " %i "
              search " %i "))
(setq org-todo-keyword-faces
      (alistq "PAUSA" my-org-wait-face
              "CONFIRMAR" my-org-confirm-face
              "YA NO" my-org-cancel-face
              "YA_NO" my-org-cancel-face))
(setq org-timer-format "⏰ %s ")

(with-eval-after-load 'org
  (setf (cdr (assoc 'state org-log-note-headings)) "LOG: %t  %s"))

(setq dired-side-window-display-buffer-base-action
      '((display-buffer-reuse-window
         display-buffer-in-previous-window
         display-buffer-same-window
         display-buffer-use-some-window
         display-buffer-pop-up-window)
        (reusable-frames . nil)))

;; Tab Bar

(setq tab-bar-format
      '(;; tab-bar-format-history
        ;; tab-bar-format-tabs
        tab-bar-icons-format-tabs
        tab-bar-separator
        tab-bar-format-add-tab
        tab-bar-format-align-right
        tab-bar-format-global))


;; Mode Line

;; based on the emacs default, put modes at the beginning and buffer
;; name at the end.  This is because buffer names vary widely, but the
;; list of mode lighters is short and varies minimally.  By keeping
;; the most varied element last, all the other mode line elements are
;; more likely to stay aligned.

(setq-default
 mode-line-format
 '("%e"
   mode-line-front-space
   (7 ("" mode-line-position))
   mode-line-frame-identification
   (:eval (propertized-buffer-identification (truncate-string-to-width (buffer-name) 30 nil ?\s t)))
   " "
   my-x-emacs-mode-line-modes
   mode-line-format-right-align
   (:propertize
    " "
    display (min-width (6.0)))
   (project-mode-line project-mode-line-format)
   (vc-mode vc-mode)
   "  "
   (eglot--managed-mode (" [" eglot--mode-line-format "] "))
   (:propertize
    (""
     mode-line-mule-info
     mode-line-client
     mode-line-modified
     mode-line-remote
     mode-line-window-dedicated)
    display (min-width (6.0)))
   "  "
   mode-line-end-spaces))

;; Dired

(setq dired-listing-switches "-alF --group-directories-first"
      dired-omit-files "\\`[.].*\\'"
      dired-subtree-use-backgrounds nil
      dired-subtree-line-prefix (format
                                 "  %s"
                                 (propertize " " 'face 'my-x-dired-subtree-line-prefix-face)))

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
   ("consult.*\\|my-x-vterm-dwim" (:not flat))))

;;;; Keymaps

(keymap-global-set "<f1>" #'keyboard-quit)

(with-eval-after-load 'tab-bar
  (define-keymap :keymap tab-bar-mode-map
    "C-TAB" nil
    "C-<tab>" nil
    "C-S-<iso-lefttab>" nil))

(with-eval-after-load 'dired
  (define-keymap :keymap dired-mode-map
    "SPC" #'dired-subtree-toggle
    "," #'dired-omit-mode
    "<remap> <find-file>" #'my-x-dired-find-file
    "s" #'isearch-forward))

(with-eval-after-load 'info
  (define-keymap :keymap Info-mode-map
    ")" #'Info-forward-node
    "(" #'Info-backward-node))

(with-eval-after-load 'isearch
  (define-keymap :keymap isearch-mode-map
    "TAB" #'my-x-isearch-repeat-direction
    "<Hangul>" #'my-x-isearch-change-direction))

(with-eval-after-load 'prog-mode
  (define-keymap :keymap prog-mode-map
    "<remap> <end-of-line>" #'mwim-end
    "<remap> <beginning-of-line>" #'mwim-beginning))

(with-eval-after-load 'text-mode
  (define-keymap :keymap text-mode-map
    "<remap> <end-of-line>" #'mwim-end
    "<remap> <beginning-of-line>" #'mwim-beginning))

(with-eval-after-load 'vertico
  (define-keymap :keymap vertico-map
    "M-SPC" #'vertico-quick-insert))

(with-eval-after-load 'vterm
  (keymap-unset vterm-mode-map "<return>" :remove)
  (define-keymap :keymap vterm-mode-map
    "M-SPC" #'vterm-copy-mode
    "<remap> <previous-line>" (command (vterm-send "C-p"))
    "<remap> <next-line>" (command (vterm-send "C-n"))
    "<remap> <end-of-line>" (command (vterm-send "C-e"))
    "<remap> <beginning-of-line>" (command (vterm-send "C-a"))
    "<remap> <forward-char>" (command (vterm-send "C-f"))
    "<remap> <backward-char>" (command (vterm-send "C-b"))
    "<remap> <delete-char>" (command (vterm-send "C-d"))
    "<remap> <isearch-backward>" (command (vterm-send "C-r"))
    "<remap> <keyboard-quit>" (command (vterm-send "C-c"))
    "<remap> <recenter-top-bottom>" (command (vterm-send "C-l"))))

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
  "a" #'beginning-of-line
  "b" #'backward-char
  "c" #'keyboard-quit
  "d" #'delete-char
  "e" #'end-of-line
  "f" #'forward-char
  "g" #'my-x-simple-keyboard-quit-dwim
  "h" help-map
  "i" #'recenter-top-bottom
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
  "c" #'keyboard-quit
  "d" #'dired-side-window-dwim
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
  "w" #'agent-shell
  "x" #'my-x-vterm-dwim
  "z" #'repeat)

(keymap-set minibuffer-local-map "<remap> <keyboard-quit>" #'abort-minibuffers)

(define-keymap :keymap search-map
  "SPC" #'replace-regexp
  "RET" #'query-replace-regexp)

;;;; Hooks

(add-hook 'ibuffer-mode-hook #'nerd-icons-ibuffer-mode)
(add-hook 'agent-shell-mode-hook #'corfu-mode)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
(add-hook 'dired-mode-hook #'dired-omit-mode)
(add-hook 'python-ts-mode-hook #'eglot-ensure)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'breadcrumb-local-mode)
(add-hook 'prog-mode-hook #'corfu-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'shell-mode-hook #'corfu-mode)
(add-hook 'vertico-flat-mode-hook #'my-x-vertico-maybe-enable-marginalia)
(add-hook 'vertico-mode-hook #'my-x-vertico-maybe-enable-marginalia)
(add-hook 'vertico-multiform-mode-hook #'my-x-vertico-maybe-enable-marginalia)
(add-hook 'telega-chat-mode-hook #'my-x-input-methods-set-spanish-prefix)
(add-hook 'telega-chat-mode-hook #'abbrev-mode)
(add-hook 'marginalia-mode-hook #'my-x-nerd-icons-completion-reactivate)
(add-hook 'vterm-mode-hook #'my-x-emacs-set-header-line-as-buffer-name)

(add-hook 'ediff-startup-hook #'my-x-ediff-prepare-buffer)

(add-hook 'ediff-before-setup-hook #'my-x-ediff-setup)
(add-hook 'ediff-quit-hook #'my-x-ediff-restore)
(add-hook 'ediff-prepare-buffer-hook #'my-x-ediff-prepare-buffer)
(add-hook 'dired-side-window-hook #'dired-hide-details-mode)


;;;; Lists

(with-eval-after-load 'elec-pair
  (add-to-list 'electric-pair-pairs (cons ?¿ ??))
  (add-to-list 'electric-pair-pairs (cons ?¡ ?!)))

(with-eval-after-load 'corfu  
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(with-eval-after-load 'vterm
  (add-to-list 'vterm-eval-cmds (list "my-x-vterm-rename" #'my-x-vterm-rename)))

(with-eval-after-load 'eglot
  (add-to-list
   'eglot-server-programs
   `((python-mode python-ts-mode)
     . ,(eglot-alternatives
         '(("basedpyright-langserver" "--stdio"))))))

;;;; Advices

(advice-add #'dired-revert :after #'my-x-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-x-nerd-icons-dired--resfresh-advice)
(advice-add #'dired-subtree-toggle :after #'my-x-dired-x-omit-mode-refresh)

;;;; Faces

(custom-theme-set-faces 'user
                        
 '(default ((t :family "Iosevka Fixed" :width expanded)))
 
 ;; Avy prompt
 ;; 
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

 ;; Ediff
 ;;
 '(ediff-current-diff-A ((t :foreground unspecified)))
 '(ediff-current-diff-B ((t :foreground unspecified)))
 '(ediff-current-fine-diff-A ((t :foreground unspecified :weight bold)))
 '(ediff-current-fine-diff-B ((t :foreground unspecified :weight bold)))
 '(ediff-fine-diff-A ((t :foreground unspecified :weight normal)))
 '(ediff-fine-diff-B ((t :foreground unspecified :weight normal)))'(smerge-lower ((t :foreground unspecified)))
 
 ;; Rainbow delimiters
 ;;
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


 ;; Smerge
 ;;
 '(smerge-refined-changed ((t :foreground unspecified)))
 '(smerge-upper ((t :foreground unspecified)))

 ;; Tab Line
 ;;
 '(tab-line-tab-special ((t :family reset)))
 
 ;; Vertico
 ;; 
 '(vertico-quick1 ((t :inherit my-select-char-face :background unspecified :foreground unspecified)))
 '(vertico-quick2 ((t :inherit my-select-char-face :background unspecified :foreground unspecified)))

 ;; Visible Mark
 ;;
 `(visible-mark-face1 ((((background dark))
                        :background ,ui-simple-dark-border-bg)
                       (((background light))
                        :background ,ui-simple-light-border-bg))) )

;;; Vertico

(provide 'my-init-bindings)
;;; my-init-bindings.el ends here

;; Local Variables:
;; outline-regexp: " '(\\|;;;;* [^ \t\n]\\|(\\|\\(^;;;###\\(\\([-[:alnum:]]+?\\)-\\)?\\(autoload\\)\\)"
;; End:
