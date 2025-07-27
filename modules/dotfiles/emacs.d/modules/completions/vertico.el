;;; vertico.el --- Completion packages configuration -*- lexical-binding: t -*-

;; Vertico - Vertical completion UI
(use-package vertico
  :straight (:host github :repo "minad/vertico" :commit "d8178c64cf6f3f9647ca3b0d45b1a5ecb0cc7e52")
  :init
  (vertico-mode))

;; Orderless - Better filtering methods
(use-package orderless
  :straight (:host github :repo "oantolin/orderless" :commit "a5be52b1ee36bb82b09e6a6d8b9c4b5d6e479b42")
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion))))
)

;; Marginalia - Completion annotations
(use-package marginalia
  :straight (:host github :repo "minad/marginalia" :commit "ec5c8fdb9be2dea8e2b17e3a59c13b96cfc14a69")
  ;; :bind (:map minibuffer-local-map
         ;; ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;; Embark - Minibuffer actions
(use-package embark
  :straight (:host github :repo "oantolin/embark" :commit "7c4e9c5a85cdb0fc50f32db55c3e0b74de95b3e5")
  ;; :bind
  ;; (("C-." . embark-act)
  ;;  ("C-;" . embark-dwim))
  :init
  ;; ;; Optionally replace the key help with a completing-read interface
  ;; (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult - Enhanced commands using completing-read
(use-package consult
  :straight (:host github :repo "minad/consult" :commit "6de7b685a01a6a0ba11fe4d5dfc46134a86dd8d6")
  :bind (:map evil-normal-state-map
         ("<leader>fb" . consult-buffer)
         ("<leader>ff" . consult-fd)
         ("<leader>fg" . consult-ripgrep)))

;; Embark Consult integration
(use-package embark-consult
  :straight (:host github :repo "oantolin/embark" :commit "7c4e9c5a85cdb0fc50f32db55c3e0b74de95b3e5")
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(provide 'vertico)
;;; vertico.el ends here
