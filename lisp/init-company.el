;; -*- coding: utf-8; lexical-binding: t; -*-
;; Company mode
(use-package company
  :ensure t
  :defer t
  :init (global-company-mode)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)

    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package company-go
  :ensure t
  :defer t
  :init
  (setq company-idle-delay 0.25)
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(provide 'init-company)
