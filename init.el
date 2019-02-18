;; -*- coding: utf-8; lexical-binding: t; -*-
(setq debug-on-error t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (defadvice package-initialize (after my-init-load-path activate)
;;   "Reset `load-path'."
;;   (push (expand-file-name "~/.emacs.d/lisp") load-path))
(package-initialize)
(push (expand-file-name "~/.emacs.d/lisp") load-path)

(let* ((minver "24.4"))
  (when (version< emacs-version minver)
    (error "Emacs v%s or higher is required." minver)))

(defvar best-gc-cons-threshold
  4000000
  "Best default gc threshold value.  Should NOT be too big!")

;; don't GC during startup to save time
(setq gc-cons-threshold most-positive-fixnum)

(setq emacs-load-start-time (current-time))

;; {{ emergency security fix
;; https://bugs.debian.org/766397
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))
;; }}
;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(setq *is-a-mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'windows-nt))
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *emacs24* (>= emacs-major-version 24))
(setq *emacs25* (>= emacs-major-version 25))
(setq *emacs26* (>= emacs-major-version 26))
(setq *no-memory* (cond
                   (*is-a-mac*
                    (< (string-to-number (nth 1 (split-string (shell-command-to-string "sysctl hw.physmem")))) 4000000000))
                   (*linux* nil)
                   (t nil)))

;; ----------------------------------------------------------------------------
;; make sure the mouse scroll event behaves the same on osx and other sytems
;; @see https://github.com/syl20bnr/spacemacs/issues/4591
(if *is-a-mac*
    (progn
    (global-set-key (kbd "<mouse-4>") (kbd "<wheel-up>"))
    (global-set-key (kbd "<mouse-5>") (kbd "<wheel-down>"))))
;; ----------------------------------------------------------------------------

;; @see https://www.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/
;; Emacs 25 does gc too frequently
(when *emacs25*
  ;; (setq garbage-collection-messages t) ; for debug
  (setq best-gc-cons-threshold (* 64 1024 1024))
  (setq gc-cons-percentage 0.5)
  (run-with-idle-timer 5 t #'garbage-collect))

(defmacro local-require (pkg)
  `(unless (featurep ,pkg)
     (load (expand-file-name
             (cond
               ((eq ,pkg 'bookmark+)
                (format "~/.emacs.d/site-lisp/bookmark-plus/%s" ,pkg))
               ((eq ,pkg 'go-mode-load)
                (format "~/.emacs.d/site-lisp/go-mode/%s" ,pkg))
               (t
                 (format "~/.emacs.d/site-lisp/%s/%s" ,pkg ,pkg))))
           t t)))


;; *Message* buffer should be writable in 24.4+
(defadvice switch-to-buffer (after switch-to-buffer-after-hack activate)
  (if (string= "*Messages*" (buffer-name))
      (read-only-mode -1)))

;; Setting font
;; for terminal, set font in terminal app
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 110
                    :weight 'normal
                    :width 'normal)

;; auto refresh buffer on change
(global-auto-revert-mode t)

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
;; @see https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/
;; Normally file-name-handler-alist is set to
;; (("\\`/[^/]*\\'" . tramp-completion-file-name-handler)
;; ("\\`/[^/|:][^/|]*:" . tramp-file-name-handler)
;; ("\\`/:" . file-name-non-special))
;; Which means on every .el and .elc file loaded during start up, it has to runs those regexps against the filename.
(let* ((file-name-handler-alist nil))
  ;; `package-initialize' takes 35% of startup time
  ;; need check https://github.com/hlissner/doom-emacs/wiki/FAQ#how-is-dooms-startup-so-fast for solution
  
  ;;----------------------------------------------------------------------------
  ;; Put all lisp/init-{}.el file in the following section
  ;;----------------------------------------------------------------------------
  (require 'init-autoload)
  (require 'init-modeline)
  (require 'init-utils)
  (require 'init-elpa)
  (require 'init-misc)
  (require 'init-neotree)
  (require 'init-evil-and-keys)
  (require 'init-themes)
  (require 'init-clipboard)
  (require 'init-keyfreq)

  (require 'init-org)
  (require 'init-company)

  (require 'init-flycheck)
  ;; programming langs
  (require 'init-python)
  (require 'init-go)
  (require 'init-web)
  ;; fuzzy search
  (require 'init-ivy)
  (require 'init-projectile)

  ;;----------------------------------------------------------------------------
  ;; @see https://github.com/hlissner/doom-emacs/wiki/FAQ
  ;; Adding directories under "site-lisp/" to `load-path' slows
  ;; down all `require' statement. So we do this at the end of startup
  ;; Neither ELPA package nor dependent on "site-lisp/".
  (setq load-path (cdr load-path))
  (load (expand-file-name "~/.emacs.d/lisp/init-site-lisp") t t)

  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.note\\'" . org-mode))
)

(setq gc-cons-threshold best-gc-cons-threshold)

(when (require 'time-date nil t)
  (message "Emacs startup time: %d seconds."
           (time-to-seconds (time-since emacs-load-start-time))))

;;; Local Variables:
;;; no-byte-compile: t
;;; End:
(put 'erase-buffer 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
