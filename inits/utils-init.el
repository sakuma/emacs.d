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
   anything-idle-delay 0.2
   ;; タイプして再描写するまでの時間。デフォは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。 デフォは 50
   anything-candidate-number-limit 200
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

  (require 'anything-grep nil t)

  ;; (install-elisp "http://github.com/imakado/anything-project/raw/master/anything-project.el")
  (when (require 'anything-project nil t)
    (global-set-key (kbd "C-c C-p") 'anything-project)
    ;; 検索対象から除外するフィルタ
    (setq ap:project-files-filters
          (list (lambda (files)
                  (remove-if 'file-directory-p files)
                  (remove-if '(lambda (file) (string-match-p "~$" file)) files))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    auto-save-buffers
;;
;;  (install-elisp "http://0xcc.net/misc/auto-save/auto-save-buffers.el")
;;  ※ 文字化け注意
(require 'auto-save-buffers)
(run-with-idle-timer 2.0 t 'auto-save-buffers) ; アイドル2.0秒で保存
;; auto-save-buffers の on/off を切り替えるためのキー定義 (C-x a s)
;;   (define-key ctl-x-map "as" 'auto-save-buffers-toggle)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;      ECB : Emacs Code Browser
;;
;; Install

;; step.1 : CEDET : Install & Compile - http://cedet.sourceforge.net/

;;  % cd cedet/install/path
;;  % make EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs

;; step.2 : ECB
;;  % cd ecb/install/path
;;  % make EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs CEDET=../cedet-1.0pre7/

;; ECB
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/ecb-2.40")
;; CEDET
;; (load-file "~/.emacs.d/site-lisp/cedet-1.0pre7/common/cedet.elc")
;;(setq semantic-load-turn-useful-things-on t)

(require 'ecb)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.25)
(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)))

;; key-bind (My-Conf)
(global-set-key [f2] 'ecb-toggle)
(global-set-key "\C-cmd" 'ecb-goto-window-directories)
(global-set-key "\C-cms" 'ecb-goto-window-sources)
(global-set-key "\C-cmm" 'ecb-goto-window-methods)
(global-set-key "\C-cm1" 'ecb-goto-window-edit1)
(global-set-key "\C-cm2" 'ecb-goto-window-edit2)
(global-set-key "\C-cml" 'ecb-goto-window-edit-last)

;; Layout
;; http://ecb.sourceforge.net/docs/Changing-the-ECB_002dlayout.html
(setq ecb-layout-name "right1") ;; Directory, Source, Methods
;; (setq ecb-layout-name "left2")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;     elscreen
;;
;; Home page : http://www.morishima.net/~naoto/software/elscreen/index.php.ja
;; Source code : ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/elscreen-1.4.6")

;; Prefix - Control-;
(setq elscreen-prefix-key [?\C-\;])

(load "elscreen" "ElScreen" t)


;; ElScreenの動作中にPrefixキーを変更する
;; (elscreen-set-prefix-key "\C-t")


;; (defun elscreen-frame-title-update ()
;;   (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;;     (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;;     (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;;     (title (mapconcat
;;       (lambda (screen)
;;         (format "%d%s %s"
;;           screen (elscreen-status-label screen)
;;           (get-alist screen screen-to-name-alist)))
;;       screen-list " ")))
;;       (if (fboundp 'set-frame-name)
;;    (set-frame-name title)
;;  (setq frame-title-format title)))))

;; (eval-after-load "elscreen"
;;   '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))

;; (load "escreen")
;; (escreen-install)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;   Hiki-mode

(require 'hiki-mode)

;; hiki-site-list を .hikiに記述

(setq hiki-browser-function 'browse-url)
(autoload 'hiki-edit "hiki-mode" nil t)
(autoload 'hiki-edit-url "hiki-mode" nil t)

;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "/usr/bin/open"
;;       browse-url-generic-args '("-a" "Safari"))


;; (autoload 'hiki-index "hiki-mode" nil t)
;;  (setq hiki-site-list '(("my 1st Hiki" "http://example.com/hiki/hiki.cgi")
;;                         ("my 2nd Hiki" "http://example.com/hiki2/")))
;;  (setq hiki-browser-function 'browse-url)
;;  (autoload 'hiki-edit "hiki-mode" nil t)
;;  (autoload 'hiki-edit-url "hiki-mode" nil t)



;;;; Chrome Extention
;; Edit with Emacs - Version: 1.6
;; Allow user to edit web-page textareas with Emacs (and other editors).

;; (require 'edit-server)
;; (edit-server-start)
;; If not nil, edit each buffer in a new frame (and raise it)
;; (edit-server-new-frame nil)
;; Show the emacs frame’s minibuffer if set to t; hide if nil
;; (edit-server-new-frame-minibuffer t)
;; edit-server-new-frame-menu-bar - Show the emacs frame’s menu-bar if set to t; hide if nil
;; edit-server-new-frame-mode-line - Show the emacs frame’s mode-line if set to t; hide if nil

;; (require 'edit-server)
;; (edit-server-start)

;; (if (and (daemonp) (locate-library "edit-server"))
;;     (progn
;;       (edit-server-start)))
;; (if (locate-library "edit-server")
;;    (progn
;;      (require 'edit-server)
;;      ;; (setq edit-server-new-frame nil)
;;      (edit-server-start)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;
;;;;;         Redmine : 未
;;;
;;;   git://github.com/fukamachi/redmine-el.git
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/redmine-el")
;; (require 'redmine)
;; (setq redmine-project-alist
;;       '(("woman" "https://redmine.everyleaf.com/projects/show/woman-life" "eMpnO6r6MIbG0EybDDwgevniYLeAJPeUnjUUjRBe")
;;         ("smalldesk" "https://redmine.everyleaf.com/projects/show/smalldesk")))






(require 'parenthesis)
;; (define-key map (kbd "\"") 'insert-pair)
;; (define-key map (kbd "\[") 'insert-pair)
;; (define-key map (kbd "\{") 'insert-pair))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 矩形選択  ---  http://www.cua.dk/cua.el
;;
;; 23.1 に同梱
;; (require 'cua-mode)
;; (setq cua-enable-cua-keys nil)
;; (cua-mode t)
;; (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;; (transient-mark-mode 1) ;; No region when it is not highlighted
;; (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

;;;;;;;;;;;;;;;;;;;;;;
;; jaspace.el ---  http://homepage3.nifty.com/satomii/software/jaspace.el
(require 'jaspace)

;; To control mode-based automatic activation:
;;
;;   (setq jaspace-modes nil)         ; disable automatic activation
;;   (setq jaspace-mdoes '(cc-mode))  ; activate on cc-mode only
;;
;; To change the alternate string for a Japanese space character:
;;
;;   (setq jaspace-alternate-jaspace-string "__")  ; or any other string
;;
;; To enable end-of-line marker:
;;
;;   (setq jaspace-alternate-eol-string "\xab\n")  ; or any other string
;;
;; To enable tab marker:
;;
;;   (setq jaspace-highlight-tabs t)  ; highlight tabs
;;
;; EXPERIMENTAL: On Emacs 21.3.50.1 (as of June 2004) or 22.0.5.1, a tab
;; character may also be shown as the alternate character if
;; font-lock-mode is enabled.
;;
;;   (setq jaspace-highlight-tabs ?^) ; use ^ as a tab marker
;;
;; Use M-x customize-group jaspace RET for further customization and/or
;; changing face attributes.


(require 'redo+)


