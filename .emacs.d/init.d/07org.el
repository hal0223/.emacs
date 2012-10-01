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

;;org-mode起動時のhook処理
(add-hook 'org-mode-hook
          (lambda ()
            ;;同時にONにするモード
            (org-indent-mode t) ;インデントモードを有効化
            (iimage-mode t)     ;iimodeで画像表示モードを有効化
            )
          t)

;;TODO項目完了時の記録
(setq org-log-done t)
