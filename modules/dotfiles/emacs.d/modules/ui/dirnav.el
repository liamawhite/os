;;; dirnav.el --- Dired Configuration -*- lexical-binding: t -*-

(defun my/dired-current-directory ()
  "Open Dired in the current buffer's directory in a new buffer."
  (interactive)
  (dired (expand-file-name default-directory)))

(evil-define-key 'normal 'global (kbd "<leader>dd") 'my/dired-current-directory)

(provide 'dirnav)
;;; dirnav.el ends here
