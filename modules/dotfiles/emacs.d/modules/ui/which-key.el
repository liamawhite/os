;;; which-key.el --- Which-key configuration -*- lexical-binding: t -*-

;; Which-key - Shows available keybindings in popup
(use-package which-key
  :straight (:host github :repo "justbur/emacs-which-key" :commit "1e89fa000e9ba9549f15ef57abccd118d5f2fe32")
  :init
  (which-key-mode 1)
  :config
  ;; Configuration options
  (setq which-key-idle-delay 0.5)                    ; Show popup after 0.5 seconds
  (setq which-key-idle-secondary-delay 0.05)         ; Update popup quickly after first show
  (setq which-key-popup-type 'side-window)           ; Use side window for popup
  (setq which-key-side-window-location 'bottom)      ; Show at bottom
  (setq which-key-side-window-max-height 0.25)       ; Max 25% of frame height
  (setq which-key-side-window-max-width 0.33)        ; Max 33% of frame width
  (setq which-key-sort-order 'which-key-key-order-alpha) ; Sort alphabetically
  (setq which-key-show-prefix 'top)                  ; Show prefix at top
  (setq which-key-use-C-h-commands t)                 ; Enable C-h commands
  (setq which-key-enable-extended-define-key t)      ; Better integration with define-key
  
  ;; Appearance
  (setq which-key-separator " → ")                   ; Separator between key and description
  (setq which-key-prefix-prefix "+")                 ; Prefix indicator
  (setq which-key-max-description-length 32)         ; Max length of descriptions
  (setq which-key-ellipsis "…")                      ; Ellipsis for truncated text
  
  ;; Integration with evil mode
  (setq which-key-allow-evil-operators t)            ; Show evil operators
  (setq which-key-show-operator-state-maps t))       ; Show operator state maps

(provide 'which-key)
;;; which-key.el ends here