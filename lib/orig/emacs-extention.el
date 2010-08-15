;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;
;;;;;          Original Extension
;;;

(defun kill-all-buffers ()
  "すべてのBufferを削除(*scratch*, *Messages*以外)"
  (interactive)
  (yes-or-no-p "kill all buffer? ")
  (dolist (buf (buffer-list))
    (unless (member (buffer-name) '("*scratch*" "*Messages*"))
        (kill-buffer buf))))

(define-key global-map "\C-xak" 'kill-all-buffers)


(defun revert-all-buffers ()
  "バッファの再読み込み"
  (interactive)
  (let ((cbuf (current-buffer)))
    (dolist (buf (buffer-list))
      (if (not (buffer-file-name buf)) ;only the file which visit on path
          nil
        (switch-to-buffer buf)
        (revert-buffer t t)))
    (switch-to-buffer cbuf)))

(define-key global-map "\C-xar" 'revert-all-buffers)

