

(defun kill-all-buffers ()
  (interactive)
  (dolist (buf (buffer-list))
	  (kill-buffer buf)))

;; (defun kill-all-buffer (all)
;;   (interactive); ”P”) ;”P”はprefix argumentを受け取る宣言のひとつ
;;   (dolist (buf (buffer-list))
;;     (if (or all ;prefix argumentがあれば全バッファを削除
;;             (buffer-file-name buf)) ;通常はvisitしているfileを削除
;;         (kill-buffer buf))))


;; バッファ再読み込み

;; (defun revert-all-buffers ()
;;   (interactive)
;;   (let ((cbuf (current-buffer)))
;;     (dolist (buf (buffer-list))
;;       (if (not (buffer-file-name buf))
;;    nil
;;  (switch-to-buffer buf)
;;  (revert-buffer t t)))
;;     (switch-to-buffer cbuf)
;;     ))

(defun revert-all-buffers ()
  "revert (reload) all buffer which is opened"
  (interactive)
  (let ((cbuf (current-buffer)))
    (dolist (buf (buffer-list))
      (if (not (buffer-file-name buf)) ;only the file which visit on path
          nil
        (switch-to-buffer buf)
        (revert-buffer t t)))
    (switch-to-buffer cbuf)))


; (define-key global-map "\C-c\C-c\ p" 'revert-all-buffers)
(define-key global-map "\C-xak" 'kill-all-buffers)



