;;; dired-side-window.el --- Dired side window mode  -*- lexical-binding: t; -*-

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

(defvar dired-side-window-side 'left
  "Side to display the dired side window.")

(defvar-keymap dired-side-window-map
  :doc "Keymap for dired in side window."
  :parent dired-mode-map)

(defvar dired-side-window-hook '()
  "Hook for dired side window.")

(defvar dired-side-window-display-buffer-base-action nil
  "Optional action for buffers created from dired side window.")

(defun dired-side-window--enable ()
  (when (eq major-mode #'dired-mode)
    (use-local-map dired-side-window-map)
    (run-hooks 'dired-side-window-hook)
    (when dired-side-window-display-buffer-alist
      (setq-local display-buffer-base-action
                  dired-side-window-display-buffer-alist))))

(defun dired-side-window-dwim (&optional dir)
  "Display dired in a side window.
"
  (interactive
   (list (when current-prefix-arg
           (read-directory-name "Directory: "))))
  (cond
   ((and (eq major-mode #'dired-mode)
         (window-at-side-p nil dired-side-window-side))
    (bury-buffer))
   (t
    (let* ((dir
            (file-name-as-directory
             (expand-file-name
              (or dir
                  (caddr (project-current))
                  default-directory))))
           (display-buffer-overriding-action
            `(display-buffer-in-side-window
              (side . ,dired-side-window-side)))
           (exists (dired-find-buffer-nocreate dir)))
      (dired dir)
      (unless exists
        (with-current-buffer (dired-find-buffer-nocreate dir)
          (dired-side-window--enable)))))))

(provide 'dired-side-window)
;;; dired-side-window.el ends here
