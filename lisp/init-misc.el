;; -*- coding: utf-8; lexical-binding: t; -*-

;; indention management
(defun my-toggle-indentation ()
  (interactive)
  (setq indent-tabs-mode (not indent-tabs-mode))
  (message "indent-tabs-mode=%s" indent-tabs-mode))

(provide 'init-misc)
