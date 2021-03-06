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

;;
;; *scratch* bufferを削除しない
;;
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(defun my-buffer-name-list ()
  (mapcar (function buffer-name) (buffer-list)))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (function (lambda ()
                      (if (string= "*scratch*" (buffer-name))
                          (progn (my-make-scratch 0) nil)
                        t))))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (function (lambda ()
                      (unless (member "*scratch*" (my-buffer-name-list))
                        (my-make-scratch 1)))))

;; ;; Emacs でファイルをsudoで開き直す
;; (defun file-root-p (filename)
;;   "Return t if file FILENAME created by root."
;;   (eq 0 (nth 2 (file-attributes filename))))

;; (defun th-rename-tramp-buffer ()
;;   (when (file-remote-p (buffer-file-name))
;;     (rename-buffer
;;      (format "%s:%s"
;;              (file-remote-p (buffer-file-name) 'method)
;;              (buffer-name)))))

;; (add-hook 'find-file-hook
;;           'th-rename-tramp-buffer)

;; (defadvice find-file (around th-find-file activate)
;;   "Open FILENAME using tramp's sudo method if it's read-only."
;;   (if (and (file-root-p (ad-get-arg 0))
;;            (not (file-writable-p (ad-get-arg 0)))
;;            (y-or-n-p (concat "File "
;;                              (ad-get-arg 0)
;;                              " is read-only.  Open it as root? ")))
;;       (th-find-file-sudo (ad-get-arg 0))
;;     ad-do-it))

;; (defun th-find-file-sudo (file)
;;   "Opens FILE with root privileges."
;;   (interactive "F")
;;   (set-buffer (find-file (concat "/sudo::" file))))
