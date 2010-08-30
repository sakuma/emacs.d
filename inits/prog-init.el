;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;       Programming Language setting
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Lisp
;;
(load "~/.emacs.d/inits/prog-inits/lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Ruby
;;
(load "~/.emacs.d/inits/prog-inits/ruby-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;
;;;;
;;
;; untabify-file.el - 保存時に自動的にタブをスペースに、いらないスペースを削除
;;
;; http://www.koders.com/lisp/fidB815221322CBDE55053CAD09D39E74418FE58B78.aspx?s=%22ruby+on+rails%22#L7
;;
(require 'untabify-file)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;; yasnippet        --- http://code.google.com/p/yasnippet/
;; yasnippets-rails --- http://github.com/eschulte/yasnippets-rails
;; yasnippets-bundle ---
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/site-lisp/yasnippet")
(yas/load-directory "~/.emacs.d/site-lisp/yasnippets-rails/rails-snippets")

;; (require 'yasnippet-bundle)
