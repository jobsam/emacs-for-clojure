;; JavaScript / HTML Configuration
(require 'tagedit)
(add-hook 'html-mode-hook #'tagedit-mode)

(add-hook 'js-mode-hook #'subword-mode)
(add-hook 'html-mode-hook #'subword-mode)
(add-hook 'coffee-mode-hook #'subword-mode)

(setq js-indent-level 2)

;; CoffeeScript Configuration
(require 'coffee-mode)
(add-hook 'coffee-mode-hook #'highlight-indentation-current-column-mode)

(defun coffee-mode-newline-and-indent ()
  "Define key for newline and indentation in CoffeeScript mode."
  (define-key coffee-mode-map (kbd "RET") 'coffee-newline-and-indent)
  (setq coffee-cleanup-whitespace nil))

(add-hook 'coffee-mode-hook #'coffee-mode-newline-and-indent)

(custom-set-variables
 '(coffee-tab-width 2))
