;;; Reduce GC frequency during startup
(setq gc-cons-threshold (* 50 1000 1000))

;;; Initialize base package configuration
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

;;; Load custom configuration sub-modules
(add-to-list 'load-path "~/.emacs.d/elisp")
(use-package ajsquared-appearance
  :ensure nil
  :load-path "~/.emacs.d/elisp/ajsquared-appearance.el")
(use-package ajsquared-base
  :ensure nil
  :load-path "~/.emacs.d/elisp/ajsquared-base.el")
(use-package ajsquared-editor
  :ensure nil
  :load-path "~/.emacs.d/elisp/ajsquared-editor.el")
(use-package ajsquared-modes
  :ensure nil
  :load-path "~/.emacs.d/elisp/ajsquared-modes.el")
(use-package ajsquared-work
  :ensure nil
  :load-path "~/.emacs.d/elisp/ajsquared-work.el")

;;; Start the server
(server-start)

;;; Put GC threshold lower for interactive use
(setq gc-cons-threshold (* 2 1000 1000))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(spaceline diminish perspective terraform auto-package-update use-package doom-themes blacken all-the-icons neotree yasnippet git-commit hcl-mode helm helm-core markdown-mode projectile scala-mode yaml-mode thrift terraform-mode rg rainbow-delimiters python-mode puppet-mode protobuf-mode powerline magit json-mode helm-projectile helm-descbinds helm-xref dumb-jump bazel-mode bar-cursor autopair auto-virtualenvwrapper auctex ac-helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
