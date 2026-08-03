;;; my-init-helpers.el --- Initialization helpers.   -*- lexical-binding: t; -*-

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

(require 'cl-lib)

(defmacro command (&rest forms)
  "Argless interactive `lambda'."
  `(lambda () (interactive) ,@forms))

(defun alist (&rest contents)
  "Build an alist consing each succesive element.

\(fn [CAR [CDR]]...)"
  (let (alist)
    (while contents
      (push (cons (pop contents) (pop contents)) alist))
    (nreverse alist)))

(defmacro alistq (&rest contents)
  "Build an alist consing each unevaluated element of CONTENTS."
  (let (alist)
    (while contents
      (push (cons (pop contents) (pop contents)) alist))
    `',(nreverse alist)))

(defun delete-lighters-after-load (file modes)
  "Delete MODES lighters after loading FILE.

FILE is the value expected by `with-eval-after-load', and is normally a
feature name.

MODES is either a symbol or a list of modes symbols and it specfieis all
the modes that should not have a lighter."
  (with-eval-after-load file
    (dolist (mode (ensure-list modes))
      (setq minor-mode-alist (assq-delete-all mode minor-mode-alist)))))

(defmacro delete-lighters-after-load-multi (&rest file-mode-pairs)
  "Call `delete-lighters-after-load' for each FILE MODES pair in FILE-MODE-PAIRS.

Both FILE and MODES are auto-quoted, so call with bare symbols/lists, e.g.:

  (delete-lighters-after-load-multi
    feature-1 mode-1
    feature-2 (mode-2 mode-3))"  
  (unless (cl-evenp (length file-mode-pairs))
    (error "Uneven number of arguments passed to `delete-lighters-after-load-multi'."))
  `(progn
     ,@(let (forms)
        (while file-mode-pairs
          (push `(delete-lighters-after-load ',(pop file-mode-pairs) ',(pop file-mode-pairs))
                forms))
        (nreverse forms))))


(provide 'my-init-helpers)
;;; my-init-helpers.el ends here
