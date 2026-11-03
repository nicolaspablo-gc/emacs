;;; my-x-telega.el --- My `telega' extensions.       -*- lexical-binding: t; -*-

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

(defun my-x-telega-isearch-backward-reply ()
  "Search backward and reply matched message."
  (isearch-backward)
  (when isearch-success
    (call-interactively #'telega-msg-reply)))

(defun my-x-telega-isearch-backward-dwim (&optional only-isearch)
  "Search backward and reply matched message.
With a prefix arg, only search backward."
  (interactive "P")
  (if only-isearch (isearch-backward) (my-x-telega-isearch-backward-reply)))

(provide 'my-x-telega)
;;; my-x-telega.el ends here
