;; -*- coding: utf-8; lexical-binding: t; -*-

(eval-after-load 'dired
  '(progn
     ;; avoid accidentally edit huge media file in dired
     (defadvice dired-find-file (around dired-find-file-hack activate)
       (let* ((file (dired-get-file-for-visit)))
         (cond
          ((string-match-p binary-file-name-regexp file)
           ;; confirm before open big file
           (if (yes-or-no-p "Edit binary file?") ad-do-it))
          (t
           (when (and (file-directory-p file)
                      ;; don't add directory when user pressing "^" in `dired-mode'
                      (not (string-match-p "\\.\\." file)))
             (add-to-list 'my-dired-directory-history file))
           ad-do-it))))

     (defadvice dired-do-async-shell-command (around dired-do-async-shell-command-hack activate)
       "Mplayer scan dvd-ripped directory in dired correctly."
       (let* ((args (ad-get-args 0))
              (first-file (file-truename (and file-list (car file-list)))))
         (cond
          ((file-directory-p first-file)
           (async-shell-command (format "%s -dvd-device %s dvd://1 dvd://2 dvd://3 dvd://4 dvd://1 dvd://5 dvd://6 dvd://7 dvd://8 dvd://9"
                                        (my-guess-mplayer-path)
                                        first-file)))
          (t
           ad-do-it))))

     ;; @see https://emacs.stackexchange.com/questions/5649/sort-file-names-numbered-in-dired/5650#5650
     (setq dired-listing-switches "-laGh1v")
     (setq dired-recursive-deletes 'always)))

(defvar binary-file-name-regexp "\\.\\(avi\\|pdf\\|mp[34g]\\|mkv\\|exe\\|3gp\\|rmvb\\|rm\\)$"
  "Is binary file name?")

;; {{ Write backup files to own directory
;; @see https://www.gnu.org/software/emacs/manual/html_node/tramp/Auto_002dsave-and-Backup.html
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not (string-match-p binary-file-name-regexp name)))))

(if (not (file-exists-p (expand-file-name "~/.backups")))
  (make-directory (expand-file-name "~/.backups")))
(setq backup-by-coping t ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.backups"))
      delete-old-versions t
      version-control t  ;use versioned backups
      kept-new-versions 6
      kept-old-versions 2)

;; Donot make backups of files, not safe
;; @see https://github.com/joedicastro/dotfiles/tree/master/emacs
(setq vc-make-backup-files nil)
;; }}

(provide 'init-dired)
