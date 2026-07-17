;;; nerd-icons-tab-line.el --- Nerd-icons for the tab line. -*- lexical-binding: t; -*-

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

;; Personal library used for a while for adding nerd-icons to the tab line.

;;; Code:

(require 'tab-line)
(require 'nerd-icons)
(require 'format-spec)

(defgroup nerd-icons-tab-line nil
  "Nerd icons for the tab line."
  :group 'tab-line
  :prefix "nerd-icons-tab-line-")

(defface nerd-icons-tab-line-icon-face
  '((t :family "NotoSansM Nerd Font"))
  "Face for icons in the tab line.
Use it to define a family or more more properties.")

(defcustom nerd-icons-tab-line-icon-default '(faicon . "nf-fa-file_o")
  "Icon to be used when the tab line is not a buffer."
  :type '(cons (symbol :tag "Icon set")
               (string :tag "Icon name")))

(defcustom nerd-icons-tab-line-tab-format " %i %t "
  "Format for a tab.
%i is the icon, %t is the original formatted tab name."
  :type 'string)

(defun nerd-icons-tab-line--face (string)
  "Get the face of the first character of STRING."
  (get-text-property 0 'face string))

(defun nerd-icons-tab-line-format-wrapper (formatter tab tabs)
  "Wrap FORMATTER to format TAB TABS with a nerd icon.
FORMATTER is a function in the same interface of
`tab-line-tab-name-format-function', TAB and TABS are the arguments of
FORMATTER."
  (let ((name (funcall formatter tab tabs))
        (icon (if (bufferp tab)
                  (with-current-buffer tab (nerd-icons-icon-for-buffer))
                ;; Fallback to default icon
                (funcall (nerd-icons--function-name (car nerd-icons-tab-line-icon-default))
                         (cdr nerd-icons-tab-line-icon-default)))))
    (mapconcat (lambda (str)
                 (propertize
                  str
                  'face (cond ((string= str icon)
                               ;; Compose face by user preference, nerd icon
                               ;; face, and tab-line face.
                               `(:inherit (nerd-icons-tab-line-icon-face
                                           ,(nerd-icons-tab-line--face icon)
                                           ,(nerd-icons-tab-line--face name))))
                              (t (nerd-icons-tab-line--face name)))))
               (format-spec nerd-icons-tab-line-tab-format
                            `((?i . ,icon)
                              (?t . ,name))
                            :ignore-missing
                            :split))))

;;;###autoload
(define-minor-mode nerd-icons-tab-line-mode
  "Add `nerd-icons' to `tab-line'."
  :lighter nil
  :global t
  (if nerd-icons-tab-line-mode
      (add-function :around
                    tab-line-tab-name-format-function
                    #'nerd-icons-tab-line-format-wrapper
                    ;; Outermost
                    '(depth -100))
    (remove-function tab-line-tab-name-format-function
                     #'nerd-icons-tab-line-format-wrapper))
  (tab-line-force-update :all))

(provide 'nerd-icons-tab-line)
;;; nerd-icons-tab-line.el ends here
