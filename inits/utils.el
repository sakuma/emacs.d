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
;;;;;
;;;      occur, multi-occur
;;

;; occur の結果で，F を入力すると，入力した文字を含む行が削除される
;; (flush-lines が実行される)．
(define-key occur-mode-map "F"
  (lambda (str) (interactive "sflush: ")
    (let ((buffer-read-only))
      (save-excursion
        (beginning-of-buffer)
        (forward-line 1)
        (beginning-of-line)
        (flush-lines str)))))

;; occur の結果で "K" を入力すると，入力した文字を含む行だけが残る
;;  (keep-lines が実行される)
(define-key occur-mode-map "K"
  (lambda (str) (interactive "skeep: ")
    (let ((buffer-read-only))
      (save-excursion
        (beginning-of-buffer)
        (forward-line 1)
        (beginning-of-line)
        (keep-lines str)))))
