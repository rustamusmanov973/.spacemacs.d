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
                                       ("bg" "misc..")
                                       ("d" "Directory, Delete...")
                                       ("dr" "ranger..")
                                       ("dd" "deer")
                                       ("dh" "helm find directory")
                                       ))
;; (print server-name)
;; (server-start)
;; emacsclient -s
;; (progn (set-variable 'server-name "gepy") (setq server-socket-dir "~/.emacs.d/servers/"))
;; emacs --eval $'(progn (set-variable \'server-name "gepy") (setq server-socket-dir "~/.emacs.d/servers/")(server-start))'
;; emacsclient -s "/Users/rst/.emacs.d/servers/gepy" --eval '(load-file "/tmp/gepy.el")'



(if nil
    (customize-save-variable 'abbreved-paths-rst '(
                                                "u" "/Users"
                                                "o" "/opt"
                                                "v" "/var"
                                                "h"  "~/"
                                                "p" "/Users/rst/msc/projects/"
                                                "m" "/Users/rst/msc/"
                                                "n" "/Users/rst/msc/daemons/"
                                                "l" "/Users/rst/lib/"
                                                "a" "/Users/rst/lib/as"
                                                "y" "/Users/rst/lib/py/"
                                                "s" "/Users/rst/lib/sh/"
                                                "e" "/Users/rst/lib/el/"
                                                "r" "/Users/rst/lib/rc/"
                                                "w" "/Users/rst/wrk/"
                                                "f" "/Users/rst/wrk/dotfiles"
                                                "L" "/Users/rst/wrk/lib/"
                                                "d" "/Users/rst/Downloads/"
                                                "D" "/Users/rst/Desktop/"
                                                ))

  )
(defun my-eval-string (string)
  (eval (car (read-from-string (format "(progn %s)" string)))))
(defun map-plist (fn plist)
  "..."
  (let ((pl    plist)
        (vals  ()))
    (while pl
      (push (funcall fn (car pl) (cadr pl)) vals)
      (setq pl (cddr pl)))
    (nreverse vals)))

(let ((rst-lk '(
                "bss" spacemacs/switch-to-scratch-buffer
                "bsms" spacemacs/switch-to-messages-buffer
                "bsmm" messages-buffer-scroll-down
                "bsww" warnings-buffer-scroll-down
                "os" org-save-all-org-buffers
                "oi" helm-org-agenda-files-headings
                "ogm" google-last-message
                "ogw" google-last-warning
                "iSc" yas-new-snippet
                "fy" nil
                "fy" nil
                "fyy" (lambda () (interactive) (message (kill-new (buffer-file-name))))
                "fyf" copy-file-name-nondirectory
                "fyd" copy-file-name-directory
                "fyr" nil
                "fyrr" copy-rel-path-auto
                "fyrg" copy-rel-path-goku-key
                "fx" nil
                "fxx" execute-file-auto
                "fk" helm-bookmarks
                "wx" ill-buffer-and-window
                "k[" beginning-of-defun
                "k]" (lambda () (interactive) (progn (beginning-of-defun)(evil-jump-item)))
                "bgr" rename-buffer
                "s," spotlight-fast
                "fem" (lambda () (interactive) (find-file "~/.spacemacs.d/module.el"))
                "fer" (lambda () (interactive) (find-file "~/.spacemacs.d/leader_keys.el"))
                "fek" (lambda () (interactive) (find-file "~/.spacemacs.d/keybindings.el"))
                "fes" (lambda () (interactive) (find-file "~/.spacemacs.d/settings.el"))
                "fet" (lambda () (interactive) (find-file "~/.spacemacs.d/transient_states.el"))
                "dhA" (lambda () (interactive) (helm-find-files-with-inp "/Applications/"))
                )))
  (progn
    (map-plist
     (lambda (x y) (plist-put rst-lk (concat "dr" x) (my-eval-string (concat " (lambda () (interactive) (ranger-go ?" x "))")))) abbreved-paths-rst)
    (map-plist
     (lambda (x y) (plist-put rst-lk (concat "dd" x) (my-eval-string (concat " (lambda () (interactive) (deer \"" y "\"))")))) abbreved-paths-rst)
    (apply #'spacemacs/set-leader-keys rst-lk)
    ))

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
