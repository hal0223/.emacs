;;;;;;;;;;;;;;;;;;;;;;;;
;; ハイライト設定     ;;
;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 各フェイスの色設定               ;;
;; (ref.) M-x, list-faces-display ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-background-color "whilte")
(set-face-foreground 'modeline "white")             ; アクティブバッファのモードライン文字色
(set-face-background 'modeline "tomato")            ; アクティブバッファのモードライン色
(set-face-background 'mode-line-buffer-id "white")  ; バッファ名の背景色
(set-face-foreground 'mode-line-buffer-id "black") ; バッファ名の背景色
(set-face-background 'modeline-inactive "gray80")   ; 非アクティブバッファのモードライン色
(custom-set-faces '(mode-line ((t (:background "tomato" :foreground "white" :box (:line-width -1 :color "tomato"))))))

;;;;;;;;;;;;;;;;;;;;;;;;
;; 対応する括弧の強調 ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)
(setq show-paren-style 'mixed)
(set-face-foreground 'show-paren-match-face "orange red") ;文字色
(set-face-background 'show-paren-match nil)               ;背景色
(setq show-paren-style 'expression)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 選択範囲を色付きにする   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(transient-mark-mode t)
(set-face-background 'region "LightSteelBlue1")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 全角スペース，タブ文字，行末スペースを強調表示する ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (defface my-face-b-1 '((t (:background "#eeeeee"))) nil)
 (defface my-face-b-2 '((t (:background "#eeeeee"))) nil)
 (defface my-face-u-1 '((t (:foreground "gainsboro" :underline t))) nil)
 (defvar my-face-b-1 'my-face-b-1)
 (defvar my-face-b-2 'my-face-b-2)
 (defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;;(set-face-background 'region "dark slate gray")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 編集行を目立たせる                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray7"))
    (((class color)
      (background light))
     (:background "antique white"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
 (global-hl-line-mode)
