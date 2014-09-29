(require 'cl)

;; Set my defaults
(setq user-full-name "Justin Richter")
(setq user-login-name "justin")
(setq user-mail-address "jrichter@jetfive.com")

;; Allow emacs to translate colors to the best terminal match
(color-theme-approximate-on)

;; Helm Mode
(helm-mode 1)

;; Projectile Mode
(require 'projectile)
(projectile-global-mode)
(setq projectile-require-project-root nil)
(setq projectile-completion-system 'grizzl)
(setq projectile-enable-caching t)

;; Load evil-mode
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-mode 1)

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

;; (after 'projectile
;;        (package 'helm-projectile))
(global-set-key (kbd "M-x") 'helm-M-x)

(recentf-mode 1)
(setq recentf-max-menu-items 100)

;; Load ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/ace-jump-mode")
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(add-hook 'ruby-mode-hook 'flycheck-mode)

;; Show line at 90 char
(require 'fill-column-indicator)
(setq-default fill-column 90)
(setq-default fci-rule-width 1)
(setq-default fci-rule-color "#859900")
(add-hook 'ruby-mode-hook 'fci-mode)
(add-hook 'clojure-mode-hook 'fci-mode)
(add-hook 'markdown-mode-hook 'fci-mode)

;; Tune emacs garbage collector
(setq gc-cons-threshold 20000000)

;; Ask for confirmation before quitting Emacs
(add-hook 'kill-emacs-query-functions
          (lambda () (y-or-n-p "Do you really want to exit Emacs? "))
          'append)

;; Don't put backups in current directory
(setq backup-directory-alist `((".*" . "~/.saves")))
(setq backup-by-copying t) ;; set how emacs backs up
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t) ;; let it be versioned!
(setq auto-save-file-name-transforms
      `((".*" ,"~/.saves" t)))

;; Change the newline-mark 'paragraph mark' to the paragraph symbol
(setq whitespace-display-mappings '((newline-mark 10 [182 10])))

;; Make C-n add newlines so I don't have to hit enter at the end of a
;; buffer
(setq next-line-add-newlines t)

;; Powerline
(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;; Turn on dired-x
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")))

;; Hide welcome screen
(setq inhibit-splash-screen t)

;; Hide Menubar and Toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; disable those annoying tooltips
(tooltip-mode -1)

;; default font Hermit for Powerline
(when (display-graphic-p)
  (set-face-attribute 'default nil :font "Hermit for Powerline Medium"))

;; sort colors in list-colors-display by hue
(setq list-colors-sort 'hsv )

;; Set initial layout
(if (string= system-name "justin-Studio-1537")
    (setq default-frame-alist
          '((width . 151) (height . 90)))
  (setq default-frame-alist
        '((width . 101) (height . 90))))

(fringe-mode (cons 8 4))

;; turn on line numbers
(global-linum-mode t)

;; Turn on winner mode
(winner-mode t)

;; Don't wrap lines
(setq-default truncate-lines t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; Clean up buffers before save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; show matching parens
(show-paren-mode 1)

;; theme those matching parens
(require 'paren)
    (set-face-background 'show-paren-match (face-background 'default))
    (set-face-foreground 'show-paren-match "#fdf6e3")
    (set-face-attribute 'show-paren-match nil :weight 'extra-bold)

;; After yank, indent region
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode scheme-mode lisp-mode sh-mode js-mode js2-mode
                           c-mode c++-mode objc-mode ruby-mode slim-mode lua-mode clojure-mode
                           LaTeX-mode TeX-mode html-mode scss-mode css-mode))
      (indent-region (region-beginning) (region-end) nil)))

;; When splitting a buffer move point to new buffer
(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))


;; majority of code formatting conventions do not recommend mixed tabs and spaces. So, here.
(setq-default indent-tabs-mode nil)     ; emacs 23.1 default is t
(setq tab-width 4)   ; width for display tabs. emacs 23.1 default is 8

;; make buffer names unique when files of the same name of diff dir are opened
(require 'uniquify) ; bundled with GNU emacs 23.2.1 or before
(setq uniquify-buffer-name-style 'forward)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " Prelude - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

;; use zenburn as the default theme
(load-theme 'zenburn t)

(provide 'my-settings)