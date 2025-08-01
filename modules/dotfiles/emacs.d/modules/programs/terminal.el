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
  
  ;; Prevent vterm from sending certain keys to the shell
  (setq vterm-keymap-exceptions '("M-R" "M-j" "M-b"))
  
  ;; Disable Evil modal editing in vterm (but keep global keybindings)
  (evil-set-initial-state 'vterm-mode 'emacs)
  
  ;; Ensure vterm always uses emacs state and hide modeline
  (add-hook 'vterm-mode-hook 
            (lambda () 
              (when (bound-and-true-p evil-local-mode)
                (evil-local-mode -1))
              ;; Hide the modeline in vterm
              (setq-local mode-line-format nil)))
  
  ;; Override vterm keybindings to use Emacs commands
  (with-eval-after-load 'vterm
    ;; Bind keys directly in vterm-mode-map with higher priority
    (define-key vterm-mode-map (kbd "M-j") 'my/consult-projectile-switch-project)
    (define-key vterm-mode-map (kbd "M-b") 'consult-buffer)
    
    ;; For M-R M-R, we need to create a prefix keymap
    (define-prefix-command 'my/vterm-M-R-map)
    (define-key vterm-mode-map (kbd "M-R") 'my/vterm-M-R-map)
    (define-key my/vterm-M-R-map (kbd "M-R") 'restart-emacs)))

;; Global keybinding for terminal
(evil-define-key 'normal 'global (kbd "<leader>tt") 'vterm)

(provide 'terminal)
;;; terminal.el ends here