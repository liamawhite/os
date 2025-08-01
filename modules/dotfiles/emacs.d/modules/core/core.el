;;; core.el --- Core module loader -*- lexical-binding: t -*-

;; Mac-specific key bindings
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)     ; Cmd key is Meta
  (setq mac-option-modifier 'super)     ; Option key is Super
  (setq mac-control-modifier 'control)  ; Control key stays Control
  (setq mac-function-modifier 'hyper))  ; Function key is Hyper

;; Load all core modules
(require 'straight)
(require 'path)
(require 'ui_elements)
(require 'evil)

(provide 'core)
;;; core.el ends here
