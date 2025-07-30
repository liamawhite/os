;;; orgmode.el --- Org mode module loader -*- lexical-binding: t -*-

;; Load org packages
(require 'packages)

;; Manual evil bindings for org-mode
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map
    "t" 'org-todo
    "T" 'org-insert-todo-heading
    ",c" 'org-ctrl-c-ctrl-c
    ",e" 'org-export-dispatch
    ",n" 'org-narrow-to-subtree
    ",r" 'org-refile
    ",s" 'org-schedule
    ",d" 'org-deadline
    "TAB" 'org-cycle
    "S-TAB" 'org-shifttab
    "{" 'org-backward-paragraph
    "}" 'org-forward-paragraph))

(provide 'orgmode)
;;; orgmode.el ends here
