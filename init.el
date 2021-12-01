;; Minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
		  (lambda ()
			(setq gc-cons-threshold (expt 2 23))))
;; add the archives
(package-initialize)
(setq package-archives '(("gnu"       . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
;; confirm install the package 'use-package
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
    (package-install 'use-package))
;; ensure all the package install automatically.
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;; prohabit the bell and the screen blink
(setq ring-bell-function #'ignore)
;; inhibit the startup-screen
(setq inhibit-startup-screen t)
;; if you modify the configuratio
;; in the directory 'elpa, it can load automatically.
(setq load-prefer-newer t)
;; show the current line
(hl-line-mode)
;; load basic configuration
(use-package basic
  :load-path "~/.emacs.d/etc"
  :custom
  (user-full-name "Rifiuto")
  :init
  ;; add some headers for shell, c and python
  (auto-insert-mode)
  (setq auto-insert-query nil)
  :config
  (defun headers//insert-string()
	(concat
	 (make-string 80 ?*)
	 "\n"
	 "Copyright © " (substring (current-time-string) -4) " " (user-full-name) "\n"
	 "File Name: " (file-name-nondirectory buffer-file-name) "\n"
	 "Author: " (user-full-name)"\n"
	 "Email: " user-mail-address "\n"
	 "Created: " (format-time-string "%Y-%m-%d %T (%Z)" (current-time)) "\n"
	 "Last Update: \n"
	 "         By: \n"
	 "Description: \n"
	 (make-string 80 ?*)))
  (defun headers/insert-string(&optional prefix)
	"Add the comment symbol."
	(or prefix (setq prefix comment-start))
	(mapconcat
	 (lambda (x) (concat prefix x))
	 (split-string (headers//insert-string) "\n") "\n"))

  (setq auto-insert-alist
		'(((python-mode . "Python program") nil
           "#!/usr/bin/env python\n"
           "# -*- coding: utf-8 -*-\n"
           (headers/insert-string) "\n")
          ((c-mode . "C program") nil
           "/*"
           (string-trim-left (headers/insert-string " ")) "*/\n"
           "#include<stdio.h>\n"
           "#include<string.h>\n")
          ((sh-mode . "Shell script") nil
           "#!/usr/bin/bash\n"
           (headers/insert-string) "\n"))))



;; change the prefix for outline-minor-mode
(customize-set-variable 'outline-minor-mode-prefix [(control o)])


;; alias
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package counsel)
(use-package swiper
  :init (ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))
;; magit
(use-package magit)

;;;
(use-package neotree
  :defer 2
  :init
  (unless (package-installed-p 'all-the-icons)
	(progn
	  (package-install 'all-the-icons)
	  (command-execute 'all-the-icons-install-fonts)
	  (shell-command "fc-cache -f -v")))
  :bind
  ("<f8>" . neotree-toggle)
  :custom
  (neo-window-width 20)
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))



(use-package rainbow-delimiters
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  (prog-mode . rainbow-delimiters-mode)
  (LaTeX-mode . rainbow-delimiters-mode)
  :custom-face
  (rainbow-delimiters-depth-1-face ((t (:foreground "#ffd700")))) ;00ffcc
  (rainbow-delimiters-depth-2-face ((t (:foreground "#e67300"))))
  (rainbow-delimiters-depth-3-face ((t (:foreground "#1ac6ff"))))
  (rainbow-delimiters-depth-4-face ((t (:foreground "#ff1ab2"))))
  (rainbow-delimiters-depth-5-face ((t (:foreground "orange"))))
  )


(use-package company
  :defer 2
  :hook
  ((python-mode . company-mode)
   (c-mode . company-mode)
   (emacs-lisp-mode . company-mode)
   (sh-mode . company-mode))
  :custom
  (company-show-numbers nil)
  (company-idle-delay 0.01)
  (company-minimum-prefix-length 1)
  :config
  (setq company-backends (delete 'company-semantic company-backends)))


;; ;;
;; (use-package exec-path-from-shell
;;   :config
;;   (when (memq window-system '(mac ns x))
;; 	(exec-path-from-shell-initialize))
;;   (when (daemonp)
;; 	(exec-path-from-shell-defun)))



(use-package multiple-cursors
  :defer t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "A fan of Emacs")
  (setq dashboard-startup-banner "~/.emacs.d/emacs.png")
  (dashboard-modify-heading-icons '((recents . "file-text")
									(bookmarks . "book")))
  (setq dashboard-center-content t)
  ;; To disable shortcut "jump" indicators for each section, set
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-set-init-info t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-navigator t)
  (setq dashboard-footer-messages '("我是真的帅"))
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          ;; (projects . 5)
                          ;; (agenda . 5)
                          (registers . 5)))
  (add-hook 'after-init-hook (lambda () (dashboard-refresh-buffer)))
  )
(use-package page-break-lines
  :defer t
  :hook (after-init . page-break-lines-mode))

(use-package projectile)
(use-package vterm
  :config
  (add-hook 'vterm-mode-hook
          (lambda ()
            (set (make-local-variable 'buffer-face-mode-face) 'fixed-pitch)
            (buffer-face-mode t))))


(set-frame-parameter (selected-frame) 'alpha '(80 . 90))
(add-to-list 'default-frame-alist '(alpha . (95 . 90)))
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(80 . 60) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)




(use-package lispy
  :hook (emacs-lisp-mode . lispy-mode)
  (emacs-lisp-mode . linum-mode))


(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))
(global-set-key (kbd "C-c o") 'switch-to-minibuffer) ;; Bind to `C-c o'

(require 'myc)
(require 'mypython)
(require 'mylatex)
(require 'myorg)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-show-quick-access nil nil nil "Customized with use-package company")
 '(outline-minor-mode-prefix [(control o)])
 '(package-selected-packages
   '(org-superstar csv-mode circadian hide-mode-line page-break-lines bash-completion emacs-bash-completion org-inline-pdf doom-modeline org vterm use-package solarized-theme rainbow-delimiters python-mode projectile pdf-tools org-bullets neotree multiple-cursors magit lsp-ui lsp-jedi lsp-ivy lispy latex-preview-pane jedi highlight-parentheses flycheck elpy ein doom-themes dashboard company-irony company-c-headers cdlatex beacon auctex all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "red"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#ffd700"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#e67300"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#1ac6ff"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#ff1ab2"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "orange")))))
