;;;;;;;;;;;;;;;;;
;; diredの拡張 ;;
;;;;;;;;;;;;;;;;;
(load "dired-x")

;;;;;;;;;;;;;;;;;;
;; キーバインド ;;
;;;;;;;;;;;;;;;;;;
;; dired編集モード(wdired)に入る
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
;; ファイルの移動
(define-key dired-mode-map "\S-r" 'dired-do-rename)
(define-key dired-mode-map "\S-m" 'dired-do-rename)
;; 新規バッファを作らずにディレクトリを開く
(define-key dired-mode-map "m" 'dired-my-advertised-find-file)
(define-key dired-mode-map "\C-m" 'dired-my-advertised-find-file)
;; 上の階層に移動
(define-key dired-mode-map "c" 'dired-my-up-directory)
(define-key dired-mode-map "^" 'dired-my-up-directory)
;; C-tでバッファを移動
(define-key dired-mode-map "\C-t" 'other-window)
;; [Windowsのみ]関連付けられたソフトで開く 
(if (equal system-type 'windows-nt)
    (define-key dired-mode-map "z" 'dired-fiber-find)
)
;; ソートする
(add-hook 'dired-mode-hook
           '(lambda ()
              (define-key dired-mode-map "s"
                '(lambda ()
                   (interactive)
                   (anything '(anything-c-source-dired-various-sort))))
              )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 設定                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://d.hatena.ne.jp/kakurasan/20070702/p1
(require 'ls-lisp)
(setq ls-lisp-dirs-first t)
;; ディレクトリを再帰的にコピー可能にする
(setq dired-recursive-copies 'always)
;; ディレクトリを再帰的に削除可能にする(使用する場合は注意)
(setq dired-recursive-deletes 'always)
;; lsのオプション 「l」(小文字のエル)は必須
(setq dired-listing-switches "-laFh ")
;; find-dired/find-grep-diredで、条件に合ったファイルをリストする形式
(setq find-ls-option '("-print0 | xargs -0 ls -Flhatd"))

;;;;;;;;;;;;;;;;;;
;; 関数         ;;
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [Windowsのみ]dired から関連付けられたソフトで開く ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-fiber-find ()
  (interactive)
  (let ((file (dired-get-filename)))
  (message "Opening %s..." file)
  (if (equal system-type 'windows-nt)
  (call-process "cmd.exe" nil 0 nil "/c" "start" "" (convert-standard-filename file)))
  (message "Opening %s...done" file)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired でディレクトリを移動しても，新しいバッファを作成しないように ;;
;;http://www.bookdhelf.jp/soft/meadow_25.html#SEC279
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun dired-my-advertised-find-file ()
  (interactive)
  (let ((kill-target (current-buffer))
        (check-file (dired-get-filename)))
    (funcall 'dired-advertised-find-file)
    (if (file-directory-p check-file)
        (kill-buffer kill-target))))

(defun dired-my-up-directory (&optional other-window)
  "Run dired on parent directory of current directory.
Find the parent directory either in this buffer or another buffer.
Creates a buffer if necessary."
  (interactive "P")
  (let* ((dir (dired-current-directory))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (if other-window
              (dired-other-window up)
            (progn
              (kill-buffer (current-buffer))
              (dired up))
          (dired-goto-file dir))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Diredで様々なソートに切り替える ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar dired-various-sort-type
  '(("S" . "size")
    ("X" . "extension")
    ("v" . "version")
    ("t" . "date")
    (""  . "name")))

(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Hehe"
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))

(defvar anything-c-source-dired-various-sort
  '((name . "Dired various sort type")
    (candidates . (lambda ()
                    (mapcar (lambda (x)
                              (cons (concat (cdr x) " (" (car x) ")") x))
                            dired-various-sort-type)))
    (action . (("Set sort type" . (lambda (candidate)
                                    (dired-various-sort-change dired-various-sort-type candidate)))))
    ))
