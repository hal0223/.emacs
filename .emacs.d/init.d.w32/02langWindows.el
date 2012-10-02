;;;=======================================
;;;言語・文字コードの設定
;;;=======================================
(setenv "LANG" "ja_JP.sjis")
;;; IME ON/OFF 時にカーソル色を変える。
(setq ime-activate-cursor-color "Deep Sky Blue")
(setq ime-inactivate-cursor-color "Deep Pink")
(set-cursor-color ime-inactivate-cursor-color)
;; ※input-method-activate-hook, input-method-inactivate-hook じゃない方がいい感じになる。
(add-hook 'w32-ime-on-hook
          (function (lambda ()
		      (set-cursor-color ime-activate-cursor-color)
		      )))
(add-hook 'w32-ime-off-hook
          (function (lambda ()
		      (set-cursor-color ime-inactivate-cursor-color)
		      )))


(setq-default mw32-ime-mode-line-state-indicator "[--]")
;;モードラインの表示も変更
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[J]" "[--]"))
;;ここまでは mw32-ime-initialize の前に入れる

(when (equal emacs-major-version 21) (require 'un-define))
(set-language-environment "Japanese")
(set-default-coding-systems 'sjis)
(set-terminal-coding-system 'sjis)
(set-keyboard-coding-system 'japanese-shift-jis)
(set-keyboard-coding-system 'sjis)
(setq file-name-coding-system 'sjis)
(set-clipboard-coding-system 'sjis-dos)
(set-w32-system-coding-system 'sjis-dos)

(set-input-method "W32-IME")
(w32-ime-initialize)  ;; IME の初期化
(w32-ime-state-switch nil)

;; Eshellの文字化け対策
(add-hook 'set-language-environment-hook 
          (lambda ()
            (when (equal "ja_JP.UTF-8" (getenv "LANG"))
              (setq default-process-coding-system '(utf-8 . utf-8))
              (setq default-file-name-coding-system 'utf-8))
            (when (equal "Japanese" current-language-environment)
              (setq default-buffer-file-coding-system 'iso-2022-jp))))
