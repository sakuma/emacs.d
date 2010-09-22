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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;   Javascript
;;
(load "~/.emacs.d/inits/prog-inits/javascript-init")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;       YAML-mode
;;

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Unlike python-mode, this mode follows the Emacs convention of not
;; binding the ENTER key to `newline-and-indent'.  To get this
;; behavior, add the key definition to `yaml-mode-hook':

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-j" 'newline-and-indent)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;       CSS-mode
;;
(setq-default css-indent-offset 2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;       Zencoding-mode   --- HTML,CSS
;;
;; git://github.com/chrisdone/zencoding.git

(require 'zencoding-mode)

(add-hook 'html-mode-hook 'zencoding-mode)
(add-hook 'nxhtml-mode-hook 'zencoding-mode)
(add-hook 'text-mode-hook 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)


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
