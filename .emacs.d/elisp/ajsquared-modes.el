;; Custom file type modes

;;; Enable markdown-mode
(use-package markdown-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.markdown" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md" . gfm-mode)))

;;; Enable json-mode
(use-package json-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.json" . json-mode)))

;;; Enable Auctex
(use-package tex
  :ensure auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-newline-function 'newline-and-indent)
  (TeX-PDF-mode t)
  (TeX-view-program-list '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
  (TeX-view-program-selection '((output-pdf "Skim")))
  (TeX-auto-local "/tmp/"))

;;; Enable python-mode
(use-package python-mode
  :ensure t
  :defer t
  :init
  (add-hook 'python-mode-hook (lambda ()
                              (setq autopair-handle-action-fns (list #'autopair-default-handle-action #'autopair-python-triple-quote-action)))))

(use-package auto-virtualenvwrapper
  :ensure t
  :hook (python-mode . auto-virtualenvwrapper-activate)
  :after (python-mode))

;;; Configure elisp-mode
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (eldoc-mode 1)
                                  (define-key (current-local-map) "\C-c\C-c" 'byte-recompile-directory)))

;;; Configure yaml-mode
(use-package yaml-mode
  :ensure t
  :defer t)

(provide 'ajsquared-modes)
