;;; ui_elements.el --- UI configuration and cleanup -*- lexical-binding: t -*-

;; Disable startup and UI elements
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message (user-login-name))
(setq initial-scratch-message nil)
(setq inhibit-startup-buffer-menu t)

;; Clear the echo area after startup
(add-hook 'emacs-startup-hook (lambda () (message "")))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq frame-title-format nil)
(setq ns-use-proxy-icon nil)
(setq frame-resize-pixelwise t)
(add-to-list 'default-frame-alist '(undecorated . t))

;; Font configuration
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font")
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font")

(provide 'ui_elements)
;;; ui_elements.el ends here
