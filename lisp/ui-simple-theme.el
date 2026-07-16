;;; ui-simple-theme.el --- Simple, dull theme for UI.

;; Copyright (C) 2025  Nicolás Pablo González Carrasco

;; Author: Nicolás Pablo González Carrasco <nicolaspablo.gc@gmail.com>
;; Keywords: faces

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

;; This theme provides color and faces for ui elements, such as
;; mode-line, tab-line, window-divider, etc.

;; Its designed with few shades of gray.  It's called simple, because
;; its simple, and dull.

;; The idea is that you load this theme /after/ you load your
;; favourite color themes.

;;;; TODO:

;; - add a `defgroup' declaration.

;; - Change defvar to defcustom, to trigger an update to
;;   face attributes.

;; - Define a custom variable for optionally reloading this theme on:

;;   - [ ] loading other themes

;;   - [ ] changing values in the customized color variables

;;   - [ ] user defined function

;;;; Known Bugs:
;;
;; - For some reason this theme doesn't work applied over
;;   `nano-theme'.

;;; Code:

(defvar ui-simple-dark-border-bg
  "gray9"
  "Dark border background color for `ui-simple' theme.")

(defvar ui-simple-dark-border-fg
  "gray20"
  "Dark border foreground color for `ui-simple' theme.")

(defvar ui-simple-dark-inactive-bg
  "gray17"
  "Dark inactive background color for `ui-simple' theme.")

(defvar ui-simple-dark-inactive-fg
  "gray47"
  "Dark inactive foreground color for `ui-simple' theme.")

(defvar ui-simple-light-border-bg
  "gray93"
  "Light border background color for `ui-simple' theme.")

(defvar ui-simple-light-border-fg
  "gray84"
  "Light border foreground color for `ui-simple' theme.")

(defvar ui-simple-light-inactive-bg
  "gray88"
  "Light inactive background color for `ui-simple' theme.")

(defvar ui-simple-light-inactive-fg
  "gray55"
  "Light inactive foreground color for `ui-simple' theme.")

(defface ui-simple-dark-border-bg-face
  `((t :background ,ui-simple-dark-border-bg))
  "Dark border background face for `ui-simple' theme.")

(defface ui-simple-dark-border-fg-face
  `((t :foreground ,ui-simple-dark-border-fg))
  "Dark border foreground face for `ui-simple' theme.")

(defface ui-simple-dark-inactive-bg-face
  `((t :background ,ui-simple-dark-inactive-bg))
  "Dark inactive background face for `ui-simple' theme.")

(defface ui-simple-dark-inactive-fg-face
  `((t :foreground ,ui-simple-dark-inactive-fg))
  "Dark inactive foreground face for `ui-simple' theme.")

(defface ui-simple-light-border-bg-face
  `((t :background ,ui-simple-light-border-bg))
  "Light border background face for `ui-simple' theme.")

(defface ui-simple-light-border-fg-face
  `((t :foreground ,ui-simple-light-border-fg))
  "Light border foreground face for `ui-simple' theme.")

(defface ui-simple-light-inactive-bg-face
  `((t :background ,ui-simple-light-inactive-bg))
  "Light inactive background face for `ui-simple' theme.")

(defface ui-simple-light-inactive-fg-face
  `((t :foreground ,ui-simple-light-inactive-fg))
  "Light inactive foreground face for `ui-simple' theme.")

(deftheme ui-simple "Simple, dull theme for UI.")

(let* ((default-bg (face-attribute 'default :background))
       (cursor (face-attribute 'cursor :background))
       (light-p '((background light) (class color) (min-colors 256)))
       (dark-p  '((background dark)  (class color) (min-colors 256)))
       (light-tty-p '((background light) (type tty)))
       (dark-tty-p '((background dark) (type tty))))
  (custom-theme-set-faces
   'ui-simple
   `(corfu-default
     ((t :background ,default-bg)))
   `(corfu-indexed
     ((t :background ,default-bg :foreground ,ui-simple-light-inactive-fg)))
   `(eldoc-box-border
     ((,light-p :background ,ui-simple-light-border-fg)
      (,dark-p  :background ,ui-simple-dark-border-fg)))
   `(fringe
     ((default :background reset)))
   `(header-line
     ((,light-p :background reset :box (:style released-button :color ,ui-simple-light-border-fg))
      (,dark-p  :background reset :box (:style pressed-button :color ,ui-simple-dark-border-fg ))))
   '(line-number
     ((t :background reset)))
   `(mode-line
     ((,light-p :background reset :box ,ui-simple-light-border-fg )
      (,dark-p  :background reset :box ,ui-simple-dark-border-fg  )))
   `(mode-line-active
     ((,light-p :inherit mode-line :background reset :box ,ui-simple-light-border-fg)
      (,dark-p  :inherit mode-line :background reset :box ,ui-simple-dark-border-fg )))
   `(mode-line-inactive
     ((,light-p :background reset :foreground ,ui-simple-light-inactive-fg :box ,ui-simple-light-border-fg)
      (,dark-p  :background reset :foreground ,ui-simple-dark-inactive-fg :box ,ui-simple-dark-border-fg)))
   '(ruler-mode-default
     ((t :background reset)))
   `(ruler-mode-current-column
     ((t :inherit hl-line :foreground ,cursor)))
   `(scroll-bar
     ((default :background ,default-bg)
      (,light-p :foreground ,ui-simple-light-inactive-bg)
      (,dark-p :foreground ,ui-simple-dark-inactive-bg)))
   `(tab-bar
     ((,light-p :background ,ui-simple-light-border-bg)
      (,dark-p  :background ,ui-simple-dark-border-bg)
      (t :background reset)))
   `(tab-bar-echo-area-tab
     ((default :box nil)
      (,light-p :background reset :underline (:position 0 :color ,ui-simple-light-border-fg))
      (,dark-p  :background reset :underline (:position 0 :color ,ui-simple-dark-border-fg))))
   `(tab-bar-tab
     ((default  :box nil)
      (,light-p :background reset :underline (:position 0 :color ,ui-simple-light-border-fg))
      (,dark-p  :background reset :underline (:position 0 :color ,ui-simple-dark-border-fg))))
   `(tab-bar-tab-inactive
     ((default :box nil)
      (,light-p :background ,ui-simple-light-inactive-bg :foreground ,ui-simple-light-inactive-fg)
      (,dark-p :background ,ui-simple-dark-inactive-bg :foreground ,ui-simple-dark-inactive-fg)
      (t :inverse-video t)))
   `(tab-line
     ((,light-p :background ,ui-simple-light-border-bg :overline ,ui-simple-light-border-bg)
      (,dark-p  :background ,ui-simple-dark-border-bg)
      (t :background reset)))
   `(tab-line-tab
     ((default :background reset)
      (,light-p :box ,default-bg :foreground ,ui-simple-light-inactive-fg)
      (,dark-p  :box ,default-bg :foreground ,ui-simple-dark-inactive-fg)))
   `(tab-line-tab-current
     ((default :background reset :foreground reset)
      (((class color) (min-colors 256)) :box ,default-bg)))
   `(tab-line-tab-inactive
     ((,light-p :box ,ui-simple-light-border-fg :background ,ui-simple-light-inactive-bg :foreground ,ui-simple-light-inactive-fg)
      (,dark-p :box ,ui-simple-dark-border-fg :background ,ui-simple-dark-inactive-bg :foreground ,ui-simple-dark-inactive-fg)
      (((type tty) (background dark)) :background "black" :foreground "black" :weight bold)))
   `(vertical-border
     ((,light-p :foreground ,ui-simple-light-border-fg :background ,ui-simple-light-border-fg)
      (,dark-p  :foreground ,ui-simple-dark-border-fg  :background ,ui-simple-dark-border-fg)))
   `(window-divider
     ((,light-p :foreground ,ui-simple-light-border-bg)
      (,dark-p  :foreground ,ui-simple-dark-border-bg)))
   `(window-divider-first-pixel
     ((,light-p :foreground ,ui-simple-light-border-bg)
      (,dark-p  :foreground ,ui-simple-dark-border-bg)))
   `(window-divider-last-pixel
     ((,light-p :foreground ,ui-simple-light-border-bg)
      (,dark-p  :foreground ,ui-simple-dark-border-bg)))))

(provide-theme 'ui-simple)
(provide 'ui-simple-theme)

;; `outline-regexp' is set to match each entry in the
;; `custom-theme-set-faces' block:

;; Local Variables:
;; outline-regexp: "   [`']([[:alnum:]-]+"
;; End:
