;;; completions.el --- Completion system configuration -*- lexical-binding: t -*-

;; Vertico - Vertical completion UI
(use-package vertico
  :straight (:host github :repo "minad/vertico" :commit "d8178c64cf6f3f9647ca3b0d45b1a5ecb0cc7e52")
  :init
  (vertico-mode))

;; Vertico Posframe - Floating window for completions
(use-package vertico-posframe
  :straight t
  :after vertico
  :config
  (vertico-posframe-mode 1)
  ;; Window sizing
  (setq vertico-posframe-width 140)
  (setq vertico-posframe-height 30)
  ;; Show more results
  (setq vertico-count 24))

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
         ("<leader>ff" . consult-fd)
         ("<leader>fg" . consult-ripgrep))
  :bind (("M-j" . my/consult-projectile-switch-project)
         ("M-b" . consult-buffer)))

;; Custom function to use consult interface but respect projectile action
(with-eval-after-load 'consult
  (defun my/consult-projectile-switch-project ()
    "Switch to project using consult interface and run projectile action."
    (interactive)
    (let ((project (consult--read (projectile-relevant-known-projects)
                                  :prompt "Switch to project: "
                                  :sort nil
                                  :category 'project)))
      (when project
        ;; Set default-directory and call the action directly
        (let ((default-directory project))
          (funcall projectile-switch-project-action))))))

;; Embark Consult integration
(use-package embark-consult
  :straight (:host github :repo "oantolin/embark" :commit "7c4e9c5a85cdb0fc50f32db55c3e0b74de95b3e5")
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Enable savehist-mode to persist history over Emacs restarts
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations for completion
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Support opening new minibuffers from inside existing minibuffers
  (setq enable-recursive-minibuffers t)

  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current mode
  (when (>= emacs-major-version 28)
    (setq read-extended-command-predicate #'command-completion-default-include-p))

  :custom
  ;; TAB cycle if there are only few candidates
  (completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key
  (tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function
  (when (>= emacs-major-version 30)
    (text-mode-ispell-word-completion nil)))

;; Manual evil bindings for vertico
(with-eval-after-load 'vertico
  (evil-define-key 'normal vertico-map
    "j" 'vertico-next
    "k" 'vertico-previous
    "gg" 'vertico-first
    "G" 'vertico-last
    "q" 'minibuffer-keyboard-quit
    [escape] 'minibuffer-keyboard-quit))

(provide 'completions)
;;; completions.el ends here