;=======================================
; 初期設定
;=======================================
;(defconst FONT_FAMILY "ＭＳ ゴシック")
;(defconst FONT_SIZE 9)
;(defconst LINE_SPACING 0.2)

;=======================================
; キー定義
;=======================================
(define-key global-map [(C up)]   'increase-font-size)          ;C-↑でフォントサイズを大きく
(define-key global-map [(C down)] 'decrease-font-size)          ;C-↓でフォントサイズを小さく
(define-key global-map [(C M p)] 'increase-line-spacing)	;C-M-↑で行間を広く
(define-key global-map [(C M n)] 'decrease-line-spacing)	;C-M-↓で行間を狭く

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
;;行の高さに対して相対値で設定される
(setq-default line-spacing LINE_SPACING)

;;;=======================================
;; 動的にフォントサイズを変更する
;;;=======================================
(defun increase-font-size ()
	"increase current font size"
	(interactive )
	(change-font-size t)
)

(defun decrease-font-size ()
	"decrease current font size"
	(interactive )
	(change-font-size nil)
)

;;フォントサイズの変更
(defun change-font-size (toIncrease)
	"change font size."
	(interactive )
	(save-size)
	(if toIncrease 
		(setq FONT_SIZE (+ FONT_SIZE 0.5) )
		(setq FONT_SIZE (- FONT_SIZE 0.5) )
	)
	(set-default-font (concat FONT_FAMILY "-" (format "%.1f" FONT_SIZE )))
	(message (format "font size : %d" FONT_SIZE))
	;; フレームサイズの再設定する
	(setq col (round (/ fw (frame-char-width) ) ))
	(setq row (round (/ fh (frame-char-height) ) ))
	(set-frame-size (selected-frame) col row)
)

;;現在のフレームサイズを保存
(defun save-size ()
	 ""
	(setq fw (* (frame-width) (frame-char-width)))
	(setq fh (* (frame-height) (frame-char-height)))
)

;;フレームサイズが変更されたときは保存する
(add-hook 'window-size-change-hook '(lambda ()(save-size)))

;=======================================
; 動的に行間を変更する
;=======================================
(defun increase-line-spacing ()
	"increase current line spacing"
	(interactive)
	(change-line-spacing t)
)

(defun decrease-line-spacing ()
	"decrease current line spacing"
	(interactive)
	(change-line-spacing nil)
)

(defun change-line-spacing (toIncrease)
	"change line spacing size."
	(interactive )
	(if toIncrease
	    (setq LINE_SPACING (+ LINE_SPACING 0.1) )
	    (setq LINE_SPACING (- LINE_SPACING 0.1) )
	)
	(setq-default line-spacing LINE_SPACING)
	(message "set the line spacing is %.1f" LINE_SPACING )
)

