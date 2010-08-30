;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;                      Ruby
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;
;;;;
;;    ruby-mode
;;

;; rcodetools
(require 'rcodetools)
(setq rct-find-tag-if-available nil)
(defun make-ruby-scratch-buffer ()
  (with-current-buffer (get-buffer-create "*ruby scratch*")
    (ruby-mode)
    (current-buffer)))
(defun ruby-scratch ()
  (interactive)
  (pop-to-buffer (make-ruby-scratch-buffer)))
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
  ;;(define-key ruby-mode-map "\C-ct" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)



(require 'anything-rcodetools)
(setq rct-get-all-methods-command "PAGER=cat fri -l")

;; (define-key anything-map [(control ?;)] 'anything-execute-persistent-action)

;; for ri
;;
(setq ri-ruby-script "/Users/nao/.emacs.d/bin/ri-emacs.rb")
(autoload 'ri "ri-ruby" nil t)
(add-hook 'ruby-mode-hook (lambda ()
                            (local-set-key 'f1 'ri)
                            (local-set-key "¥M-¥C-i" 'ri-ruby-complete-symbol)
                            (local-set-key 'f4 'ri-ruby-show-args)
                            ))



;; rubydb
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger." t)


;; マジックコメントを消す (Ruby 1.9系では必須)
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))


;; rrb - Ruby Refactoring Browser
;; (load "rrb")

;; もしくは
;;  M-x load-library[RET]rrb[RET]


;;;;;;;;;;;;
;;;;;;
;;;     Test - ZenTest
;;
;; http://www.emacswiki.org/cgi-bin/emacs/download/autotest.el
;;
;; (require 'autotest)



;; find-recursive
(require 'find-recursive)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;           Rails
;;
;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;     emacs-rails
;;
;; (defun try-complete-abbrev (old)
;;   (if (expand-abbrev) t nil))
;; (setq hippie-expand-try-functions-list
;;       '(try-complete-abbrev
;;         try-complete-file-name
;;         try-expand-dabbrev))
;; (setq rails-use-mongrel t)
;; (require 'cl)
;; (require 'rails-autoload)
;; (setq load-path (cons "~/.emacs.d/site-lisp/rails" load-path))
;; ;; (add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-rails")
;; (require 'rails)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;     rinari - Rinari Is Not A Ruby IDE
;;
;; http://github.com/eschulte/rinari
;;

;; 注意 - 以下を削除しないと Ruby-mode の挙動がおかしくなる
;; util/inf-ruby.el
;; util/ruby-mode.el
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
(require 'rinari)

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rinari-starter")
;; (require 'init)
;; (load-file "~/.emacs.d/site-lisp/rinari-starter/init.el")

;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;     rhtml-mode  --- http://github.com/eschulte/rhtml
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rhtml")
(require 'rhtml-mode)
(setq auto-mode-alist (cons '("\\.erb$" . rhtml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rhtml$" . rhtml-mode) auto-mode-alist))
(add-hook 'rhtml-mode-hook
          (lambda () (rinari-launch)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;
;;;;;;          flymake for ruby
;;;
(require 'flymake)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))


;; (require 'ido)
;; (ido-mode t)


(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("¥¥.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))
(global-font-lock-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;;       rsense
;;
;; rsense:
;;   git://github.com/m2ym/rsense.git
;; auto-complete:
;;   git://github.com/m2ym/auto-complete.git

;; (setq rsense-home "/Users/nao/.emacs.d/lib/rsense")
;; (add-to-list 'load-path (concat rsense-home "/etc"))
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
;; (add-to-list 'dictionary-directories "~/.emacs.d/site-lisp/auto-complete/dict")
;; (ac-config-default)
;; (require 'auto-complete-config)

;; (require 'rsense)
;; C-c .で補完
;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-c .") 'ac-complete-rsense)))

;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-rsense-method)
;;             (add-to-list 'ac-sources 'ac-source-rsense-constant)))

;; (add-hook 'ruby-mode-hook
;;                                      (lambda ()
;;                                              (local-set-key (kbd "C-c .") 'rsense-complete)))


;;;;;;;;;;;;;;;;;;;;;
;;;;
;;    irb - key-bind
;;
(define-key global-map
  "\C-cr" 'run-ruby)


;; ruby-electric.el --- electric editing commands for ruby files
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;; rinari-mode での使用
(add-hook 'rinari-minor-mode-hook '(lambda () (ruby-electric-mode t)))

;; ruby-block
(require 'ruby-block)
(ruby-block-mode t)
;; ミニバッファに表示し, かつ, オーバレイする.
(setq ruby-block-highlight-toggle t)

;; 参考：その他の動作
;; ;; 何もしない
;; (setq ruby-block-highlight-toggle 'noghing)
;; ;; ミニバッファに表示
;; (setq ruby-block-highlight-toggle 'minibuffer)
;; ;; オーバレイする
;; (setq ruby-block-highlight-toggle 'overlay)


;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/rinari")
;; (require 'rinari)


