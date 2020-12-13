;; Base Emacs configuration

;;; Reconfigure default behaviors
(delete-selection-mode)
(setq default-directory "~/")
(setq initial-major-mode 'text-mode)
(setq-default indent-tabs-mode nil)
(setq select-enable-clipboard t)
(setq inhibit-startup-message t)
(setq mouse-drag-copy-region nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)
(setq initial-scratch-message nil)
(setq dired-recursive-deletes 'top)
(setq show-paren-style 'parenthesis)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq require-final-newline t)
(setq abbrev-file-name "~/.emacs.d/.abbrev")

;;; Customize bell behavior
(setq ring-bell-function 
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort
			abort-recursive-edit
			exit-minibuffer
			keyboard-quit
			mwheel-scroll
			down
			up
			next-line
			previous-line
			backward-char
			forward-char))
	  (ding))))

;;; Ensure packages are updated
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;;; Configure auto-save behavior
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq auto-save-interval 1000)
(setq auto-save-timeout 120)
(setq auto-save-list-file-prefix temporary-file-directory)

(defun save-buffer-if-visiting-file (&optional args)
  "Save the current buffer only if it is visiting a file"
  (interactive)
  (if (and (buffer-file-name) (buffer-modified-p))
      (save-buffer args)))
(add-hook 'auto-save-hook #'save-buffer-if-visiting-file)

;;; Configure custom client exit behavior
(defun client-exit-setup ()
  (when (current-local-map)
    (use-local-map (copy-keymap (current-local-map))))
  (when server-buffer-clients
    (local-set-key (kbd "C-x C-k") 'server-edit)))
(add-hook 'server-switch-hook #'client-exit-setup)

(provide 'ajsquared-base)
