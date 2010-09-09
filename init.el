;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;      Emacs Config
;;
;;


;;;;;;;;;;
;;
;;  load-path

(defun add-to-load-path-recursion (&rest dir-paths)
  "指定したディレクトリ以下のすべてのディレクトリをload-pathに追加"
  (dolist (dir-path dir-paths)
    (when (and (stringp dir-path) (file-directory-p dir-path))
      (let ((default-directory dir-path))
        (setq load-path (cons default-directory load-path))
        (normal-top-level-add-subdirs-to-load-path)))))

(add-to-load-path-recursion
 "/Applications/Emacs.app/Contents/Resources/site-lisp" ;; subdirs.el
 (concat user-emacs-directory "site-lisp")
 (concat user-emacs-directory "auto-install"))

;;;;;;;;;;
;;
;;  自作 elisp

(load "~/.emacs.d/lib/orig/emacs-extention")


;;;;;;;;;;
;;
;;  exec-path

(defconst default-emacs-path (split-string (getenv "PATH") ":"))
(defconst login-path (split-string (substring (shell-command-to-string "echo $PATH") 0 -1) ":"))
(dolist (path login-path)
  (unless (member path default-emacs-path)
    (add-to-list 'exec-path path)))


;;;;;;;;;;
;;
;;  auto-install -- http://www.emacswiki.org/emacs/download/auto-install.el
;;
(when (require 'auto-install nil t)
  ;;; デフォルトは "~/.emacs.d/auto-install/"
  ;; (setq auto-install-directory "~/.emacs.d/site-lisp/")
  ;;; EmacsWikiに登録されている elisp の名前を取得
  (auto-install-update-emacswiki-package-name t)
  ;;; プロキシの設定
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; (auto-install-from-url) ; 下記と同定義
  (auto-install-compatibility-setup))   ; 互換性確保


;;;;;;;;;;
;;
;;  auto-async-byte-compile -- from emacswiki.org
;;
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp "/.el/")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;       Programming Language setting
;;
(load "~/.emacs.d/inits/prog-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;     utils
;;
(load "~/.emacs.d/inits/utils-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   scm (Software Configuration Management)
;;
(load "~/.emacs.d/inits/scm-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Window setting
;;
(load "~/.emacs.d/inits/window-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   environment setting
;;
(load "~/.emacs.d/inits/environment-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Emacs Get :
;;
;;  git clone git://git.savannah.gnu.org/emacs.git
;;
;;  ftp://ftp.twaren.net/Unix/GNU/gnu/emacs/
;;
;;  ftp://alpha.gnu.org/gnu/emacs/pretest/
;;

;;;;;;
;;
;;  Install : Cocoa Version
;;

;; $ cd archive/file/path
;; $ tar xvzf emacs-xx.xx.xx.tar.gz
;; $ ./configure --with-ns --without-x
;; $ make bootstrap
;; $ make install



