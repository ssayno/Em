(use-package org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (latex . t)))
(setq org-adapt-indentation t
	  org-hide-leading-stars nil
	  org-odd-levels-only nil)

(setq org-edit-src-content-indentation 0
      org-src-tab-acts-natively t
      org-src-preserve-indentation t)
;; set the width of the inline image.
(setq org-image-actual-width 350)
(add-hook 'org-mode-hook 'linum-mode)
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook #'org-bullets-mode)
  (setq inhibit-compacting-font-caches t))
(provide 'myorg)
