;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;
;;;;;           Software Configuration Management
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;      Git フロントエンド
;;
;;  ※最新は vc-git.elが添付されている
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; magitを使う場合
;;
;; magit.el ---  git://gitorious.org/magit/mainline.git
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/mainline")
;; (require 'magit)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Git付属
;;
;; (add-to-list 'load-path "/opt/local/share/doc/git-core/contrib/emacs")
;; (require 'git)
;; (require 'git-blame)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  egg ( Emacs Got Git ) - clone (fork) of "Magit"
;;
;;     http://github.com/byplayer/egg/raw/master/egg.el
;;
(when (executable-find "git")
  (require 'egg nil t))
;; ファイルを保存したときに、eggステータスも更新されバッファーがアクティブになる
;; (setq egg-auto-update t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;     Subversion フロントエンド
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  dsvn
;;
;;    http://svn.apache.org/repos/asf/subversion/trunk/contrib/client-side/emacs/dsvn.el
;;

(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'vc-svn)
