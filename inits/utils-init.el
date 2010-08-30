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
