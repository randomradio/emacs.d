;; -*- coding: utf-8; lexical-binding: t; -*-
;; Company mode
(use-package company
  :ensure t
  :defer t
  :init
  (global-company-mode)
  (setq company-idle-delay 0.25)
  :config
  (progn
    ;; Use Company for completion
    (bind-key [remap completion-at-point] #'company-complete company-mode-map)
    ;; start autocompletion only after typing
    (setq company-begin-commands '(self-insert-command)) 
    (setq company-tooltip-align-annotations t
          ;; Easy navigation to candidates with M-<n>
          company-show-numbers t)
    (setq company-dabbrev-downcase nil))
  :diminish company-mode)

(use-package company-go
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(use-package company-web
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-web))
  (add-hook 'web-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-web))
                          (company-mode t)))
  )

(provide 'init-company)
