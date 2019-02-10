(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-completion-system 'ivy)
  (setq projectile-require-project-root nil)
  (projectile-mode +1))

(use-package ag
  :ensure t
  )
(use-package wgrep-ag
  :ensure t
  )

(provide 'init-projectile)
