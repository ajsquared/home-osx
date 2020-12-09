(defun save-buffer-if-visiting-file (&optional args)
  "Save the current buffer only if it is visiting a file"
  (interactive)
  (if (buffer-file-name)
      (save-buffer args)))

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

(defun TeX-insert-single-quote (arg)
  (interactive "p")
  (cond
   (mark-active
    (let ((skeleton-end-newline nil))
      (skeleton-insert
       `(nil ?` _ ?') -1)))
   ((or (looking-at "\\<")
        (looking-back "^\\|\\s-\\|`"))
    (insert "`"))
   (t
    (self-insert-command arg))))

(defadvice TeX-insert-quote (around wrap-region activate)
  (cond
   (mark-active
    (let ((skeleton-end-newline nil))
      (skeleton-insert `(nil ,TeX-open-quote _ ,TeX-close-quote) -1)))
   ((looking-at (regexp-opt (list TeX-open-quote TeX-close-quote)))
    (forward-char (length TeX-open-quote)))
   (t
    ad-do-it)))
(put 'TeX-insert-quote 'delete-selection nil)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     java-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    ruby-mode
                                                     rspec-mode      python-mode
                                                     c-mode          c++-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(defun use-pay-server-rubocop ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "scripts/bin/rubocop"))
         (rubocop (and root
                       (expand-file-name "scripts/bin/rubocop"
                                         root))))
    (when (and rubocop (file-executable-p rubocop))
      (setq-local flycheck-ruby-rubocop-executable rubocop))))

(defun background-process (command)
  (let ((bufname (generate-new-buffer "*Background Process Output*")))
    (with-current-buffer bufname
      (special-mode))
    (internal-temp-output-buffer-show bufname)
    (start-process-shell-command "background-process" bufname command)))

(defun open-bazel-build-for-file ()
  (interactive)
  (let ((fname (file-name-nondirectory (buffer-file-name))))
    (find-file-existing "BUILD")
    (beginning-of-buffer)
    (search-forward fname nil t nil)))

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

(defun zoolander-format ()
  (interactive)
  (let ((default-directory (projectile-project-root)))
    (background-process "./dev/format-build && ./dev/format-scala")))

(provide 'functions)
