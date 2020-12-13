;; Customize the editing experience

;;; Built-in variable customizations
(setq c-default-style "bsd")
(setq tab-width 2)
(setq c-basic-offset 2)

;;; Enable magit
(use-package magit
  :ensure t
  :diminish auto-revert-mode
  :custom
  (magit-last-seen-setup-instructions "1.4.0")
  (magit-git-executable "/usr/local/bin/git")
  (vc-follow-symlinks t)
  (magit-auto-revert-mode)
  :bind (("C-x v" . magit-status)
         ("C-x f" . magit-log-buffer-file)
         ("C-x x" . magit-blame)))

(use-package git-commit
  :ensure t
  :config
  (global-git-commit-mode))

;;; Enable autopair
(use-package autopair
  :ensure t
  :diminish
  :custom
  (autopair-autowrap t)
  :config
  (autopair-global-mode 1))

;;; Enable yasnippet
(use-package yasnippet
  :ensure t
  :demand t
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  :bind (("C-c y" . yas-expand-from-trigger-key)))

;;; Enable auto-complete
(use-package auto-complete
  :ensure t
  :diminish
  :config
  (ac-config-default))

;;; Enable perspective
(use-package perspective
  :ensure t
  :demand t
  :config
  (persp-mode)
  (persp-turn-on-modestring))

;;; Enable projectile
(use-package projectile
  :ensure t
  :demand t
  :custom
  (projectile-enable-caching t)
  :config
  (projectile-mode)
  :init
  (defun projectile-switch-project-setup ()
    (projectile-invalidate-cache nil))
  (add-hook 'projectile-after-switch-project-hook #'projectile-switch-project-setup)
  
  (defun projectile-init-setup ()
    (mapc (lambda (project-root)
            (remhash project-root projectile-project-type-cache)
            (remhash project-root projectile-projects-cache)
            (remhash project-root projectile-projects-cache-time)
            (when projectile-verbose
              (message "Invalidated Projectile cache for %s."
                       (propertize project-root 'face 'font-lock-keyword-face)))
            (when (fboundp 'recentf-cleanup)
              (recentf-cleanup)))
          (hash-table-keys projectile-projects-cache))
    (projectile-serialize-cache))
  (add-hook 'after-init-hook #'projectile-init-setup))

;;; Enable helm
(use-package helm
  :ensure t
  :demand t
  :diminish
  :custom
  (helm-scroll-amount 4)
  (helm-quick-update t)
  (helm-idle-delay 0.01)
  (helm-input-idle-delay 0.01)
  (helm-ff-search-library-in-sexp t)
  (helm-split-window-default-side 'other)
  (helm-split-window-in-side-p t)
  (helm-candidate-number-limit 200)
  (helm-M-x-requires-pattern 0)
  (helm-ff-skip-boring-files t)
  (helm-boring-file-regexp-list
        '("\\`\\." "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./" "\\`\\.git/" "\\.pdf" "\\.class" "\\.pyc" "\\.log" "\\.aux" "\\.nav" "\\.out" "\\.snm" "\\.elc"))
  (helm-ff-file-name-history-use-recentf t)
  (helm-move-to-line-cycle-in-source t)
  (ido-use-virtual-buffers t)
  (helm-buffers-fuzzy-matching t)
  (recentf-exclude
        '("COMMIT_EDITMSG" "\\.emacs\\.d/elpa"))
  :config
  (require 'helm-config)
  (require 'helm-files)
  (require 'helm-grep)
  (helm-mode 1)
  (helm-descbinds-mode)
  :init
  (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-mini)
         ("C-x C-f" . helm-find-files)
         ("C-c h f" . helm-find)
         ("C-c h l" . helm-locate)
         ("C-s" . helm-occur)
         ("C-c h r" . helm-resume)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action)
         ("C-z" . helm-select-action)
         :map helm-grep-mode-map
         ("<return>" . helm-grep-mode-jump-other-window)
         ("n" . helm-grep-mode-jump-other-window-forward)
         ("p" . helm-grep-mode-jump-other-window-backward)
         :map help-map
         ("C-f" . helm-apropos)
         ("r" . helm-info-emacs)))

;;; Enable helm extensions
(use-package helm-descbinds
  :ensure t
  :after (helm))

(use-package ac-helm
  :ensure t
  :after (auto-complete helm)
  :bind (("C-;" . ac-complete-with-helm)))

(use-package helm-projectile
  :ensure t
  :demand t
  :after (helm projectile)
  :bind (("C-c p h" . helm-projectile)
         ("C-c p s" . helm-projectile-switch-project)))

(use-package helm-xref
  :ensure t)

;;; Enable neotree
(use-package all-the-icons
  :ensure t
  :defer t)

(use-package neotree
  :ensure t
  :defer t
  :custom
  (neo-theme (if (display-graphic-p) 'icons 'arrow))
  (neo-smart-open t)
  :bind ("C-c p n" . neotree-toggle)
  :after (all-the-icons))

;;; Enable dumb-jump
(use-package rg
  :ensure t
  :custom
  (rg-executable "/usr/local/bin/rg")
  :bind (("C-c a" . rg-project)))

(use-package dumb-jump
  :ensure t
  :custom
  (dumb-jump-force-searcher 'rg)
  :init
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :after (rg))

;;; Enable opening file with sudo
(defun find-alternative-file-with-sudo ()
  (interactive)
  (let ((fname (or buffer-file-name
		   dired-directory)))
    (when fname
      (if (string-match "^/sudo:root@localhost:" fname)
	  (setq fname (replace-regexp-in-string
		       "^/sudo:root@localhost:" ""
		       fname))
	(setq fname (concat "/sudo:root@localhost:" fname)))
      (find-alternate-file fname))))
(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)

;;; Remap standard keys
(bind-key "RET" 'newline-and-indent)
(bind-key "C-x C-k" 'kill-this-buffer)
(bind-key "C-c r" 'replace-string)
(bind-key "C-c s" 'isearch-forward)
(bind-key "C-z" 'undo)
(bind-key "M-g" 'goto-line)
(bind-key "C-c c" 'comment-region)
(bind-key "C-c u" 'uncomment-region)
(bind-key "M-m" 'move-beginning-of-line)
(bind-key "C-a" 'back-to-indentation)
(bind-key "C-c p l" 'package-list-packages)

(provide 'ajsquared-editor)
