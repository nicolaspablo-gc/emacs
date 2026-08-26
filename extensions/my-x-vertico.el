;;; my-x-vertico.el --- My `vertico' extensions.     -*- lexical-binding: t; -*-

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

(defun my-x-vertico-flat-setup ()
  "Setup vertico flat."
  ;; Enable/disable marginalia wether entering or leaving vertico flat
  ;; mode, but only if vertico is enabled.
  (marginalia-mode
   (if (and vertico-mode (not vertico-flat-mode)) 1 -1))
  ;; Add more candidates if flat mode is activated. Flat automatically
  ;; fits as much as can, so its set to 100, in case that names are
  ;; short, I don't want to loose screen size by having at so its set
  ;; to 100.
  (setq vertico-count (if vertico-flat-mode 100 10)))

(provide 'my-x-vertico)
;;; my-x-vertico.el ends here
