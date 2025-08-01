;;; terminal.el --- Terminal configuration -*- lexical-binding: t -*-

;; VTerm - Better terminal emulator
(use-package vterm
  :straight (:host github :repo "akermu/emacs-libvterm" :commit "a5b5b53e1b5db42489c5b8c96a2aff0c02a4c08f")
  :config
  ;; Basic configuration
  (setq vterm-max-scrollback 10000)           ; Scrollback buffer size
  (setq vterm-buffer-name-string "vterm %s")  ; Buffer naming
  
  ;; Don't ask for confirmation when killing vterm buffers
  (setq vterm-kill-buffer-on-exit t)
  
  ;; Always start vterm in insert mode
  (add-hook 'vterm-mode-hook (lambda () (evil-insert-state)))
  
  ;; Enter insert mode when switching to any vterm buffer
  (add-hook 'buffer-list-update-hook
            (lambda ()
              (when (and (derived-mode-p 'vterm-mode)
                         (bound-and-true-p evil-mode)
                         (not (evil-insert-state-p)))
                (evil-insert-state)))))

;; Global keybinding for terminal
(evil-define-key 'normal 'global (kbd "<leader>tt") 'vterm)

(provide 'terminal)
;;; terminal.el ends here