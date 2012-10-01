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
(defun bigger-font-size ()
	"set the font size bigger than defalut size."
	(interactive )
	(setq FONT_SIZE (+ FONT_SIZE 0.5) )
	(set-default-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE )))
	(message "set the  font sizeis %.1f" FONT_SIZE )
)

(defun smaller-font-size ()
	"set the font size smaller than defalut size."
	(interactive )
	(setq FONT_SIZE (- FONT_SIZE 0.5) )
	(set-default-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE ) ))
	(message "set the font size is %.1f" FONT_SIZE )
)

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

