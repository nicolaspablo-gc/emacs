;;; autorequire.el --- Auto `require' features by name convention.  -*- lexical-binding: t; -*-

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

;;; Code:

(defun autorequire (prefix)
  "Setup autorequire for features prefixed by containing PREFIX.

This creates the function `autorequire--PREFIX-features' that is added
to `after-load-functions'.

For any feature Y being loaded, if a feature X exists that when stripped
of PREFIX equals Y, load X after Y.  For example, if \\=`foo' is being
loaded, and PREFIX equals \"my-\", and a file \\=`my-foo' exists,
\\=`my-foo' will automatically load after \\=`foo'."
  (add-hook 'after-load-functions (autorequire--make-fn prefix)))

(defun autorequire-clear (prefix)
  "Clear the auto require function created by PREFIX from `after-load-functions'."
  (remove-hook 'after-load-functions (autorequire--fn-name prefix)))

(defun autorequire--fn-name (prefix)
  "Return the name (a symbol) of the autorequire function for `prefix'."
  (intern (format "autorequire--%s-features" prefix)))

(defun autorequire--make-fn (prefix)
  "Creates the autorequire function for prefix."
  (defalias (autorequire--fn-name prefix)
    (lambda (file)
      (let* ((autorequired-name (format "%s%s" prefix (file-name-base file)))
             (autorequired (intern autorequired-name)))
        (when (and (not (featurep autorequired)) ;; not loaded
                   (locate-library autorequired-name) ;; exists
                   ;; avoid loading two times `autorequired' when
                   ;; `autorequired' contains a `(require loaded)'
                   ;; form inside.
                   (not (and load-file-name
                             (equal (file-name-base load-file-name)
                                    autorequired-name))))
          (require autorequired))))))


(provide 'autorequire)
;;; autorequire.el ends here
