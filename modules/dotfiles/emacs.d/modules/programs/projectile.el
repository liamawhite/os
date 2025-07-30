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
  
  ;; Project discovery
  (setq projectile-project-search-path '("~/github.com/"))  ; Look for projects in github directory
  
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