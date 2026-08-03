;;; my-x-vterm.el --- My `vterm' extensions.         -*- lexical-binding: t; -*-

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

(defun my-x-vterm-in-dir (dir)
  (interactive "DVterm in dir:")
  (let ((default-directory dir))
    (vterm)))

(defun my-x-vterm-dwim (&optional new)
  "Switch to a vterm buffer, or create a new one in a dir."
  (interactive "P")
  (if new
      (my-x-vterm-in-dir (read-directory-name "Vterm in dir: "))
    (switch-to-buffer
     (completing-read
      "Vterm Buffer: " 
      (completion-table-with-metadata
       (let (buffers
             (exclude (and (eq major-mode #'vterm-mode) (current-buffer))))
         (dolist (buffer (buffer-list))
           (when (and (with-current-buffer buffer (eq major-mode #'vterm-mode))
                      (not (eq buffer exclude)))
             (push (buffer-name buffer) buffers)))
         buffers)
       '((category . buffer)))
      nil
      :require-match))))


(defun my-x-vterm-rename (ps1-string)
  "Rename current buffer by ps1 string sent through vterm."
  (when (eq major-mode #'vterm-mode)
    (rename-buffer (format "vterm %s" ps1-string) :unique)))

(defun my-x-vterm-suspend-ssh ()
  "Send escape sequences for suspending ssh session."
  (interactive)
  (vterm-send-return)
  (vterm-send "~")
  (vterm-send "C-z"))

(defun my-x-vterm-close-ssh ()
  "Send escape sequences for suspending ssh session."
  (interactive)
  (vterm-send-return)
  (vterm-send "~")
  (vterm-send "."))

(provide 'my-x-vterm)
;;; my-x-vterm.el ends here
