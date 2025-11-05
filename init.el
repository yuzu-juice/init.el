;;; init.el --- setting file -*- lexical-binding: t -*-

;;; Author: yuzu-juice
;;; Commentary:

;;; Code:
;; byte compile warning 非表示
(setq byte-compile-warnings nil)

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

;;
;; Core Emacs Settings
;;
(leaf emacs
  :doc "Emacs-lisp standard library"
  :tag "built-in"
  :custom
  ;; 現在位置表示
  (column-number-mode . t)
  ;; 行番号表示
  (global-display-line-numbers-mode . t)
  ;; 最初の挨拶非表示
  (inhibit-startup-message . t)
  ;; 最終行に空行を強制
  (require-final-newline . t)
  ;; 起動時に最後に開いていたファイルを開く
  (desktop-save-mode . 1)
  :config
  ;; カーソルの色を変更
  (set-cursor-color "#F79428")
  ;; UTF-8を優先
  (prefer-coding-system 'utf-8)

  :bind (("C-t" . delete-window)
         ("C-h" . delete-backward-char)))

;;
;; Ui Packages
;;
(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-solarized-light t))

(leaf doom-modeline
  :ensure t
  :global-minor-mode t)

(leaf beacon
  :ensure t
  :global-minor-mode t
  :custom ((beacon-color . "#FAB27B")))

;;
;; Editing Packages
;;
(leaf undo-tree
  :ensure t
  :global-minor-mode global-undo-tree-mode
  :custom
  (undo-tree-auto-save-history . nil))

(leaf gcmh
  :ensure t
  :global-minor-mode t
  :custom
  (gcmh-verbose . t))

(leaf puni
  :ensure t
  :global-minor-mode puni-global-mode)

;;
;; Programming Packages
;;
(leaf lsp-mode
  :ensure t
  :hook ((c-mode . lsp)
         (c++-mode . lsp))
  :commands lsp)

(leaf lsp-ui
  :ensure t
  :after lsp-mode
  :commands lsp-ui-mode)

(leaf company
  :ensure t
  :global-minor-mode global-company-mode)

(leaf flycheck
  :ensure t
  :global-minor-mode global-flycheck-mode)

(leaf projectile
  :ensure t
  :global-minor-mode projectile-mode)

(leaf diff-hl
  :ensure t
  :global-minor-mode t
  :after magit
  :config
  (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
  (add-hook 'magit-post-commit-hook #'diff-hl-update))

;;
;; Tools Packages
;;
(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(leaf treemacs
  :ensure t
  :custom
  (treemacs-is-never-other-window . t)
  :bind
  ("<f8>" . treemacs)
  (:treemacs-mode-map
   ([mouse-1] . #'treemacs-single-click-expand-action))
  )

(leaf treemacs-magit
  :ensure t
  :after (treemacs magit))

(leaf treemacs-projectile
  :ensure t
  :after (treemacs projectile)
  :config
  (add-hook 'projectile-after-switch-project-hook
            #'treemacs-display-current-project-exclusively))

(leaf mozc
  :ensure t
  :config
  (setq default-input-method "japanese-mozc"))

(leaf wakatime-mode
  :ensure t
  :global-minor-mode t
  :custom
  ((wakatime-cli-path . "/opt/homebrew/bin/wakatime-cli")))


;;; init.el ends here
