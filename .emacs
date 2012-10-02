;=======================================
; 定数設定
;=======================================
; .emacs.dディレクトリパスの指定
(defconst EMACS_D_DIR "C:/Dropbox/.emacs.d/.emacs.d/")
;CygwinのPath
(defconst CYGWIN_PATH "C:/cygwin/bin")
(defconst FONT_FAMILY "ＭＳ ゴシック")	;;フォントファミリ
(defconst FONT_SIZE 9)			;;フォントサイズ
(defconst LINE_SPACING 0.2)		;;行間
; 起動時のフレームサイズと位置
(defconst LOCATION_Y 0)		;; フレームの左上座標Y(pixel)
(defconst LOCATION_X 80)	;; フレームの左上座標X(pixel)
(defconst COL_NUM 100)		;; フレーム幅(列数)
(defconst ROW_NUM 50)		;; フレーム高(行数)

;=======================================
; ロードパスの追加
;=======================================
(add-to-list 'load-path EMACS_D_DIR )
(add-to-list 'load-path (concat EMACS_D_DIR "elisp"))

;=======================================
; デバッガー
;=======================================
;(setq debug-on-error t)

;=======================================
; ファイルリスト更新スクリプト
;=======================================
;; cd 0.working/.emacs.d/elisp/anything-config/exte
;; ruby make-filelist.rb > ../all.filelist

;=======================================
; .elファイル読み込み ;;
;=======================================
;;全OS共通.elファイル読み込み （~/EMACS_D_DIR/init.d/*.el）
(let* ((dir (concat EMACS_D_DIR "init.d/" ))
       (el-suffix "\\.el\\'")
       (files (mapcar
               (lambda (path) (replace-regexp-in-string el-suffix "" path))
               (directory-files dir t el-suffix))))
  (while files
    (load (car files))
    (setq files (cdr files))))

;;各OS専用.elファイル読み込み（~/EMACS_D_DIR/init.d.XXX/*.el）
(let* ((dir (concat EMACS_D_DIR "init.d." (prin1-to-string window-system) "/" ))
       (el-suffix "\\.el\\'")
       (files (mapcar
               (lambda (path) (replace-regexp-in-string el-suffix "" path))
               (directory-files dir t el-suffix))))
  (while files
    (load (car files))
    (setq files (cdr files))))

;=======================================
; ref
;=======================================
;;Re: .emacs分割のすゝめ  http://d.hatena.ne.jp/holidays-l/20101125/p1
;でらうま倶楽部 : 今風のEmacsの設定ってどんな風？ 
;http://blog.livedoor.jp/tek_nishi/archives/2524700.html

