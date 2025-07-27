;;; packages.el --- Org mode packages configuration -*- lexical-binding: t -*-

;; Org mode - Built-in but configured
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :config
  ;; Basic org configuration
  (setq org-directory "~/org")
  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  
  ;; TODO keywords
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "ABANDONED(a)")))
  
  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("n" "Note" entry (file+headline "~/org/notes.org" "Notes")
           "* %?\nEntered on %U\n  %i\n  %a")))
  
  ;; Agenda configuration
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  
  :bind (:map evil-normal-state-map
         ("<leader>oa" . org-agenda)
         ("<leader>oc" . org-capture)
         ("<leader>ol" . org-store-link)))

;; Org Modern - Modern UI for org mode
;; (use-package org-modern
;;   :straight (:host github :repo "minad/org-modern" :commit "8da65fb89b1f9f734c8b90c1720e9abc8e5a7a4b")
;;   :after org
;;   :config
;;   (global-org-modern-mode))

;; Evil Org - Better Evil integration for org mode
;; (use-package evil-org
;;   :straight (:host github :repo "Somelauw/evil-org-mode" :commit "2b2139ca25228c83fc9646a42e1d1f7f71a9c334")
;;   :after org
;;   :hook (org-mode . evil-org-mode)
;;   :config
;;   ;; Only set up agenda keys when actually using agenda
;;   (with-eval-after-load 'org-agenda
;;     (when (fboundp 'evil-org-agenda-set-keys)
;;       (evil-org-agenda-set-keys))))

(provide 'packages)
;;; packages.el ends here
