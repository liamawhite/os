;;; straight.el --- Straight.el package manager bootstrap -*- lexical-binding: t -*-

;; Bootstrap straight.el package manager
;; This code installs and sets up straight.el for package management

(defvar bootstrap-version)
(let ((bootstrap-file
       ;; Path to the straight.el bootstrap file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  ;; If bootstrap file doesn't exist, download it
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        ;; Download the installer script from GitHub
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      ;; Execute the installer
      (eval-print-last-sexp)))
  ;; Load the bootstrap file to initialize straight.el
  (load bootstrap-file nil 'nomessage))

(provide 'straight)
;;; straight.el ends here
