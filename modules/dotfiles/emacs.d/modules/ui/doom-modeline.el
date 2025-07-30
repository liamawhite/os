;;; doom-modeline.el --- Doom modeline configuration -*- lexical-binding: t -*-

;; Doom Modeline - A fancy and fast mode-line
(use-package doom-modeline
  :straight (:host github :repo "seagle0128/doom-modeline" :commit "8b03a7ae6ea9c26e60b8b83c7ba5c46a8cc0c46c")
  :init
  (doom-modeline-mode 1)
  :config
  ;; Configuration options
  (setq doom-modeline-height 25)                                      ; Height of the modeline in pixels
  (setq doom-modeline-bar-width 4)                                    ; Width of the bar indicator

  ;; Enable modal display
  (setq doom-modeline-modal t)
  (setq doom-modeline-modal-icon nil)                                 ; Disable modal state icons (keep text)

  (setq doom-modeline-major-mode-icon t)                              ; Show major mode icon (e.g., language icons)
  ;; (setq doom-modeline-major-mode-color-icon t)                        ; Use colored major mode icons
  ;; (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)  ; Show file path relative to project
  ;; (setq doom-modeline-buffer-state-icon t)                            ; Show buffer state icons (modified, read-only, etc.)
  ;; (setq doom-modeline-buffer-modification-icon t)                     ; Show modification indicator
  ;; (setq doom-modeline-minor-modes nil)                                ; Hide minor modes list
  ;; (setq doom-modeline-enable-word-count nil)                          ; Disable word count display
  ;; (setq doom-modeline-buffer-encoding t)                              ; Show buffer encoding (UTF-8, etc.)
  ;; (setq doom-modeline-indent-info nil)                                ; Hide indentation info
  ;; (setq doom-modeline-checker-simple-format t)                        ; Use simple format for syntax checker
  ;; (setq doom-modeline-vcs-max-length 12)                              ; Max length for VCS branch names
  ;; (setq doom-modeline-env-version t)                                  ; Show environment version (Python, Node, etc.)
  ;; (setq doom-modeline-irc-stylize 'identity)                          ; IRC styling option
  ;; (setq doom-modeline-github-timer nil)                               ; Disable GitHub notifications timer
  ;; (setq doom-modeline-gnus-timer nil)                                 ; Disable Gnus mail timer
)

(provide 'doom-modeline)
;;; doom-modeline.el ends here
