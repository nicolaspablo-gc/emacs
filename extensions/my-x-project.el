;;; my-x-project.el --- My `project' extensions.     -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nico

;; Author: Nico <nico@thinkpad-nico>
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

(require 'project)

(defun my-x-project-find-regexp (regexp)
  "`project-find-regexp' but all spaces are transformed to \".*\"."
  (interactive "sRegexp: ")
  (project-find-regexp (string-replace " " ".*" regexp)))

(defun my-x-project--dir-to-name (dir)
  (file-name-base (directory-file-name dir)))

(defun my-x-project--pick ()
  "Pick a project."
  (project--ensure-read-project-list)
  (when (null project--list)
    (user-error "No seen projects."))
  (let* ((projects
          (mapcar (lambda (p)
                    (cons (my-x-project--dir-to-name (car p))
                          (car p)))
                  project--list))
         (name (completing-read "Project: " projects nil t)))
    (list
     :root (if (string= "" name)
               (user-error "No project picked.")
             (expand-file-name (cdr (assoc name projects #'string=))))
     :name name)))

(defmacro my-x-project--with-select-workspace (&rest forms)
  `(progn
     (let* ((p (my-x-project--pick))
            (default-directory (plist-get p :root))
            (display-buffer-overriding-action
             `(display-buffer-in-tab
               (tab-name . ,(plist-get p :name)))))
       ,@forms)))

(defun my-x-project-workspace-execute-command ()
  "Choose a project and execute an extended command."
  (interactive)
  (my-x-project--with-select-workspace
   (call-interactively #'execute-extended-command)))

(defun my-x-project-workspace-execute-command-by-keyseq ()
  "Choose a project and input a key sequence to run a command."
  (interactive)
  (my-x-project--with-select-workspace
   (let* ((keys (read-key-sequence "Key sequence: "))
          (cmd (key-binding keys)))
     (if cmd
         (call-interactively cmd)
       (user-error "%s is undefined" (key-description keys))))))

(defun my-x-project-workspace-vterm ()
  "Choose a project and switch to a vterm buffer in it."
  (interactive)
  (let* ((p (my-x-project--pick))
         (b (seq-find (lambda (b)
                        (with-current-buffer b
                          (and (eq major-mode #'vterm-mode)
                               (project-current)
                               (string= (expand-file-name (nth 2 (project-current)))
                                        (plist-get p :root)))))
                      (buffer-list)))
         (default-directory (plist-get p :root))
         (display-buffer-overriding-action
          `(display-buffer-in-tab (tab-name . ,(plist-get p :name)))))
    (pop-to-buffer (or b (vterm)))))

(defun my-x-project-workspace-find-regexp ()
  "Choose a project and execute an extended command."
  (interactive)
  (my-x-project--with-select-workspace
   (call-interactively #'my-x-project-find-regexp)))

(defun my-x-project-workspace-find-file ()
  "Choose a project and then a file in its workspace."
  (interactive)
  (my-x-project--with-select-workspace
   (call-interactively #'project-find-file)))


(provide 'my-x-project)
;;; my-x-project.el ends here
