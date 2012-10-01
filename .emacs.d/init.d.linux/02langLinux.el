;;;=======================================
;;;言語・文字コード関連の設定
;;;=======================================
(when (equal emacs-major-version 21) (require 'un-define))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
;; Eshellの文字化け対策 ;;
(add-hook 'set-language-environment-hook 
          (lambda ()
            (when (equal "ja_JP.UTF-8" (getenv "LANG"))
              (setq default-process-coding-system '(utf-8 . utf-8))
              (setq default-file-name-coding-system 'utf-8))
            (when (equal "Japanese" current-language-environment)
              (setq default-buffer-file-coding-system 'iso-2022-jp))))
;;クリップボードからのペースト時の文字化けを防ぐ;(set-clipboard-coding-system 'utf-8)
(set-language-environment 'Japanese)
;;日本語infoの文字化け防止
(auto-compression-mode t)

;; japanese-anthy をデフォルトの input-method にする。
(setq default-input-method "japanese-mozc")

;; ibus-mode
(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("deeppink" "white" "blue"))
(global-set-key "\C-\\" 'ibus-toggle)
