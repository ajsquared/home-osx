;; Emacs UI configuration

;;; Setup modifier keys on OS X
(when (eq system-type 'darwin)
  (setq mac-control-modifier 'meta)
  (setq mac-command-modifier 'control))

;;; Customize frame title
(setq frame-title-format
      '("Emacs " emacs-version ": "(:eval (if (buffer-file-name)
                                              (abbreviate-file-name (buffer-file-name))
                                            "%b"))))

;;; Disable unnecessary UI
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode nil)
(global-hl-line-mode t)

;;; Miscellaneous UI tweaks
(global-linum-mode)
(global-subword-mode)
(show-paren-mode)
(global-font-lock-mode t)
(mouse-wheel-mode t)
(column-number-mode 1)

;;; Mac-specific UI settings
(when (and (window-system) (eq system-type 'darwin))
  (set-face-attribute 'default nil :font "Monaco-14")
  (toggle-frame-maximized))

;;; Enable diminish
(use-package diminish
  :ensure t
  :config
  (diminish 'subword-mode))

;;; Enable theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;;; Enable bar cursor
(use-package bar-cursor
  :ensure t
  :diminish
  :config
  (bar-cursor-mode 1))

;;; Enable spaceline
(use-package spaceline
  :ensure t
  :defer 2
  :config
  (spaceline-emacs-theme)
  (spaceline-helm-mode))

;;; Enable rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(provide 'ajsquared-appearance)
