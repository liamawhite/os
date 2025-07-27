;;; early-init.el --- Early Emacs initialization -*- lexical-binding: t -*-

;; Temporarily increase gc-cons-threshold for faster startup
(setq gc-cons-threshold most-positive-fixnum)

;; Disable package.el at startup to handle it ourselves
(setq package-enable-at-startup nil)

;; Restore gc threshold after init
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216))) ; 16MB

;;; early-init.el ends here