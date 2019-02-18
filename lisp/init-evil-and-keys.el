;; Vim mode with evil
(use-package evil
  :ensure t
  :config
    (add-to-list 'evil-emacs-state-modes 'neotree-mode)
    (evil-mode 1)
    ;; Move back the cursor one position when exiting insert mode
    (setq evil-move-cursor-back t)

    ;; As a general RULE, mode specific evil leader keys started
    ;; with uppercased character or 'g' or special character except "=" and "-"
    (evil-declare-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "gl" 'outline-next-visible-heading
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "<" (lambda () (interactive) (org-demote-or-promote 1)) ; out-dent
    ">" 'org-demote-or-promote ; indent
    (kbd "TAB") 'org-cycle)

    ;; I prefer Emacs way after pressing ":" in evil-mode
    (define-key evil-ex-completion-map (kbd "C-a") 'move-beginning-of-line)
    (define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
    (define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
    (define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)
    (define-key evil-normal-state-map "Y" (kbd "y$"))
    ;; (define-key evil-normal-state-map (kbd "RET") 'ivy-switch-buffer-by-pinyin) ; RET key is preserved for occur buffer
    (define-key evil-normal-state-map "go" 'goto-char)
    ;; (define-key evil-normal-state-map (kbd "C-]") 'counsel-etags-find-tag-at-point)
    ;; (define-key evil-visual-state-map (kbd "C-]") 'counsel-etags-find-tag-at-point)
    (define-key evil-insert-state-map (kbd "C-x C-n") 'evil-complete-next-line)
    (define-key evil-insert-state-map (kbd "C-x C-p") 'evil-complete-previous-line)
    ;; (define-key evil-insert-state-map (kbd "C-]") 'aya-expand)

    ;; Frequently used comands are listed here
    (local-require 'general)
    (general-evil-setup t)
    ;; {{ use ',' as leader key
    (nvmap :prefix ","
	    "bf" 'beginning-of-defun
	    "bu" 'backward-up-list
	    "bb" 'back-to-previous-buffer
	    "ef" 'end-of-defun
	    "mf" 'mark-defun
	    "em" 'erase-message-buffer
	    "eb" 'eval-buffer
	    "er" 'eval-region
	    "xk" 'kill-buffer
	    "xs" 'save-buffer
	    "kb" 'kill-buffer-and-window ;; "k" is preserved to replace "C-g"
	    "sd" 'sudo-edit
	    "sc" 'scratch
	    "ee" 'eval-expression
	    "aa" 'copy-to-x-clipboard ; used frequently
	    "zz" 'paste-from-x-clipboard ; used frequently
	    "kc" 'kill-ring-to-clipboard
	    "aw" 'ace-swap-window
	    "af" 'ace-maximize-window
	    "ac" 'aya-create
	    ;; neotree keys
	    "nt" 'neotree-toggle
	    "nf" 'neotree-find ; open file in current buffer in neotree
	    "nd" 'neotree-project-dir-toggle
	    ;; file and directory
	    "fn" 'cp-filename-of-current-buffer
	    "fp" 'cp-fullpath-of-current-buffer
	    "dj" 'dired-jump ;; open the dired from current file
	    "xd" 'dired
	    ;; project/file
	    "ip" 'find-file-in-project
	    "jj" 'find-file-in-project-at-point
	    "kk" 'find-file-in-project-by-selected
	    "kn" 'find-file-with-similar-name ; ffip v5.3.1
	    "fd" 'find-directory-in-project-by-selected
	    "pjo" 'projectile-multi-occur
	    ; ag
	    "as" 'ag-project ; search in project
	    ;; comment vs uncomment
	    "ci" 'evilnc-comment-or-uncomment-lines
	    "cl" 'evilnc-comment-or-uncomment-to-the-line
	    "cc" 'evilnc-copy-and-comment-lines
	    "ct" 'evilnc-comment-or-uncomment-html-tag ; evil-nerd-commenter v3.3.0 required
	    ;; counsel
	   )
    ;; }}

    ;; {{ Use `SPC` as leader key
    ;; all keywords arguments are still supported
    (nvmap :prefix "SPC"
            "gg" 'magit-status
            "gs" 'magit-show-commit
            "gl" 'magit-log-all
            "gff" 'magit-find-file ; loading file in specific version into buffer
            "gdd" 'magit-diff-dwim
            "gdc" 'magit-diff-staged
            "gau" 'magit-stage-modified
            "gcc" 'magit-commit-popup
            "gca" 'magit-commit-amend
            "gja" 'magit-commit-extend
            "gtt" 'magit-stash-both
            "gta" 'magit-stash-apply
      )
    ;; }}
)

;; {{ remember what we searched
;; http://emacs.stackexchange.com/questions/24099/how-to-yank-text-to-search-command-after-in-evil-mode/
(defvar my-search-text-history nil "List of search entries.")
(defun my-select-from-search-text-history ()
  (interactive)
  (ivy-read "Search text history:" my-search-text-history
	    :action (lambda (item)
		      (copy-yank-str item)
		      (message "%s -> clipboard & yank ring" item))))

(defun my-cc-isearch-string ()
  (interactive)
  (if (and isearch-string (> (length isearch-string) 0))
      ;; NOT pollute clipboard who has things to paste into Emacs
      (add-to-list 'my-search-text-history isearch-string)))

(defadvice evil-search-incrementally (after evil-search-incrementally-after-hack activate)
  (my-cc-isearch-string))

(defadvice evil-search-word (after evil-search-word-after-hack activate)
  (my-cc-isearch-string))

(defadvice evil-visualstar/begin-search (after evil-visualstar/begin-search-after-hack activate)
  (my-cc-isearch-string))
;; }}

(use-package evil-escape
  :ensure t
  :init
  :config
    ;; {{ https://github.com/syl20bnr/evil-escape
    (setq-default evil-escape-delay 0.3)
    (setq evil-escape-excluded-major-modes '(dired-mode))
    (setq-default evil-escape-key-sequence "kj")
    ;; disable evil-escape when input method is on
    (evil-escape-mode 1))
    ;; }

(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right)
)

(provide 'init-evil-and-keys)
