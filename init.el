;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;
;;;      Emacs Config
;;
;; 変更があったらその都度勝手にバイトコンパイルする
;; http://www.netlaputa.ne.jp/~kose/Emacs/index2.html#Gnus_speedup
;; (defun byte-compile-dotfiles ()
;;   "byte-compile dotfiles."
;;   (interactive)
;;   (if (file-newer-than-file-p "~/.emacs.d/init.el")
;;       (byte-compile-file "~/.emacs.d/init.elc"))
;;   )
;; (add-hook 'kill-emacs-hook 'byte-compile-dotfiles)


;;;;;;
;;
;;  load-path
;;
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


;; 自作 elisp
(load-file "~/.emacs.d/lib/orig/emacs-extention.el")


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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;       Programming Language setting
;;
;;




;;=======================================================================
;; HyperSpec
;;=======================================================================
;;
;; Ports版 - /opt/local/var/macports/software/lisp-hyperspec/7.0_0/opt/local/share/doc/lisp/HyperSpec-7-0/HyperSpec/

(setq hyperspec-path
      "/opt/local/var/macports/software/lisp-hyperspec/7.0_0/opt/local/share/doc/lisp/HyperSpec-7-0/HyperSpec/")

(setq common-lisp-hyperspec-root (concat "file://" hyperspec-path)
      common-lisp-hyperspec-symbol-table (concat hyperspec-path "Data/Map_Sym.txt"))

;; HyperSpecをw3mで見る
;; (defadvice common-lisp-hyperspec
;;   (around hyperspec-lookup-w3m () activate)
;;   (let* (
;;       ;;(window-configuration (other-window-configuration))
;;       (window-configuration (current-window-configuration))
;;          (browse-url-browser-function
;;           `(lambda (url new-window)
;;              (w3m-browse-url url nil)
;;              (let ((hs-map (copy-keymap w3m-mode-map)))
;;                (define-key hs-map (kbd "q")
;;                  (lambda ()
;;                    (interactive)
;;                    (kill-buffer nil)
;;                    (set-window-configuration ,window-configuration)))
;;                (use-local-map hs-map)))))
;;     ad-do-it))

(define-key global-map "\C-ch" 'hyperspec-lookup)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;     Commmon Lisp
;;

(add-to-list 'auto-mode-alist '("\\.l$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;     clojure-mode
;;
;;
;; http://github.com/technomancy/clojure-mode

;; (add-to-list 'load-path "~/.emacs.d/site-lisp/clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
;;(setq clojure-src-root (expand-file-name "~/.emacs.d/clojure"))

;;(clojure-slime-config)

;; ;; Git版 - swank-clojure
;; ;; git clone git://github.com/jochu/swank-clojure.git
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/swank-clojure")
;; (add-to-list 'load-path "~/.emacs.d/tmp/swank-clojure/src/emacs/")

;;(require 'swank-clojure)
;; (require 'slime-autoloads) なくなっている
;; (require 'swank-clojure-autoload)
;; (swank-clojure-config
;; (setq swank-clojure-jar-home "/opt/local/share/java/clojure/lib/clojure.jar"
;;       swank-clojure-extra-classpath
;;      (list "/opt/local/share/java/clojure/lib/clojure-contrib.jar"))
;; )





















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;      SLIME
;;


;; Git版 - SLIME
;; git://git.boinkor.net/slime.git
;; (setq load-path (append '("~/.emacs.d/site-lisp/slime"
;;                           "~/.emacs.d/site-lisp/slime/contrib")
;;                          load-path))


;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime")
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime/contrib")

;;;  ------------------------------
;; (setq slime-lisp-implementations
;;       `(
;;        (clojure ("/opt/local/bin/clj"))
;;        (sbcl ("/opt/local/bin/sbcl") :coding-system utf-8-unix)
;;         (clisp ("/opt/local/bin/clisp") :coding-system utf-8-unix)
;;         (abcl ("/opt/local/bin/abcl") :coding-system utf-8-unix)
;;        ))

;; (clojure ("/opt/local/bin/clj"))


;; (setq swank-clojure-jar-path "~/code/shcloj-code/lib/clojure.jar"
;;       swank-clojure-extra-classpaths (list
;;                                       "~/opt/swank-clojure/src/main/clojure"
;;                                       "~/code/shcloj-code"
;;                                       "~/code/shcloj-code/lib/commons-io-1.4.jar"
;;                                       "~/code/shcloj-code/lib/commons-fileupload-1.2.1.jar"
;;                                       "~/code/shcloj-code/lib/commons-codec-1.3.jar"
;;                                       "~/code/shcloj-code/lib/jline-0.9.94.jar"
;;                                       "~/code/shcloj-code/lib/clojure.jar"
;;                                       "~/code/shcloj-code/lib/clojure-contrib.jar"
;;                                       "~/code/shcloj-code/lib/ant.jar"
;;                                       "~/code/shcloj-code/lib/ant-launcher.jar"
;;                                       "~/code/shcloj-code/lib/compojure.jar"
;;                                       "~/code/shcloj-code/lib/hsqldb.jar"
;;                                       "~/code/shcloj-code/lib/jetty-6.1.14.jar"
;;                                       "~/code/shcloj-code/lib/jetty-util-7.1.14.jar"
;;                                       "~/code/shcloj-code/lib/servlet-api-2.5-6.1.14.jar"
;;                                       "~/code/shcloj-code/classes"))

;; (eval-after-load 'slime
;;  '(progn (require 'swank-clojure)
;;          (setq slime-lisp-implementations
;;                (cons `(clojure ,(swank-clojure-cmd) :init swank-clojure-init)
;;                      (remove-if #'(lambda (x) (eq (car x) 'clojure))
;;                                 slime-lisp-implementations)))))


;;;  ------------------------------

;; (add-hook 'lisp-mode-hook
;;            (lambda ()
;;              (cond ((not (featurep 'slime))
;;                     (require 'slime)
;;                     (normal-mode)))))
;; (require 'slime-autoloads)

;; (eval-after-load "slime"
;;   ;; '(slime-setup '(slime-scratch slime-editing-commands)))
;;  '(slime-setup '(slime-repl
;;                  slime-fancy
;;                  slime-banner
;;                   slime-autodoc
;;                   ;; Bad - slime-highlight-edits
;;                   ;slime-mrepl
;;                   ;inferior-slime-mode
;;                   )))

;; (eval-after-load "slime"
;;   '(progn (slime-setup '(slime-repl slime-fuzzy slime-c-p-c))))



;;======================================================================
;; clojure HP

;; swank-clojure
;; (add-to-list 'load-path "~/opt/swank-clojure/src/emacs")

(setq swank-clojure-jar-path "~/.clojure/clojure.jar"
      swank-clojure-extra-classpaths (list
                                      ;;"~/opt/swank-clojure/src/main/clojure"
                                      "~/.clojure/clojure-contrib.jar"))
;;(require 'swank-clojure-autoload)

;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(require 'slime)
(slime-setup)


;;======================================================================
;; SLIME 設定
;;
;; (SLIME) 閉じ括弧を全て補完する
;;(global-set-key "\C-cj" 'slime-close-all-parens-in-sexp)

;; ;; カーソル付近にある単語の情報を表示
;; (add-hook 'slime-load-hook (lambda () (require 'slime-autodoc)))


;; (slime-setup '(slime-fancy))


;;  日本語利用
(setq slime-net-coding-system 'utf-8-unix)

(define-key global-map "\C-cs" 'slime)




;; Ports Message
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime")
;; (require 'slime-autoloads)
;; (setq slime-lisp-implementations
;;      `((sbcl ("/opt/local/bin/sbcl"))
;;        (abcl ("/opt/local/bin/abcl"))
;;        (clisp ("/opt/local/bin/clisp"))))
;; (add-hook 'lisp-mode-hook
;;            (lambda ()
;;              (cond ((not (featurep 'slime))
;;                     (require 'slime)
;;                     (normal-mode)))))

;; (eval-after-load "slime"
;;    '(slime-setup '(slime-fancy slime-banner)))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;     Scheme-mode
;;


;;;;;;;;;;;;;
;; Gauche
;;

(modify-coding-system-alist 'process "gosh" '(utf-8 . utf-8))
;; (setq scheme-program-name "gosh -i")
;; (autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
;; (autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window ()
  (setq scheme-program-name "gosh -i")
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(defun gauche-info ()
  (interactive)
  (switch-to-buffer-other-frame
   (get-buffer-create "*info*"))
  (info "/opt/local/share/info/gauche-refe.info.gz"))

(define-key global-map
  "\C-cg" 'scheme-other-window)
(define-key global-map
  "\C-ci" 'gauche-info)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:
;;;;
;;    Ruby
;;

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



(require 'anything)
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;
;;;;
;;
;; untabify-file.el
;; http://www.koders.com/lisp/fidB815221322CBDE55053CAD09D39E74418FE58B78.aspx?s=%22ruby+on+rails%22#L7
;;
(require 'untabify-file)


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










;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;         Javascript
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;      j2-mode - http://code.google.com/p/js2-mode
;;
;;
;; Installation:
;;
;;  - put `js2.el' somewhere in your emacs load path
;;  - M-x byte-compile-file RET <path-to-js2.el> RET
;;    Note:  it will refuse to run unless byte-compiled
;;  - add these lines to your .emacs file:
;;    (autoload 'js2-mode "js2" nil t)
;;    (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\|htc\\)\\'" 'js2-mode))

;; js2-mode のインデント幅は js2-basic-offset で、デフォルトが 2 だが、
;; c-basic-offset が設定されていれば、その値が js2-basic-offsetの初期値として使われる。
;; (setq js2-basic-offset 2)
;;
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;    espresso-mode(インデントなど) - http://www.nongnu.org/espresso/
;;
;; (add-to-list 'auto-mode-alist (cons  "\\.\\(js\\|as\\|json\\|jsn\\|htc\\)\\'" 'espresso-mode))
;; (autoload 'espresso-mode "espresso" nil t)

;; fixing indentation
;; refer to http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode

(autoload 'espresso-mode "espresso")



(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))

(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  ;; (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map "\C-\M-\\"
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map "\C-m" 'newline-and-indent)
  ;; (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  ;; (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map "\C-\M-q" 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
      (js2-highlight-vars-mode))
  (message "My JS2 hook"))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)






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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;       YAML-mode
;;

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Unlike python-mode, this mode follows the Emacs convention of not
;; binding the ENTER key to `newline-and-indent'.  To get this
;; behavior, add the key definition to `yaml-mode-hook':

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;
;;;       CSS-mode
;;

(setq css-indent-offset 2)


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

;; Shift + カーソルキーでバッファ移動
(setq windowmove-wrap-around t)
(windmove-default-keybindings)

;; Layout
;; http://ecb.sourceforge.net/docs/Changing-the-ECB_002dlayout.html
(setq ecb-layout-name "right1") ;; Directory, Source, Methods
;; (setq ecb-layout-name "left2")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 ;; '(gud-gdb-command-name "gdb --annotate=1")
 '(inhibit-startup-screen t)
 ;;'(clojure-inferior-lisp-program "/opt/local/share/java/clojure-contrib/launchers/bash/clj-env-dir"))
 ;; clojure

 ;; '(large-file-warning-threshold nil)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;;;;;;;;;;;;;;;;;;;;;;;
;; shell-pop
;;
;; http://www.emacswiki.org/emacs/download/shell-pop.el
;;
(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/zsh")

(defvar ansi-term-after-hook nil)
(add-hook 'ansi-term-after-hook
          '(lambda ()
             (define-key term-raw-map "\C-c\C-t" 'shell-pop)
             (hl-line-unhighlight)))
(defadvice ansi-term (after ansi-term-after-advice (org))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)
(global-set-key "\C-c\C-t" 'shell-pop)
;; Besides, you can set the window height, the number for the percentage
;; for selected window.
(shell-pop-set-window-height 40)

;;(setq system-uses-terminfo nil)


;;;;;;;;;;;;;;;;;;;;;;;;
;; uniquify
;; http://www.ysbl.york.ac.uk/~emsley/software/stuff/uniquify.el

(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;; Emacs でファイルをsudoで開き直す
(defun file-root-p (filename)
  "Return t if file FILENAME created by root."
  (eq 0 (nth 2 (file-attributes filename))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-root-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;
;;;;;         Redmine : 未
;;;
;;;   git://github.com/fukamachi/redmine-el.git
;;
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/redmine-el")
(require 'redmine)
(setq redmine-project-alist
      '(("woman" "https://redmine.everyleaf.com/projects/show/woman-life" "eMpnO6r6MIbG0EybDDwgevniYLeAJPeUnjUUjRBe")
        ("smalldesk" "https://redmine.everyleaf.com/projects/show/smalldesk")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;    Git  ※最新は vc-git.elが添付されて
;;
;; magitを使う場合
;;
;; magit.el ---  git://gitorious.org/magit/mainline.git
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/mainline")
;; (require 'magit)

(add-to-list 'load-path "/opt/local/share/doc/git-core/contrib/emacs")
(require 'git)
(require 'git-blame)


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;      Emacs config
;;
;;


;;画面を 2 分割したときの 上下を入れ替える swap screen
;;というのが PF 何番かにわりあてられていました。
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f5] 'swap-screen)
(global-set-key [S-f5] 'swap-screen-with-cursor)


(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let (before-height (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)

    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally)
      )

    (switch-to-buffer-other-window other-buf)
    (other-window -1)))

(global-set-key [f6] 'window-toggle-division)



;; Terminal から emacsclient コマンドで、開いているEmacsの
;; 新しいバッファとしてすばやく開けるように、サーバーを立ち上げる
;;
;; emacsclient 経由で開いているバッファを閉じるとき
;;
;;      C-x #
;;
;; (if window-system (server-start))
;; (when (equal (getenv "DISPLAY") ":0.0")
;;   (server-start))
(server-start)

;; (if (and (daemonp) (locate-library "edit-server"))
;;     (progn
;;       (edit-server-start)))

(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
;; (set-default-coding-systems 'sjis-mac)
;;(set-default-coding-systems 'utf-8)

;; (set-clipboard-coding-system 'sjis-mac)
(set-clipboard-coding-system 'utf-8)

;; (set-buffer-file-coding-system 'sjis-mac)

(setq-default buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'sjis-mac)


;; (setq default-input-method "MacOSX")
;; (utf-translate-cjk-mode 1)

(set-file-name-coding-system 'utf-8)


;; 日本語infoの文字化け防止
(auto-compression-mode t)

;; (setq Info-directory-list
;;     (list "/usr/local/share/info" "/Applications/Emacs.app/Contents/Resources/extra/info/"))
;; /usr/share/info" "/usr/ml/info" "/usr/jp/info"))



(setq c-tab-always-indent t)
(setq-default tab-width 2)
(setq indent-line-function 'indent-relative-maybe) ; 前と同じ行の幅にインデント


;; (setq mac-allow-anti-aliasing nil)  ; mac 固有の設定
;;(mac-key-mode 1) ; MacKeyModeを使う

;;;; mac 用の command キーバインド

;;;; for Carbon
;; (setq mac-option-modifier 'meta)
;;;; for Cocoa
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; Drag and Drop
(define-key global-map [ns-drag-file] 'ns-find-file)


(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

(global-set-key "\C-x\C-i" 'indent-region) ; 選択範囲をインデント
(global-set-key "\C-j" 'newline-and-indent) ; C-j で改行とインデント
;;(global-set-key "\C-j" 'newline)  ; 改行

(show-paren-mode t) ; 対応する括弧を光らせる。
(transient-mark-mode t) ; 選択部分のハイライト

(setq require-final-newline t)          ; always terminate last line in file
(setq default-major-mode 'text-mode)    ; default mode is text mode


;;;; file名の補完で大文字小文字を区別しない
;; (setq completion-ignore-case t) ;旧設定
(setq partial-completion-mode 1) ; 補完機能を使う
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)


(global-set-key "\M-g" 'goto-line) ;Jamp to line

;; 起動時から global-auto-revert-mode を有効にする
(global-auto-revert-mode 1)

;; ファイルを開いて，以前の続きを編集

(setq-default save-place t)
(require 'saveplace)
(setq save-place-file "~/.emacs.d/app-data/.emacs-places")


;; Beep音を鳴らさない
(setq visible-bell t)

;;EOFを表示
(defun set-buffer-end-mark()
  (let ((overlay (make-overlay (point-max) (point-max))))
    (overlay-put overlay 'before-string #("[EOF]" 0 5 (face highlight)))
    (overlay-put overlay 'insert-behind-hooks
                 '((lambda (overlay after beg end &optional len)
                     (when after
                       (move-overlay overlay (point-max) (point-max))))))))
(add-hook 'find-file-hooks 'set-buffer-end-mark)

;; ウィンドウを縦分割したときも折り返す設定
(setq truncate-partial-width-windows nil)

;;   左側に行数表示
(require 'linum nil t)
(global-linum-mode) ; すべてのバッファに対し、起動時に表示

;; 自動再読み込み
(global-auto-revert-mode)

;; 削除ファイルをごみ箱に入れる
(setq delete-by-moving-to-trash t)

;;; 補完
;; C-x b で候補を絞り込む
(iswitchb-mode 1)
;; (partial-completion-mode 1)

;; (mcomplete-mode 1)

;; 最近開いたファイルを開く
(setq recentf-auto-cleanup 'never)
(setq recentf-save-file "~/.emacs.d/app-data/.recentf")
(recentf-mode 1)
(global-set-key "\C-xf" 'recentf-open-files)


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



;; カーソル行をハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "gray15")) ;dark slate gray
    (((class color)
      (background light))
     (:background "gray15")) ;ForestGreen
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)






;;;
;; Config window

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; フレームの初期値
(setq initial-frame-alist
      (append
       '((foreground-color . "gray")
         (background-color . "black")
         (cursor-color     . "blue")
;;          (width . XXX)
;;          (height . XXX)
         (top . 0)
;;          (left . XXX)
         (alpha . (85 70))) ; 透明度 (active inactive)
       initial-frame-alist))

;;(add-to-list 'default-frame-alist '(cursor-type . 'hbar))
;;'(bar . 1)

;;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;;; バックアップファイルを作らない
(setq backup-inhibited t)

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; 改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; \C-aでインデントを飛ばした行頭に移動
(defun beginning-of-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文字しかない場合は、行頭に戻る。"
  (interactive "d")
  (if (string-match
       "^[ ¥t]+$"
       (save-excursion
         (buffer-substring-no-properties
          (progn (beginning-of-line) (point))
          current-point)))
      (beginning-of-line)
    (back-to-indentation)))

(defun beginning-of-visual-indented-line (current-point)
  "インデント文字を飛ばした行頭に戻る。ただし、ポイントから行頭までの間にインデント文 字しかない場合は、行頭に戻る。"
  (interactive "d")
  (let ((vhead-pos (save-excursion (progn (beginning-of-visual-line) (point))))
        (head-pos (save-excursion (progn (beginning-of-line) (point)))))
    (cond
     ;; 物理行の1行目にいる場合
     ((eq vhead-pos head-pos)
      (if (string-match
           "^[ ¥t]+$"
           (buffer-substring-no-properties vhead-pos current-point))
          (beginning-of-visual-line)
        (back-to-indentation)))
     ;; 物理行の2行目以降の先頭にいる場合
     ((eq vhead-pos current-point)
      (backward-char)
      (beginning-of-visual-indented-line (point)))
     ;; 物理行の2行目以降の途中にいる場合
     (t (beginning-of-visual-line)))))

(global-set-key "\C-a" 'beginning-of-visual-indented-line)
(global-set-key "\C-e" 'end-of-visual-line)




;;; toolバーを消す
(tool-bar-mode 0)
;;; フレームのタイトル指定
;;タイトルバーにファイル名とディレクトリ名の表示
(setq frame-title-format '((buffer-file-name "%f" (dired-mode-p default-directory mode-line-buffer-identification))))

;;; カーソルの位置
;; 何文字目かを表示する
(column-number-mode t)
;; 何行目かを表示する
(line-number-mode t)

;;=======================================================================
;; 対応する括弧を光らせる
;;=======================================================================
(show-paren-mode t)

;;=======================================================================
;; リージョンに色を付ける
;;=======================================================================
(setq transient-mark-mode t)



(require 'highlight-symbol)

(setq-default highlight-symbol-mode t)

;; (global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
;; (global-set-key [(meta f3)] 'highlight-symbol-prev)



;;; 起動時のメッセージを打ち出さないようにする
(setq inhibit-startup-message t)


;; diffのカラー表示
(add-hook 'diff-mode-hook
          (lambda ()
            (set-face-foreground 'diff-context-face "grey50")
            (set-face-background 'diff-header-face "black")
            (set-face-underline-p 'diff-header-face t)
            (set-face-foreground 'diff-file-header-face "MediumSeaGreen")
            (set-face-background 'diff-file-header-face "black")
            (set-face-foreground 'diff-index-face "MediumSeaGreen")
            (set-face-background 'diff-index-face "black")
            (set-face-foreground 'diff-hunk-header-face "plum")
            (set-face-background 'diff-hunk-header-face"black")
            (set-face-foreground 'diff-removed-face "pink")
            (set-face-background 'diff-removed-face "gray5")
            (set-face-foreground 'diff-added-face "light green")
            (set-face-foreground 'diff-added-face "white")
            (set-face-background 'diff-added-face "SaddleBrown")
            (set-face-foreground 'diff-changed-face "DeepSkyBlue1")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Emacs
;;
;; Get :
;;
;;  ftp://ftp.twaren.net/Unix/GNU/gnu/emacs/
;;
;;  ftp://alpha.gnu.org/gnu/emacs/pretest/
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;
;;;;     Install : Cocoa Version
;;
;; $ cd archive/file/path
;; $ tar xvzf emacs-xx.xx.xx.tar.gz
;; $ ./configure --with-ns --without-x
;; $ make bootstrap
;; $ make install



