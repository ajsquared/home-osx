;;; Set load path
(add-to-list 'load-path "~/.emacs.d")

;;; Initialize package system
(require 'package-install)

;;; Packages to require
(require 'powerline)
(require 'bar-cursor)
(require 'autopair)
(require 'yasnippet)
(require 'markdown-mode)
(require 'functions)
(require 'keyboard-shortcuts)
(require 'mode-hooks)
(require 'auto-complete-config)
(require 'rainbow-delimiters)
(require 'go-autocomplete)
(require 'env-var-import)

;;; Set frame title
(setq frame-title-format
      '("" invocation-name ": "(:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;;; Enable modes and window setup
(setq default-directory "/Users/ajsquared")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(load-theme 'wilson t)
(if (window-system)
    (progn
      (env-var-import '("GOPATH"))
      (if (eq system-type 'darwin)
	(progn
	  (set-face-attribute 'default nil :font "Monaco-14")
	  (maximize-frame))
      (toggle-maximize))))
(powerline-default-theme)
(global-rainbow-delimiters-mode)
(ac-config-default)
(delete-selection-mode)
(yas/global-mode 1)
(global-linum-mode)
(ido-mode t)
(global-subword-mode)
(ido-everywhere 1)
(show-paren-mode)
(global-font-lock-mode t)
(mouse-wheel-mode t)
(column-number-mode 1)
(bar-cursor-mode 1)
(autopair-global-mode 1)
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))

;;; General variable customization
(setq ido-save-directory-list-file "/dev/null")
(setq initial-major-mode 'text-mode)
(setq c-default-style "bsd")
(setq-default indent-tabs-mode t)
(setq x-select-enable-clipboard t)
(setq inhibit-startup-message t)
(setq mouse-drag-copy-region nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)
(setq initial-scratch-message nil)
(setq browse-url-firefox-program "firefox")
(setq dired-recursive-deletes 'top)
(setq show-paren-style 'parenthesis)
(setq autopair-autowrap t)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq auto-save-interval 1000)
(setq auto-save-timeout 120)
(setq auto-save-list-file-prefix temporary-file-directory)
(setq require-final-newline t)
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

;;; Configure ido
(setq ido-enable-flex-matching t)
(setq ido-enable-last-directory-history nil)
(setq ido-record-commands nil)
(setq ido-execute-command-cache nil)
(setq ido-ignore-buffers '("\\` " "\\`*"))
(setq ido-ignore-files '("\\`\\." "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./" "\\`\\.git/" "\\.pdf" "\\.class" "\\.pyc" "\\.log" "\\.aux" "\\.nav" "\\.out" "\\.snm"))

;;; Configure AUCTex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-newline-function 'newline-and-indent)
(setq TeX-PDF-mode t)
(setq TeX-view-program-list (quote (("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b"))))
(setq TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "open -a Preview.app %s.pdf") (output-pdf "Skim") (output-html "open -a Preview.app %s.pdf"))))
(setq TeX-auto-local "/tmp/")
(setenv "PATH" (concat "/usr/texbin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/usr/texbin" "/usr/local/bin") exec-path))

;;; Configure org-mode
(setq org-return-follows-link t)
(setq org-startup-folded t)
(setq org-completion-use-ido t)
(setq org-hide-leading-stars t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-blank-before-new-entry '((heading . nil) (plain-list-item . auto)))
(setq org-export-with-LaTeX-fragments t)
(setq org-enforce-todo-dependencies t)

;;; Custom faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-subdir ((t (:foreground "coral3")))))

;;; Start the server
(server-start)
