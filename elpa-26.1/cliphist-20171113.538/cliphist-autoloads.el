;;; cliphist-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "cliphist" "cliphist.el" (0 0 0 0))
;;; Generated autoloads from cliphist.el

(autoload 'cliphist-version "cliphist" "\


\(fn)" nil nil)

(autoload 'cliphist-read-items "cliphist" "\


\(fn)" t nil)

(autoload 'cliphist-copy-to-clipboard "cliphist" "\
Copy STR into clipboard.

\(fn STR)" nil nil)

(autoload 'cliphist-paste-item "cliphist" "\
Paste selected item into current buffer.
Rectangle paste the item if arg RECT-PASTE is non-nil.

\(fn &optional RECT-PASTE)" t nil)

(autoload 'cliphist-select-item "cliphist" "\
Select one item from clipboard history.
NUM is passed to `cliphist-select-item-callback'.

\(fn &optional NUM)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cliphist" '("cliphist-")))

;;;***

;;;### (autoloads nil "cliphist-clipit" "cliphist-clipit.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from cliphist-clipit.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cliphist-clipit" '("cliphist-clipit-")))

;;;***

;;;### (autoloads nil "cliphist-flycut" "cliphist-flycut.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from cliphist-flycut.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cliphist-flycut" '("cliphist-f")))

;;;***

;;;### (autoloads nil "cliphist-parcellite" "cliphist-parcellite.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from cliphist-parcellite.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "cliphist-parcellite" '("cliphist-parcellite-")))

;;;***

;;;### (autoloads nil nil ("cliphist-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; cliphist-autoloads.el ends here
