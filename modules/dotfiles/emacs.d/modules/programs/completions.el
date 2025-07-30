;;; completions.el --- Completion system configuration -*- lexical-binding: t -*-

;; Load completion packages
(require 'vertico)

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