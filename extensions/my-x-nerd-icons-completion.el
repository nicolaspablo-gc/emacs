;;; my-x-nerd-icons-completion.el --- My `nerd-icons-completion' extensions.  -*- lexical-binding: t; -*-

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

(defun my-x-nerd-icons-completion-reactivate ()
  "Reactivate `nerd-icons-completion' if active.
This is needed because when `marginalia-mode' is enabled,
`nerd-icons-completion' needs to be reactivated to take effect."
  (when nerd-icons-completion-mode
    (nerd-icons-completion-mode -1)
    (nerd-icons-completion-mode +1)))

(provide 'my-x-nerd-icons-completion)
;;; my-x-nerd-icons-completion.el ends here
