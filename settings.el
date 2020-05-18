(package-initialize)
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

(org-add-link-type "chrome"  (lambda (path) (browse-url-chrome (concat "http:" path))))
(org-add-link-type "chromes" :follow (lambda (path) (browse-url-chrome (concat "https:" path))))
(org-add-link-type "chromium" :follow (lambda (path) (browse-url-chromium (concat "http:" path))))
(org-add-link-type "chromiums" :follow (lambda (path) (browse-url-chromium (concat "https:" path))))
(org-add-link-type "ety" :follow (lambda (query) (browse-url-chrome (message (concat "https://www.etymonline.com/search?q=" query)))))
(org-add-link-type "ety" (lambda (query) (progn (message (concat "Fetching etymology for query: " query)) (browse-url-chrome (concat "https://www.etymonline.com/search?q=" query)))))

(custom-set-variables
 '(tramp-default-method "ssh"))


;; (setenv "xy" "/ssh:news@news.my.domain:/opt/news/etc/")
(add-to-list
 'directory-abbrev-alist
 '("^/xy" . "/ssh:news@news.my.domain:/opt/news/etc/")
 )
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
    
