;;; my-x-bookmark.el --- My bookmark extensions.     -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Nicolas Gonzalez

;; Author: Nicolas Gonzalez <nico@thinkpad-nico>
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

(defun my-x-bookmark--url-jump (bookmark)
  "Open the URL stored in BOOKMARK with `browse-url'."
  (browse-url (bookmark-prop-get bookmark 'location)))

;; Emacs 29+: label these bookmarks as "URL" in the bookmark list (C-x r l)
(put 'my/bookmark-url-jump 'bookmark-handler-type "URL")

(defun my-x-bookmark-url (url name)
  "Create a bookmark NAME that opens URL with `browse-url'."
  (interactive
   (let ((url (read-string "URL: " (thing-at-point 'url))))
     (list url (read-string "Bookmark name: " url))))
  (bookmark-store name `((location . ,url)
                         (handler . my-x-bookmark--url-jump))
                  nil))

(provide 'my-x-bookmark)
;;; my-x-bookmark.el ends here
