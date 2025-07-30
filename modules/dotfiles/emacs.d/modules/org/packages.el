;;; packages.el --- Org mode packages configuration -*- lexical-binding: t -*-

;; Org mode - Built-in but configured
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :config
  ;; Basic org configuration
  (setq org-directory "~/org")
  (setq org-personal-directory (expand-file-name "personal" org-directory))
  (setq org-docusign-directory (expand-file-name "docusign" org-directory))
  (setq org-agenda-files (list org-personal-directory org-docusign-directory))
  (setq org-default-notes-file (expand-file-name "notes.org" org-personal-directory))
  
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "ABANDONED(a)")))
  
  ;; Capture templates
  (setq org-capture-templates
        `(("pt" "Personal Todo" entry (file+headline ,(expand-file-name "inbox.org" org-personal-directory) "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("pn" "Personal Note" entry (file+headline ,(expand-file-name "notes.org" org-personal-directory) "Notes")
           "* %?\nEntered on %U\n  %i\n  %a")
          ("dt" "Docusign Todo" entry (file+headline ,(expand-file-name "inbox.org" org-docusign-directory) "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("dn" "Docusign Note" entry (file+headline ,(expand-file-name "notes.org" org-docusign-directory) "Notes")
           "* %?\nEntered on %U\n  %i\n  %a")))
  
  ;; Agenda configuration
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  
  ;; Custom functions for consult grep in org directories
  (defun consult-grep-org-all ()
    "Run consult-grep in all org directories."
    (interactive)
    (consult-grep org-directory))
  
  :bind (:map evil-normal-state-map
         ("<leader>oa" . org-agenda)
         ("<leader>oc" . org-capture)
         ("<leader>ol" . org-store-link)
         ("<leader>fo" . consult-grep-org-all))
  :config
  ;; Org-mode specific evil keybindings using comma as secondary leader
  (evil-define-key 'normal org-mode-map
    (kbd ",p") 'org-set-property
    (kbd ",#") 'org-set-tags-command
    (kbd ",s") 'org-schedule
    (kbd ",d") 'org-deadline))

;; Org Modern - Modern UI for org mode
;; (use-package org-modern
;;   :straight (:host github :repo "minad/org-modern" :commit "8da65fb89b1f9f734c8b90c1720e9abc8e5a7a4b")
;;   :after org
;;   :config
;;   (global-org-modern-mode))

;; Evil Org - Better Evil integration for org mode
(use-package evil-org
  :straight (:host github :repo "Somelauw/evil-org-mode" :commit "2b2139ca25228c83fc9646a42e1d1f7f71a9c334")
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  ;; Enable desired key themes
  (evil-org-set-key-theme '(navigation insert textobjects additional shift todo heading))
  ;; Set up agenda keys when actually using agenda
  (with-eval-after-load 'org-agenda
    (when (fboundp 'evil-org-agenda-set-keys)
      (evil-org-agenda-set-keys))))

(provide 'packages)
;;; packages.el ends here
