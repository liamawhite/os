;;; init.el --- Main Emacs configuration -*- lexical-binding: t -*-

;; Load modules
(add-to-list 'load-path (expand-file-name "modules/core" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/themes" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/ui" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "modules/programs" user-emacs-directory))

(require 'core)
(require 'themes)
(require 'ui)
(require 'orgmode)
(require 'projectile)
(require 'completions)  ; Load completions last per user request

;; (require 'packages)
;; (require 'git)
;; (require 'terminal)
;; (require 'org-config)
;; (require 'keybindings)
