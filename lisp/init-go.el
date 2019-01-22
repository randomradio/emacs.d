;; -*- coding: utf-8; lexical-binding: t; -*-
;; golang

(use-package go-mode
  :ensure t
  :init
  (progn
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (bind-key [remap find-tag] #'godef-jump))
  :config
  (add-hook 'go-mode-hook 'electric-pair-mode))

(use-package go-eldoc
  :ensure t
  :defer
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(provide 'init-go)
