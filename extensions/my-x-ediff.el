;;; my-x-ediff.el --- My `ediff' extensions.         -*- lexical-binding: t; -*-

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

(require 'my-x-window)

(defun my-x-ediff-setup ()
  (tab-switch "ediff"))

(defun my-x-ediff-restore ()
  (with-demoted-errors "Error: %s"
    (tab-bar-close-tab-by-name "ediff")))

(defun my-x-ediff-prepare-buffer ()
  (unless (eq major-mode #'ediff-mode)
    (setq mode-line-format nil
          truncate-lines t)
    (my-x-window-unset-sibling-buffers)
    (display-line-numbers-mode 1)))

(defun ediff-copy-both-to-C ()
  "Merge both A and B in ediff for three way merge.
Thank you!: https://emacs.stackexchange.com/a/29316"
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))

(defun my-x-ediff--scroll (direction n)
  "In ediff, scroll horizontally N columns in DIRECTION."
  (let ((last-command-event
         (cond ((eq direction 'right) ?<)
               ((eq direction 'left) ?>)
               ((eq direction 'up) ?V)
               ((eq direction 'down) ?v)
               (t (error "Invalid direction: %s" direction))))
        (command (cond ((memq direction '(left right))
                        #'ediff-scroll-horizontally)
                       ((memq direction '(up down))
                        #'ediff-scroll-vertically)
                       (t (error "Invalid direction: %s" direction)))))
    (funcall command n)))

(defun my-x-ediff-scroll-right (n)
  "In ediff, scroll right N columns."
  (interactive "p")
  (my-x-ediff--scroll 'right n))

(defun my-x-ediff-scroll-left (n)
  "In ediff, scroll left N columns."
  (interactive "p")
  (my-x-ediff--scroll 'left n))

(defun my-x-ediff-scroll-up (n)
  "In ediff, scroll up N columns."
  (interactive "p")
  (my-x-ediff--scroll 'up n))

(defun my-x-ediff-scroll-down (n)
  "In ediff, scroll down N columns."
  (interactive "p")
  (my-x-ediff--scroll 'down n))


(provide 'my-x-ediff)
;;; my-x-ediff.el ends here
