;;; catppuccin.el --- Catppuccin theme configuration -*- lexical-binding: t -*-

;; Catppuccin - Modern pastel theme
(use-package catppuccin-theme
  :straight (:host github :repo "catppuccin/emacs" :commit "9034b9b71f8b79fbe5e700c8bd0ff71b92e33f18")
  :config
  ;; Set the variant to mocha (dark)
  (setq catppuccin-flavor 'mocha)
  ;; Load the theme
  (load-theme 'catppuccin :no-confirm))

(provide 'catppuccin)
;;; catppuccin.el ends here