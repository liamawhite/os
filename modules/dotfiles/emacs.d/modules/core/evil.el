;;; evil.el --- Evil mode configuration -*- lexical-binding: t -*-

;; Evil - Vim emulation layer
(use-package evil
  :straight (:host github :repo "emacs-evil/evil" :commit "e97e5c76e07fa06b10b6fe28c6b106e65eb9a38e")
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  ;; Set leader key to Space
  (evil-set-leader 'normal (kbd "SPC"))
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  
  ;; Core keybindings
  (define-key global-map (kbd "M-R M-R") 'restart-emacs))

;; Evil Surround - Surround text objects
(use-package evil-surround
  :straight (:host github :repo "emacs-evil/evil-surround" :commit "e40dcf4b9efba31b8ae4c30dc6b78b24b1b37a1b")
  :after evil
  :config
  (global-evil-surround-mode 1))

(provide 'evil)
;;; evil.el ends here
