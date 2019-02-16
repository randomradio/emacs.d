;; Theme

;; Light theme
(require-package 'leuven-theme)
(require-package 'ample-theme)
(require-package 'twilight-bright-theme)
(require-package 'moe-theme)
(require-package 'anti-zenburn-theme)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-spacegrey t))

(provide 'init-themes)
