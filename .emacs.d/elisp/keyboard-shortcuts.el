(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-x C-r") 'find-alternative-file-with-sudo)
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)
(global-set-key (kbd "C-x v") 'magit-status)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "C-c s") 'isearch-forward)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)
(global-set-key (kbd "M-m") 'move-beginning-of-line)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h l") 'helm-locate)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c h r") 'helm-resume)
(global-set-key (kbd "C-;") 'ac-complete-with-helm)
(global-set-key (kbd "C-c p h") 'helm-projectile)
(global-set-key (kbd "C-c p s") 'helm-projectile-switch-project)
(global-set-key (kbd "C-c a") 'helm-ag)
(global-set-key (kbd "C-c p l") 'package-list-packages)
(global-set-key (kbd "M-.") 'lsp-find-definition)
(global-set-key (kbd "M-?") 'lsp-find-references)

(define-key 'help-command (kbd "C-f") 'helm-apropos)
(define-key 'help-command (kbd "r") 'helm-info-emacs)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)

(define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
(define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
(define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-helm)

(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-control-modifier 'meta)
  (setq mac-command-modifier 'control))

(provide 'keyboard-shortcuts)
