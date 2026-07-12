;;; early-init.el ---                                -*- lexical-binding: t; -*-

(setq gc-cons-threshold (* 32 1024 1024))

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
(push '(horizontal-scroll-bars . nil) default-frame-alist)
