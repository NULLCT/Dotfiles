;;  _ _   _ _ _         _  ;;
;; (_) \ | (_) |_   ___| | ;;
;; | |  \| | | __| / _ \ | ;;
;; | | |\  | | |_ |  __/ | ;;
;; |_|_| \_|_|\__(_)___|_| ;;
;; ----------------------- :;
;;     Made by NULLCT      ;;

;; package.el ;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)
(package-initialize)

;; package settings ;;
(custom-set-variables
n ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages '(gruvbox-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Looks ;;
;; theme
(load-theme 'gruvbox t)
;; font
(add-to-list 'default-frame-alist '(font . "VictorMono Nerd Font-16"))
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)

;; タブにスペースを使用する
(setq-default tab-width 2 indent-tabs-mode nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)
;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)
