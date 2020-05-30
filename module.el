  (defun my-reload-dir-locals-for-current-buffer ()
    "reload dir locals for the current buffer"
    (interactive)
    (let ((enable-local-variables :all))
      (hack-dir-local-variables-non-file-buffer)))
  (defun my-reload-dir-locals-for-all-buffer-in-this-directory ()
    "For every buffer with the same `default-directory` as the
current buffer's, reload dir-locals."
    (interactive)
    (let ((dir default-directory))
      (dolist (buffer (buffer-list))
        (with-current-buffer buffer
          (when (equal default-directory dir))
          (my-reload-dir-locals-for-current-buffer)))))

  (add-hook 'emacs-lisp-mode-hook
            (defun enable-autoreload-for-dir-locals ()
              (when (and (buffer-file-name)
                         (equal dir-locals-file
                                (file-name-nondirectory (buffer-file-name))))
                (add-hook (make-variable-buffer-local 'after-save-hook)
                          'my-reload-dir-locals-for-all-buffer-in-this-directory))))

    (defun find-file-new-buffer (filename)
    "Very basic `find-file' which does not use a pre-existing buffer."
    (interactive "fFind file in new buffer: ")
    (let ((buf (create-file-buffer filename)))
      (with-current-buffer buf
        (insert-file-contents filename t))
      (pop-to-buffer-same-window buf)))
  (defun pm (str)
    (print str)
    (message str)
    )
 (defun say (str)
   (shell-command-to-string (concat "say '"  str "'"))
    )
  (defun asay (str)
    "Say str asynchronously"
    (async-shell-command (concat "say '"  str "'"))
    )
    (defun write_goku_with_py ()
      (interactive )
    (print  "write_goku_with_py started")
      (setq kar_py_stderr
            (shell-command-to-trimmed-string  "/Users/rst/.config/karabiner_edn_writer.py >/dev/null"))
    (setq db 1)
  (vd 'kar_py_stderr "write_goku_with_py started")
      (if (string= "" kar_py_stderr)
    ;; (print "OK")
    (make_goku)
    (progn
  (print (concat "a_rst: karabiner_edn_writer.py ERROR>>|" kar_py_stderr "|"))
  (asay "python karabiner writer error")
  )))

  (defun make_goku ()
  (setq goku_output (shell-command-to-trimmed-string  "goku &; sleep 2; kill -9 $!"))
  (if (string-match "Done!" goku_output )
  (message "make_goku: OK")
  (progn
  (message (concat "make_goku ERROR: goku_output not 'Done!'>>|" goku_output "|"))
  (asay "goku error")
  )))


(defun my-after-save-actions ()
        "Used in `after-save-hook'."
        (message "After save activated")
        (let* ((bfn buffer-file-name))
          (cond
           ((member bfn (mapcar #'mac-concat-wdtf '(".profile" ".zprofile" ".zshrc" ".aliases" ".xonshrc")))
            (mac-copy-file-to-hdir bfn)
            (srv-copy-file-to-hdir bfn)
            (lom2-copy-file-to-rhdir bfn))
           ((string-equal bfn (mac-concat-dcnf "karabiner.edn"))
            (and (vdp) (say "Saving file"))(or (make_goku) (say "goku done, but use kar py file instead")))
           ((string-equal bfn (mac-concat-dcnf "karabiner_prettified_before_python_inject.edn"))
            (write_goku_with_py))
           ((string-equal (file-name-directory bfn) mac-wlib)
            (mac-copy-file-to-lb37 bfn)
            (srv-copy-file-to-lb37 bfn)
            ;; (lom2-copy-file-to-lb37 bfn)
            )
           ((string-equal bfn (mac-concat-wdtf "00-first.py"))
            (mac-copy-file-to-ipython-startup bfn)
            (srv-copy-file-to-ipython-startup bfn)
            ;; (lom2-copy-file-to-ext37 bfn)
            )
           ((string-equal bfn (mac-concat-wdtf "lb_prms.py"))
           (mac-copy-file-to-ext37 bfn)
           (srv-copy-file-to-ext37 bfn)
           ;; (lom2-copy-file-to-ext37 bfn)
           )
           ((string-equal (file-name-directory bfn) mac-ubin)
            (debug)
            (srv-copy-file-to-ubin bfn)
            (lom2-copy-file-to-ubin bfn)
           ;; .ssh, .spacemacs.d , .emacs.dk,  executables in 
           ))))
    (add-hook 'after-save-hook 'my-after-save-actions)
  (defun backward-kill-line (arg)
    "Kill ARG lines backward."
    (interactive "p")
    (kill-line (- 1 arg)))
  (defun h_world ()
    (message "hello world!!")
    (message "hello world!!")
    )
  (defun hwd ()
    (interactive)
    (message "hello world!!")
    (message "hello world!!")
    )
  (defun resolve-rel-path-auto ()
    (let ((file-name (or (buffer-file-name) list-buffers-directory)))
      (if file-name
          (progn
            (setq nfn buffer-file-name)
            (setq nfn (s-replace "/Users/rst/lib/rc/" "l" nfn))
            (setq nfn (s-replace "/Users/rst/lib/as/" "a" nfn))
            (setq nfn (s-replace "/Users/rst/lib/py/" "p" nfn))
            (setq nfn (s-replace "/Users/rst/lib/ss/" "s" nfn))
            (vd 'nfn)
            ;; (message (kill-new nfn))
            (message nfn)
            )
        (error "Buffer not visiting a file")))
    )
  (defun copy-rel-path-auto ()
    (interactive)
    (message (kill-new (subseq (resolve-rel-path-auto) 1)))
    )

  (defun copy-rel-path-goku-key ()
                          (interactive)
                          (message (kill-new (concat "[:" (read-string "key: ") " [:xl" (subseq (resolve-rel-path-auto) 0 1) " \"" (subseq (resolve-rel-path-auto) 1) "\"]]")))
                          )


  (defun copy-file-name-directory()
    (interactive)
    (let ((file-name (or (buffer-file-name) list-buffers-directory)))
      (if file-name
          (progn
            (message (kill-new (file-name-directory file-name)))
            )
        (error "Buffer not visiting a file")))
    )
  (defun copy-file-name-nondirectory()
    (interactive)
    (let ((file-name (or (buffer-file-name) list-buffers-directory)))
      (if file-name
          (progn
            (message (kill-new (file-name-nondirectory file-name)))
            )
        (error "Buffer not visiting a file")))
    )
  (defun dired-do-snippet-action1 (&optional arg)
    "Delete all marked (or next ARG) files.
`dired-recursive-deletes' controls whether deletion of
non-empty directories is allowed."
    ;; This is more consistent with the file marking feature than
    ;; dired-do-flagged-delete.
    (interactive "P")

    ;; (spacemacs/alternate-window)
    ;; (dired-do-snippet-action1)
    ;; (find-file "/Users/rst/.emacs.d/private/snippets/lisp-mode/comment")
    ;; (end-of-buffer)
    ;; (execute-kbd-macro 'insert_foobar)

    ;; (kmacro-pop-ring)
    ;; (find-file "/Users/rst/.emacs.d/private/snippets/lisp-mode/comment")
    ;; (execute-kbd-macro [?i ?f ?o ?o ?b ?a ?r escape])

    (let ((lst (dired-map-over-marks (message (dired-get-filename))
                                     nil)))
      (progn (loop for x in lst
             do (message x)))
      (switch-to-buffer "Music")


      )
     arg t)

  (defun execute-file-auto ()
    (interactive)
(setq args (read-string "With arg: "))
    (save-buffer)
    (message buffer-file-name)
    (setq qbfn (concat "'" buffer-file-name "'"))
    (setq scm (concat "chmod 777 " qbfn "; " qbfn " " args))
    (vd 'scm)
    (shell-command scm)
    )

  (defun ace-split (buf-name ori)
    (interactive)
    (require 'ace-window)
    (with-selected-window (aw-select (concat "Select window for " buf-name " buffer"))(my-eval-string (concat "(split-window-" ori "-and-focus)"))(progn (switch-to-buffer buf-name)(end-of-buffer)))
    )
  (defun ace-messages-right () (interactive)(ace-split "*Messages*" "right"))
  (defun ace-messages-below () (interactive)(ace-split "*Messages*" "below"))

  (defun buffer-scroll-down (buf-nam)
    (let* ((mes-win (get-buffer-window (get-buffer buf-nam)))
           )
      (if (null mes-win) (ace-messages-below) (with-selected-window mes-win (end-of-buffer)))
      )
)
  (defun messages-buffer-scroll-down ()(interactive)(buffer-scroll-down "*Messages*"))
  (defun warnings-buffer-scroll-down ()(interactive)(buffer-scroll-down "*Warnings*"))

  (setq gepy-alist '(
                     ("jup" .      (1 "jupyter-notebook --no-browser --port 8888"))
                     ("klg" .      (2 "keylogger"))
                     ("jpf_gpu" .  (3 "while true; do ssh -N -L 51515:localhost:51515 gpu || echo 'retrying...'; done"))
                     ("jpf_l2" .   (4 "hile true; do ssh -N -L 51517:localhost:51517 lom || echo 'retrying...'; done"))
                     ("pypf_srv" . (5 "while true; do ssh -N -R 9170:localhost:9170 gpu || echo 'retrying...'; done"))
                     ("als_ppf" .  (6 "hile true; do ssh -vvv -p 22022 -N -R9000:localhost:9000 rustam@alesia.store || echo 'retrying...'; done")))
                     )
  (defun gepy_very_bad ()
    (setq proc23 (start-process "jup" "jup" "jupyter-notebook" "--no-browser" "--port" "5555"))
    (process-live-p proc23)

    (start-process "klg" "klg" "keylogger")
    (start-process "klg" "klg" "keylogger")
    (start-process-shell-command "jpf_gpu" "ge:jpf_gpu" "while true; do ssh -N -L 51515:localhost:51515 gpu2 || echo 'retrying...'; done")
    (start-process-shell-command "jpf_l2" "ge:jpf_l2" "hile true; do ssh -N -L 51517:localhost:51517 lom2 || echo 'retrying...'; done")
    (start-process-shell-command "pypf_srv" "ge:pypf_srv" "while true; do ssh -N -R 9170:localhost:9170 gpu || echo 'retrying...'; done")
    (start-process-shell-command "als_ppf" "ge:als_ppf" "hile true; do ssh -vvv -p 22022 -N -R9000:localhost:9000 rustam@alesia.store || echo 'retrying...'; done")
    )

  (defun my-find-file ()
    "Like `icicle-find-file', but alt action views file temporarily.
    Alternate action keys such as `C-S-down' visit the candidate file in
    `view-mode' and kill the buffer of the last such viewed candidate."
    (interactive)
    (let ((icicle-candidate-alt-action-fn
           (lambda (file)
             (when (and my-last-viewed
                        (get-file-buffer my-last-viewed))
               (kill-buffer (get-file-buffer my-last-viewed)))
             (setq my-last-viewed  (abbreviate-file-name file))
             (view-file file)
             (select-frame-set-input-focus
              (window-frame (active-minibuffer-window))))))
      (icicle-find-file-of-content)))

  (defvar my-last-viewed nil
    "Last file viewed by alternate action of `my-find-file'.")
(defun kill-gepy ()
(kill-buffer "jup")
(kill-buffer "jup")
  )
(defun google-it(query)
  ;; (start-process "open" "open" "open" (concat "https://www.google.com/search?q=" query))
    (browse-url (format
                 "http://www.google.com/search?q=%s"
                 (url-hexify-string query)))
  )
(defun get-last-trimmed-line (buf-name)
  (with-current-buffer (get-buffer-create buf-name)
    (progn (goto-char (point-max))(string-trim (thing-at-point 'line t))))
  )
(defun google-last-message () (interactive) (google-it (get-last-trimmed-line "*Messages*")))
(defun google-last-warning () (interactive) (google-it (get-last-trimmed-line "*Warnings*")))

(defun htop ()
  (interactive)
  (if (get-buffer "*htop*")
      (switch-to-buffer "*htop*")
    (ansi-term "/bin/bash" "htop")
    (comint-send-string "*htop*" "htop\n")))
(defun htop-emacs ()
  (interactive)
  (if (get-buffer "*htop*")
      (switch-to-buffer "*htop*")
    (ansi-term "/bin/bash" "htop")
    (comint-send-string "*htop*" "htop\n")))
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )
(defun client-save-kill-emacs (&optional display)
"This is a function that can bu used to shutdown save buffers and
shutdown the emacs daemon. It should be called using
emacsclient -e '(client-save-kill-emacs)'.  This function will
check to see if there are any modified buffers or active clients
or frame.  If so an x window will be opened and the user will
be prompted."

  (let (new-frame modified-buffers active-clients-or-frames)

    ; Check if there are modified buffers or active clients or frames.
    (setq modified-buffers (modified-buffers-exist))
    (setq active-clients-or-frames ( or (> (length server-clients) 1)
					(> (length (frame-list)) 1)
				       ))

    ; Create a new frame if prompts are needed.
    (when (or modified-buffers active-clients-or-frames)
      (when (not (eq window-system 'x))
	(message "Initializing x windows system.")
	(x-initialize-window-system))
      (when (not display) (setq display (getenv "DISPLAY")))
      (message "Opening frame on display: %s" display)
      (select-frame (make-frame-on-display display '((window-system . x)))))

    ; Save the current frame.
    (setq new-frame (selected-frame))


    ; When displaying the number of clients and frames:
    ; subtract 1 from the clients for this client.
    ; subtract 2 from the frames this frame (that we just created) and the default frame.
    (when ( or (not active-clients-or-frames)
	       (yes-or-no-p (format "There are currently %d clients and %d frames. Exit anyway?" (- (length server-clients) 1) (- (length (frame-list)) 2))))

      ; If the user quits during the save dialog then don't exit emacs.
      ; Still close the terminal though.
      (let((inhibit-quit t))
             ; Save buffers
	(with-local-quit
	  (save-some-buffers))

	(if quit-flag
	  (setq quit-flag nil)
          ; Kill all remaining clients
	  (progn
	    (dolist (client server-clients)
	      (server-delete-client client))
		 ; Exit emacs
	    (kill-emacs)))
	))

    ; If we made a frame then kill it.
    (when (or modified-buffers active-clients-or-frames) (delete-frame new-frame))
    )
  )
(defun modified-buffers-exist()
  "This function will check to see if there are any buffers
that have been modified.  It will return true if there are
and nil otherwise. Buffers that have buffer-offer-save set to
nil are ignored."
  (let (modified-found)
    (dolist (buffer (buffer-list))
      (when (and (buffer-live-p buffer)
		 (buffer-modified-p buffer)
		 (not (buffer-base-buffer buffer))
		 (or
		  (buffer-file-name buffer)
		  (progn
		    (set-buffer buffer)
		    (and buffer-offer-save (> (buffer-size) 0))))
		 )
	(setq modified-found t)
	)
      )
    modified-found
    )
  )
(defun helm-filtered-bookmarks ()
  "Preconfigured helm for bookmarks (filtered by category).
Optional source `helm-source-bookmark-addressbook' is loaded
only if external addressbook-bookmark package is installed."
  (interactive)
  (helm :sources helm-bookmark-default-filtered-sources
        :prompt "Search Bookmark: "
        :buffer "*helm filtered bookmarks*"
        :default (list (thing-at-point 'symbol)
                       (buffer-name helm-current-buffer)))
  (recenter nil)
  )

;; gepy.el
(defun buffer-exists-if (bn)
  (let ((cur-buffer-names
         (loop for x in (buffer-list)
               collect (buffer-name x))))
    (not (null (member bn cur-buffer-names)))
    ))
(defun gepy-kill-process-in-eshell-and-return-to-prompt (buf-name &key to)
  (with-current-buffer buf-name
    (eshell-interrupt-process)
    (sit-for to)
    (eshell-interrupt-process)
    (sit-for to)
    (eshell-return-to-prompt)
    (sit-for to)
    (eshell-interrupt-process)
    )
  )

(defun gepy-launch-process-in-eshell (buf-name command &optional win-num)
  (when (not (buffer-exists-if buf-name))
      (let ((eshell-buffer-name buf-name))
        (eshell)))
  (if win-num (set-window-buffer (winum-get-window-by-number win-num) (get-buffer buf-name)))
  (gepy-kill-process-in-eshell-and-return-to-prompt buf-name :to 0.1)
  (with-current-buffer (get-buffer buf-name)
    (message (concat "gepy-...eshell: Inserting command ..." command "in buffer" buf-name))
    (insert command)
    (eshell-send-input)
    )
  (if win-num (with-selected-window (winum-get-window-by-number win-num) (end-of-buffer)))
  )
(defun gepy-start (proc-alias)
  "Start process by alias (e.g. jup) defined in `gepy-alist'"
  (message (concat ">>gepy-start<<|" proc-alias "|-->" (caddr (assoc proc-alias gepy-alist))))
  ;; (gepy-launch-process-in-eshell proc-alias (cadr (assoc proc-alias gepy-alist)) (caddr (assoc proc-alias gepy-alist)))
  (let* ((prefixed-proc-alias (concat "ge:" proc-alias)))
    (start-process-shell-command prefixed-proc-alias prefixed-proc-alias (caddr (assoc proc-alias gepy-alist)) ))
  )
(defun gepy-start-all ()
  (loop for x in gepy-alist
        do (gepy-start (car x)))
  )
;; (gepy-start-all)

;; ( process-live-p (get-process "ge:jup"))
;; (kill-process ( get-process "ge:jup"))
(defun helm-mini-ge ()
  "Preconfigured `helm' displaying `helm-mini-default-sources'."
  (interactive)
  (require 'helm-x-files)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
  (helm :sources helm-mini-default-sources
        :input "ge:"
        :buffer "*helm mini*"
        :ff-transformer-show-only-basename nil
        :truncate-lines helm-buffers-truncate-lines
        :left-margin-width helm-buffers-left-margin-width))

(defun spacemacs-layouts/non-restricted-buffer-list-helm-ge ()
  (interactive)
  (let ((ido-make-buffer-list-hook (remove #'persp-restrict-ido-buffers ido-make-buffer-list-hook)))
    (helm-mini-ge)))

;; (setq lexical-binding t)
(defun quick-view-file-at-point ()
  "Preview the file at point then jump back after some idle time.

In order for this to work you need to bind this function to a key combo,
you cannot call it from the minibuffer and let it work.

The reason it works is that by holding the key combo down, you inhibit
idle timers from running so as long as you hold the key combo, the
buffer preview will still display."
  (interactive)
  (let* ((buffer (current-buffer))
         (file (thing-at-point 'filename t))
         (file-buffer-name (format "*preview of %s*" file)))
    (if (and file (file-exists-p file))
        (let ((contents))
          (if (get-buffer file)
              (setq contents (save-excursion
                               (with-current-buffer (get-buffer file)
                                 (font-lock-fontify-buffer)
                                 (buffer-substring (point-min) (point-max)))))
            (let ((new-buffer (find-file-noselect file)))
              (with-current-buffer new-buffer
                (font-lock-mode t)
                (font-lock-fontify-buffer)
                (setq contents (buffer-substring (point-min) (point-max))))
              (kill-buffer new-buffer)))
          (switch-to-buffer (get-buffer-create file-buffer-name))
          (setq-local header-line-format "%60b")
          (delete-region (point-min) (point-max))
          (save-excursion (insert contents))
          (local-set-key (kbd "C-M-v") (lambda () (interactive) (sit-for .2)))
          (run-with-idle-timer
           .7
           nil
           (lambda ()
             (switch-to-buffer buffer)
             (kill-buffer file-buffer-name))))
      (message "no file to preview at point!"))))
;; VARIABLES
  (setq org-todo-keywords
        '((sequence "TODO(t!)" "NEXT(n!)" "DOINGNOW(d!)" "BLOCKED(b!)" "TODELEGATE(g!)" "DELEGATED(D!)" "FOLLOWUP(f!)" "TICKLE(T!)" "|" "CANCELLED(c!)" "DONE(F!)")))
  (setq org-todo-keyword-faces
        '(("TODO" . org-warning)
          ("DOINGNOW" . "#E35DBF")
          ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
          ("DELEGATED" . "pink")
          ("NEXT" . "#008080")))
  ;; (setq org-tag-faces
  ;;       '((sequence "aals(A!)" "amsu" "avsb" "21" "42(h!)" "chrome" "comm" "NEXT(n!)" "DOINGNOW(d!)" "BLOCKED(b!)" "TODELEGATE(g!)" "DELEGATED(D!)" "FOLLOWUP(f!)" "TICKLE(T!)" "|" "CANCELLED(c!)" "DONE(F!)")))
  (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l)))
  ;; (setq org-tag-alist '(("TODAY" . ?w) ("APPT" . ?h) ("NEXT" . ?l)))
  (setq org-tag-alist '(("TODAY" . ?w) ("APPT" . ?h) ("NEXT" . ?l)))

  (setq org-tag-alist '((:startgrouptag)
                        ("GTD" . ?g)
                        (:grouptags)
                        ("Control")
                        ("Persp")
                        (:endgrouptag)
                        (:startgrouptag)
                        ("Control")
                        (:grouptags)
                        ("Context")
                        ("Tass")
                        (:endgrouptag)))
  (setq org-tag-faces
        '(("TODAY" . (:foreground "#C00000"))
          ("APPT"  . (:foreground "#4d4d4d"))
          ("NEXT"  . (:foreground "#E35DBF"))))

  ;; (use-package org-fancy-priorities
  ;;   :ensure t
  ;;   :hook
  ;;   (org-mode . org-fancy-priorities-mode)
  ;;   :config
  ;;   (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))


 ;; KEYS definitions:
  ;; (global-set-key (kbd ""))


  (global-visual-line-mode t)
(setq dotspacemacs-distinguish-gui-tab t)
(defalias 'nuke 'delete-trailing-whitespace)
(setq org-ref-bibliography-notes "~/org/ref/notes.org"
      org-ref-default-bibliography '("~/org/ref/master.bib")
      org-ref-pdf-directory "~/org/ref/pdfs/")

(defalias 'nuke 'delete-trailing-whitespace)

;; MISC CODE:

;; (ssh-deploy-async . 1)
;; (ssh-deploy-on-explicit-save . 0)
;; (ssh-deploy-hydra "C-c C-z")
;; (global-set-key (kbd "C-c C-z") 'ssh-deploy-prefix-map)

;; ssh-deploy - prefix = C-c C-z, f = forced upload, u = upload, d = download, x = diff, t = terminal, b = browse, h = shell
;; (ssh-deploy-line-mode) ;; If you want mode-line feature
;; (ssh-deploy-add-menu) ;; If you want menu-bar feature
;; (ssh-deploy-add-after-save-hook) ;; If you want automatic upload support
;; (ssh-deploy-add-find-file-hook) ;; If you want detecting remote changes support


(defun yasnippet-snippets--fixed-indent ()
  (message "I am ugly function yasnippet...indent"))
;; (print auto-revert-remote-files)
(setq auto-revert-remote-files t)

;; (start-process-shell-command "jup" "jup" "jupyter notebook --no-browser --port 22033")



;; SETQs
(ranger-override-dired-mode t)
;; (revert-without-query '("/ssh:srv:/home/domain/rustam/.xonshrc"))
;; (revert-without-query '("~/.xonshrc"))
(setq projectile-mode-line "Projectile")
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
              vc-ignore-dir-regexp
              tramp-file-name-regexp))
(setq tramp-verbose 1)
(setq my_path (getenv "PATH"))

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))
(progn (message "my_path:")(message my_path))
;; (load "~/.hammerspoon/spacehammer.el")
(defun eww-new (url)
  (interactive
   (let* ((prompt (concat "Enter url: ")))
     (list (read-string prompt nil nil))))
    (switch-to-buffer (generate-new-buffer "eww"))
    (eww-mode)
    (eww url))


(defun helm-find-files-with-inp (input)
  (interactive "P")
  (let* ((hist            "")
         (smart-input     "")
         (default-input   "")
         (input-as-presel "")
         (presel          ""))
    ;; Continue using the same display function as history which used
    ;; probably itself the same display function as inner HFF call,
    ;; i.e. if history was using frame use a frame otherwise use a window.

    (set-text-properties 0 (length input) nil input)
    (setq current-prefix-arg nil)
    ;; Allow next helm session to reuse helm--last-frame-parameters as
    ;; resume would do.
    (let ((helm--executing-helm-action (not (null hist))))
      (helm-find-files-1 input (and presel (null helm-ff-no-preselect)
                                    (concat "^" (regexp-quote presel)))))))



(defun ranger-go (path)
  "Go subroutine"
  (interactive
   (list
    (read-char-choice
     "e   : /etc
U   : /Users
d   : /dev
l   : follow directory link
L   : follow selected file
o   : /opt
v   : /var
h   : ~/
m   : /media
M   : /mnt
s   : /srv
r,/ : /
R   : ranger . el location
> "
     '(?q ?e ?u ?d ?l ?L ?o ?v ?m ?M ?s ?r ?R ?/ ?h ?g ?D ?j ?k ?T ?t ?n ?c))))
  (message nil)
  (let* ((c (char-to-string path))
         (new-path
          (cl-case (intern c)
            ('/ "/")
            ('u "/Users")
            ('o "/opt")
            ('v "/var")
            ('h  "~/")
            ('m "/Users/rst/msc/")
            ('n "/Users/rst/msc/daemons/")
            ('l "/Users/rst/lib/")
            ('a "/Users/rst/lib/as")
            ('p "/Users/rst/lib/py/")
            ('s "/Users/rst/lib/sh/")
            ('e "/Users/rst/lib/el/")
            ('r "/Users/rst/lib/rc/")
            ('w "/Users/rst/wrk/")
            ('f "/Users/rst/wrk/dotfiles")
            ('L "/Users/rst/wrk/lib/")
            ('d "/Users/rst/Downloads/")
            ('D "/Users/rst/Desktop/")
            ))
         (alt-option
          (cl-case (intern c)
            ;; Subdir Handlng
            ('j 'ranger-next-subdir)
            ('k 'ranger-prev-subdir)
            ;; Tab Handling
            ('n 'ranger-new-tab)
            ('T 'ranger-prev-tab)
            ('t 'ranger-next-tab)
            ('c 'ranger-close-tab)
            ('g 'ranger-goto-top))))
    (when (string-equal c "q")
      (keyboard-quit))
    (when (and new-path (file-directory-p new-path))
      (ranger-find-file new-path))
    (when (eq system-type 'windows-nt)
      (when (string-equal c "D")
        (ranger-show-drives)))
    (when alt-option
      (call-interactively alt-option))))

(defun list-to-radix-tree(l)
  (--reduce-from (radix-tree-insert acc it t) radix-tree-empty l))

(setq small (list-to-radix-tree '("molecular" "molecule" "mole" "appa" "appetizer" "applicative" "apple")))

(setq vsbg (list-to-radix-tree '("molo" "molar" "molecular dynamics" "molecule" "mole" "appa" "appetizer" "applicative" "apple" "appar")))

(require 'company)

(defun radix-tree-keys(subtree prefix)
  (let (keys '())
    (radix-tree-iter-mappings (radix-tree-subtree subtree prefix)
			                        (lambda (key val)
				                        (!cons (concat prefix key) keys)))
    keys))

(defun get-candidates (prefix)
  "Given a prefix return a list of matching words that begin with it"
  (when (> (length prefix) 2)
    (radix-tree-keys company-custom-dictionary--words-tree (downcase prefix))))

(defun company-custom-dictionary2 (command &optional arg &rest ignored)
  "RELOAD the mode to embed the changes!!! Company mode backend for a custom dictionary stored as a radix tree. force bind - redefines your tree."
  (setq force-bind-ccd t)
  (case command
    ('init
     (if (or (not (null force-bind-ccd)) (not (boundp 'company-custom-dictionary--words-tree)))
         (progn (message "reloading tre..")(setq company-custom-dictionary--words-tree vsbg))))
    ('prefix
     (company-grab-word))
    ('candidates
     (radix-tree-keys company-custom-dictionary--words-tree (downcase arg)))
    ('ignore-case
     'keep-prefix)))

;; (provide 'company-custom-dictionary)

;; Push the mode to the list of company backends molecular dynamics dictionary:
;; WARNING: ALL OTHER COMPLETIONS WILL BE DESTROYED (for some reason)
;; (push 'company-custom-dictionary2 company-backends)
;; TODO make function that opens shell in remote path on server
;; als-tramp-browse-shell
;; also to open shell in directories specified in slots
;; 

