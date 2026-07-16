;;; packages.el --- Per package settings.            -*- lexical-binding: t; -*-

(require 'helpers)

(use-package use-package-core
  :config
  (setq use-package-verbose t))

(use-package cus-edit
  :defer t
  :config
  (setq custom-file "/dev/null"))

(use-package custom
  :config
  ;; don't ask
  (setq custom-safe-themes t))

(use-package auto-dark
  :ensure t
  :config
  (setq auto-dark-themes '((modus-vivendi-tinted ui-simple)
			   (modus-operandi ui-simple)))
  (auto-dark-mode t))

(use-package ui-simple-theme
  :config
  (load-theme 'ui-simple :no-confirm))

(use-package theme-reload
  :config  
  (setq theme-reload-themes '(ui-simple))
  (theme-reload-mode))

(use-package breadcrumb
  :ensure t
  :defer t
  :config
  (setq breadcrumb-imenu-max-length 1.0
        breadcrumb-imenu-crumb-separator (propertize " > " 'face '(:height 0.5)))
  (define-minor-mode my-breadcrumb-local-mode
    "Unconditionally set `breadcrumb-imenu-crumbs' in header-line."
    :lighter nil
    (setq header-line-format (when my-breadcrumb-local-mode
                               '(:eval (breadcrumb-imenu-crumbs))))))

(use-package nerd-icons
  :defer t
  :ensure t
  :config
  (setq nerd-icons-scale-factor 0.85))

(use-package nerd-icons-tab-line
  ;; :custom-face
  ;; (nerd-icons-tab-line-icon-face ((t :height 0.9)))
  :config
  (nerd-icons-tab-line-mode 1))

(use-package tab-line
  :config
  (setq tab-line-tab-name-function #'tab-line-tab-name-truncated-buffer)
  (global-tab-line-mode))

(use-package files
  :config
  (setq make-backup-files nil))

(use-package mwim
  :ensure t)

(use-package simple
  :config
  ;; kills whole line at BOL
  (setq kill-whole-line t))

(use-package avy
  :defer t
  :custom-face
   (avy-lead-face-0
    ((t :inherit avy-lead-face
	:background nil)))
   (avy-lead-face-1
    ((((min-colors 256))
      :inherit avy-lead-face-0
      :weight light
      :foreground "gray")
     (t :inherit avy-lead-face-0)))
   (avy-lead-face-2
    ((t :inherit avy-lead-face-0
	:background nil)))
   (avy-lead-face
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
   (avy-background-face ((t :foreground "gray40")))
   (aw-leading-char-face
    ((default
      :inverse-video nil
      :box (:line-width (20 . 10) :color "royal blue")
      :inherit avy-lead-face
      :height 4.0)
     (((background dark))
      :foreground "gray10"))))

(use-package rainbow-delimiters
  :ensure t
  :defer
  :hook (prog-mode-hook . rainbow-delimiters-mode)
  :custom-face
  (rainbow-delimiters-base-error-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 8))
     :inherit show-paren-mismatch)))
  (rainbow-delimiters-base-face ((t)))
  (rainbow-delimiters-depth-1-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "deep sky blue")
    (((min-colors 256) (background light))
     :foreground "#0077c4")
    (((min-colors   8))
     :foreground "blue" :weight bold)))
  (rainbow-delimiters-depth-2-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "turquoise")
    (((min-colors 256) (background light))
     :foreground "medium turquoise")
    (((min-colors   8))
     :foreground "cyan")))
  (rainbow-delimiters-depth-3-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "lime green")
    (((min-colors 256) (background light))
     :foreground "#19b87a")
    (((min-colors   8))
     :foreground "green")))
  (rainbow-delimiters-depth-4-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "OliveDrab1")
    (((min-colors 256) (background light))
     :foreground "#64e72f")
    (((min-colors   8))
     :foreground "green" :weight bold)))
  (rainbow-delimiters-depth-5-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "tan1")
    (((min-colors 256) (background light))
     :foreground "gold3" :weight bold)
    (((min-colors   8))
     :foreground "yellow" :weight bold)))
  (rainbow-delimiters-depth-6-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "tomato1")
    (((min-colors 256) (background light))
     :foreground "coral")
    (((min-colors   8))
     :foreground "red" :weight bold)))
  (rainbow-delimiters-depth-7-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "brown1")
    (((min-colors 256) (background light))
     :foreground "firebrick1")
    (((min-colors 8))
     :foreground "magenta")))
  (rainbow-delimiters-depth-8-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "#f36f8e")
    (((min-colors 256) (background light))
     :foreground "#f36f8e")
    (((min-colors   8))
     :foreground "magenta" :weight bold)))
  (rainbow-delimiters-depth-9-face
   ((default
     :inherit rainbow-delimiters-base-face)
    (((min-colors 256) (background dark))
     :foreground "#d249cc")
    (((min-colors 256) (background light))
     :foreground "#d249cc")
    (((min-colors   8))
     :foreground "blue"))))

(use-package faces
  :custom-face
  (default ((t :family "Iosevka Fixed" :width expanded))))

(use-package modal
  :config
  (require 'modal-variant)
  (require 'mwim)
  (require 'convenience)
  (defun modal-change-cursor-type ()
    "Make more visually apparent the changes in modal modes."
    (setq cursor-type
	  (cond (modal-global-mode 'box) (modal-mode 'bar) (t 'hbar))))
  (add-hook 'modal-mode-hook #'modal-change-cursor-type)
  (add-hook 'modal-global-mode-hook #'modal-change-cursor-type)
  (keymap-set modal-mode-map "." #'set-mark-command)
  (keymap-set modal-mode-map "e" #'mwim-end)
  (keymap-set modal-mode-map "a" #'mwim-beginning)
  (keymap-set modal-mode-map "k" #'kill-sexp)
  (keymap-set modal-mode-map "r" #'isearch-backward)
  (keymap-set modal-mode-map "s" #'isearch-forward)
  (keymap-set modal-mode-map "d" #'delete-forward-char)
  (keymap-set modal-mode-map "n" #'next-line)
  (keymap-set modal-mode-map "p" #'previous-line)
  (keymap-set modal-mode-map "f" #'forward-char)
  (keymap-set modal-mode-map "b" #'backward-char)
  (keymap-set modal-mode-map "," #'duplicate-dwim)
  (keymap-set modal-mode-map "z" #'repeat)
  (keymap-set modal-mode-map "/" #'undo)
  (keymap-set modal-mode-map "SPC" #'execute-extended-command)
  (keymap-set modal-mode-map "RET" #'modal-variant-mode) ;; deactivate modal mode
  (keymap-set modal-mode-map "<Hangul>" #'modal-global-mode)
  (keymap-set modal-global-mode-map "<Hangul>" (lambda () (interactive) (modal-variant-mode -1) (modal-global-mode -1)))
  (keymap-set modal-global-mode-map "RET" (lambda () (interactive) (modal-global-mode -1) (modal-variant-mode 1)))
  (keymap-set modal-global-mode-map "d" #'dired-side-window-dwim)
  (keymap-set modal-global-mode-map "n" #'tab-line-switch-to-next-tab)
  (keymap-set modal-global-mode-map "b" #'switch-to-buffer)
  (keymap-set modal-global-mode-map "f" #'find-file)
  (keymap-set modal-global-mode-map "k" #'kill-current-buffer)
  (keymap-set modal-global-mode-map "p" #'tab-line-switch-to-prev-tab)
  (keymap-set modal-global-mode-map "e" #'tab-bar-switch-to-next-tab)
  (keymap-set modal-global-mode-map "a" #'tab-bar-switch-to-prev-tab)
  (keymap-set modal-global-mode-map "o" #'other-window)
  (keymap-set modal-global-mode-map "q" #'bury-buffer)
  (keymap-set modal-global-mode-map "s" #'save-buffer)
  (keymap-set modal-global-mode-map "0" #'delete-window))

(use-package nerd-icons-dired
  :ensure t
  :after dired
  :hook (dired-mode-hook . nerd-icons-dired-mode)
  :config
  (defun my-nerd-icons-dired--resfresh-advice (&rest args)
    (when nerd-icons-dired-mode (nerd-icons-dired--refresh)))
  (advice-add #'dired-revert :after #'my-nerd-icons-dired--resfresh-advice))

(use-package dired-subtree
  :ensure t
  :after (dired nerd-icons-dired dired-x)
  :bind (:map dired-mode-map
	  ("SPC" . dired-subtree-toggle))
  :config
  (require 'ui-simple-theme)
  (defface my-dired-subtree-line-prefix-face
    `((((type graphic) (background light)) :background ,ui-simple-light-border-bg)
      (((type graphic) (background dark)) :background ,ui-simple-dark-border-bg)
      (((type tty) (background dark)) :background "blue")
      (t :background "brightwhite"))
    "Face for prefixing dired subtree lines.")
  (setq dired-subtree-use-backgrounds nil
	dired-subtree-line-prefix (format "  %s" (propertize " " 'face 'my-dired-subtree-line-prefix-face)))
  (advice-add #'dired-subtree-toggle :after #'my-nerd-icons-dired--resfresh-advice)
  (advice-add #'dired-subtree-toggle :after #'my-dired-omit-mode-refresh))

(use-package dired
  :config
  (setq dired-listing-switches "-alF --group-directories-first"))

(use-package dired-x
  :after dired
  :hook (dired-mode . dired-omit-mode)
  :bind (:map dired-mode-map ("," . dired-omit-mode))
  :config
  (defun my-dired-omit-mode-refresh (&rest _)
    "Refresh `dired-omit-mode'.
Implementation taken from the mode activation function."
    (when dired-omit-mode
      (let ((dired-omit-size-limit  nil)
            (file-count 0))
        (setq file-count (dired-omit-expunge))
        (when dired-omit-lines
          (dired-omit-expunge dired-omit-lines 'LINEP file-count)))))
  (setq dired-omit-files "\\`[.].*\\'"))

(use-package elec-pair
  :config
  (electric-pair-mode))

(use-package orderless
  :ensure t)

(use-package convenience)

(use-package info
  :defer t
  :config
  (define-keymap :keymap Info-mode-map
    ")" #'Info-forward-node
    "(" #'Info-backward-node))

(use-package info-rename-buffer
  :after info
  :ensure t
  :config
  (info-rename-buffer-mode))

(use-package window
  :config
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
      display-buffer-in-side-window (side . right)))))

(use-package marginalia
  :ensure t
  :config)

(use-package nerd-icons-completion
  :ensure t
  :config
  (nerd-icons-completion-mode))

(use-package vterm
  :ensure t
  :defer t
  :config
  (defun my-vterm-rename (ps1-string)
    "Rename current buffer by ps1 string sent through vterm."
    (rename-buffer (format "*vterm:%s*" ps1-string) :unique))
  (add-to-list 'vterm-eval-cmds (list "my-vterm-rename" #'my-vterm-rename)))

(use-package vertico
  :ensure t
  :after (marginalia nerd-icons-completion)
  :config
  ;; Workarounds for using vertico-flat with nerd-icons-completion.
  ;; We need to deactivate marginalia for vertico flat, but elsewhere
  ;; marginalia is wanted.
  (defun my-vertico-maybe-enable-marginalia ()
    (marginalia-mode
     (cond ((and vertico-mode
		 (not vertico-flat-mode))
	    1)
	   (t -1))))
  (add-hook 'vertico-mode-hook #'my-vertico-maybe-enable-marginalia)
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
  (vertico-mode)
  (vertico-multiform-mode)
  (vertico-flat-mode))

(use-package corfu
  :ensure t
  :config
  :hook
  ((prog-mode-hook . corfu-mode)
   (shell-mode-hook . corfu-mode)))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package vc-hooks
  :defer t
  :config
  (setq vc-follow-symlinks t))

(use-package emacs
  :bind
  (;; I have in keyd set caps lock to hangul, to have a new "free" key to bind.
   ;; I set to Hangul because is key thats mostly not bound elsewhere (f13-24 are
   ;; bound in gnome/wayland to media keys)
   ("<Hangul>" . modal-variant-mode)
   ("M-SPC" . modal-global-mode))
  :config
  (setq tab-always-indent 'complete
	completion-styles '(initials partial-completion basic partial-completion emacs22 orderless)
	delete-pair-blink-delay 0
	create-lockfiles nil
	ring-bell-function #'ignore
	enable-recursive-minibuffers t
        inhibit-startup-screen t
        initial-buffer-choice #'vterm)
  (setq-default cursor-type 'hbar
		indent-tabs-mode nil))

(use-package saveplace
  :config
  (save-place-mode))

(provide 'packages)
;;; packages.el ends here
