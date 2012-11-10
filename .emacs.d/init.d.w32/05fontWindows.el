;=======================================
; 初期設定
;=======================================
;(defconst FONT_FAMILY "ＭＳ ゴシック")
;(defconst FONT_SIZE 9)
;(defconst LINE_SPACING 0.2)

;=======================================
; キー定義
;=======================================
(define-key global-map [(C up)] 'bigger-font-size)              ;C-↑でフォントサイズを大きく
(define-key global-map [(C down)] 'smaller-font-size)           ;C-↓でフォントサイズを小さく
(define-key global-map [(C M up)] 'bigger-line-spacing-size)    ;C-M-↑で行間を広く
(define-key global-map [(C M down)] 'smaller-line-spacing-size) ;C-M-↓で行間を狭く

;=======================================
; フォント定義
;=======================================
;[ref]http://d.hatena.ne.jp/itouhiro/20100605
(set-default-font (concat FONT_FAMILY "-" (format "%s" FONT_SIZE)))
(set-fontset-font (frame-parameter nil 'font)
                                    'japanese-jisx0208
                                    (cons FONT_FAMILY "unicode-bmp"))

;====================================
; 行間設定
;====================================
;;整数で指定するとピクセル数で、少数で指定すると
;;行の高さに対して相対値で設定されます。
(setq-default line-spacing LINE_SPACING)

;;;=======================================
;; 動的にフォントサイズを変更する
;;;=======================================
;;フォントサイズ小さく
(defun smaller-font-size ()
	"set the font size smaller than defalut size."
	(interactive )
	(save-size)
	(setq FONT_SIZE (- FONT_SIZE 1.0) )
	(set-default-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE )))
	(resize-frame)
)

;;フォントサイズ大きく
(defun bigger-font-size ()
	"set the font size bigger than defalut size."
	(interactive )
	(save-size)
	(setq FONT_SIZE (+ FONT_SIZE 1.0) )
	(set-default-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE )))
	(resize-frame)
)

;;現在のフレームサイズを保存
(defun save-size ()
	 ""
	(setq fw (* (frame-width) (frame-char-width)))
	(setq fh (* (frame-height) (frame-char-height)))
)
;; フォントサイズを変更した時に
;; 追従してフレームサイズが変わるので
;; フレームサイズを再設定する
(defun resize-frame () ""
	(interactive )
	(setq col (/ fw (frame-char-width) ) )
	(setq row (/ fh (frame-char-height) ) )
	(set-frame-size (selected-frame) col row)
)
;;フレームサイズが変更されたときは保存する
(add-hook 'window-configuration-change-hook '(lambda ()(save-size)))

;=======================================
; 動的に行間を変更する
;=======================================
(defun bigger-line-spacing-size ()
	"set the line spacing size."
	(interactive )
	(setq LINE_SPACING (+ LINE_SPACING 0.1) )
	(setq-default line-spacing LINE_SPACING)
	(message "set the line spacing is %.1f" LINE_SPACING )
)
(defun smaller-line-spacing-size ()
	"set the line spacing size."
	(interactive )
	(setq LINE_SPACING (- LINE_SPACING 0.1) )
	(setq-default line-spacing LINE_SPACING)
	(message "set the line spacing is %.1f" LINE_SPACING )
)

