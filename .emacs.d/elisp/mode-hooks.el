(defun python-setup ()
  (setq tab-width 4)
  (setq autopair-handle-action-fns (list #'autopair-default-handle-action #'autopair-python-triple-quote-action)))
(defun elisp-setup ()
  (eldoc-mode 1)
  (define-key (current-local-map) "\C-c\C-c" 'byte-recompile-directory))
(defun latex-setup ()
  (auto-fill-mode 1)
  (modify-syntax-entry ?$ "\"")
  (local-set-key "'" 'TeX-insert-single-quote))
(defun org-agenda-setup ()
  (fset 'org-agenda-follow-mode 'org-agenda-later)
  (fset 'org-agenda-tree-to-indirect-buffer 'org-agenda-earlier)
  (define-key (current-local-map) "f" 'org-agenda-later)
  (define-key (current-local-map) "b" 'org-agenda-earlier)
  (setq autopair-dont-activate t))
(defun org-setup ()
  (auto-fill-mode 1)
  (modify-syntax-entry ?$ "\"")
  (modify-syntax-entry ?\" "\"")
  (modify-syntax-entry ?\' "\"")
  (define-key (current-local-map) (kbd "RET") 'org-meta-return)
  (define-key (current-local-map) (kbd "<M-return>") 'org-return)
  (define-key (current-local-map) "\C-c," 'org-table-create)
  (define-key (current-local-map) "\C-c/" 'org-table-insert-column)
  (define-key (current-local-map) "\C-c;" 'org-table-insert-row))
(defun client-exit-setup ()
  (when (current-local-map)
    (use-local-map (copy-keymap (current-local-map))))
  (when server-buffer-clients
    (local-set-key (kbd "C-x C-k") 'server-edit)))
(defun go-setup ()
  (setq tab-width 4)
  (setq gofmt-command "gofmt")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (local-set-key (kbd "M-.") 'godef-jump)
  (go-eldoc-setup))
(defun clojure-setup ()
  (cider-turn-on-eldoc-mode)
  (subword-mode)
  (ac-flyspell-workaround)
  (ac-cider-setup))
(defun cider-repl-setup()
  (ac-cider-setup))

;;; Mode hooks
(add-hook 'python-mode-hook 'python-setup)
(add-hook 'emacs-lisp-mode-hook 'elisp-setup)
(add-hook 'org-mode-hook 'org-setup)
(add-hook 'server-switch-hook 'client-exit-setup)
(add-hook 'auto-save-hook 'save-buffer-if-visiting-file)
(add-hook 'LaTeX-mode-hook 'latex-setup)
(add-hook 'org-finalize-agenda-hook 'org-agenda-setup)
(add-hook 'go-mode-hook 'go-setup)
(add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)
(add-hook 'cider-mode-hook 'clojure-setup)
(add-hook 'cider-repl-mode-hook 'cider-repl-setup)
(add-hook 'clojure-mode-hook 'cider-mode)

(provide 'mode-hooks)
