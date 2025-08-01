;;; projectile.el --- Projectile project management -*- lexical-binding: t -*-

;; Projectile - Project management and navigation
(use-package projectile
  :straight (:host github :repo "bbatsov/projectile" :commit "fd5d15538862c818e27e56c3a9eac0b1ead2b5c1")
  :init
  (projectile-mode +1)
  :config
  ;; Basic configuration
  (setq projectile-completion-system 'default)  ; Use default completion (integrates with vertico/consult)
  (setq projectile-indexing-method 'hybrid)     ; Fast indexing with fallback
  (setq projectile-enable-caching t)            ; Enable caching for better performance
  (setq projectile-require-project-root nil)    ; Allow projectile outside of projects
  
  ;; File discovery settings
  (setq projectile-generic-command "find . -type f -print0")  ; Fast file finding
  (setq projectile-git-command "git ls-files -zco --exclude-standard")  ; Git-aware file listing
  
  ;; Project discovery (handled by custom function below)
  (setq projectile-project-search-path '())
  
  ;; Custom function to discover all directories under github.com/*/* and ~/org/* as projects
  (defun my/discover-projects ()
    "Discover all directories under ~/github.com/*/*, ~/github.docusignhq.com/*/*, and ~/org/* as projects"
    ;; Discover github.com/*/* projects
    (let ((github-dir (expand-file-name "~/github.com/")))
      (when (file-directory-p github-dir)
        ;; Loop through each user directory
        (dolist (user-dir (directory-files github-dir t "^[^.]"))
          (when (file-directory-p user-dir)
            ;; Loop through each repo directory under the user
            (dolist (repo-dir (directory-files user-dir t "^[^.]"))
              (when (file-directory-p repo-dir)
                (projectile-add-known-project repo-dir)))))))
    
    ;; Discover github.docusignhq.com/*/* projects
    (let ((docusign-github-dir (expand-file-name "~/github.docusignhq.com/")))
      (when (file-directory-p docusign-github-dir)
        ;; Loop through each user directory
        (dolist (user-dir (directory-files docusign-github-dir t "^[^.]"))
          (when (file-directory-p user-dir)
            ;; Loop through each repo directory under the user
            (dolist (repo-dir (directory-files user-dir t "^[^.]"))
              (when (file-directory-p repo-dir)
                (projectile-add-known-project repo-dir)))))))
    
    ;; Discover ~/org/* projects  
    (let ((org-dir (expand-file-name "~/org/")))
      (when (file-directory-p org-dir)
        (dolist (project-dir (directory-files org-dir t "^[^.]"))
          (when (file-directory-p project-dir)
            (projectile-add-known-project project-dir))))))
  
  ;; Ensure projects are discovered after projectile is fully loaded
  (add-hook 'after-init-hook #'my/discover-projects)
  
  ;; Custom function to open vterm in project
  (defun my/projectile-open-vterm ()
    "Open vterm in the project root directory, reusing existing buffer if available."
    (let* ((project-name (projectile-project-name))
           (buffer-name (format "*vterm-%s*" project-name))
           (existing-buffer (get-buffer buffer-name)))
      (if existing-buffer
          (switch-to-buffer existing-buffer)
        (let ((default-directory (projectile-project-root)))
          (vterm buffer-name)))))
  
  ;; Safe version that works with any directory
  (defun my/projectile-open-vterm-safe ()
    "Open vterm in the selected directory, handling both projects and regular directories."
    (let* ((project-dir (or (ignore-errors (projectile-project-root))
                            default-directory))
           (project-name (file-name-nondirectory (directory-file-name project-dir)))
           (buffer-name (format "*vterm-%s*" project-name))
           (existing-buffer (get-buffer buffer-name)))
      (if existing-buffer
          (switch-to-buffer existing-buffer)
        (let ((default-directory project-dir))
          (vterm buffer-name)))))
  
  ;; Open vterm when switching to a project (safe version)
  (setq projectile-switch-project-action #'my/projectile-open-vterm-safe)
  
  ;; Cache location
  (setq projectile-cache-file (expand-file-name "projectile.cache" user-emacs-directory))
  (setq projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" user-emacs-directory)))

;; Consult-Projectile - Integration with Consult completion
(use-package consult-projectile
  :straight (:host gitlab :repo "OlMon/consult-projectile" :commit "5f3a6b02a3c6b7b3c0b85f35b13ef5f4c5a8a5a1")
  :after (projectile consult)
  :config
  ;; Basic configuration for consult-projectile
  ;; No keybindings added per user request
  )

(provide 'projectile)
;;; projectile.el ends here
