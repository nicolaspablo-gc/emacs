;;; my-conf.el --- Commands for editing my emacs config.  -*- lexical-binding: t; -*-

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

(require 'dired-side-window)

(defmacro my-conf--with-defaults (&rest forms)
  "Run `forms' with emacs configuration defaults.
The defaults are:

- Buffers are displayed under a tab called `emacs'.

- The default directory is `my-emacs-directory' which is set to the root
  my emacs config project.
"
  `(let ((default-directory my-emacs-directory)
         (display-buffer-overriding-action
          '(display-buffer-in-tab
            (tab-name . "emacs"))))
    ,@forms))

(defun my-conf-find-file (&optional regular-find-file)
  "Find a file within `my-emacs-directory'.
By default this uses `project-find-file', but with a prefix argument it
calls regular `find-file' at the project root."
  (interactive "P")
  (my-conf--with-defaults
   (if regular-find-file
       (call-interactively #'find-file)
     (project-find-file :include-all))))

(defun my-conf--read-regexp (prompt)
  "Read a space separated string, tranform each space into \".*\""
  (replace-regexp-in-string " " ".*" (read-string prompt)))

(defun my-conf--occur (&optional regexp)
  "Call `occur' and jump to its window buffer."
  (occur (or regexp (my-conf--read-regexp "Search: ")))
  (pop-to-buffer "*Occur*"))

(defun my-conf--find-bindings-file ()
  "Jump to `my-init-bindings' file."
  (find-file (concat my-emacs-directory "my-bindings.el")))

(defun my-conf-find-binding ()
  "Find a binding in `my-init-bindings' file."
  (interactive)
  (my-conf--with-defaults
   (my-conf--find-bindings-file)
   (my-conf--occur)))

(defun my-conf-find-regexp ()
  (interactive)
  (my-conf--with-defaults
   (call-interactively #'project-find-regexp)))

(defun my-conf-vterm ()
  "Jump or create a vterm buffer in `my-emacs-directory'."
  (interactive)
  (my-conf--with-defaults
   (let ((buffer
          (seq-find
           (lambda (buffer)
             (with-current-buffer buffer
               (and (eq major-mode #'vterm-mode)
                    (string= (abbreviate-file-name my-emacs-directory)
                             (caddr (project-current))))))
           (buffer-list))))
     (display-buffer (or buffer (vterm))))))

(defun my-conf-workspace ()
  "Setup default workspace for editing my emacs config."
  (interactive)
  (my-conf--with-defaults
   (my-conf-vterm)
   (dired-side-window-dwim)))

(provide 'my-conf)
;;; my-conf.el ends here
