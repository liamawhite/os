;;; ui.el --- UI configuration and cleanup -*- lexical-binding: t -*-

;; Disable startup and UI elements
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq frame-title-format nil)
(setq ns-use-proxy-icon nil)
(setq frame-resize-pixelwise t)
(add-to-list 'default-frame-alist '(undecorated . t))

(provide 'ui)
;;; ui.el ends here