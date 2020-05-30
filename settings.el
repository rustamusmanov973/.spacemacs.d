(package-initialize)
(pdf-tools-install)
;; (require 'xonsh-mode)
;; (require 'pdf-tools)
(require 'ob-ipython)
(add-to-list 'org-src-lang-modes '("jupyter" . python))
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)
   (js . t)
   (clojure . t)
   (emacs-lisp . t)
   (ipython . t)
   (jupyter . t)
   ))
(org-babel-jupyter-override-src-block "python")


(defun ety-open (query)
  (progn
    (print (concat "opening ety link: " query))
    (browse-url-chrome (message (concat "https://www.etymonline.com/search?q=" query)))
    ))
(org-link-set-parameters "etl"
                         :follow #'ety-open
                         :face #'org-warning
                         :mouse-face #'vertical-border
                         :help-echo (lambda () (interactive) (print "help-echo"))
                         :display 'full)
(org-add-link-type "chrome"  (lambda (path) (browse-url-chrome (concat "http:" path))))
(org-add-link-type "chromes" :follow (lambda (path) (browse-url-chrome (concat "https:" path))))
(org-add-link-type "chromium" :follow (lambda (path) (browse-url-chromium (concat "http:" path))))
(org-add-link-type "chromiums" :follow (lambda (path) (browse-url-chromium (concat "https:" path))))
(org-add-link-type "ety" :follow (lambda (query) (browse-url-chrome (message (concat "https://www.etymonline.com/search?q=" query)))))
(org-add-link-type "ety" (lambda (query) (progn (message (concat "Fetching etymology for query: " query)) (browse-url-chrome (concat "https://www.etymonline.com/search?q=" query)))))

(custom-set-variables
 '(tramp-default-method "ssh"))
;; abbrev dirs: https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html 

(setq-default abbrev-mode t)
;; (define-abbrev global-abbrev-table "dtF" "~/wrk/dotfiles")
;; (define-abbrhv global-abbrev-table "dta\\" "~/wrk/")
;; (define-abbrev global-abbrev-table "dL" "~/Downloads/")
;; (define-abbrev global-abbrev-table "dtP" "~/Desktop/")
;; (define-abbrev global-abbrev-table "r" "~/lib/rc/")
;; (define-abbrev global-abbrev-table "r" "~/lib/rc/")
;; (define-abbrev global-abbrev-table "L" "~/Library/")
;; (define-abbrev global-abbrev-table "A" "/Applications/")
;; (define-abbrev global-abbrev-table "S" "/System/")
;; (define-abbrev global-abbrev-table "V" "/Volumes/")
;; (define-abbrev global-abbrev-table "U" "/Users/")
;; (define-abbrev global-abbrev-table "/")
;; (define-abbrev global-abbrev-table "lb" "~/Library/")
(define-abbrev global-abbrev-table "srvh" "/ssh:srv:/home/domain/rustam/")
(define-abbrev global-abbrev-table "srvu" "/ssh:srv:/home/domain/data/rustam/")
(define-abbrev global-abbrev-table "srvd" "/ssh:srv:/home/domain/data/rustam/dgfl/")
(define-abbrev global-abbrev-table "srve" "/ssh:srv:/home/domain/data/rustam/dgfl/ed/")
(define-abbrev global-abbrev-table "srvm" "/ssh:srv:/home/domain/data/rustam/dgfl/md")

;; define-abbrev-table
(add-hook
 'minibuffer-setup-hook
 (lambda ()
   (abbrev-mode 1)
   (setq local-abbrev-table my-tramp-abbrev-table)))

(defadvice minibuffer-complete
    (before my-minibuffer-complete activate)
  (expand-abbrev))

;; If you use partial-completion-mode
(defadvice PC-do-completion
    (before my-PC-do-completion activate)
  (expand-abbrev))


(use-package shr-tag-pre-highlight
  :ensure t
  :after shr
  :config
  (add-to-list 'shr-external-rendering-functions
               '(pre . shr-tag-pre-highlight))
  (when (version< emacs-version "26")
    (with-eval-after-load 'eww
      (advice-add 'eww-display-html :around
                  'eww-display-html--override-shr-external-rendering-functions))))

   ;; Eclim ...
   ;; (add-hook 'java-mode-hook (lambda () (interactive) (progn (message "consider activating :(global-eclim-mode)")(eclim-mode))))
(custom-set-variables
 '(eclim-eclipse-dirs '("/Users/rst/eclipse/java-2020-03/Eclipse.app/Contents/Eclipse"))
 '(eclim-executable "/Users/rst/.p2/pool/plugins/org.eclim_2.8.0/bin/eclim"))
(require 'pubmed)
(require 'pubmed-advanced-search)
(let ((bookmarkplus-dir "~/.emacs.d/custom/bookmark-plus/")
      (emacswiki-base "https://www.emacswiki.org/emacs/download/")
      (bookmark-files '("bookmark+.el" "bookmark+-mac.el" "bookmark+-bmu.el" "bookmark+-key.el" "bookmark+-lit.el" "bookmark+-1.el")))
  (require 'url)
  (add-to-list 'load-path bookmarkplus-dir)
  (make-directory bookmarkplus-dir t)
  (mapcar (lambda (arg)
            (let ((local-file (concat bookmarkplus-dir arg)))
              (unless (file-exists-p local-file)
                (url-copy-file (concat emacswiki-base arg) local-file t))))
          bookmark-files)
  (byte-recompile-directory bookmarkplus-dir 0)
  (require 'bookmark+))


(use-package org-pdftools
  :init (message "org-pdftools init ")
  :hook (org-load . org-pdftools-setup-link)
  :config (message "org-pdftools config ")
  )
(use-package org-noter-pdftools
  :init (message "org-noter-pdftools init ")
  :after org-noter
  :config
  (message "org-noter-pdftools config ")
  (with-eval-after-load 'pdf-annot
    (add-hook 'pdf-annot-activate-handler-functions #'org-noter-pdftools-jump-to-note)))
;; (use-package multi-vterm
;; :init (message "multi-vterm init ")
;; :config
;; (message "multi-vterm config")
;; (add-hook 'vterm-mode-hook
;; (lambda ()
;; (setq-local evil-insert-state-cursor 'box)
;; (evil-insert-state)))
;; (define-key vterm-mode-map [return]                      #'vterm-send-return)

;; (setq vterm-keymap-exceptions nil)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
;; (evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
;; (evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
;; (evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
;; (evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
;; (evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
;; (evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
;; (evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
;; (evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))
(use-package shr-tag-pre-highlight
  :ensure t
  :after shr
  :config
  (add-to-list 'shr-external-rendering-functions
                '(pre . shr-tag-pre-highlight))
  (when (version< emacs-version "26")
    (with-eval-after-load 'eww
      (advice-add 'eww-display-html :around
                  'eww-display-html--override-shr-external-rendering-functions))))
;; Tramp is slow, so:
(setq projectile-mode-line "Projectile")
;; (setq tramp-verbose 6)
(setq tramp-verbose 6)
(add-to-list 'exec-path "/usr/local/Cellar/ImageMagick")
;; (load-file "~/.spacemacs.d/vkontakte.el")
(add-to-list 'org-emphasis-alist
             '("*" (:foreground "orange")
               ))
