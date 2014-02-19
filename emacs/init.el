(add-to-list 'load-path "~/.emacs.d/lisp")

;; Google protobuf mode
(autoload 'protobuf-mode "protobuf-mode" "Major mode for editing protobuf files" t)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode)) ;

;; Cython mode
(require 'cython-mode)

;; function decides whether .h file is C or C++ header, sets C++ by
;; default because there's more chance of there being a .h without a
;; .cc than a .h without a .c (ie. for C++ template files)
(defun c-c++-header ()
  "sets either c-mode or c++-mode, whichever is appropriate for
header"
  (interactive)
  (let ((c-file (concat (substring (buffer-file-name) 0 -1) "c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-c++-header))

;; Color settings
(add-to-list 'load-path "~/dotfiles/emacs-color-theme-solarized/")

(if
    (equal 0 (string-match "^24" emacs-version))
    ;; it's emacs24, so use built-in theme
    (if (display-graphic-p)
	(require 'solarized-light-theme)
      (require 'solarized-dark-theme))
  ;; it's NOT emacs24, so use color-theme
  (progn
    (require 'color-theme)
    (color-theme-initialize)
    (require 'color-theme-solarized)
    (if (display-graphic-p)
	(color-theme-solarized-light)
      (color-theme-solarized-dark))))

(defun solarized-toggle-bold ()
  (interactive)
  (setq solarized-bold (if solarized-bold nil t))
  (if (display-graphic-p)
      (color-theme-solarized-light)
    (color-theme-solarized-dark)))

;; make duplicate buffer names use dirs to distinguish
(require 'uniquify)
(setq-default uniquify-buffer-name-style 'forward)

;; Generic settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)
(setq-default show-trailing-whitespace t)
