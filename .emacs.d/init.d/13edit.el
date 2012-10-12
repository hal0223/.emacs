;;;;;;;;;;;;;;
;; 編集関連 ;;
;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; Undo
(global-set-key [(C z)] 'undo)
;; Ctrl-Hでバックスペース
(global-set-key [(C h)] 'backward-delete-char)
;; 拡張kill-ring
(global-set-key [(C M y)] 'browse-kill-ring)
;; 置換
(global-set-key [(C S s)] 'replace-regexp)
;;カーソル位置を変えずにスクロール
(global-unset-key [(C M p)] )
(global-unset-key [(C M n)] )
(global-set-key [(M n)] 'scroll-up-line)
(global-set-key [(M p)] 'scroll-down-line)
;; 指定行へ移動
(global-set-key [(C c)(C l)] 'goto-line)
;; 括弧入力時に、対応する括弧を自動挿入する
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;;;;;;;;;;
;; 設定 ;;
;;;;;;;;;;
;; 拡張kill-ring
(require 'browse-kill-ring)
;; 検索において，大文字・小文字の区別しない．
(setq-default case-fold-search t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Kill-ringをクリップボードへコピー ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(cond (window-system
       (setq x-select-enable-clipboard t)
       )) 
;;自動保存時間を短くする
(setq auto-save-timeout 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 矩形選択ツール
;;  sense-region http://taiyaki.org/elisp/sense-region/ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sense-region)
(sense-region-on)
;;おなじコマンドを連続実行することで挙動を変える
(require 'sequential-command-config)
(global-set-key "\C-a" 'seq-home)
(global-set-key "\C-e" 'seq-end)
(when (require 'org nil t)
  (define-key org-mode-map "\C-a" 'org-seq-home)
  (define-key org-mode-map "\C-e" 'org-seq-end))
(define-key esc-map "u" 'seq-upcase-backward-word)
(define-key esc-map "c" 'seq-capitalize-backward-word)
(define-key esc-map "l" 'seq-downcase-backward-word)
