;;;;;;;;;;;;;;;;;;
;; バッファ関連 ;;
;;;;;;;;;;;;;;;;;;
;; バッファ再読込
(global-set-key [F5] 'revert-buffer)
;; バッファー削除
(define-key global-map (kbd "M-k") 'kill-this-buffer)
(global-set-key [C-f4] 'kill-this-buffer) 
;; バッファーのelisp評価
(global-set-key [(C j)] 'eval-buffer)
;; バッファサイズ変更
(define-key global-map [(S M n)] 'enlarge-window)
(define-key global-map [(S M p)] 'shrink-window)
(define-key global-map [(S M f)] 'enlarge-window-horizontally)
(define-key global-map [(S M b)] 'shrink-window-horizontally)
;;行折り返し
(global-set-key [(C c)(C r)] 'toggle-truncate-lines)

(setq default-major-mode 'text-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scratchバッファの内容を保持する ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'scratch-log.el)
;;scratchログファイルのパスを設定
(setq sl-scratch-log-file (concat EMACS_D_DIR ".scratch_log"))

;;;;;;;;;;;;;;;;;;;;
;; backup-files   ;;
;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name (concat EMACS_D_DIR "backup")))
    backup-directory-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2分割したバッファを入れ替える    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ウィンドウ入れ替え
;; (global-set-key [f2] 'swap-screen)
;; (defun swap-screen()
;;   "Swap two screen,leaving cursor at current window."
;;   (interactive)
;;   (let ((thiswin (selected-window))
;;         (nextbuf (window-buffer (next-window))))
;;     (set-window-buffer (next-window) (window-buffer))
;;     (set-window-buffer thiswin nextbuf)))
;; (defun swap-screen-with-cursor()
;;   "Swap two screen,with cursor in same buffer."
;;   (interactive)
;;   (let ((thiswin (selected-window))
;;         (thisbuf (window-buffer)))
;;     (other-window 1)
;;     (set-window-buffer thiswin (window-buffer))
;;     (set-window-buffer (selected-window) thisbuf)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; バッファー情報保存 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'windows)
;;;(win:startup-with-window)
;;;(define-key ctl-x-map "C" 'see-you-again)
;;; 新規にフレームを作らない
;; (setq win:use-frame nil)
;; (win:startup-with-window)
;; (define-key ctl-x-map "C" 'see-you-again)
;; (global-set-key "\C-^" 'resume-windows )
