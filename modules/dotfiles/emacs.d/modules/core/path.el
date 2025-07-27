;;; path.el --- Core shell setup -*- lexical-binding: t -*-

;; Ensure Emacs uses the shell PATH
(use-package exec-path-from-shell
  :straight (:host github :repo "purcell/exec-path-from-shell" :commit "72ede29a0e0467b3b433e8edbee3c79bab005884")
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(provide 'path)
;;; path.el ends here
