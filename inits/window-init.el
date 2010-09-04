;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;      Emacs config
;;
;;


;;画面を 2 分割したときの 上下を入れ替える swap screen
;;というのが PF 何番かにわりあてられていました。
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f5] 'swap-screen)
(global-set-key [S-f5] 'swap-screen-with-cursor)


(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )

    (switch-to-buffer-other-window other-buf)
    (other-window -1)))

(global-set-key [f6] 'window-toggle-division)



;;EOFを表示
(defun set-buffer-end-mark()
  (let ((overlay (make-overlay (point-max) (point-max))))
    (overlay-put overlay 'before-string #("[EOF]" 0 5 (face highlight)))
    (overlay-put overlay 'insert-behind-hooks
                 '((lambda (overlay after beg end &optional len)
                     (when after
                       (move-overlay overlay (point-max) (point-max))))))))
(add-hook 'find-file-hooks 'set-buffer-end-mark)

;; ウィンドウを縦分割したときも折り返す設定
(setq truncate-partial-width-windows nil)

;;   左側に行数表示
;; (require 'linum nil t)
(global-linum-mode) ; すべてのバッファに対し、起動時に表示


;;;
;; Config window

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)


;;;;;;;;
;;
;;  フレームの初期値
;;
(setq initial-frame-alist
      '((foreground-color . "gray")
        (background-color . "black")
        (cursor-color . "blue")
        (height . 100) ; Emacsがディスプレーの高さにあわせてくれるため、大きい数字を与えておく
        (top    . 0)
        (alpha  . (85 70)))) ; 透明度 (active inactive)

;; 環境毎の設定
(when (string= system-name "imac.lan")
  (progn
    (add-to-list 'initial-frame-alist '(width . 245))
    (add-to-list 'initial-frame-alist '(left  . 165))))

(when (string= system-name "MacBook.local")
  (progn
    (add-to-list 'initial-frame-alist '(width . 170))
    (add-to-list 'initial-frame-alist '(left  . 50))))


;;; カーソルの点滅を止める
(blink-cursor-mode 0)

;; カーソル行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray15")) ;dark slate gray
    (((class color)
      (background light))
     (:background "gray15")) ;ForestGreen
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)




;;; toolバーを消す
(tool-bar-mode 0)
;;; フレームのタイトル指定
;;タイトルバーにファイル名とディレクトリ名の表示
(setq frame-title-format '((buffer-file-name "%f" (dired-mode-p default-directory mode-line-buffer-identification))))

;;; カーソルの位置
;; 何文字目かを表示する
(column-number-mode t)
;; 何行目かを表示する
(line-number-mode t)

;;=======================================================================
;; 対応する括弧を光らせる
;;=======================================================================
(show-paren-mode t)

;;=======================================================================
;; リージョンに色を付ける
;;=======================================================================
(setq transient-mark-mode t)



(require 'highlight-symbol)

(setq-default highlight-symbol-mode t)

;; (global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-prev)



;;; 起動時のメッセージを打ち出さないようにする
(setq inhibit-startup-message t)


;; diffのカラー表示
(add-hook 'diff-mode-hook
          (lambda ()
            (set-face-foreground 'diff-context-face "grey50")
            (set-face-background 'diff-header-face "black")
            (set-face-underline-p 'diff-header-face t)
            (set-face-foreground 'diff-file-header-face "MediumSeaGreen")
            (set-face-background 'diff-file-header-face "black")
            (set-face-foreground 'diff-index-face "MediumSeaGreen")
            (set-face-background 'diff-index-face "black")
            (set-face-foreground 'diff-hunk-header-face "plum")
            (set-face-background 'diff-hunk-header-face"black")
            (set-face-foreground 'diff-removed-face "pink")
            (set-face-background 'diff-removed-face "gray5")
            (set-face-foreground 'diff-added-face "light green")
            (set-face-foreground 'diff-added-face "white")
            (set-face-background 'diff-added-face "SaddleBrown")
            (set-face-foreground 'diff-changed-face "DeepSkyBlue1")))


(setq c-tab-always-indent t)
(setq-default tab-width 2)
(setq indent-line-function 'indent-relative-maybe) ; 前と同じ行の幅にインデント

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")


;; Shift + カーソルキーでバッファ移動
(setq windowmove-wrap-around t)
(windmove-default-keybindings)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 ;; '(gud-gdb-command-name "gdb --annotate=1")
 '(inhibit-startup-screen t)
 ;;'(clojure-inferior-lisp-program "/opt/local/share/java/clojure-contrib/launchers/bash/clj-env-dir"))
 ;; clojure

 ;; '(large-file-warning-threshold nil)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

