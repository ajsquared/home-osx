;; Configuration specific to my current job not applicable to personal work

;;; Set up blacken for python-mode
(use-package blacken
  :ensure t
  :custom
  (blacken-executable (concat (projectile-project-root) "vendor3/bin/black"))
  :hook (python-mode . blacken-mode))

;;; Define formatting helper
(defun zoolander-format ()
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (background-process "./dev/format-build && ./dev/format-scala")))

;;; Set up bazel utilities
(use-package bazel-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\BUILD$" . bazel-build-mode))
  (add-to-list 'auto-mode-alist '("\\WORKSPACE$" . bazel-workspace-mode))
  (add-to-list 'auto-mode-alist '("\\.sky" . bazel-starlark-mode))
  
  (defun background-process (command)
    (let ((bufname (generate-new-buffer "*Background Process Output*")))
      (with-current-buffer bufname
        (special-mode))
      (internal-temp-output-buffer-show bufname)
      (start-process-shell-command "background-process" bufname command)))

  (defun get-bazel-build-target-name ()
    (unless (looking-at-p ".*(.*\n.*name")
      (re-search-backward "^.*(.*\n.*name" nil t nil))
    (re-search-forward ".*name ?=" nil t nil)
    (let* (
           (dirname (replace-regexp-in-string "/$" ""
                                              (replace-regexp-in-string (projectile-project-root) ""
                                                                        (file-name-directory (buffer-file-name)))))
           (current-line (thing-at-point 'line t))
           (target-name (replace-regexp-in-string ".*name ?= ?\"\\(.*\\)\".*\n" "\\1" current-line)))
      (message "//%s:%s" dirname target-name)))

  (defun copy-bazel-build-target-name ()
    (interactive)
    (kill-new (get-bazel-build-target-name)))

  (defun run-bazel-on-target (command)
    (let ((default-directory (projectile-project-root)))
      (background-process (concat "bazel " command " " (get-bazel-build-target-name)))))

  (defun build-current-bazel-target ()
    (interactive)
    (run-bazel-on-target "build"))

  (defun test-current-bazel-target ()
    (interactive)
    (run-bazel-on-target "test"))

  :bind (:map bazel-build-mode-map
              ("C-c f" . zoolander-format)
              ("C-c b b" . build-current-bazel-target)
              ("C-c b t" . test-current-bazel-target)
              ("C-c b c" . copy-bazel-build-target-name)))


;;; Configure formatting helpers
(use-package scala-mode
  :ensure t
  :config
  (defun open-bazel-build-for-file ()
    (interactive)
    (let ((fname (file-name-nondirectory (buffer-file-name))))
      (find-file-existing "BUILD")
      (goto-char (point-min))
      (search-forward fname nil t nil)))
  :bind (:map scala-mode-map
              ("C-c f" . zoolander-format)
              ("C-c b f" . open-bazel-build-for-file)))

;;; Configure terraform-mode
(use-package hcl-mode
  :ensure t
  :defer t)

(use-package terraform-mode
  :ensure t
  :defer t
  :after (hcl-mode))

;;; Configure puppet-mode
(use-package puppet-mode
  :ensure t
  :defer t)

;;; Configure thrift-mode
(use-package thrift
  :ensure t
  :defer t)

;;; Configure protobuf-mode
(use-package protobuf-mode
  :ensure t
  :defer t)

(provide 'ajsquared-work)
