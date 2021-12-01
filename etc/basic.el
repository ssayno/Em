;; set default font
;; (set-frame-font "DejaVu Sans Mono 11" nil t)
;; set english font
(set-face-attribute
 'default nil :font "Fira Code")
;; set for chinese font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
					charset
					(font-spec :family "Noto Sans CJK SC")))
;; 如果想要，可以使用筑紫字体 Heiti SC
;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
;; backup and file related
(setq make-backup-files nil)
(setq auto-save-default t)
(setq-default indent-tabs-mode t)
;; 4 is more popular than 8.
(setq-default tab-width 4)
;; fullscreen
(if (display-graphic-p)
    (setq initial-frame-alist
          '((tool-bar-lines . 0)
            (fullscreen . maximized)))
  (setq initial-frame-alist '((tool-bar-lines . 0))))
(setq default-frame-alist
      '((tool-bar-lines . 0)
        (fullscreen . maximized)))
;; set the title
;; (setq-default frame-title-format '("sayno"))
;; basic mode
(progn
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (menu-bar-mode)
  (blink-cursor-mode -1)
  (recentf-mode)
  ;; highlight the paren
  (show-paren-mode)
  ;; Delete parentheses in pairs
  (electric-pair-mode 1)
  ;; show the column number
  (column-number-mode))
;; set time for emacs in mode-line 
(add-hook 'after-init-hook (lambda ()
							 (setq display-time-24hr-format t)
							 (setq display-time-day-and-date t)
							 (display-time-mode)))

;; when you have a process in emacs
;; set this, it won't ask if kill them when you quit
(setq confirm-kill-processes nil)
;; set some basic global key
(global-set-key (kbd "<f9>") 'whitespace-mode)
(global-set-key (kbd "<f7>") 'hl-line-mode)
;; change the mode-line
(use-package hide-mode-line
  :hook
  (after-init . hide-mode-line-mode))
(use-package doom-modeline
  :defer 2
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-window-width-limit fill-column)
  ;; set version
  (setq doom-modeline-env-version t)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; load theme ;;;;;;;;;;;;;;;;;
;; (use-package solarized-theme
;;   :config
;;   (if (daemonp)
;; 	  (load-theme 'solarized-gruvbox-light t)
;; 	(load-theme 'solarized-gruvbox-dark t)))
;; (use-package doom-themes
;;   :config
;;   (if (daemonp)
;; 	  (load-theme 'doom-gruvboxy t)
;; 	(load-theme 'doom-gruvbox t))
;;   )
(use-package doom-themes
  :defer t)
(use-package circadian
  :config
  (setq calendar-latitude 22.247690)
  (setq calendar-longitude 114.222107)
  ;; sunrise dark, sunset light
  (setq circadian-themes '((:sunrise . doom-gruvbox)
                           (:sunset  . doom-one)))
  (circadian-setup)
  (add-hook 'circadian-after-load-theme-hook
			#'(lambda (theme)
				;; Line numbers appearance
				(setq linum-format 'linum-format-func)
				;; Cursor
				(set-default 'cursor-type 'box)
				(set-cursor-color "#F52503"))))
(use-package csv-mode
  :defer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'basic)
