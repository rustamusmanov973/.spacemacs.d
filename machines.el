(setf servs '())
(defun enquote (str &optional delim)
  (let ((delim (or  delim "\"" )))
    (concat delim str delim))
  )

(defun copy-file-async (local remote-path)
    (async-start
  `(lambda ()
     (copy-file ,local ,remote-path t t)
     (format "(copy-file \"%s\" \"%s\")" ,local ,remote-path))
  (lambda(return-path)
    (message "Upload %s finished" return-path))))
(defun copy-directory-async (local remote-path)
  (async-start
   `(lambda ()
      (copy-directory ,local ,remote-path t t)
      (format "%s->%s" ,local ,remote-path))
   (lambda(return-path)
     (message "Upload %s finished" return-path))))
(setq db 1)
(defun vdp ()
  (and (boundp 'db) (member db '(t 1)))
  )
(cl-defun vd (sym &optional (comment "") (idb nil))
  (when (or idb (vdp))
    (or (string= "" comment)
        (progn
          (setq comment2 (concat "[" comment "]"))
          (setq comment comment2)))

    (setq arg_type (type-of sym))
    (cond
     ((typep sym 'symbol)
      (progn
        (setq var_name (symbol-name sym))
        (setq var_value (symbol-value sym))
        )
      )
     (t (progn (print "VD: UNKNOWN variable TYPE. your var:") (print sym))))
    (message (concat "VD["
                     var_name
                     "]"
                     comment
                     ">>:"))
    (message var_value)

    ))
(defun my-eval-string (string)
  (eval (print (car (read-from-string (format "(progn %s)" string))))))
(defun shell-command-to-trimmed-string (str)
  (setq db 1)
  (vd 'str)
  (setq otp (shell-command-to-string  str))
  (vd 'otp "b tr")
  (setq trimmed_output (string-trim otp))
  )
(defun plist-mapc (function plist)
  "Iterate FUNCTION (a two-argument function) over PLIST.  Error
checking is for weenies."
  (when plist
    (funcall function (car plist) (cadr plist))
    (plist-mapc function (cddr plist))))
(defun copy-slot (s d slot)
  (my-eval-string (format "(setf (serv-%s %s) (serv-%s %s))" slot d slot s)))
(defun copy-by-slots (s d slots)
  (let ((f (lambda (s$) (print "aaa")(print s)(print d)(print s$)(eval (copy-slot s d s$)))))
    (mapcar f slots)))
(defun update-slots (s slot-plist)
  (plist-mapc (lambda (sl-n sl-v)
                (eval `(setf (oref ,s ,sl-n) ,sl-v))
                ) slot-plist))
(defun shell-in-dir (def-dir &optional s-f-n)
  (interactive)
  (let ((default-directory def-dir)
        (explicit-shell-file-name s-f-n)
        (s-f-n (or s-f-n "shell")))
    (shell (let ((nbn (generate-new-buffer-name (enquote (enquote s-f-n "*")))))
             (read-string (concat "Enter shell name [" nbn "]") nil nil nbn)
             ))))
;; (let (explicit-shell-))
(setq cur-ser-mid (shell-command-to-trimmed-string "cat /etc/machine-id 2>/dev/null"))
(setq serv-slots-srv '(
                       name
                       mid
                       hostname
                       host_alias
                       username
                       port
                       molfile2params_exe
                       plants_exe
                       spores_exe
                       acpype_exe
                       ante_red_exe
                       ed_exe
                       red_exe
                       mopac_home
                       udir
                       hdir
                       gmx_exe
                       py_exe
                       n_md_cpus
                       xmlRpcPort
                       dgfl
                       ddir
                       cdir
                       envs
                       py37
                       bin37
                       exe37
                       lib37
                       sp37
                       lb37
                       mopac_exe
                       adir
                       mdir
                       mdires
                       edir
                       tdir
                       rhdir
                       tdires
                       sdir
                       msc
                       liuw
                       REF
                       ipython-startup
                       ext37
                       emd
                       smd
                       wrk
                       wdtf
                       wlib
                       dcnf
                       rlx_exe
                       rosetta_dir
                       hrx_gmx_exe
                       hrx_module
                       run_mult_exe
                       bash_exe
                       ola
                       rc
                       ubin
                       lb
                       dt
                       dl
                       pj
                       rc
                       Ap
                       Sy
                       Vo
                       Us
                       rdir
                       xonsh_exe
                       ))
(define-abbrev-table 'my-tramp-abbrev-table
  '())

(my-eval-string (concat "(defclass serv () ("
                        (apply #'concat (mapcar (lambda (x0) (let ((x (symbol-name x0))) (concat "(" x " :initarg :" x " :accessor serv-" x ")") )) serv-slots-srv))
                 "))"))
;; (defun deploy-to-servs (file-nam dest-dir-slot serv-list) (mapcar (lambda (s) (progn
;;                                                                                   (message (concat "Deploying to :" (serv-name s)))
;;                                                                                   (copy-file (serv-s))
;;                                                                 )
;;                                                    ) servs))
;; (als-deploy-file-to-mopac_home)

(defun string-is-file-or-directory (str)
  (and (typep str 'string)(not (string= "" str))(string= (substring str 0 1) "/"));; (search "/" str) 
  )
(defun string-is-directory (str)
  (and (string-is-file-or-directory str)(string= "/" (substring sl-v -1)))
  )
(defun string-is-file (str)
  (and (string-is-file-or-directory str)(not (string-is-directory str)))
  )
(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))
(defun abbrevify (sl-n)
  (replace-in-string "_" "L" (replace-in-string "-" "L" (symbol-name sl-n)))
  )

(defun file-name-as-file (fnm)
  (if (string-is-file-or-directory fnm) (substring (file-name-as-directory fnm) 0 -1) nil)
  )



(cl-defmethod initialize-instance :after ((s serv) &rest initargs)
  (message (concat "ini in: " (serv-name s)))
  (my-eval-string (concat "(setq " (serv-name s) " s)"))
  (if (or (not (boundp 'servs)) (null servs) ) (setf servs '()))
  (setf servs (--remove (string-equal (serv-name s) (serv-name it)) servs))
  (my-eval-string (concat "(push " (serv-name s) " servs)")))
(cl-defmethod initialize-instance-serv ((s serv))
  (let* (
        (ser-n (serv-name s))
        (ser-o (serv-ola s))
        (tr-t-pref (format "/ssh:%s:" ser-n))
        (tr-n-pref "")
        (cur-ser-ok (string-equal (serv-mid s) cur-ser-mid))
        (tr-a-pref (if cur-ser-ok tr-n-pref tr-t-pref))
        (ser-n-pref (if cur-ser-ok "" (format "%s-" ser-n)))
        (ser-o-pref (if cur-ser-ok "" (format "%s" ser-o)))
        )
  (setf (serv-dgfl s) (member (serv-dgfl s) '("srv", "gpu", "lom2")))
  (setf (serv-bash_exe s) "/bin/bash")
  (setf (serv-ubin s) (concat (serv-hdir s) "bin/"))
  (setf (serv-ubin s) (concat (serv-hdir s) "bin/"))
  (setf (serv-dt s) (concat (serv-hdir s) "Desktop/"))
  (setf (serv-dl s) (concat (serv-hdir s) "Downloads/"))
  (setf (serv-lb s) (concat (serv-hdir s) "lib/"))
  (let ((miniconda "miniconda/"))
    (if (member (serv-name s) '("srv")) (setq miniconda "miniconda3/"))
    (setf (serv-cdir s) (concat (serv-hdir s) miniconda))
    (setf (serv-envs s) (concat (serv-cdir s) "envs/"))
  (setf (serv-py37 s) (concat (serv-envs s) "py37/"))
  (setf (serv-bin37 s) (concat (serv-py37 s) "bin/"))
  (setf (serv-exe37 s) (concat (serv-bin37 s) "python"))
  (setf (serv-xonsh_exe s) (concat (serv-bin37 s) "xonsh"))
  (setf (serv-lib37 s) (concat (serv-py37 s) "lib/"))
  (setf (serv-sp37 s) (concat (serv-lib37 s) "python3.7/site-packages/"))
  (setf (serv-lb37 s) (concat (serv-sp37 s) "lib/"))
  (setf (serv-ipython-startup s) (concat (serv-hdir s) ".ipython/profile_default/startup/"))
  (setf (serv-ext37 s) (concat (serv-lib37 s) "IPython/extensions/"))
  ;; (define-abbrev global-abbrev-table "dt1" "~/wrk/dotfiles")
  (setf (serv-emd s) (concat (serv-hdir s) ".emacs.d/"))
  (setf (serv-smd s) (concat (serv-hdir s) ".spacemacs.d/"))
(mapcar (lambda (slot-desc)
              (let* ((sl-n (cl--slot-descriptor-name slot-desc))
                     (sl-n-ab (abbrevify sl-n))
                     (sl-v (my-eval-string (format "(if (slot-boundp s :%s)(oref s %s)(print \"%s: %s is unbound\"))" sl-n sl-n ser-n sl-n)))
                     (ola-a (format "%s%s" ser-o-pref sl-n-ab))
                     (ab-a (format "%sA%s" ser-n sl-n-ab))
                     (ab-n (format "%sN%s" ser-n sl-n-ab))
                     (ab-t (format "%sT%s" ser-n sl-n-ab))
                     (ab-a-q (format "%sA%sq" ser-n sl-n-ab))
                     (ab-n-q (format "%sN%sq" ser-n sl-n-ab))
                     (ab-t-q (format "%sT%sq" ser-n sl-n-ab))
                     (tr-a-sl-v (format "%s%s" tr-a-pref (file-name-as-file sl-v)))
                     (tr-n-sl-v (format "%s%s" tr-n-pref (file-name-as-file sl-v)))
                     (tr-t-sl-v (format "%s%s" tr-t-pref (file-name-as-file sl-v)))
                     (tr-a-sl-v-q (enquote tr-a-sl-v))
                     (tr-n-sl-v-q (enquote tr-n-sl-v))
                     (tr-t-sl-v-q (enquote tr-t-sl-v))
                       )
                (if (string-is-file-or-directory sl-v)
                    (progn
                      (define-abbrev my-tramp-abbrev-table ola-a tr-a-sl-v)
                      (define-abbrev global-abbrev-table ab-a tr-a-sl-v)
                      (define-abbrev global-abbrev-table ab-n tr-n-sl-v)
                      (define-abbrev global-abbrev-table ab-t tr-t-sl-v)
                      (my-eval-string (format "(setq %s nil)" ab-a))
                      (my-eval-string (format "(setq %s nil)" ab-t))
                      (my-eval-string (format "(setq %s nil)" ab-n))

                      (define-abbrev global-abbrev-table ab-a-q tr-a-sl-v-q)
                      (define-abbrev global-abbrev-table ab-n-q tr-n-sl-v-q)
                      (define-abbrev global-abbrev-table ab-t-q tr-t-sl-v-q)
                      (my-eval-string (format "(setq %s nil)" ab-a-q))
                      (my-eval-string (format "(setq %s nil)" ab-t-q))
                      (my-eval-string (format "(setq %s nil)" ab-n-q))

                      (my-eval-string (print (format "(setf %s%s-tr                                \"%s%s\")"             ser-n-pref sl-n tr-t-pref sl-v)))
                      (my-eval-string (print (format "(setf %s%s-no-tr                             \"%s%s\")"             ser-n-pref sl-n tr-n-pref sl-v)))
                      (my-eval-string (print (format "(setf %s%s                                   \"%s%s\")"             ser-n-pref sl-n tr-a-pref sl-v)))
                      )
                  )
                (if (string-is-file sl-v)
                    (progn
                      (my-eval-string (format "(defun %sfind-%s             ()(interactive)     (find-file \"%s\"))"                ser-n-pref sl-n sl-v))
                      )
                  )
                  (if (string-is-directory sl-v)
                      (progn
                        (print (concat "found directory-slot: " sl-v))
                        (my-eval-string (print (format "(defun bash-%s%s
                      ()(interactive) (shell-in-dir \"%s%s\" \"%s\"))"
                      ser-n-pref sl-n tr-a-pref sl-v (serv-bash_exe s))))
                        (my-eval-string (print (format "(defun xonsh-%s%s
                      ()(interactive) (shell-in-dir \"%s%s\" \"%s\"))"
                      ser-n-pref sl-n tr-a-pref sl-v (serv-xonsh_exe s))))
                        (my-eval-string (format "(defun %sconcat-%s-no-tr   (path) (concat \"%s%s\" path))"            ser-n-pref sl-n tr-n-pref sl-v))
                        (my-eval-string (format "(defun %sconcat-%s-tr      (path) (concat \"%s%s\" path))"            ser-n-pref sl-n tr-t-pref sl-v))
                        (my-eval-string (format "(defun %sconcat-%s         (path) (concat \"%s%s\" path))"            ser-n-pref sl-n tr-a-pref sl-v))
                        (my-eval-string (format "(defun %scopy-file-to-%s   (path) (copy-file-async path \"%s%s\"))"       ser-n-pref sl-n tr-a-pref sl-v))
                        ))
                ))
            (eieio-class-slots serv)
            )
)))
(make-instance 'serv
:name "srv"
:ola "s"
:mid "08068b0f203f6c97228bff940000247a"
:hostname "vsb.fbb.msu.ru"
:host_alias "rsrv"
:username "rustam"
:port "22022"
:molfile2params_exe "/home/domain/data/prog/rosetta_2017/main/source/scripts/python/public/molfile_to_params.py"
:plants_exe "/home/domain/data/rustam/bin/PLANTS1.2_64bit"
:spores_exe "/home/domain/data/rustam/bin/SPORES_64bit"
:acpype_exe "/home/domain/rustam/miniconda3/envs/py37/bin/acpype"
:ante_red_exe "/opt/gamess/Ante_RED-1.5.pl"
:ed_exe "/home/domain/data/prog/rosetta_2017/main/source/build/src/release/linux/3.13/64/x86/gcc/4.8/default/enzyme_design.default.linuxgccrelease"
:red_exe "/opt/gamess/RED-vIII.51.pl"
:mopac_home "/home/domain/data/prog/mopac/"
:udir "/home/domain/data/rustam/"
:hdir "/home/domain/rustam/"
:gmx_exe "/usr/bin/gmx"
:py_exe "/home/domain/rustam/miniconda3/envs/py37/bin/python"
:n_md_cpus 8
:xmlRpcPort 9173
)

(make-instance 'serv
               :name "als"
               :ola "a"
               :mid "08068b0f203f6c97228bff940000247a"
               :hostname "vsb.fbb.msu.ru"
               :host_alias "rsrv"
               :username "rustam"
               :port "22022"
               :molfile2params_exe "/home/domain/data/prog/rosetta_2017/main/source/scripts/python/public/molfile_to_params.py"
               :plants_exe "/home/domain/data/rustam/bin/PLANTS1.2_64bit"
               :spores_exe "/home/domain/data/rustam/bin/SPORES_64bit"
               :acpype_exe "/home/domain/rustam/miniconda3/envs/py37/bin/acpype"
               :ante_red_exe "/opt/gamess/Ante_RED-1.5.pl"
               :ed_exe "/home/domain/data/prog/rosetta_2017/main/source/build/src/release/linux/3.13/64/x86/gcc/4.8/default/enzyme_design.default.linuxgccrelease"
               :red_exe "/opt/gamess/RED-vIII.51.pl"
               :mopac_home "/home/domain/data/prog/mopac/"
               :udir "/home/domain/data/rustam/"
               :hdir "/home/domain/rustam/"
               :gmx_exe "/usr/bin/gmx"
               :py_exe "/home/domain/rustam/miniconda3/envs/py37/bin/python"
               :n_md_cpus 8
               :xmlRpcPort 9173
)


(make-instance 'serv
 :name "mac"
 :ola "m"
 :mid ""
 :hostname "mac"
 :port "22"
 :hdir "/Users/rst/"
 :udir "/Users/rst/"
 :wrk "/Users/rst/wrk/"
 :wdtf "/Users/rst/wrk/dotfiles/"
 :wlib "/Users/rst/wrk/lib/"
 :dcnf "/Users/rst/.config/"
 :py_exe "/Users/rst/miniconda/envs/py37/bin/python"
 :msc "/Users/rst/msc/"
 :pj "/Users/rst/msc/projects/"
 :rc "/Users/rst/lib/rc/"
 :Ap "//Applications/"
 :Sy "/System/"
 :Vo "/Volumes/"
 :Us "/Users/"
 )
(make-instance 'serv
    :name "lom2"
    :ola "l"
    :mid "11a2e8e0953e4023ad8806b6d61669a7"
    :hostname "lomonosov2.parallel.ru"
    :host_alias "lom2"
    :username "fbbstudent"
    :molfile2params_exe "/mnt/scratch/users/golovin/progs/rosetta_src_2018.33.60351_bundle/main/source/scripts/python/public/molfile_to_params.py"
    :ed_exe "/mnt/scratch/users/golovin/progs/rosetta_src_2018.33.60351_bundle/main/source/bin/enzyme_design.linuxgccrelease"
    :rlx_exe "/mnt/scratch/users/golovin/progs/rosetta_src_2018.33.60351_bundle/main/source/bin/relax.linuxgccrelease"
    :plants_exe "/mnt/scratch/users/fbbstudent/work/rustam/bin/PLANTS1.2_64bit"
    :spores_exe "/mnt/scratch/users/fbbstudent/work/rustam/bin/SPORES_64bit"
    :port "22"
    :rosetta_dir "/home/golovin/_scratch/progs/rosetta_bin_linux_2016.32.58837_bundle/"
    :mopac_home "/mnt/scratch/users/fbbstudent/work/rustam/progs/mopac"
    :rhdir "/home/fbbstudent/"
    :hdir "/mnt/scratch/users/fbbstudent/work/rustam/"
    :udir "/mnt/scratch/users/fbbstudent/work/rustam/"
    :gmx_exe "/home/golovin/progs/bin/gmx514"
    :hrx_gmx_exe "/home/golovin/_scratch/progs/gromacs-2018.6-pm251-mpi-gpu-single/bin/gmx_mpi"
    :hrx_module "gmx/2019.2-gcc-ompi18-cuda-single-pm"
    :py_exe "/mnt/scratch/users/fbbstudent/work/rustam/miniconda/bin/python3.7"
    :run_mult_exe "/mnt/scratch/users/golovin/progs/lom_tools/run_multiple_tasks.py"
    :n_md_cpus 16
    :xmlRpcPort 9170
)
;; Special cases:
(make-instance 'serv :name "gpu")
(copy-by-slots "srv" "gpu" (mapcar #'cl--slot-descriptor-name (eieio-class-slots serv)))
(update-slots gpu '(
  :name "gpu"
  :ola "g"
  :mid "887ef9dbe17e4fef99c82196d34035cd"
  :hostname "gpu.vsb.fbb.msu.ru"
  :host_alias "rgpu"
  :xmlRpcPort 9172
  ))
(mapcar #'initialize-instance-serv servs)
(let ((cur-ser-list (--filter (string-equal (serv-mid it) cur-ser-mid) servs)))
  (if (not (null cur-ser-list))
      (progn (make-instance 'serv :name "cs")
             (copy-by-slots (serv-name (nth 0 cur-ser-list)) "cs" (mapcar #'cl--slot-descriptor-name (eieio-class-slots serv)))
             (update-slots cs '(
                                 :name "cs"
                                 :ola "c"
                                 ))
             (initialize-instance-serv cs))
      )
  )




 
