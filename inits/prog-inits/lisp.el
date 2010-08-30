;; TODO: 整理


;;;;;;;;;;;;;;;;;;;;
;;
;;   Common Lisp
;;


(add-to-list 'auto-mode-alist '("\\.l$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)


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
