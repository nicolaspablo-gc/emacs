;;; my-x-tab-line.el --- My `tab-line' extensions.   -*- lexical-binding: t; -*-

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

(defun my-x-tab-line-switch-to-buffer-tab (buffer-tab)
  "Switch to buffer tab `buffer-tab'."
  (interactive (list (get-buffer
                      (completing-read "Tab: "
                                       (completion-table-with-metadata
                                        (mapcar #'buffer-name (funcall tab-line-tabs-function))
                                        '((category . buffer)))
                                       nil
                                       :require-match))))
  (if (not (bufferp buffer-tab))
      (user-error "Tab `%s' is not a buffer." buffer-tab)
    (switch-to-buffer buffer-tab)))


(defun my-x-tab-line-switch-to-sibling-tab (direction &optional event)
  "Switch to a sibling tab, wrapping over from first to last.
Assumes tab-line is a flat list of buffers."
  (let* ((switch-function
          (cond ((eq direction 'left) #'tab-line-switch-to-prev-tab)
                ((eq direction 'right) #'tab-line-switch-to-next-tab)
                (t (error "Direction only can be 'left or 'right."))))
         (selected (current-buffer))
         (tabs (funcall tab-line-tabs-function))
         (first (car tabs))
         (last (car (last tabs))))
    (cond ((= (length tabs) 1)
           nil) ;; nothing to switch to
          ((and (eq direction 'left) (eq selected first))
           (tab-line-select-tab-buffer last))
          ((and (eq direction 'right) (eq selected last))
           (tab-line-select-tab-buffer first))
          (t
           (funcall switch-function event)))))

(defun my-x-tab-line-switch-to-next-tab (&optional event)
  "Switch to next tab, wrapping over from first to last."
  (interactive (list last-nonmenu-event))
  (my-x-tab-line-switch-to-sibling-tab 'right event))

(defun my-x-tab-line-switch-to-prev-tab (&optional event)
  "Switch to previous tab, wrapping over from first to last."
  (interactive (list last-nonmenu-event))
  (my-x-tab-line-switch-to-sibling-tab 'left event))

(provide 'my-x-tab-line)
;;; my-x-tab-line.el ends here
