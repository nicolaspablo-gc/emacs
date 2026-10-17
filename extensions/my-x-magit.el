;;; my-x-magit.el --- My `magit' extensions.         -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolas Pablo Gonzalez Carrasco

;; Author: Nicolas Pablo Gonzalez Carrasco <nico@localhost.localdomain>
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

(require 'my-x-window)

(defvar my-x-magit-frame-name "magit"
  "Name used for dedicated magit frames.")

(defun my-x-magit-bury-buffer-function (&optional _ _)
  "Function for `magit-bury-buffer-function'."
  (cond ((string= (frame-parameter nil 'name)
                  my-x-magit-frame-name)
         (delete-frame))
        (t (my-x-window-quit-dwim))))

(defun my-x-magit-from-cli ()
  "Set current frame as a magit dedicated frame and start magit.

Inteded to be called by cli \"emacsclient -c --eval '(magit)'\", which
blocks the shell until the frame exits."
  (set-frame-parameter nil 'name my-x-magit-frame-name)
  (set-frame-parameter nil 'tab-bar-lines 0)
  (magit-status)
  (set-window-prev-buffers (selected-window) nil)
  (set-window-next-buffers (selected-window) nil))

(provide 'my-x-magit)
;;; my-x-magit.el ends here
