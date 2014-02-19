;;; screen.el --- define function key sequences and standard colors for screen
(load "term/xterm")

(defun terminal-init-screen ()
  "Terminal initialization function for screen."

  ;; Use the xterm color initialization code.
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))