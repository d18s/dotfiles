
;; todo don't ask if i want to delete excessive backups!
;; todo wrap long lines?

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
             ))

;;;;;;;;;;;;;;;;;;;;;;
;; LOADS & REQUIRES ;;
;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/elisp")
(require 'cc-mode)
(require 'font-lock)
(require 'paren)
(require 'redo)
(cond (window-system
       (require 'color-theme)
       (color-theme-classic)
       ))
;; (require 'emacs-goodies-el)
;; (require 'tramp)

;;;;;;;;;;;
;; MODES ;;
;;;;;;;;;;;

(blink-cursor-mode -1)        ;; flashing cursor
(column-number-mode 1)        ;; use column numbering
(delete-selection-mode 1)     ;; insert over region a la Aquamacs
(global-font-lock-mode 1)     ;; syntax highlighting
(iswitchb-mode 1)             ;; better buffer switching
(line-number-mode 1)          ;; use line numbering
(menu-bar-mode -1)            ;; don't show menu
(mouse-wheel-mode 1)          ;; enable wheel-mouse scrolling
(show-paren-mode 1)           ;; show matching parenthesis
(tool-bar-mode -1)            ;; don't show toolbar
(transient-mark-mode 1)       ;; highlight region
(longlines-mode -1)
(fringe-mode 1)               ;; (don't) get rid of that fringe boy!
(cond (window-system
       (scroll-bar-mode -1)   ;; stop terminals complaining
       )) 

;;;;;;;;;;;;;;;
;; VARIABLES ;;
;;;;;;;;;;;;;;;

(setq kill-whole-line t) ;; will make "ctrl-k" kill an entire line if the cursor is at the beginning of line
(setq case-fold-search t) ;; make searches case insensitive
(setq comment-multi-line t) ;; continue comment when line is wrapped
(setq inhibit-startup-message t) ;; don't show the gnu splash screen
(setq make-backup-files t) ;; do want to backup files
(setq next-line-add-newlines nil) ;; disallow new lines when you press the down arrow at end of the buffer
(setq require-final-newline t) ;; silently ensure newline at end of file
(setq search-highlight t) ;; highlight incremental search
(setq version-control t) ;; enable versioning with default values
(setq visible-bell t) ;; visual bell instead of annoying beep
(setq scroll-step 1) ;; do only one line scrolling
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/")))) ;; save all backup file in this directory.
(setq confirm-kill-emacs 'yes-or-no-p) ;; ask if I'm sure when quitting
;; (setq tramp-default-method "ssh") ;; tramp defaults
;; Ignore case when completing filenames
;;(setq completion-ignore-case t) ;; no!!!
(setq read-file-name-completion-ignore-case t) ;; yes!!!
(setq completion-ignored-extensions ;; ignore these file extensions as possible completions
      '(".o" "~"))
(setq default-frame-alist ;; set initial frame location and size
      '((top . 0)
        (left . 0)
        (width . 200)
        (height . 100)))
(setq frame-title-format ;; set title to show file name or buffer name
      '(buffer-file-name "%f" ("%b")))
(setq-default indent-tabs-mode nil) ;; don't insert tabs
(setq default-major-mode 'text-mode) ;; set major mode to text mode by default
;; n.b. display all faces: M-x list-faces-display
(set-face-foreground 'minibuffer-prompt "white")
(set-face-background 'fringe "white")
(fset 'yes-or-no-p 'y-or-n-p) ;; make all "yes or no" prompts show "y or n" instead
;; (setq-default fill-column 80) ;; the fill column influences how Emacs justifies paragraphs
;; (setq-default truncate-lines nil)
;; (set-fill-column 80)
;; (setq auto-fill-mode 1) ;; lines are automatically wrapped when the cursor goes beyond the column limit
;; (setq auto-save-default nil) ;; Don't want any auto saving
;; (setq modifier-keys-are-sticky t) ;; sticky modifier keys
;; (setq-default tab-width 4)

;;;;;;;;;;;;;;;;;;
;; KEY BINDINGS ;;
;;;;;;;;;;;;;;;;;;

;; Go to the matching parenthesis when you press
;; ! if on parenthesis otherwise insert !
(defun goto-matching-paren-or-insert (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-sexp 1))
	(t (self-insert-command (or arg 1)))))

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
(global-set-key "!" 'goto-matching-paren-or-insert)
(global-set-key [(shift up)] 'scroll-down-fixed-point)
(global-set-key [(shift down)] 'scroll-up-fixed-point)

;; Let Emacs type pairs of parens
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
;;(global-set-key "<" 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair t)

;; n.b. Windows key as meta, done in system > preferences > keyboard > layout options

;; Aquamacs stuff
(when (boundp 'aquamacs-version)
  (cua-mode 0) ;;deactivate cut-copy-paste
  )

;; Carbon Emacs stuff
(when (boundp 'carbon-emacs-package-version)  
  (setq mac-command-modifier 'alt mac-option-modifier 'meta) ;; switch apple key and alt
  )

;;;;;;;;;;
;; TEXT ;;
;;;;;;;;;;

(add-hook 'text-mode-hook
	  '(lambda ()
             ))

;;;;;;;;;;;;;;;;
;; JAVASCRIPT ;;
;;;;;;;;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.js\\'" . java-mode))

(add-hook 'java-mode-hook
	  '(lambda ()
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
	     ))

;;;;;;;;;
;; C++ ;;
;;;;;;;;;

(setq-default c-basic-offset 2)

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
 	     (desktop-save "~/") ;; save session
             ))
