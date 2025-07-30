;;; dirnav.el --- Dired Configuration -*- lexical-binding: t -*-

(defun my/dired-current-directory ()
  "Open Dired in the current buffer's directory in a new buffer."
  (interactive)
  (dired (expand-file-name default-directory)))

(evil-define-key 'normal 'global (kbd "<leader>dd") 'my/dired-current-directory)

;; Manual evil bindings for dired
(with-eval-after-load 'dired
  (evil-define-key 'normal dired-mode-map
    "j" 'dired-next-line
    "k" 'dired-previous-line
    "h" 'dired-up-directory
    "l" 'dired-find-file
    (kbd "RET") 'dired-find-file
    "q" 'quit-window
    "gr" 'revert-buffer
    "R" 'dired-do-rename
    "D" 'dired-do-delete
    "C" 'dired-do-copy
    "+" 'dired-create-directory
    "m" 'dired-mark
    "u" 'dired-unmark
    "U" 'dired-unmark-all-marks))

(provide 'dirnav)
;;; dirnav.el ends here
