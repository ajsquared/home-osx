(defun c-setup ()
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (setq compilation-read-command t)
  (setq compile-command "make -k"))
(defun python-setup ()
  (setq tab-width 4)
  (setq autopair-handle-action-fns (list #'autopair-default-handle-action #'autopair-python-triple-quote-action)))
(defun java-setup ()
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (subword-mode)
  (font-lock-add-keywords 'java-mode
  			  '(("\\<\\(FIXME\\|TODO\\|BUG\\)" 1 font-lock-warning-face prepend)))
  (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
  (modify-syntax-entry ?@ "< b" java-mode-syntax-table))
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
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq compile-command "go build -v && go test -v && go vet")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (local-set-key (kbd "M-.") 'godef-jump)
  (go-eldoc-setup))

;;; Mode hooks
(add-hook 'c++-mode-hook 'c-setup)
(add-hook 'c-mode-hook 'c-setup)
(add-hook 'java-mode-hook 'java-setup)
(add-hook 'python-mode-hook 'python-setup)
(add-hook 'emacs-lisp-mode-hook 'elisp-setup)
(add-hook 'org-mode-hook 'org-setup)
(add-hook 'server-switch-hook 'client-exit-setup)
(add-hook 'auto-save-hook 'save-buffer-if-visiting-file)
(add-hook 'LaTeX-mode-hook 'latex-setup)
(add-hook 'org-finalize-agenda-hook 'org-agenda-setup)
(add-hook 'go-mode-hook 'go-setup)

(provide 'mode-hooks)
