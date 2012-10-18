;;;;;;;;;;;;
;; その他 ;;
;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; HELP表示
(global-set-key [f1] 'help-for-help)
;; C-cをリセット
(global-unset-key [(C-c)])
;; sdic
(global-set-key [(C c)(C i)] 'sdic-describe-word)
(global-set-key [(C c)(C u)] 'sdic-describe-word-at-point)
;;ミニバッファでファイル名入力時に一つ上のディレクトリへ
(define-key minibuffer-local-filename-completion-map "\C-p" 'up-dir)
;;;;;;;;;;
;; 設定 ;;
;;;;;;;;;;
;; yes-or-noをy-or-nに
(fset 'yes-or-no-p 'y-or-n-p)
;; スクロールバーを右側に
(set-scroll-bar-mode 'right)
;; isearch のハイライトの反応をよくする
(setq isearch-lazy-highlight-initial-delay 0)
;;ウィンドウ切り替えを循環させる
(setq indmove-wrap-around t)
;;;Emacs23からでる警告を予防
(setq byte-compile-warnings '(free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local))

;;;;;;;;;;;;;;;;;;;
;; ブラウザ"w3m" ;;
;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/w3m"))
(require 'w3m-load)
(add-hook 'w3m-mode-hook
          '(lambda ()
             (progn
               (local-set-key "\C-t" 'other-window)
               )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 現在のカーソルから/、\までの文字列を削除する ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun up-dir ()
	"現在のカーソルから/、\までの文字列を削除する"
	(interactive )
	(backward-char)
	(if
	    (or 
	     (equal "\\" (format "%c" (following-char)))
	     (equal "/" (format "%c" (following-char))) )
	   (progn
	     (delete-char 1)
	     (backward-char)
	     )
	  )
	(while
	    (and 
	     (not (equal "\\" (format "%c" (following-char))))
	     (not (equal "/" (format "%c" (following-char))))
	     )
	  (delete-char 1)
	  (backward-char)
	  )
	(forward-char)
)

;;;;;;;;;;;;;;;;;;;;;;
;; バイトコンパイル ;;
;;;;;;;;;;;;;;;;;;;;;;
;; (require 'auto-async-byte-compile)
;; (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;;;;;;;;;;;;;;;;
;; 自動補完    ;;
;;;;;;;;;;;;;;;;;
;; 参照
;; http://cx4a.org/software/auto-complete/manual.ja.html
;; (defconst AC_DIC_DIR (concat EMACS_D_DIR "elisp/auto-complete-1.3.1/") "auto-complate dic directory.")
;; (add-to-list 'load-path AC_DIC_DIR )
;; (setq ac-dictionary-directories (concat AC_DIC_DIR "dict") )
;; (add-to-list 'ac-dictionary-directories (concat AC_DIC_DIR "dict") )
;; (require 'auto-complete-config)
;; (ac-config-default)
;; ;; 自動補完メニュー表示時のみC-n/C-pで補完候補を選択する
;; (setq ac-use-menu-map t)
;; (define-key ac-menu-map [(C n)] 'ac-next)
;; (define-key ac-menu-map [(C p)] 'ac-previous)
;; ;; 自動補完オプション
;; (setq ac-auto-start 2);;2文字以上から補完
;; (setq ac-candidate-limit 10)
;; (setq ac-delay 0.3)
;; (setq ac-auto-show-menu 1)
;; (setq ac-stop-flymake-on-completing t)
;; (setq ac-menu-height 8)

;;;;;;;;;;;;;;;;;;;;;;
;; 自動インストール ;;
;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-install)
(setq auto-install-directory (concat EMACS_D_DIR "elisp/"))
;起動時にemacswiki-packageを更新する
;(auto-install-update-emacswiki-package-name t)
;互換性確保
(auto-install-compatibility-setup)

;; ;;;;;;;;;;
;; ;; sdic ;;
;; ;;;;;;;;;;
;; (autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
;; (setq sdic-default-coding-system 'utf-8-dos)
;; (autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
;; ;(defconst SDIC_E "~/0.working/.emacs.d/dic/eijirou.sdic")
;; ;(setq sdic-eiwa-dictionary-list '((sdicf-client SDIC_E)))
;; ;(setq sdic-eiwa-dictionary-list '((sdicf-client "~/0.working/.emacs.d/dic/eijirou.sdic")))
;; (setq sdic-eiwa-dictionary-list '((sdicf-client "I:/eijirou.sdic")))
;; (setq sdic-disable-select-window t)

;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; sdic-inline モード ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; http://d.hatena.ne.jp/khiker/20100303/sdic_inline
;; (require 'sdic-inline)
;; ;(setq sdic-inline-eiwa-dictionary "~/0.working/.emacs.d/dic/eijirou.sdic")
;; (setq sdic-inline-eiwa-dictionary "I:/eijirou.sdic")
;; (setq sdic-inline-dictionary-encoding 'utf-8-dos)
;; (setq sdic-inline-enable-modes nil)   ; major-mode を基準にオン・オフを判断しなくする。
;; (setq sdic-inline-enable-faces nil)   ;テキスプロパティを基準にオン・オフを判断しなくする。
;; ;; ;; sdic-inline を有効とするメジャーモードを収めたリスト。
;; ;; sdic-inline-enable-modes
;; 98;; ;; sdic-inline を有効とするテキストプロパティを収めたリスト。
;; ;; sdic-inline-enable-faces
;; ;; ;; 以下に設定された正規表現とファイル名がマッチする場合、sdic-inline を有効とする。
;; ;; sdic-inline-enable-filename-regex
;; ;; ;; この変数に指定された関数の実行結果が t を返す場合、sdic-inline を有効とする。
;; ;; sdic-inline-enable-func
;; ;(add-to-list 'sdic-inline-enable-modes 'w3m-mode)  ; w3m-mode でも動作するようにする。
;; ;(add-to-list 'sdic-inline-enable-faces 'font-lock-doc-face) ; テキストプロパティが font-lock-doc-face である文字上でもオンとする。

;; ;(setq sdic-inline-not-search-style 'point)	; デフォルト値。ポイント位置が前回と同じである限り、再度辞書ではひかない。
;; ;(setq sdic-inline-not-search-style 'word)	; カーソル下の単語が前回辞書で引いた単語と同じである限り、再度辞書ではひかない。
;; (setq sdic-inline-not-search-style 't)		; sdic-inline-delay に定められた秒数毎にポイント下の単語を辞書でひく。
;; (setq sdic-inline-delay 0.5)
;; ;(setq sdic-inline-word-at-point-strict nil)	;単語の後に空白がいくつかあってもマッチするという挙動

