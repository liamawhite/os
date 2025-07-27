;;; init.el --- Main Emacs configuration -*- lexical-binding: t -*-

;; Load modules
(add-to-list 'load-path (expand-file-name "modules/core" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/completions" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/themes" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/org" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/ui" user-emacs-directory))

(require 'core)
(require 'completions)
(require 'themes)
(require 'orgmode)
(require 'ui)

;; (require 'packages)
;; (require 'git)
;; (require 'terminal)
;; (require 'org-config)
;; (require 'keybindings)
