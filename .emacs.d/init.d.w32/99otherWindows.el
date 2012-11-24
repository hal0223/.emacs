;=======================================
; Cygwin
;======================================
 (setq exec-path (cons CYGWIN_PATH exec-path))
 ;;Cygwinをパスに通す
 (setenv "PATH" (concat CYGWIN_PATH (getenv "PATH")))
 ;; cygwinをマウント ;;
(require 'cygwin-mount)
(cygwin-mount-activate)

;(require 'multi-term)
;(setq explicit-shell-file-name (concat CYGWIN_PATH "/bash.exe"))


;; (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
;; (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt nil t)


;; ;(setenv "SHELL"  (concat CYGWIN_PATH "/bash.exe"))
;; ;; For subprocesses invoked via the shell
;; ;; (e.g., "shell -c command")
;; (setq shell-file-name explicit-shell-file-name)

;; ;; ;; Shell 名の設定
;; ;; (setq shell-file-name (skt:shell))

;; ;; (setq explicit-shell-file-name shell-file-name)

;; ;; (set-language-environment  'utf-8)
;; (prefer-coding-system 'utf-8)

;; ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ;; (global-set-key (kbd "C-c t") '(lambda ()
;; ;;                                 (interactive)
;; ;;                                 (term shell-file-name)))

;=======================================
; その他
;======================================
;; isearchで日本語検索をする
(defun w32-isearch-update ()
  (interactive)
  (isearch-update))
(define-key isearch-mode-map [compend] 'w32-isearch-update)
(define-key isearch-mode-map [kanji] 'isearch-toggle-input-method)

;; これは、Java アプリケーションの出力に出現する
;; 見苦しい ^M 文字を削除します。
(add-hook 'comint-output-filter-functions
          'comint-strip-ctrl-m)

;;警告音を消す
(setq visible-bell nil)
;;ビープ音を抑制
(setq ring-bell-function '(lambda ()))

;;;Windowsのリンク機能を使う
(setq w32-symlinks-handle-shortcuts t)
(require 'w32-symlinks)


 ;; save後，cygwin におけるファイル属性を rw-r--r-- にする ;;
 (defvar cygwin-umask
   (string-to-int
    (shell-command-to-string "printf %d 0`umask`"))
   "cygwin 上で設定された umask の値")
 (defun cygwin-correct-file-mode ()
   "シェルスクリプトならばファイルモードを 777、それ以外ならば 666 に設定する。
 その際、シェルの umask を参照するので、実際は 755 や 644 などになると思われる。"
   (interactive)
   (save-restriction
     (widen)
     (let* ((shell-script-p
             (string= "#!" (buffer-substring 1 (min 3 (point-max)))))
            (mode (logand (if shell-script-p #o777 #o666)
                          (lognot cygwin-umask)))
            (command (format "chmod %03o %s" mode (buffer-file-name))))
       (if (not (and (boundp 'cygwin-file-modes)
                     (eq cygwin-file-modes mode)))
           (progn
             (make-local-variable 'cygwin-file-modes)
             (shell-command-to-string command)))
       (setq cygwin-file-modes mode)
       (message (format "Wrote %s (mode %03o)" (buffer-file-name) mode)))))

 (add-hook 'after-save-hook 'cygwin-correct-file-mode)
