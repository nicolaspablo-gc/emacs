;;; init.el ---                                      -*- lexical-binding: t; -*-

(defvar emacs-home (file-name-directory (file-truename load-file-name))
  "Directory where I place all my config files.")

(add-to-list 'load-path emacs-home)
(add-to-list 'load-path (concat emacs-home "lib/"))
(add-to-list 'custom-theme-load-path (concat emacs-home "lib/"))

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; First time emacs startup.
(unless package-archive-contents
  (package-refresh-contents))

(require 'packages)
