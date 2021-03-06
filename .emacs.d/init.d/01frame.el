﻿;;;;;;;;;;;;;;;;;;;;;;
;; フレーム表示関連 ;;
;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;;透明化解除
(global-set-key (kbd "C-7") (lambda() (interactive) (my-gradual-modify-transparency)))
;;透明化
(global-set-key (kbd "C-8") (lambda() (interactive) (my-gradual-modify-transparency t)))
;; ウィンドウ移動
(global-set-key  [(C t)] 'other-window)
;; ウィンドウ削除
(define-key global-map (kbd "C-0") 'delete-window)
;; フォーカスウィンドウ以外を削除
(define-key global-map (kbd "C-1") 'delete-other-windows)
;; ウィンドウを横に分割
(define-key global-map (kbd "C-2") 'split-window-below)
;; ウィンドウを縦に分割
(define-key global-map (kbd "C-3") 'split-window-right)

;;;;;;;;;;;;;;;;;;
;; 設定         ;;
;;;;;;;;;;;;;;;;;;
;; 起動時のフレームサイズと位置
(setq initial-frame-alist
      (append
       (list
         (cons 'top LOCATION_Y)		; フレームの左上座標Y(pixel)
         (cons 'left LOCATION_X)	; フレームの左上座標X(pixel)
         (cons 'width COL_NUM)		; フレーム幅(列数)
         (cons 'height ROW_NUM)		; フレーム高(行数)
         )
       initial-frame-alist)
)

;;幅3ポイントの縦棒カーソル
(add-to-list 'default-frame-alist '(cursor-type . bar))
;; tool-bar を消す
(tool-bar-mode 0)
;; スタートアップメッセージを消す
(setq inhibit-startup-message t)
;; 行折り返しマークの設定を右のみに表示
(set-fringe-style   `(0) )
;;;;;;;;;;;;;;;;;;
;; 透明度の調整 ;;
;;;;;;;;;;;;;;;;;;
;; デフォルトの透明度を設定する (85%)
;;(add-to-list 'default-frame-alist '(alpha . 85))
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

