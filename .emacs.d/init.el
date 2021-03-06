(load-file (expand-file-name "~/.emacs.d/package-setup.el"))

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load-file custom-file)
(global-set-key (kbd "C-x g") 'magit-status)
(load-theme 'sanityinc-tomorrow-night)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq inhibit-startup-buffer-menu t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-hooks t)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(fset 'yes-or-no-p 'y-or-n-p)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq ring-bell-function 'ignore)
(setq lsp-keymap-prefix "s-l")

(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin" ":/usr/local/opt/llvm/bin"))
(setq exec-path (append exec-path '("/usr/local/bin" "/usr/local/opt/llvm/bin")))
(setq vc-follow-symlinks t)

(require 'better-defaults)

(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))
