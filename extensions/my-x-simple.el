;;; my-x-simple.el --- My `simple' extensions.       -*- lexical-binding: t; -*-

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

(defun my-x-simple-yank-dwim (&optional yank-from-kill-ring)
  "DWIM between `yank', `yank-pop' and `yank-from-kill-ring'.
If called for the first time, then call `yank'.
If called consecutively, then call `yank-pop'.
Finally, at any moment, if called with a prefix arg, then call `yank-from-kill-ring'."
  (interactive "P")
  (call-interactively
   (cond (yank-from-kill-ring #'yank-from-kill-ring)
         ((eq last-command #'yank) #'yank-pop)
         ((eq last-command #'vterm-yank) #'vterm-yank-pop)
         ((eq major-mode #'vterm-mode) #'vterm-yank)
         (t #'yank))
   t))

(defun my-x-simple-downward-delete-indentation (&optional arg beg end)
  "Delete indentation downwards."
  (interactive
   (cons (if (numberp current-prefix-arg) (- current-prefix-arg) -1)
         (and (use-region-p)
              (list (region-beginning) (region-end)))))
  (delete-indentation arg beg end))

(defun my-x-simple-unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty.
Source: https://www.emacswiki.org/emacs/MarkCommands#h5o-4"
  (interactive)
  (when mark-ring
    (let ((pos (marker-position (car (last mark-ring)))))
      (if (not (= (point) pos))
          (goto-char pos)
        (setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
        (set-marker (mark-marker) pos)
        (setq mark-ring (nbutlast mark-ring))
        (goto-char (marker-position (car (last mark-ring))))))))

(defun my-x-simple-forward-delete-indentation (&optional arg beg end)
  "Like `delete-indentation' but going forward."
  (interactive
   (cons (if (numberp current-prefix-arg) (- current-prefix-arg) -1)
         (and (use-region-p)
              (list (region-beginning) (region-end)))))
  (delete-indentation arg beg end))

(defun my-x-simple-keyboard-quit-dwim ()
  "If on the minibuffer call `abort-minibuffer', else call `keyboard-quit'."
  (call-interactively
   (cond ((major-mode-p 'minibuffer-mode) #'abort-minibuffers)
         (t #'keyboard-quit))))

(provide 'my-x-simple)
;;; my-x-simple.el ends here
