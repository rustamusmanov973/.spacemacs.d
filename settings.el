 (package-initialize)

;; In order to automatically start RefTeX when you open a LaTeX file add the following code to your init file
;; Turn on RefTeX in AUCTeX
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Activate nice interface between RefTeX and AUCTeX
(setq reftex-plug-into-AUCTeX t)


(setq TeX-auto-save t)  
(setq TeX-parse-self t)  
(setq-default TeX-master nil)  
;; https://www.emacswiki.org/emacs/ExecPath
;; (setq exec-path (append exec-path '("/usr/local/texlive/2020basic/bin/x86_64-darwin")))
(setenv "PATH" "/usr/local/texlive/2020basic/bin/x86_64-darwin:$PATH" t)
(use-package pdf-tools
  :ensure t
  :config
  (custom-set-variables
   '(pdf-tools-handle-upgrades nil)) ; Use brew upgrade pdf-tools instead.
  (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo"))
(pdf-tools-install)
;; ;; (require 'xonsh-mode)
;; ;; (require 'pdf-tools)
;; (require 'ob-ipython)
;; (add-to-list 'org-src-lang-modes '("jupyter" . python))
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((python . t)
;;    (shell . t)
;;    (js . t)
;;    (clojure . t)
;;    (emacs-lisp . t)
;;    (ipython . t)
;;    (jupyter . t)
;;    ))
;; (org-babel-jupyter-override-src-block "python")

;; (require 'pubmed)
;; (require 'pubmed-advanced-search)
;; (use-package shr-tag-pre-highlight
;;   :ensure t
;;   :after shr
;;   :config
;;   (add-to-list 'shr-external-rendering-functions
;;                '(pre . shr-tag-pre-highlight))
;;   (when (version< emacs-version "26")
;;     (with-eval-after-load 'eww
;;       (advice-add 'eww-display-html :around
;;                   'eww-display-html--override-shr-external-rendering-functions))))

;; (use-package shr-tag-pre-highlight
;;   :ensure t
;;   :after shr
;;   :config
;;   (add-to-list 'shr-external-rendering-functions
;;                '(pre . shr-tag-pre-highlight))
;;   (when (version< emacs-version "26")
;;     (with-eval-after-load 'eww
;;       (advice-add 'eww-display-html :around
;;                   'eww-display-html--override-shr-external-rendering-functions))))
(defun ety-open (query)
  (progn
    (print (concat "opening ety link: " query))
    (browse-url-chrome (message (concat "https://www.etymonline.com/search?q=" query)))
    ))
(use-package org)
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
(org-add-link-type "prod" (lambda (query) (progn (message (concat "Making product link... : " query)) (browse-url-chrome (concat "https://sbermarket.ru/metro/search?keywords=" (replace-in-string " " "+" query))))))

(custom-set-variables
 '(tramp-default-method "ssh"))
;; abbrev dirs: https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html 

(setq-default abbrev-mode t)
;; (define-abbrev global-abbrev-table "rx" "/ssh:srv:/home/domain/data/rustam/dgfl/md")
(define-abbrev my-tramp-abbrev-table "rxa" "\\(.*?\\")

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




   ;; Eclim ...
   ;; (add-hook 'java-mode-hook (lambda () (interactive) (progn (message "consider activating :(global-eclim-mode)")(eclim-mode))))
(custom-set-variables
 '(eclim-eclipse-dirs '("/Users/rst/eclipse/java-2020-03/Eclipse.app/Contents/Eclipse"))
 '(eclim-executable "/Users/rst/.p2/pool/plugins/org.eclim_2.8.0/bin/eclim"))
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

;; Tramp is slow, so:
(setq projectile-mode-line "Projectile")
;; (setq tramp-verbose 6)
(setq tramp-verbose 6)
(add-to-list 'exec-path "/usr/local/Cellar/ImageMagick")
;; (load-file "~/.spacemacs.d/vkontakte.el")
(add-to-list 'org-emphasis-alist
             '("*" (:foreground "orange")
               ))
(setq vterm-toggle-fullscreen-p nil)
(add-to-list 'display-buffer-alist
             '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
               (display-buffer-reuse-window display-buffer-at-bottom)
               ;;(display-buffer-reuse-window display-buffer-in-direction)
               ;;display-buffer-in-direction/direction/dedicated is added in emacs27
               ;;(direction . bottom)
               ;;(dedicated . t) ;dedicated is supported in emacs27
               (reusable-frames . visible)
               (window-height . 0.3)))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))
;; https://stackoverflow.com/questions/5034839/emacs-pop-up-bottom-window-for-temporary-buffers
(push '("\*anything*" :regexp t :height 20) popwin:special-display-config)

(add-to-list 'auto-mode-alist '("\\.fnl\\'" . clojure-mode))

(add-to-list 'load-path "/Users/rst/.emacs.d/site-lisp/org-ref/")
(add-to-list 'load-path "/Users/rst/.emacs.d/site-lisp/misc/")
(add-to-list 'load-path "/Users/rst/.emacs.d/site-lisp/iproject/")
(require 'iproject)

(setq symbol-to-kar-py-symbol '(
("!" . ":!S1")
("@" . ":!S2")
("#" . ":!S3")
("$" . ":!S4")
("%" . ":!S5")
("^" . ":!S6")
("&" . ":!S7")
("*" . ":!S8")
("(" . ":!S9")
(")" . ":!S0")
("_" . ":!Shyphen")
("+" . ":!Sequal_sign")
("Q" . ":!Sq")
("W" . ":!Sw")
("E" . ":!Se")
("R" . ":!Sr")
("T" . ":!St")
("Y" . ":!Sy")
("U" . ":!Su")
("I" . ":!Si")
("O" . ":!So")
("P" . ":!Sp")
("{" . ":!Sopen_bracket")
("}" . ":!Sclose_bracket")
("|" . ":!Sbackslash")
("A" . ":!Sa")
("S" . ":!Ss")
("D" . ":!Sd")
("F" . ":!Sf")
("G" . ":!Sg")
("H" . ":!Sh")
("J" . ":!Sj")
("K" . ":!Sk")
("L" . ":!Sl")
(":" . ":!Ssemicolon")
("\"" . ":!Squote")
("Z" . ":!Sz")
("X" . ":!Sx")
("C" . ":!Sc")
("V" . ":!Sv")
("B" . ":!Sb")
("N" . ":!Sn")
("M" . ":!Sm")
("<" . ":!Scomma")
(">" . ":!Speriod")
("?" . ":!Sslash")
("1" . ":1")
("2" . ":2")
("3" . ":3")
("4" . ":4")
("5" . ":5")
("6" . ":6")
("7" . ":7")
("8" . ":8")
("9" . ":9")
("0" . ":0")
("-" . ":hyphen")
("=" . ":equal_sign")
("q" . ":q")
("w" . ":w")
("e" . ":e")
("r" . ":r")
("t" . ":t")
("y" . ":y")
("u" . ":u")
("i" . ":i")
("o" . ":o")
("p" . ":p")
("[" . ":open_bracket")
("]" . ":close_bracket")
("\\" . ":backslash")
("a" . ":a")
("s" . ":s")
("d" . ":d")
("f" . ":f")
("g" . ":g")
("h" . ":h")
("j" . ":j")
("k" . ":k")
("l" . ":l")
(";" . ":semicolon")
("\'" . ":quote")
("z" . ":z")
("x" . ":x")
("c" . ":c")
("v" . ":v")
("b" . ":b")
("n" . ":n")
("m" . ":m")
("," . ":comma")
("." . ":period")
("/" . ":slash")
(" " . ":spacebar")
                                ))
(require 'org-ref)
(require 'org-tempo)
(page-break-lines-mode)
