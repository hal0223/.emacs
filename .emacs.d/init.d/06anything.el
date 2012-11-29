;;;;;;;;;;;;;;
;; anything ;;
;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;; ロードパスの設定 ;;
;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/anything"))
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/anything/developer-tools"))
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/anything/extensions"))

;;;;;;;;;;;;;;;;;;;;;;
;; init             ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; Note: anything-config.el loads anything.el.
(require 'anything-config)

;;; anything-match-plugin.el extends pattern matching. Some Anything
;;; Applications requires it. It is a must-have plugin now.
(require 'anything-match-plugin)

;;; anything-complete.el replaces various completion with anything
;;; (like Icicles). Use Anything power for normal completion.
(when (require 'anything-complete nil t)
  ;; Automatically collect symbols by 150 secs
  (anything-lisp-complete-symbol-set-timer 150)
  (define-key emacs-lisp-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
  (define-key lisp-interaction-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
  ;; Comment if you do not want to replace completion commands with `anything'.
  (anything-read-string-mode 1)
  )

;;; anything-show-completion.el shows current selection prettily.
(require 'anything-show-completion)

;;; anything-auto-install.el integrates auto-install.el with anything.
(require 'anything-auto-install nil t)

;;; descbinds-anything.el replaces describe-bindings with anything interface.
(when (require 'descbinds-anything nil t)
  ;; Comment if you do not want to replace `describe-bindings' with `anything'.
  (descbinds-anything-install)
  )

;;; `anything-grep' replaces standard `grep' command.
(require 'anything-grep nil t)

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; 現在開いているバッファ・過去に開いたバッファ
(define-key global-map [(C \;)] 'main-anything)
;; 現在開いているバッファ・過去に開いたバッファ
(define-key global-map [(C x)(C f)] 'anything-find-file)

;; 登録済みコマンド
(define-key global-map [(M \;)] 'sub-anything)
;; moccur検索
(define-key global-map [(M s)] 'anything-c-moccur-occur-by-moccur)
;; C-hで後ろへ1文字削除
(define-key anything-map [(C h)] 'delete-backward-char)
;; Grepと同機能だけど重い、かつ指定ディレクトリのバッファをすべて開く
(define-key global-map [(C M s)] 'dmoccur)
;; 拡張kill-ring
(global-set-key [(M y)] 'anything-kill-ring)

;;;;;; 各モードのanything ;;;;;;;;;
;; lisp-mode
(define-key emacs-lisp-mode-map [(C \:)] 'anything-browse-code)
;; org-mode
(define-key org-mode-map [(C \:)] 'anything-org)
;; dired-mode
(define-key dired-mode-map [(C \:)] 'anything-dired)


;; 利用できるanything-source一覧を表示
(global-set-key [(M \;)] 'anything-call-source)

;; 複数ソースがある場合、次のソースをフォーカスする
(define-key anything-map [(C \;)] 'anything-next-source)
(define-key anything-map [(C \:)] 'anything-next-source)
(define-key anything-map [(M \;)] 'anything-next-source)

;;デフォルトのプレフィックス"F5 a"から"F6 a"へ変更
;;(setq anything-command-map-prefix-key "<F6> a")

;;;;;;;;;;;;;;;;;;;;;
;; Tips            ;;
;;;;;;;;;;;;;;;;;;;;;
;; 利用可能な情報源一覧 : M-x anything-call-source

;;;;;;;;;;;;;;;;;;;;;;;;;
;; main-anything       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'recentf-ext)
(defun main-anything ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-recentf
     anything-c-source-buffers+
     anything-c-source-files-in-current-dir+
     )
   "*buffer-anything* ")
  )

;;;;;;;;;;;;;;;;;;;;;;;;
;; sub-anything       ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun sub-anything ()
  (interactive)
  (anything-other-buffer 
   '(
     anything-c-source-extended-command-history
     anything-c-source-favorite-commands
     ) "*sub-anything* "))

;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-kill-ring ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun anything-kill-ring ()
  (interactive)
  (anything-other-buffer '(anything-c-source-kill-ring) "*anything-kill-ring* "))

;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-browse-code;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun anything-browse-code ()
  (interactive)
  (anything-other-buffer '(anything-c-source-browse-code) "*anything-browse-code* "))

;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-org       ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun anything-org ()
  (interactive)
  (anything-other-buffer 
   '(
     anything-c-source-org-headline
     anything-c-source-org-keywords
     ) "*anything-org* "))

;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-dired     ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(defun anything-dired ()
  (interactive)
  (anything-other-buffer '( anything-c-source-files-in-all-dired ) "*anything-dired* "))

;;;;;;;;;;;;;;;;;;;;;;
;; anything-C-Occur ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; color-moccur.elの設定
(require 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; (cf.) http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
(setq moccur-grep-default-word-near-point nil)
(setq moccur-kill-moccur-buffer t)

;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))
(setq *moccur-buffer-name-exclusion-list*
      '("\.svn" "*Completions*" "*Messages*"))

(require 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.2		;anything-idle-delay
      anything-c-moccur-higligt-info-line-flag t	; anything-c-moccur-dmoccurなどのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t		; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern 	;anything-c-moccur-occur-by-moccurの起動時にポイントの位置の単語を初期パターンにする
      )

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; favorite-anything-commands ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq fc-file-path (concat EMACS_D_DIR "favorite_command.txt"))
(defvar anything-c-source-favorite-commands
  '((name . "favorite commands")
    (candidates-file fc-file-path updating)
    (type . command)))

 ;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything-filelist+  ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;
;; ファイルリストが古いままだと、新規ファイルが反映されないので、
;; rootのcronで自動更新しておきましょう。 
;; crontabに以下の行を加えると、1:00に実行します。
;; 0 1 * * * ruby /path/to/make-filelist.rb > /tmp/all.filelist
;; (concat EMACS_D_DIR "elisp/anything-config/make-filelist.rb") > (concat EMACS_D_DIR "elisp/anything-config/all.filelist")
;; ~/0.working/.emacs.d/elisp/anything-config//make-filelist.rb > ~/0.working/.emacs.d/elisp/anything-config/all.filelist
(setq anything-c-filelist-file-name (concat EMACS_D_DIR "elisp/anything-config/all.filelist"))
(setq anything-grep-candidates-fast-directory-regexp (concat EMACS_D_DIR "elisp/anything-config/"))
;; #TODO:もっとスマートに
(setq anything-c-source-filelist
      '((name . "FileList")
        (grep-candidates . anything-c-filelist-file-name)
        (candidate-number-limit . 200)
        (requires-pattern . 2)
        (type . file)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 入力が終わった後にanything検索を行う ;;
;; ※動作が重い場合にコメントアウトする ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defadvice anything-check-minibuffer-input (around sit-for activate)
;;   (if (sit-for anything-idle-delay t)
;;       ad-do-it)
;;   )
