
;;;;;;
;;
;;  言語設定

(set-language-environment 'Japanese)
(require 'ucs-normalize)

(let ((coding-sym
			 (if (string= window-system "ns") 'utf-8-nfd 'utf-8)))
	(prefer-coding-system coding-sym)
	(setq file-name-coding-system coding-sym)
	(setq locale-coding-system coding-sym))

;; (set-default-coding-systems 'sjis-mac)
;; (set-default-coding-systems 'utf-8)
;; (set-clipboard-coding-system 'sjis-mac)
;; (set-buffer-file-coding-system 'sjis-mac)
;; (setq-default buffer-file-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'sjis-mac)
;; (setq default-input-method "MacOSX")
;; (utf-translate-cjk-mode 1)
;; 日本語infoの文字化け防止
;; (auto-compression-mode t)
;; (setq Info-directory-list
;;     (list "/usr/local/share/info" "/Applications/Emacs.app/Contents/Resources/extra/info/"))
;; /usr/share/info" "/usr/ml/info" "/usr/jp/info"))


;;;;;;
;;
;;  Mac特有の設定

(when (string= window-system "ns")
  ;; mac 用の command キーバインド
  ;; (setq mac-allow-anti-aliasing nil)  ; mac 固有の設定
  ;;(mac-key-mode 1) ; MacKeyModeを使う

  ;; for Carbon
  ;; (setq mac-option-modifier 'meta)
  ;; for Cocoa
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))

  ;; Drag and Drop
  (define-key global-map [ns-drag-file] 'ns-find-file)


  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil))




(global-set-key "\C-x\C-i" 'indent-region) ; 選択範囲をインデント
(global-set-key "\C-j" 'newline-and-indent) ; C-j で改行とインデント
;;(global-set-key "\C-j" 'newline)  ; 改行

(show-paren-mode t) ; 対応する括弧を光らせる。
(transient-mark-mode t) ; 選択部分のハイライト

(setq require-final-newline t)          ; always terminate last line in file
(setq default-major-mode 'text-mode)    ; default mode is text mode


;;;; file名の補完で大文字小文字を区別しない
;; (setq completion-ignore-case t) ;旧設定
(setq partial-completion-mode 1) ; 補完機能を使う
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


(global-set-key "\M-g" 'goto-line) ;Jamp to line

;; 起動時から global-auto-revert-mode を有効にする
(global-auto-revert-mode 1)


;; Beep音を鳴らさない
(setq visible-bell t)

;; 自動再読み込み
(global-auto-revert-mode)

;; 削除ファイルをごみ箱に入れる
(setq delete-by-moving-to-trash t)


;; 最近開いたファイルを開く
;; (setq recentf-auto-cleanup 'never)
(setq recentf-save-file "~/.emacs.d/app-data/.recentf")
(recentf-mode 1)
;; (global-set-key "\C-xf" 'recentf-open-files)


;; ファイルを開いて，以前の続きを編集

(setq-default save-place t)
(require 'saveplace)
(setq save-place-file "~/.emacs.d/app-data/.emacs-places")


;; Terminal から emacsclient コマンドで、開いているEmacsの
;; 新しいバッファとしてすばやく開けるように、サーバーを立ち上げる
;;
;; emacsclient 経由で開いているバッファを閉じるとき
;;
;;      C-x #
;;
;; (if window-system (server-start))
;; (when (equal (getenv "DISPLAY") ":0.0")
;;   (server-start))
(server-start)

;; (if (and (daemonp) (locate-library "edit-server"))
;;     (progn
;;       (edit-server-start)))

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;;; バックアップファイルを作らない
(setq backup-inhibited t)

;; \C-aでインデントを飛ばした行頭に移動
(defun beginning-of-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ ¥t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun beginning-of-visual-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文 字しかない場合は、行頭に戻る。"
  (interactive "d")
  (let ((vhead-pos (save-excursion (progn (beginning-of-visual-line) (point))))
        (head-pos (save-excursion (progn (beginning-of-line) (point)))))
    (cond
     ;; 物理行の1行目にいる場合
     ((eq vhead-pos head-pos)
      (if (string-match
           "^[ ¥t]+$"
           (buffer-substring-no-properties vhead-pos current-point))
          (beginning-of-visual-line)
        (back-to-indentation)))
     ;; 物理行の2行目以降の先頭にいる場合
     ((eq vhead-pos current-point)
      (backward-char)
      (beginning-of-visual-indented-line (point)))
     ;; 物理行の2行目以降の途中にいる場合
     (t (beginning-of-visual-line)))))

(global-set-key "\C-a" 'beginning-of-visual-indented-line)
(global-set-key "\C-e" 'end-of-visual-line)
