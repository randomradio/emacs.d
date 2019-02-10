;; -*- coding: utf-8; lexical-binding: t; -*-
;; golang

(use-package go-mode
  :ensure t
  :init
  (progn
    ;; use goimports instead of default gofmt for formatting
    ;; as well as imports cleanup
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (bind-key [remap find-tag] #'godef-jump)
    ;; move cursor to import block
    (local-set-key (kbd "C-c C-g") 'go-goto-imports)
    ;; godoc popup
    (local-set-key (kbd "C-c C-k") 'godoc)
    ;--------------------------------------------------
    ;; For go jump to def
    ;; It is bound to C-c C-j. Remember that C-x <LEFT>
    ;; will move you back to previous buffer once you done reading
    ;--------------------------------------------------
    )
  :config
  (add-hook 'go-mode-hook 'electric-pair-mode))

(use-package go-eldoc
  :ensure t
  :defer
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-flycheck
  :defer t
  )

(provide 'init-go)
