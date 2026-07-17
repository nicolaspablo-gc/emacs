;;; init.el ---                                      -*- lexical-binding: t; -*-

;;;; Bootstrap

;; Bootstrap my emacs config project

(defconst my-emacs-directory
  (file-name-directory
   (file-truename (or load-file-name buffer-file-name user-init-file)))
  "Root of my emacs configuration dir.")

(defconst my-lisp-directory (expand-file-name "lisp" my-emacs-directory)
  "Directory containing my personal libraries.")

(defconst my-init-directory (expand-file-name "init" my-emacs-directory)
  "Directory containing my personal initialization files.")

(defconst my-lisp-loaddefs-file (expand-file-name "my-lisp-loaddefs.el" my-lisp-directory)
  "File for automatically generated autoloads of my personal libraries.")

(defconst my-custom-file (make-temp-file "my-custom-" nil ".el")
  "My file where `custom' saves config.
I try to not depend on `custom'.  A temporary file ensures that
accidental writing to `custom' (by triggering commands that save the
custom's state) can't be loaded on next sesion.")

(add-to-list 'load-path my-lisp-directory)
(add-to-list 'custom-theme-load-path my-lisp-directory)
(loaddefs-generate my-lisp-directory my-lisp-loaddefs-file)
(load my-lisp-loaddefs-file nil t)

(add-to-list 'load-path my-init-directory)

;; Do this before anything that could write to custom file.
(setq custom-file my-custom-file) 

;; Bootstrap packages

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq
 package-selected-packages
 '(auto-dark avy
   breadcrumb
   corfu
   dired-subtree
   info-rename-buffer
   marginalia mwim
   nerd-icons nerd-icons-completion nerd-icons-corfu nerd-icons-dired
   orderless
   rainbow-delimiters
   vertico vterm))

(unless (seq-every-p #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (package-install-selected-packages :noconfirm))

;;;; Strata

(require 'my-defs)
(require 'my-bindings)

;;;; Ignition

;; load themes

(auto-dark-mode)
(load-theme 'ui-simple :no-confirm)

;; Start server

(require 'server)
(unless (server-running-p)
  (server-start))

;; Start modes

(electric-pair-mode)
(global-tab-line-mode)
(info-rename-buffer-mode)
(my-global-map-mode)
(nerd-icons-completion-mode)
(nerd-icons-tab-line-mode)
(save-place-mode)
(savehist-mode)
(theme-reload-mode)
(vertico-flat-mode)
(vertico-mode)
(vertico-multiform-mode)
