;;; init.el ---                                      -*- lexical-binding: t; -*-

;;;; Bootstrap

;; Bootstrap my emacs config project

(defconst my-emacs-directory
  (file-name-directory
   (file-truename (or load-file-name buffer-file-name user-init-file)))
  "Root of my emacs configuration dir.")

(defconst my-lisp-directory (expand-file-name "lisp" my-emacs-directory)
  "Directory containing my personal libraries.")

(defconst my-lisp-loaddefs (expand-file-name "my-lisp-loaddefs.el" my-lisp-directory)
  "File for automatically generated autoloads of my personal libraries.")

(defconst my-extensions-directory (expand-file-name "extensions" my-emacs-directory)
  "Directory containing my personal extensions of libraries.")

(defconst my-definitions-directory (expand-file-name "defs" my-emacs-directory)
  "Directory containing my personal definitions.")

(defconst my-init-directory (expand-file-name "init" my-emacs-directory)
  "Directory containing my init files.")

(defconst my-custom-file (make-temp-file "my-custom-" nil ".el")
  "My file where `custom' saves config.
I try to not depend on `custom'.  A temporary file ensures that
accidental writing to `custom' (by triggering commands that save the
custom's state) can't be loaded on next sesion.")

(add-to-list 'load-path my-emacs-directory)
(add-to-list 'load-path my-lisp-directory)
(add-to-list 'load-path my-definitions-directory)
(add-to-list 'load-path my-init-directory)
(add-to-list 'custom-theme-load-path my-lisp-directory)
(add-to-list 'load-path my-extensions-directory)

;; There used to be more dirs where I generated loaddefs.  Now theres
;; only one, but I keep the alist idioms in case I need to add more
;; dirs.
(dolist (dir-file (list (cons my-lisp-directory my-lisp-loaddefs)))
  (loaddefs-generate (car dir-file) (cdr dir-file))
  (load (cdr dir-file) nil t))

;; Bootstrap packages

(require 'my-packages)

;;;; Setup

;; First, definitions and extensions, then apply bindings, finally
;; enable modes and themes.

;; definitions, dinamically require all `my-' files in `my-definitions-directory'.
(dolist (file (directory-files my-definitions-directory nil "my-.*\\.el\\'"))
  (require (intern (file-name-sans-extension file))))

;; extensions, dinamically require all `my-x' files in `my-extensions-directory'.
(dolist (file (directory-files my-extensions-directory nil "my-x.*\\.el\\'"))
  (require (intern (file-name-sans-extension file))))

;; Apply bindings
(require 'my-bindings)

;; Load themes.

(auto-dark-mode)
(load-theme 'ui-simple :no-confirm)

;; Start server.

(require 'server)
(unless (server-running-p)
  (server-start))

;; Start modes

(electric-pair-mode)
(global-tab-line-mode)
(tab-bar-history-mode)
(info-rename-buffer-mode)
;;(my-global-map-mode)
(nerd-icons-completion-mode)
(nerd-icons-tab-line-mode)
(save-place-mode)
(savehist-mode)
(theme-reload-mode)
(vertico-flat-mode)
(vertico-mode)
(vertico-multiform-mode)
(remove-hook 'minibuffer-setup-hook #'my-insert-mode)
(visible-mark-mode)
(recentf-mode)

;; Load local file if exists

(when (locate-library "local.el")
  (require 'local))
