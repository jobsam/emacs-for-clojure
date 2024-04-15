;; Setup package archives and initialize package system
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install required packages if not already installed
(defvar my-required-packages
  '(lsp-mode lsp-ui lsp-ivy lsp-treemacs
    clojure-mode cider company cider-hydra clj-refactor))

(dolist (pkg my-required-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; Configure lsp-mode for Clojure development
(require 'lsp-mode)
(require 'lsp-ui)
(require 'lsp-ivy)
(require 'lsp-treemacs)
(add-hook 'clojure-mode-hook #'lsp)

;; Configure clojure-mode and related settings
(require 'clojure-mode)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'lsp)

;; Configure CIDER and related key bindings
(require 'cider)
(global-set-key (kbd "C-c u") #'cider-user-ns)
(global-set-key (kbd "C-M-r") #'cider-refresh)
(setq cider-show-error-buffer t
      cider-auto-select-error-buffer t
      cider-repl-history-file "~/.emacs.d/cider-history"
      cider-repl-pop-to-buffer-on-connect t
      cider-repl-wrap-history t)

;; Configure company for auto-completion with CIDER
(require 'company)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)

;; Configure cider-hydra for Clojure development
(require 'cider-hydra)
(add-hook 'clojure-mode-hook #'cider-hydra-mode)

;; Configure clj-refactor for additional refactorings
(require 'clj-refactor)
(add-hook 'clojure-mode-hook #'clj-refactor-mode)
(cljr-add-keybindings-with-prefix "C-c C-m")

;; Enable paredit in CIDER REPL
(add-hook 'cider-repl-mode-hook #'paredit-mode)

;; Use clojure mode for specific file extensions
(add-to-list 'auto-mode-alist '("\\.boot\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs.*\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("lein-env" . enh-ruby-mode))

;; Custom functions for starting HTTP server and managing namespaces
(defun cider-start-http-server ()
  (interactive)
  (cider-load-buffer)
  (let ((ns (cider-current-ns)))
    (cider-repl-set-ns ns)
    (cider-interactive-eval (format "(println '(def server (%s/start))) (println 'server)" ns))
    (cider-interactive-eval (format "(def server (%s/start)) (println server)" ns))))

(defun cider-refresh ()
  (interactive)
  (cider-interactive-eval (format "(user/reset)")))

(defun cider-user-ns ()
  (interactive)
  (cider-repl-set-ns "user"))