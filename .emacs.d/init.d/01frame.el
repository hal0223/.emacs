;;;;;;;;;;;;;;;;;;;;;;
;; フレーム表示関連 ;;
;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;;[C-7]透明化解除
(global-set-key (kbd "C-7") (lambda() (interactive) (my-gradual-modify-transparency)))
;;[C-8]透明化
(global-set-key (kbd "C-8") (lambda() (interactive) (my-gradual-modify-transparency t)))

;;;;;;;;;;;;;;;;;;;;;;;;
;; 初期フレームの設定 ;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;幅3ポイントの縦棒カーソル
(add-to-list 'default-frame-alist '(cursor-type . bar))
;; tool-bar を消す
(tool-bar-mode 0)
;; スタートアップメッセージを消す
(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;
;; 透明度の調整 ;;
;;;;;;;;;;;;;;;;;;
;; デフォルトの透明度を設定する (85%)
;(add-to-list 'default-frame-alist '(alpha . 85))
(setq frame-alpha-lower-limit 0)
(setq my-transparency-modification-interval 7)
(defun my-gradual-modify-transparency (&optional dec)
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
         (oldalpha (if alpha-or-nil alpha-or-nil 100))
         (tm (if dec (- oldalpha my-transparency-modification-interval)
               (+ oldalpha my-transparency-modification-interval)))
         (newalpha (if (< tm frame-alpha-lower-limit) frame-alpha-lower-limit
                     (if (> tm 100) 100 tm))))
    (modify-frame-parameters nil (list (cons 'alpha newalpha)))))

(defun my-set-transparency (x)
  (modify-frame-parameters nil (list (cons 'alpha x))   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; デフォルトウィンドウ表示サイズ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO 変数で指定できるようにしたい
;; (defconst LOCATION_Y 0)
;; (defconst LOCATION_X 4)
;; (defconst COL_NUM 200)
;; (defconst ROW_NUM 60)

;; (setq initial-frame-alist
;;       (append
;;        '(
;;          (cons (top '(format "%d" LOCATION_Y)))  ; フレームの左上座標Y(pixel)
;;          (cons (left '(foprmat "%d" LOCATION_X))) ; フレームの左上座標X(pixel)
;;          (cons (width '(format "%d" COL_NUM )))  ; フレーム幅(列数)
;;          (cons (height '(format "%d" ROW_NUM)))  ; フレーム高(行数)
;;          )
;;        initial-frame-alist)
;; )
