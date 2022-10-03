;;    
;; Epitech configuration
;;
(add-to-list 'load-path "~/.emacs.d/lisp")
(load "site-start.d/epitech-init.el")

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`

;; and `package-pinned-packages`. Most users will not need or want to do this.

;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2627707bc15dd427ef165fc8ff9868e3e184f6a151f139c092561bbc39734364" default))
 '(package-selected-packages '(wakatime-mode catppuccin-theme))
 '(ps-default-bg t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'use-package)

(use-package catppuccin-theme
 :config
 (setq catppuccin-height-title1 1.5)



(load-theme 'catppuccin)

(global-wakatime-mode)
