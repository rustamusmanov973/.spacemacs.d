;; LEADER KEYS

(spacemacs/set-leader-keys "bs" nil)
(setq spacemacs/key-binding-prefixes '(
                                       ("o" "own-menu")
                                       ("og" "Google ...")
                                       ("fy" "Yanking ...")
                                       ("fyr" "relative ..")
                                       ("fx" "Exec ...")
                                       ("fx" "Exec ...")
                                       ("bc" "ACE ...")
                                       ("bcs" "Ace starred...")
                                       ("bs" "Star/Scratch..")
                                       ("bsm" "Messages..")
                                       ("bsw" "Warnings..")
                                       ))
;; (print server-name)
;; (server-start)
;; emacsclient -s
;; (progn (set-variable 'server-name "gepy") (setq server-socket-dir "~/.emacs.d/servers/"))
;; emacs --eval $'(progn (set-variable \'server-name "gepy") (setq server-socket-dir "~/.emacs.d/servers/")(server-start))'
;; emacsclient -s "/Users/rst/.emacs.d/servers/gepy" --eval '(load-file "/tmp/gepy.el")'

(spacemacs/set-leader-keys
  "bss" 'spacemacs/switch-to-scratch-buffer
  "bsms" 'spacemacs/switch-to-messages-buffer
  "bsmm" 'messages-buffer-scroll-down
  "bsww" 'warnings-buffer-scroll-down
"os" 'org-save-all-org-buffers
"oi" 'helm-org-agenda-files-headings
"ogm" 'google-last-message
"ogw" 'google-last-warning
"iSc" 'yas-new-snippet
"fy" nil
"fy" nil
"fyy" (lambda () (interactive) (message (kill-new (buffer-file-name))))
"fyf" 'copy-file-name-nondirectory
"fyd" 'copy-file-name-directory
"fyr" nil
"fyrr" 'copy-rel-path-auto
"fyrg" 'copy-rel-path-goku-key
"fx" nil
"fxx" 'execute-file-auto
"fk" 'helm-bookmarks
"wx" 'ill-buffer-and-window
"k[" 'beginning-of-defun
"k]" (lambda () (interactive) (progn (beginning-of-defun)(evil-jump-item)))
)

(spacemacs/declare-prefix-for-mode 'emacs-lisp-mode "m" "Mark ...")
(spacemacs/set-leader-keys-for-minor-mode 'emacs-lisp-mode  "m" nil)
(spacemacs/set-leader-keys-for-minor-mode 'emacs-lisp-mode  "[" 'beginning-of-defun)
(spacemacs/set-leader-keys-for-minor-mode 'emacs-lisp-mode  "]" (lambda () (interactive) (progn (beginning-of-defun)(evil-jump-item))))
(spacemacs/set-leader-keys-for-minor-mode 'emacs-lisp-mode  "." (lambda () (interactive) (spacemacs/defun-jump-transient-state-transient-state/end-of-defun)))
(spacemacs/set-leader-keys-for-minor-mode 'emacs-lisp-mode  "mf" 'mark-defun)
(defvar treemacs-node-visit-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s")        #'treemacs-visit-node-vertical-split)
    (define-key map (kbd "v")        #'treemacs-visit-node-horizontal-split)
    (define-key map (kbd "o")        #'treemacs-visit-node-no-split)
    (define-key map (kbd "aa")       #'treemacs-visit-node-ace)
    (define-key map (kbd "av")       #'treemacs-visit-node-ace-horizontal-split)
    (define-key map (kbd "as")       #'treemacs-visit-node-ace-vertical-split)
    (define-key map (kbd "r")        #'treemacs-visit-node-in-most-recently-used-window)
    (define-key map (kbd "x")        #'treemacs-visit-node-in-external-application)
    map)
  "Keymap for node-visiting commands in `treemacs-mode'.")

