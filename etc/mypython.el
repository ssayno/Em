(use-package python-mode
  :defer t
  :mode "\\.py\\'"
  :interpreter "python"
  :config
  (add-hook 'python-mode-hook '(lambda ()
								 (auto-complete-mode -1))))
(use-package elpy
  :ensure t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  ;; this is important when you use python environment.
  (add-to-list 'process-coding-system-alist '("python" . (utf-8 . utf-8)))
  (setq elpy-rpc-python-command "python3"))
(use-package anaconda-mode
  :hook python-mode)
(use-package flycheck
  :hook
  (;; (emacs-lisp-mode . flycheck-mode)
   (python-mode . flycheck-mode)
   (cc-mode . flycheck-mode))
  ;; Enable Flycheck and disabled flamake.
  :config
  (when (require 'flycheck nil t)
	(setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
	(add-hook 'elpy-mode-hook 'flycheck-mode)))
;; (use-package ein)
;; (use-package virtualenvwrapper
;;   :config
;;   ;; (venv-initialize-interactive-shells) ;; if you want interactive shell support
;;   ;; (venv-initialize-eshell) ;; if you want eshell support
;;   (setq venv-location "/home/sayno/.local/bin/virtualenv"))
(use-package jedi
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:server-command '("/home/sayno/anaconda3/bin/python" "/home/sayno/.emacs.d/elpa/jedi-core-20210503.1315/jediepcserver.py"))
  (setq jedi:complete-on-dot t))
(use-package lsp-jedi
  :ensure t
  :config
  (with-eval-after-load "lsp-mode"
    (add-to-list 'lsp-disabled-clients 'pyls)
    (add-to-list 'lsp-enabled-clients 'jedi)))

;; (global-whitespace-mode)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
;; (use-package which-key
;;     :config
;;     (which-key-mode))
(use-package ein
  :config
  (add-hook 'ein-mode-hook 'cdlatex-mode)
  :custom
  (ein:jupyter-default-notebook-directory "~/PycharmProjects/pymatlab/jp")
  (ein:output-area-inlined-images t) )

(add-hook 'python-mode-hook
		  (lambda ()
			(setq-default indent-tabs-mode t)
			(setq-default tab-width 4)
			(setq-default py-indent-tabs-mode t)
			(setq-default python-indent-offset 4)
			(setq python-indent-guess-indent-offset nil)
			(setq python-indent-guess-indent-offset-verbose nil)
			(linum-mode)
			(add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(provide 'mypython)
