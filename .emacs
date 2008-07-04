;;;;;;;;;;;;;;;
;; VARIABLES ;;
;;;;;;;;;;;;;;;

;; don't show the gnu splash screen
(setq inhibit-startup-message t) 
(setq visible-bell t)
;;(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;;;;;;;;;;
;; MODES ;;
;;;;;;;;;;;

(menu-bar-mode -1)          ;; don't show menu
(tool-bar-mode -1)          ;; don't show toolbar
(line-number-mode 1)        ;; use line numbering
(column-number-mode 1)      ;; use column numbering
(cond (window-system
       (scroll-bar-mode -1) ;; stop terminals complaining
       (require 'color-theme)
       ))


;; tabs
;; (tabbar-mode nil)
;; (global-set-key "\M-1" 'tabbar-backward)
;; (global-set-key "\M-2" 'tabbar-forward)

;;;;;;;;;;;;;;
;; START UP ;;
;;;;;;;;;;;;;;

;; on opening
(add-hook 'emacs-startup-hook
          '(lambda ()
             ))

;; after initialising
(add-hook 'after-init-hook 
          '(lambda ()
;;              (reset-buffers)
             ))

;;;;;;;;;;;;;;;;;;;;;;
;; LOADS & REQUIRES ;;
;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/elisp")
;;(add-to-list 'load-path (expand-file-name "~/.elisp"))

(require 'cc-mode)

;;(require 'emacs-goodies-el)		; not for osx
(require 'font-lock)
(require 'paren)
;;(require 'redo)
;; (require 'tramp)
;;(autoload 'redo "redo")
;;(load "redo")

;;;;;;;;;;;
;; FRAME ;;
;;;;;;;;;;;

;; Set initial frame location and size
(setq default-frame-alist
      '((top . 0)
        (left . 0)
        (width . 200)
        (height . 100)
        ))

;; Show the time
;;(display-time)

;; Include current buffer name in the title bar
;;(setq frame-title-format "%b - emacs")
;; Or set the title bar to show file name if available, buffer name otherwise
(setq frame-title-format 
      '(buffer-file-name "%f" ("%b")
                         ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONTS, COLOURS & HIGHLIGHTING ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; todo sort this stuff out
;; (cond ((null window-system))
;;  ((fboundp 'global-font-lock-mode)
;;   (setq font-lock-maximum-decoration t)
;;   (global-font-lock-mode t)
;;   (if (load "lazy-lock" t)
;;   (add-hook 'font-lock-mode-hook 'turn-on-lazy-lock))))

;; Tasteful theme from color-theme.el via emacs-goodies-el
(cond (window-system
       (color-theme-classic)
       ))

;; Font lock
(global-font-lock-mode t)

;; Font size

;; Highlight incremental search
(setq search-highlight t)

;; Show matching parenthesis. How can you live without it.
(show-paren-mode t)

;; Highlight region
(transient-mark-mode t)

;;;;;;;;;;
;; MISC ;;
;;;;;;;;;;

;; Lines are automatically wrapped when the cursor goes beyond the column limit
(setq auto-fill-mode t)

;; The fill column influences how Emacs justifies paragraphs
(setq-default fill-column 75)

(setq comment-multi-line t)

;; Ignore case when completing filenames
;;(setq completion-ignore-case t) ;; no!!!
(setq read-file-name-completion-ignore-case t) ;; yes!!!

;; Ignore these file extensions as possible completions
(setq completion-ignored-extensions
      '(".o" "~")
      )

;; Make searches case insensitive
(setq case-fold-search t)

;; Do only one line scrolling
(setq scroll-step 1)

;; Flashing cursor
(blink-cursor-mode -1)

;; Visual bell instead of annoying beep
(setq visible-bell 0)

;; Ask if I'm sure when quitting
(setq confirm-kill-emacs 'yes-or-no-p)

;; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Disallow new lines when you press the down arrow at end of the buffer
(setq next-line-add-newlines nil)

;; Insert over region a la Aquamacs
(delete-selection-mode t)

;; todo wrap long lines
;;(setq-default truncate-lines t)
;;(longlines-mode t)
;;(set-fill-column 120)

;; Go to the matching parenthesis when you press
;; ! if on parenthesis otherwise insert !
(defun goto-matching-paren-or-insert (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-sexp 1))
	(t (self-insert-command (or arg 1)))
	))

(global-set-key "!" 'goto-matching-paren-or-insert)

;; Silently ensure newline at end of file
(setq require-final-newline t)
;; or make Emacs ask about missing newline
;; (setq require-final-newline 'ask)

;; Tramp defaults
(setq tramp-default-method "ssh")

;; Don't want any backup files
;;(setq make-backup-files nil)

;; Do want to backup files
(setq make-backup-files t)

;; Enable versioning with default values
(setq version-control t)

;; todo don't ask if i want to delete excessive backups!

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; Better buffer switching
(iswitchb-mode t)

;; Don't want any auto saving
;;(setq auto-save-default nil)

;; Get intermittent messages to stop typing
;;(type-break-mode)

;; Run delete-trailing-whitespace when exiting a file
;;M-x delete-trailing-whitespace

;; sticky modifier keys
;; (setq modifier-keys-are-sticky t)

;; Highlight current line
;; (global-hl-line-mode t)

;; Enable wheel-mouse scrolling
(mouse-wheel-mode t)

;;;;;;;;;;;;;;;;;;
;; KEY BINDINGS ;;
;;;;;;;;;;;;;;;;;;

(defun scroll-up-fixed-point ()
  (interactive) (scroll-up 1)
  (forward-line 1))

(defun scroll-down-fixed-point ()
  (interactive) (scroll-down 1)
  (forward-line -1))

(defun kill-line-x ()
  "Kills the whole line under cursor"
  (interactive)
  (beginning-of-line)
  (kill-line))

;; Will make "Ctrl-k" kill an entire line if the cursor is at the beginning of line
(setq kill-whole-line t)

(global-set-key "\C-j" 'comment-or-uncomment-region)
(global-set-key "\C-q" 'copy-region-as-kill)

(global-set-key "\M-_" 'redo)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-m" 'scroll-up-fixed-point)
(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-o" 'scroll-down-fixed-point)
(global-set-key "\M-p" 'backward-paragraph)
(global-set-key "\M-r" 'replace-regexp)
(global-set-key "\M-s" 'replace-string)
(global-set-key "\M-k" 'kill-line-x)

(global-set-key [(shift up)] 'scroll-down-fixed-point)
(global-set-key [(shift down)] 'scroll-up-fixed-point)

;; Spacebar as filename completion
(cond (window-system
       (define-key minibuffer-local-filename-completion-map
	 " " 'minibuffer-complete-word)
       ))

;; Let Emacs type pairs of parens
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
;;(global-set-key "<" 'skeleton-pair-insert-maybe)
;;(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;;(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair t)

;; Windows key as meta
;; done in system > preferences > keyboard > layout options

;; Aquamacs stuff
(when (boundp 'aquamacs-version)
  ;;deactivate cut-copy-paste
  (cua-mode 0)
  )

;; Carbon Emacs stuff
(when (boundp 'carbon-emacs-package-version)
  ;; switch apple key and alt
  (setq mac-command-modifier 'alt mac-option-modifier 'meta)
  ;; get rid of that fringe boy!
  (fringe-mode -1)
  )

;;;;;;;;;;
;; TEXT ;;
;;;;;;;;;;

;; Set major mode to text mode by default
(setq default-major-mode 'text-mode)

;; todo sort this out
(add-hook 'text-mode-hook
	  (turn-on-auto-fill)
	  (setq fill-column 80)
	  ;;(ispell-change-dictionary "british")
          )

;; todo Change dictionary to British
;;(ispell-change-dictionary "british")

(setq-default c-basic-offset 2)

;;;;;;;;;;;;;;;;
;; JAVASCRIPT ;;
;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.js\\'" . java-mode))

(add-hook 'java-mode-hook
	  '(lambda ()
	     ;; auto indent on return
	     (define-key java-mode-map (kbd "RET") 'newline-and-indent)
	     ;; delete hungrily
 	     (define-key java-mode-map [backspace] 'c-hungry-delete)
	     ))

;;;;;;;;;
;; PHP ;;
;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(add-hook 'php-mode-hook
	  '(lambda ()
             (setq tab-width 2)
	     ))

;;;;;;;;;;;;
;; PYTHON ;;
;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(add-hook 'python-mode-hook
	  '(lambda ()
	     ;; auto indent on return
;; 	     (define-key python-mode-map (kbd "RET") 'newline-and-indent)
	     ;; delete hungrily
;; 	     (define-key python-mode-map [backspace] 'c-hungry-delete)
	     ))

;;;;;;;;;
;; C++ ;;
;;;;;;;;;

;; Load c++-mode in .h files
(add-to-list 'auto-mode-alist '("\\.cpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-hook 'c++-mode-hook
	  '(lambda ()
	     ))

;;;;;;;;;;;;;;;;;;;;
;; LATEX / AUCTEX ;;
;;;;;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))

(add-hook 'latex-mode-hook
	  '(lambda ()
	     (load "auctex.el" nil t t)
	     (setq TeX-auto-save t)
	     (setq TeX-parse-self t)
	     (setq fill-column 70)
	     (setq tex-pdf-mode t)
	     (setq-default TeX-master nil)
             (turn-on-auto-fill)
	     ))

;;;;;;;;;;;;;;;;;;;;
;; AND FINALLY... ;;
;;;;;;;;;;;;;;;;;;;;

;; Save current emacs session
(desktop-load-default)
(desktop-read)

;; On closing
(add-hook 'kill-emacs-hook
	  '(lambda ()
             ;; Save session
 	     (desktop-save "~/") 
          ))
