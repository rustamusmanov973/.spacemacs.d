
;; TRANSIENT STATES
(spacemacs|define-transient-state window
  :title "Window Transient State with X"
  :hint-is-doc t
  :dynamic-hint (spacemacs//window-ts-hint)
  :bindings
  ("?" spacemacs//window-ts-toggle-hint)
  ;; Select
  ("j" evil-window-down)
  ("<down>" evil-window-down)
  ("k" evil-window-up)
  ("<up>" evil-window-up)
  ("h" evil-window-left)
  ("<left>" evil-window-left)
  ("l" evil-window-right)
  ("<right>" evil-window-right)
  ("0" winum-select-window-0)
  ("1" winum-select-window-1)
  ("2" winum-select-window-2)
  ("3" winum-select-window-3)
  ("4" winum-select-window-4)
  ("5" winum-select-window-5)
  ("6" winum-select-window-6)
  ("7" winum-select-window-7)
  ("8" winum-select-window-8)
  ("9" winum-select-window-9)
  ("a" ace-window)
  ("o" other-frame)
  ("w" other-window)
  ;; Move
  ("J" evil-window-move-very-bottom)
  ("<S-down>" evil-window-move-very-bottom)
  ("K" evil-window-move-very-top)
  ("<S-up>" evil-window-move-very-top)
  ("H" evil-window-move-far-left)
  ("<S-left>" evil-window-move-far-left)
  ("L" evil-window-move-far-right)
  ("<S-right>" evil-window-move-far-right)
  ("r" spacemacs/rotate-windows-forward)
  ("R" spacemacs/rotate-windows-backward)
  ;; Split
  ("s" split-window-below)
  ("S" split-window-below-and-focus)
  ("-" split-window-below-and-focus)
  ("v" split-window-right)
  ("V" split-window-right-and-focus)
  ("/" split-window-right-and-focus)
  ("m" spacemacs/toggle-maximize-buffer)
  ("|" spacemacs/maximize-vertically)
  ("_" spacemacs/maximize-horizontally)
  ;; Resize
  ("[" spacemacs/shrink-window-horizontally)
  ("]" spacemacs/enlarge-window-horizontally)
  ("{" spacemacs/shrink-window)
  ("}" spacemacs/enlarge-window)
  ;; Other
  ("d" delete-window)
  ("D" delete-other-windows)
  ("u" winner-undo)
  ("U" winner-redo)
  ("x" kill-buffer-and-window)
  ("q" nil :exit t))

;; TRANSIENT STATE

(spacemacs|define-transient-state defun-jump-transient-state
  :title "Defun Jump Transient State2"
  :doc (concat "
 [_k_] prev defun p n    [_j_]^^   next defun
 ^^^^                                      [_q_]^^   quit")
  :bindings
  ("q" nil :exit t)
  ("k" beginning-of-defun)
  ("j" end-of-defun)
  ("r" hwd)
  ("p" beginning-of-defun)
  ("n" end-of-defun)
  )
