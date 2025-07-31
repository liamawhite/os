;;; custom-modeline.el --- Custom modeline implementation -*- lexical-binding: t -*-

;; A lightweight custom modeline inspired by doom-modeline
;; but with full control over appearance and functionality

(require 'projectile)

;;
;; Configuration
;;

(defgroup custom-modeline nil
  "A custom modeline implementation."
  :group 'mode-line)

(defcustom custom-modeline-height 33
  "Height of the modeline in pixels."
  :type 'integer
  :group 'custom-modeline)

(defcustom custom-modeline-show-project t
  "Whether to show project name in modeline."
  :type 'boolean
  :group 'custom-modeline)

(defcustom custom-modeline-show-git-branch nil
  "Whether to show git branch in modeline."
  :type 'boolean
  :group 'custom-modeline)

(defcustom custom-modeline-show-lsp t
  "Whether to show LSP status in modeline."
  :type 'boolean
  :group 'custom-modeline)

;;
;; Faces
;;

(defface custom-modeline-evil-normal
  '((t (:background "#89b4fa" :foreground "#11111b" :weight bold 
        :box (:line-width 2 :color "#89b4fa" :style nil))))
  "Face for Evil normal state."
  :group 'custom-modeline)

(defface custom-modeline-evil-insert
  '((t (:background "#a6e3a1" :foreground "#11111b" :weight bold
        :box (:line-width 2 :color "#a6e3a1" :style nil))))
  "Face for Evil insert state."
  :group 'custom-modeline)

(defface custom-modeline-evil-visual
  '((t (:background "#fab387" :foreground "#11111b" :weight bold
        :box (:line-width 2 :color "#fab387" :style nil))))
  "Face for Evil visual state."
  :group 'custom-modeline)

(defface custom-modeline-buffer-name
  '((t (:inherit mode-line :weight bold)))
  "Face for buffer name in modeline."
  :group 'custom-modeline)

(defface custom-modeline-project
  '((t (:inherit mode-line :foreground "#7c7c7c")))
  "Face for project name in modeline."
  :group 'custom-modeline)

(defface custom-modeline-git-branch
  '((t (:inherit mode-line :foreground "#ffd700")))
  "Face for git branch in modeline."
  :group 'custom-modeline)

(defface custom-modeline-lsp-connected
  '((t (:background "#a6e3a1" :foreground "#11111b" :weight bold
        :box (:line-width 2 :color "#a6e3a1" :style nil))))
  "Face for connected LSP status."
  :group 'custom-modeline)

(defface custom-modeline-lsp-disconnected
  '((t (:inherit mode-line :foreground "#f38ba8")))
  "Face for disconnected LSP status."
  :group 'custom-modeline)

(defface custom-modeline-position
  '((t (:background "#89b4fa" :foreground "#11111b" :weight bold
        :box (:line-width 2 :color "#89b4fa" :style nil))))
  "Face for position info."
  :group 'custom-modeline)

;;
;; Helper Functions
;;

(defun custom-modeline--propertize (text &optional face)
  "Add properties to TEXT with optional FACE."
  (if face
      (propertize text 'face face)
    text))

(defun custom-modeline--separator-left (from-face to-face)
  "Create a left-pointing powerline separator from FROM-FACE to TO-FACE."
  (let ((from-bg (if from-face 
                     (face-attribute from-face :background nil t)
                     (face-attribute 'mode-line :background nil t)))
        (to-bg (if to-face 
                   (face-attribute to-face :background nil t)
                   (face-attribute 'mode-line :background nil t))))
    (when (and from-bg to-bg (not (eq from-bg 'unspecified)) (not (eq to-bg 'unspecified)))
      (propertize "" 
                  'face `(:foreground ,from-bg :background ,to-bg)))))

(defun custom-modeline--separator-right (from-face to-face)
  "Create a right-pointing powerline separator from FROM-FACE to TO-FACE."
  (let ((from-bg (if from-face 
                     (face-attribute from-face :background nil t)
                     (face-attribute 'mode-line :background nil t)))
        (to-bg (if to-face 
                   (face-attribute to-face :background nil t)
                   (face-attribute 'mode-line :background nil t))))
    (when (and from-bg to-bg (not (eq from-bg 'unspecified)) (not (eq to-bg 'unspecified)))
      (propertize "" 
                  'face `(:foreground ,to-bg :background ,from-bg)))))

;;
;; Segment Functions
;;

(defun custom-modeline--evil-state ()
  "Return Evil state indicator."
  (when (bound-and-true-p evil-mode)
    (let ((state (symbol-name evil-state)))
      (cond
       ((string= state "normal")
        (custom-modeline--propertize " NORMAL " 'custom-modeline-evil-normal))
       ((string= state "insert")
        (custom-modeline--propertize " INSERT " 'custom-modeline-evil-insert))
       ((string= state "visual")
        (custom-modeline--propertize " VISUAL " 'custom-modeline-evil-visual))
       ((string= state "replace")
        (custom-modeline--propertize " REPLACE " 'custom-modeline-evil-insert))
       (t
        (custom-modeline--propertize (format " %s " (upcase state)) 'mode-line))))))

(defun custom-modeline--buffer-name ()
  "Return formatted buffer name."
  (let* ((buffer-name (buffer-name))
         (project-root (when (and custom-modeline-show-project
                                  (bound-and-true-p projectile-mode))
                         (projectile-project-root)))
         (file-path (buffer-file-name)))
    (cond
     ;; Show project-relative path for files
     ((and file-path project-root)
      (let ((relative-path (file-relative-name file-path project-root)))
        (custom-modeline--propertize relative-path 'custom-modeline-buffer-name)))
     ;; Show buffer name for non-file buffers
     (t
      (custom-modeline--propertize buffer-name 'custom-modeline-buffer-name)))))

(defun custom-modeline--project-name ()
  "Return project name if available."
  (when (and custom-modeline-show-project
             (bound-and-true-p projectile-mode))
    (let ((project (projectile-project-name)))
      (when (and project (not (string= project "-")))
        (custom-modeline--propertize (format "[%s]" project) 'custom-modeline-project)))))

(defun custom-modeline--major-mode ()
  "Return major mode name."
  (let ((mode-name (symbol-name major-mode)))
    (custom-modeline--propertize 
     (if (string-suffix-p "-mode" mode-name)
         (substring mode-name 0 (- (length mode-name) 5))
       mode-name)
     'mode-line)))

(defun custom-modeline--git-branch ()
  "Return git branch if available."
  (when (and custom-modeline-show-git-branch
             (bound-and-true-p projectile-mode))
    (let ((branch (ignore-errors
                    (with-temp-buffer
                      (call-process "git" nil t nil "branch" "--show-current")
                      (string-trim (buffer-string))))))
      (when (and branch (not (string-empty-p branch)))
        (custom-modeline--propertize (format "git:%s" branch) 'custom-modeline-git-branch)))))

(defun custom-modeline--lsp-status ()
  "Return LSP status if available."
  (when custom-modeline-show-lsp
    (cond
     ;; Eglot
     ((and (bound-and-true-p eglot--managed-mode)
           (eglot-current-server))
      (custom-modeline--propertize " lsp " 'custom-modeline-lsp-connected))
     ;; LSP-mode
     ((and (bound-and-true-p lsp-mode)
           (lsp-workspaces))
      (custom-modeline--propertize " lsp " 'custom-modeline-lsp-connected))
     ;; No LSP active
     (t nil))))

(defun custom-modeline--position ()
  "Return cursor position info."
  (custom-modeline--propertize 
   (format " %d:%d " (line-number-at-pos) (current-column))
   'custom-modeline-position))

(defun custom-modeline--buffer-encoding ()
  "Return buffer encoding info."
  (let ((encoding (symbol-name buffer-file-coding-system)))
    (unless (string-match-p "utf-8" encoding)
      (custom-modeline--propertize (upcase encoding) 'mode-line))))

;;
;; Main modeline construction
;;

(defun custom-modeline--format-left ()
  "Format left side of modeline."
  (let ((segments (delq nil
                        (list
                         (custom-modeline--evil-state)
                         (custom-modeline--buffer-name)
                         (custom-modeline--project-name)))))
    (mapconcat 'identity segments " ")))

(defun custom-modeline--format-right ()
  "Format right side of modeline."
  (let ((segments (delq nil
                        (list
                         (custom-modeline--git-branch)
                         (custom-modeline--lsp-status)
                         (custom-modeline--buffer-encoding)
                         (custom-modeline--position)
                         (custom-modeline--major-mode)))))
    (when segments
      (mapconcat 'identity segments " "))))

(defun custom-modeline--format ()
  "Main modeline format function."
  (let ((left (custom-modeline--format-left))
        (right (custom-modeline--format-right)))
    (if right
        (list
         left
         '(:eval (propertize 
                  " " 
                  'display 
                  `((space :align-to (- right ,(+ 1 (string-width (custom-modeline--format-right))))))))
         right)
      left)))

;;
;; Activation
;;

(defun custom-modeline-setup ()
  "Setup custom modeline."
  (setq-default mode-line-format '(:eval (custom-modeline--format)))
  ;; Set modeline height and padding
  (set-face-attribute 'mode-line nil 
                      :height 110  ; Moderately larger font size
                      :box `(:line-width 3 :color ,(face-background 'mode-line)))
  (set-face-attribute 'mode-line-inactive nil 
                      :height 110
                      :box `(:line-width 3 :color ,(face-background 'mode-line-inactive))))

(defun custom-modeline-disable ()
  "Disable custom modeline and restore default."
  (setq-default mode-line-format
                '("%e" mode-line-front-space
                  (:propertize ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote)
                               display (min-width (5.0)))
                  mode-line-frame-identification
                  mode-line-buffer-identification
                  "   "
                  mode-line-position
                  (vc-mode vc-mode)
                  "  "
                  mode-line-modes
                  mode-line-misc-info
                  mode-line-end-spaces)))

;;;###autoload
(define-minor-mode custom-modeline-mode
  "Toggle custom modeline mode."
  :global t
  :group 'custom-modeline
  (if custom-modeline-mode
      (custom-modeline-setup)
    (custom-modeline-disable)))

(provide 'custom-modeline)
;;; custom-modeline.el ends here
