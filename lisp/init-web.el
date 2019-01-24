;; -*- coding: utf-8; lexical-binding: t; -*-
;; Web mode
(use-package web-mode
  :ensure t
  :mode
  (
   ".twig"
   ".html?"
   ".hbs$"
   ".vue$"
   )
  :config
  (setq
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-enable-auto-closing t
   web-mode-enable-auto-opening t
   web-mode-enable-auto-pairing t
   web-mode-enable-current-column-highlight t
   web-mode-enable-auto-indentation t))

(provide 'init-web)
