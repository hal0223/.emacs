;;;;;;;;;;;;;;
;; org-mode ;;
;;;;;;;;;;;;;;
;;orgモード
(require 'org)

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;カレントノードのレベルを上げる (ref.)サブノードも含む場合は C-M-→
(define-key org-mode-map [(meta f)] 'org-metaright)
;カレントノードのレベルを下げる (ref.)サブノードも含む場合は C-M-←
(define-key org-mode-map [(meta b)] 'org-metaleft)
;同レベルのセクションを下に作成
(define-key org-mode-map [(M m)] 'org-meta-return)
;折りたたみの切り替え
(define-key org-mode-map "\C-i" 'org-cycle)
;リストアップされているアイテムへ移動
;(define-key org-mode-map "\M-f" 'org-next-item)
;(define-key org-mode-map "\M-b" 'org-previous-item)
;同じレベルへ移動
(define-key org-mode-map "\M-n" 'org-forward-same-level)
(define-key org-mode-map "\M-p" 'org-backward-same-level)

;; 括弧入力時に、対応する括弧を自動挿入する
(define-key org-mode-map (kbd "(") 'skeleton-pair-insert-maybe)
(define-key org-mode-map (kbd "{") 'skeleton-pair-insert-maybe)
(define-key org-mode-map (kbd "[") 'skeleton-pair-insert-maybe)
(define-key org-mode-map (kbd "\"") 'skeleton-pair-insert-maybe)
(define-key org-mode-map (kbd "'") 'skeleton-pair-insert-maybe)
;; 行頭へ
(define-key org-mode-map "\C-a" 'org-seq-home)
;; 行末へ
(define-key org-mode-map "\C-e" 'org-seq-end)

;;;;;;;;;;
;; 設定 ;;
;;;;;;;;;;

;;org-mode起動時のhook処理
(add-hook 'org-mode-hook
	(lambda ()
	;;同時にONにするモード
	(org-indent-mode t) ;インデントモードを有効化
	(iimage-mode t)     ;iimodeで画像表示モードを有効化
	)
)

;;TODO項目完了時の記録
(setq org-log-done t)
