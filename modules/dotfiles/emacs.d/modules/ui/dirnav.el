;;; dirnav.el --- Dired Configuration -*- lexical-binding: t -*-

(defun my/dired-current-directory ()
  "Open Dired in the current buffer's directory in a new buffer."
  (interactive)
  (dired (expand-file-name default-directory)))

(defun my/dired-create-file ()
  "Create a new file in the current dired directory."
  (interactive)
  (let ((filename (read-string "Create file: ")))
    (when (and filename (not (string-empty-p filename)))
      (find-file (expand-file-name filename (dired-current-directory)))
      (save-buffer)
      (revert-buffer))))

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
    "N" 'my/dired-create-file
    "m" 'dired-mark
    "u" 'dired-unmark
    "U" 'dired-unmark-all-marks))

(provide 'dirnav)
;;; dirnav.el ends here
