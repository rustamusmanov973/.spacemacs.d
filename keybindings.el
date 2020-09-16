;; KEYBINDINGS:
(fset 'insert_foobar [?i ?f ?o ?o ?b ?a ?r escape])
(fset 'insert_foobar2 [?i ?f ?o ?o ?b ?a escape])
(evil-set-register ?f [?i ?f ?o ?o ?b ?a ?r escape])
(evil-set-register ?q [?i ?f ?o ?o ?b ?a escape])
(global-set-key (kbd "<s-backspace>") 'backward-kill-line)
(global-set-key (kbd "C-M-]") 'kill-line)
(global-set-key (kbd "C-M-ъ") 'kill-line)
(global-set-key (kbd "M-s-|") 'kill-word)
(global-set-key (kbd "M-s-/") 'kill-word)
(global-set-key (kbd "M-m") 'spacemacs/frame-killer)
(global-set-key (kbd "M-s-!") 'beginning-of-line)
(global-set-key (kbd "M-s-!") 'beginning-of-line)
(global-set-key (kbd "M-s-@") 'end-of-line)
(global-set-key (kbd "M-s-\"") 'end-of-line)
(global-set-key (kbd "M-s-#") 'evil-backward-word-begin)
(global-set-key (kbd "M-s-№") 'evil-backward-word-begin)
(global-set-key (kbd "C-z") 'org-babel-execute-src-block)
(global-set-key (kbd "C-z") 'org-babel-execute-src-block)
(global-set-key (kbd "C-k") 'nil)
(global-set-key (kbd "C-b") 'nil)
;; C-j was:  (org-return-indent)
;; (define-key org-mode-map (kbd "C-k") 'org-backward-paragraph)
;; (define-key org-mode-map (kbd "C-j") 'org-forward-paragrapha
;; (set-register ?p '(file . "~/org/prd.org")
