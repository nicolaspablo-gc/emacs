;;; init.el ---                                      -*- lexical-binding: t; -*-

;;;; Defs

(defconst my-config-directory
  (file-name-directory
   (file-truename (or load-file-name buffer-file-name
                      user-init-file)))
  "Root of my Emacs configuration.")

(defconst my-lisp-directory (expand-file-name "lisp" my-config-directory))
(defconst my-init-directory (expand-file-name "init" my-config-directory))


;;;; Init

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(add-to-list 'load-path my-lisp-directory)
(add-to-list 'custom-theme-load-path my-lisp-directory)

(load (expand-file-name "packages" my-init-directory))

