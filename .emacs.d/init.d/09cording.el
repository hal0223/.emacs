;;;;;;;;;;;;;;
;; 基本設定 ;;
;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;
;; emacs-lisp-mode ;;
;;;;;;;;;;;;;;;;;;;;;
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
;	(outline-minor-mode t)
             (local-set-key (kbd "TAB") 'indent-region)
	     (local-set-key "\C-i" 'org-cycle)
             (local-set-key "\C-@" 'comment-or-uncomment-region)
             (progn
               )))


;; ;; (autoload 'svn-status "dsvn" "Run `svn status'." t)
;; ;; (autoload 'svn-update "dsvn" "Run `svn update'." t)
;; ;;(require 'vc-svn)



;; (require 'psvn)
;; (add-hook 'dired-mode-hook
;;           '(lambda ()
;;              (require 'dired-x)
;;              ;;(define-key dired-mode-map "V" 'cvs-examine)
;;              (define-key dired-mode-map "V" 'svn-status)
;;              (turn-on-font-lock)
;;              ))
;; (setq process-coding-system-alist (cons '("svn" . utf-8) process-coding-system-alist))
;; (setq default-file-name-coding-system 'utf-8)
;; (setq svn-status-svn-file-coding-system 'utf-8)
;; (setq svn-status-verbose nil)
;; (setq svn-status-hide-unmodified t)

;; ;;tortoise-svnを呼び出し
;; (load "tortoise-svn.el")

;; ;;全自動インデント
;; (setq c-uto-newline nil)
;; ;;タブをスペース(4)に展開
;; (setq-default tab-width 4 indent-tabs-mode nil)
;; ;;コーディングスタイル
;; (setq c-default-style "k&r")
;; ;;入力後自動改行
;; (setq c-toggle-auto-newline nil)
;; ;;;;;;;;;;;;;;
;; ;; terminal ;;
;; ;;;;;;;;;;;;;;
;; ;(load "ansi-term.el")
;; ;;;;;;;;;;;;;
;; ;; cc-mode ;;
;; ;;;;;;;;;;;;;
;; (require 'cc-mode)
;; (add-hook 'c++-mode-hook
;;           '(lambda ()
;;              (progn
;;                 ;  (c-toggle-hungry-state 1)
;;                (setq-default tab-width 4nn)
;;                (setq indent-tabs-mode t)
;;                 ;  (c-set-offset 'innamespace 0)
;;                 ;  (c-set-offset 'arglist-close 0)
;;                )))
;; (setq auto-mode-alist
;;       (append
;;        '(("\\.hpp$" . c++-mode)
;;          ("\\.h$"   . c++-mode)
;;          ) auto-mode-alist))

;; ;;; PHP開発で追加しておきたいEmacs Lisp 8選 : アシアルブログ http://blog.asial.co.jp/190
;; ;;;;;;;;;;;;;;
;; ;; php-mode ;;
;; ;;;;;;;;;;;;;;
;; ;;; 設定例
;; (require 'php-mode);(autoload 'php-mode "php-mode")
;; (setq auto-mode-alist
;;       (cons '("\\.php\\'" . php-mode) auto-mode-alist))
;; (setq php-mode-force-pear t)
;; (add-hook 'php-mode-user-hook
;;           '(lambda ()
;; ;;;(setq php-manual-path "/usr/local/share/php/doc/html")
;;              (setq php-manual-url "http://www.phppro.jp/phpmanual/")))

;; ;;;;;;;;;;;;;;
;; ;; css-mode ;;
;; ;;;;;;;;;;;;;;
;; (require 'css-mode);(autoload 'css-mode "css-mode")
;; (setq auto-mode-alist
;;       (cons '("\\.css\\'" . css-mode) auto-mode-alist))
;; (setq cssm-indent-function #'cssm-c-style-indenter)

;; ;;;;;;;;;;;;;;
;; ;; mmm-auto ;;
;; ;;;;;;;;;;;;;;
;; ;;; 設定例
;; (add-to-list 'load-path (concat EMACS_D_DIR "elisp/mmm-mode-0.4.8"))
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)
;; ;(set-face-background 'mmm-default-submode-face nil) ;背景色が不要な場合
;; (mmm-add-classes
;;  '((embedded-css
;;     :submode css-mode
;;     :front "<style[^>]*>"
;;     :back "</style>")))
;; (mmm-add-mode-ext-class nil "\\.html\\'" 'embedded-css)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; C モード等で関数の中括弧（関数等の中身）を 隠したり、表示したりする ;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load-library "hideshow")
;; (require 'hideshow)
;; (autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
;; ;;隠した行は検索しない。
;; (setq search-invisible nil)
;; ;; コメントは、隠さず表示する。
;; (setq hs-hide-comments-when-hiding-all t)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; GNU GLOBAL(gtags)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'gtags-mode "gtags" "" t)
;; (setq gtags-mode-hook
;;       '(lambda ()
;;          (local-set-key "\M-e" 'gtags-find-tag)
;;          (local-set-key "\M-r" 'gtags-find-rtag)
;;          (local-set-key "\M-s" 'gtags-find-symbol)
;;          (local-set-key "\C-t" 'gtags-pop-stack)
;;          ))
;; ;; c-modeで自動的にgtags-modeに切り替える
;; (add-hook 'c++-mode-common-hook
;;           '(lambda ()
;;              (gtags-mode 1)
;;              (gtags-make-complete-list)
;;              (local-unset-key  "\C-t")
;;              ))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 自動的に対応する括弧を挿入する 　;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'parenthesis)
;; (defun myfunc (name)
;;   (let ((modehook (intern (concat name "-mode-hook"))))
;;     (add-hook modehook
;;               (lambda ()
;;                 (define-key (current-local-map) "{" 'parenthesis-insert-braces)
;;                 (define-key (current-local-map) "(" 'parenthesis-insert-parens)
;;                 (define-key (current-local-map) "\'" 'parenthesis-insert-single-quotation)
;;                 (define-key (current-local-map) "\"" 'parenthesis-insert-double-quotation)
;;                 (define-key (current-local-map) "[" 'parenthesis-insert-brackets)
;;                 ))))
;; (setq parenthesis-add-language  '("javascript" "js" "c++" "php" "py" "text" "emacs-lisp" "c"))
;; (let ((x parenthesis-add-language))
;;   (while (car x)
;;     (myfunc (car x))
;;     (setq x (cdr x))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; リアルタイム文法チェック ;;コンパイルのタイミングは自動保存と保存時みたい
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;http://d.hatena.ne.jp/suztomo/20080905/1220633281
;; ;;http://d.hatena.ne.jp/khiker/20070630/emacs_ruby_flymake
;; ;;http://d.hatena.ne.jp/khiker/20070720/emacs_flymake
;; ;; [参考]]Flymakeのススメ（PHP版 , JS版） http://openlab.dino.co.jp/2008/08/05/223548324.html
;; ;; flymake (Emacs22から標準添付されている)
;; (when (require (quote flymake) nil t)
;;   (global-set-key [(C c)(C d)] (quote flymake-display-err-menu-for-current-line))

;;   ;; C用設定
;;   (defun flymake-c-init ()
;;     (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                          (quote flymake-create-temp-inplace)))
;;            (local-file  (file-relative-name
;;                          temp-file
;;                          (file-name-directory buffer-file-name))))
;;       (list "gcc" (list  local-file "-o" "tmp" ))))
;;   (push '("\\.c$" flymake-c-init) flymake-allowed-file-name-masks)

;;   ;; C++用設定
;;   (defun flymake-c++-init ()
;;     (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                          (quote flymake-create-temp-inplace)))
;;            (local-file  (file-relative-name
;;                          temp-file
;;                          (file-name-directory buffer-file-name))))
;;       (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
;;   (push '("\\.cpp$" flymake-c++-init) flymake-allowed-file-name-masks)
;;   (push '("\\.hpp$" flymake-c++-init) flymake-allowed-file-name-masks)

;;   ;; PHP用設定
;;   (when (not (fboundp (quote flymake-php-init)))
;;     (defun flymake-php-init ()
;;       (let* ((temp-file   (flymake-init-create-temp-buffer-copy
;;                            (quote flymake-create-temp-inplace)))
;;              (local-file  (file-relative-name
;;                            temp-file
;;                            (file-name-directory buffer-file-name))))
;;         (list "php" (list "-f" local-file "-l"))))
;;     (setq flymake-allowed-file-name-masks
;;           (append
;;            flymake-allowed-file-name-masks
;;            (quote (("\.php[345]?$" flymake-php-init)))))
;;     (setq flymake-err-line-patterns
;;           (cons
;;            (quote ("\(\(?:Parse error\|Fatal error\|Warning\): .*\) in \(.*\) on line \([0-9]+\)" 2 3 nil 1))
;;            flymake-err-line-patterns))
;;     )
;;   ;; JavaScript用設定
;;   (when (not (fboundp (quote flymake-javascript-init)))
;;     (defun flymake-javascript-init ()
;;       (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                          (quote flymake-create-temp-inplace)))
;;              (local-file (file-relative-name
;;                           temp-file
;;                           (file-name-directory buffer-file-name))))
;;         ;;(list "js" (list "-s" local-file))
;;         (list "jsl" (list "-process" local-file))))
;;     (setq flymake-allowed-file-name-masks
;;           (append
;;            flymake-allowed-file-name-masks
;;            (quote (("\.json$" flymake-javascript-init)
;;                    ("\.js$" flymake-javascript-init)))))
;;     (setq flymake-err-line-patterns
;;           (cons
;;            (quote ("\(.+\)(\([0-9]+\)): \(?:lint \)?\(\(?:warning\|SyntaxError\):.+\)" 1 2 nil 3))
;;            flymake-err-line-patterns))
;;     )
;; )

;; ;;背景色の変更
;; (custom-set-faces
;;  '(flymake-errline ((((class color)) (:background "pink"))))
;;  '(flymake-warnline ((((class color)) (:background "blue")))))

;; ;;ミニバッファにエラーメッセージ表示
;; (defun flymake-display-err-minibuf () 
;;   "Displays the error/warning for the current line in the minibuffer"
;;   (interactive)
;;   (let* ((line-no             (flymake-current-line-no))
;;          (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;;          (count               (length line-err-info-list))
;;          )
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;;                (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;;                (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;;                (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;;           (message "[%s] %s" line text)
;;           )
;;         )
;;       (setq count (1- count)))))

;; ;;;;;;;;;;;;;;;;;;;
;; ;; 共通部分hoook ;;
;; ;;;;;;;;;;;;;;;;;;;
;; (dolist (hook (list
;; ;               'emacs-lisp-mode-hook
;;                'lisp-mode-hook
;;                ;; 'c-mode-hook
;;                ;; 'c++-mode-hook
;;                'php-mode-hook
;;                'js-mode-hook
;;                'sh-mode-hook
;;                ))
;;   (add-hook hook (lambda() 
;;                    (flymake-mode t)
;;                    (local-set-key [(C c)(C o)] 'flymake-display-err-minibuf)
;;                    (local-set-key [(C c)(C c)] 'compile)
;;                    (local-set-key [(C c)(C f)] 'ff-find-other-file)
;;                    (local-set-key [(C @)] 'comment-or-uncomment-region)
;;                    (local-set-key [(C i)] 'indent-region)
;;                    (hs-minor-mode t)
;;                    ;;(local-set-key "\t" 'c-indent-line-or-region)TODO:regionがなければこちらを
;;                    ;;(define-key c++-mode-map "\C-i" (make-sparse-keymap))
;;                    ))
;;   )

;; ;;;;;;;;;;;;;;;
;; ;; yasnippet ;;
;; ;;;;;;;;;;;;;;;
;; ;; [参考]yasnippet を導入してみた - gan2 の Ruby 勉強日記 
;; ;;----http://d.hatena.ne.jp/gan2/20080402/1207135480
;; ;; [参考] http://d.hatena.ne.jp/antipop/20080321/1206090430

;; ;; (add-to-list 'load-path (concat EMACS_D_DIR "plugins/yasnippet-x.y.z") )
;; ;; (require 'yasnippet) ;; not yasnippet-bundle

;; ;; ;; メニューは使わない
;; ;; (setq yas/use-menu t)

;; ;; ;; コメントやリテラルではスニペットを展開しない
;; ;; (setq yas/buffer-local-condition
;; ;;       '(or (not (or (string= "font-lock-comment-face"
;; ;;                              (get-char-property (point) 'face))
;; ;;                     (string= "font-lock-string-face"
;; ;;                              (get-char-property (point) 'face))))
;; ;;            '(require-snippet-condition . force-in-comment)))
;; ;; ;; 複数のディレクトリからスニペットを読み込む。
;; ;; ;; yasnippet の snippet を置いてあるディレクトリ
;; ;; (setq yas/root-directory (expand-file-name (concat EMACS_D_DIR "plugins/yasnippet-x.y.z/snippets")))
;; ;; ;; 自分用スニペットディレクトリ(リストで複数指定可)
;; ;; (defvar my-snippet-directories
;; ;;   (list (expand-file-name (concat EMACS_D_DIR "plugins/yasnippet-x.y.z/my_snippets")) ))
;; ;; ;; yasnippet 公式提供のものと、
;; ;; ;; 自分用カスタマイズスニペットをロード同名のスニペットが複数ある場合、
;; ;; ;; あとから読みこんだ自分用のものが優先される。
;; ;; ;; また、スニペットを変更、追加した場合、
;; ;; ;; このコマンドを実行することで、変更・追加が反映される。
;; ;; (defun yas/load-all-directories ()
;; ;;   (interactive)
;; ;;   (yas/reload-all)
;; ;;   (mapc 'yas/load-directory-1 my-snippet-directories))
;; ;; ;;; yasnippet展開中はflymakeを無効にする
;; ;; (defvar flymake-is-active-flag nil)
;; ;; (defadvice yas/expand-snippet
;; ;;   (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
;; ;;   (setq flymake-is-active-flag
;; ;;         (or flymake-is-active-flag
;; ;;             (assoc-default 'flymake-mode (buffer-local-variables))))
;; ;;   (when flymake-is-active-flag
;; ;;     (flymake-mode-off)))
;; ;; (add-hook 'yas/after-exit-snippet-hook
;; ;;           '(lambda ()
;; ;;              (when flymake-is-active-flag
;; ;;                (flymake-mode-on)
;; ;;                (setq flymake-is-active-flag nil))))
;; ;; ;; yasnippet の anything インターフェース anything-c-yasnippet
;; ;; ;; http://d.hatena.ne.jp/IMAKADO/20080324/1206370301
;; ;; (require 'anything-c-yasnippet)
;; ;; (setq anything-c-yas-space-match-any-greedy t)
;; ;; ;; anything-c-yasnippet を使うモードの登録
;; ;; ;; (add-to-list 'yas/extra-mode-hooks 'c++-mode-hook)
;; ;; ;; (add-to-list 'yas/extra-mode-hooks 'c-mode-hook)
;; ;; ;; (add-to-list 'yas/extra-mode-hooks 'ruby-mode-hook)
;; ;; ;; (add-to-list 'yas/extra-mode-hooks 'cperl-mode-hook)

;; ;; ;(setq yas/next-field-key (kbd "TAB"))
;; ;; ;; トリガはSPC, 次の候補への移動はTAB
;; ;; (setq yas/trigger-key (kbd "SPC"))
;; ;; (setq yas/next-field-key (kbd "TAB"))

;; ;; ;; yasnippet の初期化
;; ;; (yas/initialize)
;; ;; (yas/load-all-directories)

;; ;; (define-key yas/minor-mode-map [(C c) (C t)] 'yas/insert-snippet)
;; ;; (global-set-key [(C c)(C s)] 'anything-c-yas-complete)
