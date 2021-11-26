(setq c-default-style "linux")
(setq-default c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode t)
;; (require 'company)

(use-package company-c-headers
  :init
  (eval-after-load 'company
	'(add-to-list 'company-backends 'company-c-headers)))
(use-package company-irony
  :init
  (eval-after-load 'company
	'(add-to-list 'company-backends 'company-irony)))
(provide 'myc)
