(add-to-list 'load-path "~/.emacs.d/lisp")
(load "site-start.d/epitech-init.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9fe9462ddb8d826c7b2c9991ce79d5e90afbeed8846294d4bc69a2893149ef12" "2627707bc15dd427ef165fc8ff9868e3e184f6a151f139c092561bbc39734364" default))
 '(package-selected-packages
   '(company-tabnine irony auto-complete drag-stuff wakatime-mode catppuccin-theme))
 '(ps-default-bg t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;;; 
;(require 'use-package)

(use-package catppuccin-theme
 :config
 (setq catppuccin-height-title1 1.5))

(global-linum-mode 1)

(setq linum-format "%4d  ")
(setq-default display-fill-column-indicator-column 80)
(global-display-fill-column-indicator-mode)

(load-theme 'catppuccin)
(global-wakatime-mode)


(drag-stuff-global-mode 1)
(drag-stuff-define-keys)
(ac-config-default)

(set-face-background 'ac-candidate-face "black")
(set-face-foreground 'ac-candidate-face "while")

(set-face-underline 'ac-candidate-face "steelblue")
(set-face-background 'ac-selection-face "cyan")
