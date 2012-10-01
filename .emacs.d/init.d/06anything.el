;;;;;;;;;;;;;;
;; anything ;;
;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;
;; ロードパスの設定 ;;
;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/anything-config"))
(add-to-list 'load-path (concat EMACS_D_DIR "elisp/anything-config/extensions"))
(require 'anything-startup)

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; TODO: キーバインドを調べる作業をしあわせにしてくれる
;; (require 'descbinds-anything)
;(define-key global-map [(C \;)] 'buffer-anything)
(define-key global-map [(C \;)] 'my-anything)
(define-key global-map [(C \:)] 'my-favo-anything)
(define-key global-map [(M \;)] 'anything-c-source-emacs-functions)
;(define-key global-map [(C M s)] 'anything-c-moccur-occur-by-moccur);moccur

;(define-key global-map [(C M s)] 'dmoccur)
;(define-key global-map [(C c)(C w)] 'anything-show-w3m-bookmarks-only)
;(define-key global-map [(C S s)] 'anything-do-grep);;#TODO:anything grep
(define-key anything-map [(C \;)] 'anything-next-source)
(define-key anything-map [(C h)] 'delete-backward-char)

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; favorite-anything-commands ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq fc-file-path (concat EMACS_D_DIR "favorite_command.txt"))
(defvar anything-c-source-favorite-commands
  '((name . "favorite commands")
    (candidates-file fc-file-path updating)
    (type . command)))
;; (anything 'anything-c-source-favorite-commands')

 ;;;;;;;;;;;;;;;;;;;;;
 ;; ソースの追加    ;;
 ;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)

 ;;;;;;;;;;;;;;;;;;;;;
 ;; buffer-anything ;;
 ;;;;;;;;;;;;;;;;;;;;;
(defun my-anything ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-buffers+
     anything-c-source-extended-command-history
     anything-c-source-recentf
     anything-c-source-filelist
;;     anything-c-source-emacs-commands
;;     anything-c-source-info-pages
;;     anything-c-source-info-elisp
;;     anything-c-source-man-pages
;;     anything-c-source-locate
;;     anything-c-source-emacs-functions
     )
   "*my-anything* ")
  )

;;;;;;;;;;;;;;;;;;;;;;
;; my-favo-anything ;;
;;;;;;;;;;;;;;;;;;;;;;
(defun my-favo-anything ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-favorite-commands
     )
   "*my-favorite-anything* ")
  )

;;;;;;;;;;;;;;;;;;;;;;
;; anything-C-Occur ;;
;;;;;;;;;;;;;;;;;;;;;;
;;; color-moccur.elの設定
(require 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
(setq moccur-grep-default-word-near-point nil)

;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))
(setq *moccur-buffer-name-exclusion-list*
      '("\.svn" "*Completions*" "*Messages*"))

(require 'anything-c-moccur)
(setq anything-c-moccur-anything-idle-delay 0.2		;anything-idle-delay
      anything-c-moccur-higligt-info-line-flag t	; anything-c-moccur-dmoccurなどのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t		; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t	;anything-c-moccur-occur-by-moccurの起動時にポイントの位置の単語を初期パターンにする
)

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
;; ※重い場合はコメントを外す           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defadvice anything-check-minibuffer-input (around sit-for activate)
;;   (if (sit-for anything-idle-delay t)
;;       ad-do-it)
;;   )
