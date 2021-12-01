(use-package org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (latex . t)))
;; (setq org-adapt-indentation t
;; 	  org-hide-leading-stars nil
;; 	  org-odd-levels-only nil)
(setq org-src-fontify-natively t
      org-src-window-setup 'current-window ;; edit in current window
      org-src-strip-leading-and-trailing-blank-lines t
      org-src-preserve-indentation t ;; do not put two spaces on the left
      org-src-tab-acts-natively t)
;; when edit the code, then load the configuration
(defun my-org-confirm-babel-evaluate (lang body)
(not (string= lang "python")))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
(setq org-edit-src-content-indentation 0)
;; set the width of the inline image.
(add-hook 'org-mode-hook #'org-inline-pdf-mode)
(setq org-image-actual-width 350)
(add-hook 'org-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'org-cdlatex-mode)
;; (use-package org-bullets
;;   :config
;;   (add-hook 'org-mode-hook #'org-bullets-mode)
;;   (setq inhibit-compacting-font-caches t)
;;   (setq org-bullets-bullet-list '( "⦿" "○" "✸" "✿" "◆")))
(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-hide-leading-stars t)
  (setq org-indent-mode-turns-on-hiding-stars nil))
(provide 'myorg)
