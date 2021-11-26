
(use-package highlight-parentheses
  :hook (LaTeX-mode. highlight-parentheses-mode))
(use-package tex
  :defer t
  :custom
  (TeX-region "fragment")
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (TeX-show-compilation nil)
  (TeX-clean-confirm nil)
  (TeX-save-query nil)
  (LaTeX-item-indent 4)
  (LaTeX-indent-level 0)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  ;; speed up the start emacs when you open the tex file.
  (pdf-view-use-unicode-ligther nil)
  (pdf-view-use-scaling t)
  (pdf-view-use-imagemagick nil)
  :ensure auctex
  :init
  (use-package pdf-tools
  :init
  (if (package-installed-p 'pdf-tools)
	  (progn
		(add-hook 'doc-view-mode-hook 'pdf-tools-install)
		(pdf-loader-install)
		(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
		(eval-after-load "tex"
		  '(setcar (cdr (assoc 'output-pdf TeX-view-program-selection)) "PDF Tools")))
	(pdf-loader-install)))
  :config
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex -shell-escape --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
              (add-to-list 'TeX-command-list '("PdfLaTeX" "%`pdflatex -shell-escape --synctex=1 -8bit%(mode)%' %t" TeX-run-TeX nil t))
              (setq TeX-command-default "XeLaTeX")
			  (local-set-key (kbd "<f5>") 'TeX-clean)
			  (local-set-key (kbd "<f6>") 'TeX-documentation-texdoc)
			  (local-set-key (kbd "C-S-a") 'LaTeX-find-matching-begin)
			  (local-set-key (kbd "C-S-e") 'LaTeX-find-matching-end)
			  (turn-off-auto-fill)
              (linum-mode 1)
              ;; (auto-complete-mode)
              (outline-minor-mode)
              (menu-bar-mode)
              (visual-line-mode)
			  (setq autopair-handle-action-fns
					(list 'autopair-default-handle-action
						  '(lambda (action pair pos-before)
							 (hl-paren-color-update))))
			  (TeX-fold-mode)
			  (LaTeX-math-mode)
			  (use-package latex-preview-pane
				:custom
				(shell-escape-mode "-shell-escape")
				(pdf-latex-command "xelatex")
				:config
				(defun toggle-preview-mode ()
				  "Use for preview latex."
				  (interactive)
				  (if (bound-and-true-p latex-preview-pane-mode)
					  (latex-preview-pane-mode 0)
					(latex-preview-pane-mode 1)))
				(local-set-key (kbd "C-c M-p") 'toggle-preview-mode))
			  )))
;; (use-package auto-complete-auctex)
(use-package cdlatex
  ;; (require 'tex)
  :defer t
  :init
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
  (add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
  :custom
  (cdlatex-paired-parens "$[{(")
  (TeX-electric-sub-and-superscript t)
  :config
  (defun my-after-load-cdlatex ()
    (define-key cdlatex-mode-map "_" nil) t)
  (eval-after-load "cdlatex" '(my-after-load-cdlatex))
  (setq cdlatex-env-alist
		'(("pmatrix" "\\begin{equation}\n\t\\begin{pmatrix}\n\t ? &  &  &  &  \\\\\n\t  &  &  &  &  \n\t\\end{pmatrix}\n\\end{equation}\n" nil)))
  (setq cdlatex-command-alist
		'(("ma" "Insert pmatrix env"   "" cdlatex-environment ("pmatrix") t nil)))
  )


;;  test for change to lambda.

(provide 'mylatex)
