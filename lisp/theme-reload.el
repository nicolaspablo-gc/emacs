;;; theme-reload.el --- Reload a set of themes on any theme activation.  -*- lexical-binding: t; -*-

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

;; Some themes are meant to be used as "configurations" layered on top
;; of existing themes.  For this themes it becomes useful to be able
;; to automatically reload them whenever any theme is loaded.  This
;; package allows you to define such themes:

;;    (setq theme-reload-themes '(my-theme-1 my-theme-2))

;; so that whenever any theme is enabled, all these themes are
;; reloaded.

;;; Code:

(defgroup theme-reload nil
  "Reload themes when any theme is enabled."
  :group 'faces)

(defcustom theme-reload-themes '()
  "List of themes to reload whenever any mode is enabled.
Note that these are reloaded only if enabled.")

(defun theme-reload--reload-themes (theme)
  "Upon loading THEME reload all enabled themes of `theme-reload-themes'."
  ;; Guard against reloading THEME itself (inf loop).
  (unless (seq-contains-p (append '(user) theme-reload-themes)
                          theme
			  #'eq)
     (dolist (reload-theme (reverse theme-reload-themes))
       (when (custom-theme-enabled-p reload-theme)
	(load-theme reload-theme 'no-confirm)))))

;;;###autoload
(define-minor-mode theme-reload-mode
  "Reload `theme-reload-themes' whenever any theme is loaded."
  :lighter nil
  :global t
  (dolist (hook '(enable-theme-functions
		  disable-theme-functions))
    (funcall (if theme-reload-mode #'add-hook #'remove-hook)
	     hook
	     #'theme-reload--reload-themes)))

(provide 'theme-reload)
;;; theme-reload.el ends here
