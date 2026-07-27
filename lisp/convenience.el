;;; convenience.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco <nicolaspablo.gc@gmail.com>
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

;; Convinience commands and functions.

;;; Code:

(require 'window)
(require 'frame)
(require 'dired)

;;;###autoload
(defun dired-side-window-dwim ()
  "Display dired in a side window.
Defaults to project root, else the current directory."
  (interactive)
  (let ((current-dired-window
         (let ((current-default-directory default-directory))
           (car-safe
            (seq-filter
             (lambda (win)
               (with-current-buffer (window-buffer win)
                 (and (eq major-mode #'dired-mode)
                      (or
                       (string= default-directory
                                (and (project-current)
                                     (project-root (project-current))))
                       (string= default-directory
                                current-default-directory)))))
             (window-list))))))
    (if current-dired-window
        (with-selected-window current-dired-window
          (bury-buffer))
      (progn
        (other-side-window-prefix 'left)
        (dired (or (and (project-current)
                        (project-root (project-current)))
                   default-directory))
        (dired-hide-details-mode)))))


(provide 'convenience)
;;; convenience.el ends here
