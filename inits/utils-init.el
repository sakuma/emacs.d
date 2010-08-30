;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;      Utilities
;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;       uniquify
;;
;; http://www.ysbl.york.ac.uk/~emsley/software/stuff/uniquify.el

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;      grep-edit
;;
;;       htttp://www.emacswiki.org/emacs/download/grep-edit.el
;;
(require 'grep-edit)


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;      color-moccur
;;
(require 'color-moccur)

;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;      color-moccur
;;
(require 'moccur-edit)
(defadvice moccur-edit-change-file
 (after save-after-moccur-edit-buffer activate)
 (save-buffer))

;; ;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;;
;; ;;;      occur, multi-occur
;; ;;

;; ;; occur の結果で，F を入力すると，入力した文字を含む行が削除される
;; ;; (flush-lines が実行される)．
;; (define-key occur-mode-map "F"
;;   (lambda (str) (interactive "sflush: ")
;;     (let ((buffer-read-only))
;;       (save-excursion
;;         (beginning-of-buffer)
;;         (forward-line 1)
;;         (beginning-of-line)
;;         (flush-lines str)))))

;; ;; occur の結果で "K" を入力すると，入力した文字を含む行だけが残る
;; ;;  (keep-lines が実行される)
;; (define-key occur-mode-map "K"
;;   (lambda (str) (interactive "skeep: ")
;;     (let ((buffer-read-only))
;;       (save-excursion
;;         (beginning-of-buffer)
;;         (forward-line 1)
;;         (beginning-of-line)
;;         (keep-lines str)))))


;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    wdired (標準添付)
;;
(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    履歴
;;

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    undohist - 閉じたバッファもUndoできる
;;
;; (install-elisp "http://cx4a.org/pub/undohist.el")
;;
(when (require 'undohist nil t)
  (undohist-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    undo-tree - 履歴を視角化
;;
;; (install-elisp "http://www.dr-qubit.org/undo-tree/undo-tree.el")
;;

(when (require 'undo-tree)
  (global-undo-tree-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    補完 - auto-complete
;;
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/auto-complete//ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    anything
;;
;;  (auto-install-batch "anything")
;;

(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォは0.5秒
   anything-idle-delay 0.3
   ;; タイプして再描写するまでの時間。デフォは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。 デフォは 50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    ;; デフォルトは "su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)
  (and (equal current-language-environment "Japanese")
       (executable-find "cmigemo")
       (require 'anything-migemo nil t))
  (when (require 'anything-complete nil t)
    ;; M-xによる保管をAnythingで行う
    (anything-read-string-mode 1)
    ;; Lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; descbinds-bindings をAnythingに置き換える
    (descbinds-anything-install))

  (require 'anything-grep nil t))

