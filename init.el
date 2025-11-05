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

;; leaf
(leaf magit
  :ensure t
  :bind (("C-x g" . magit-status)))
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
(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-solarized-light t))
(leaf doom-modeline
  :ensure t
  :global-minor-mode t
)
(leaf beacon
  :ensure t
  :global-minor-mode t
  :custom ((beacon-color . "#FAB27B")))
(leaf mozc
  :ensure t
  :config
  (setq default-input-method "japanese-mozc"))
(leaf puni
  :ensure t
  :global-minor-mode puni-global-mode)
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
(leaf wakatime-mode
  :ensure t
  :custom
  ((wakatime-cli-path . "/opt/homebrew/bin/wakatime-cli"))
  :config
  (global-wakatime-mode))
(leaf treemacs
  :ensure t
  :bind
  ("<f8>" . treemacs)
  (:treemacs-mode-map
   ([mouse-1] . #'treemacs-single-click-expand-action)
   )
  )
(leaf treemacs-magit
  :ensure t
  :after (treemacs magit)
  )
(leaf diff-hl
  :ensure t
  :config
  (global-diff-hl-mode 1)
  (with-eval-after-load 'magit
    (add-hook 'magit-pre-refresh-hook #'diff-hl-magit-pre-refresh)
    (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh)
    (add-hook 'magit-post-commit-hook #'diff-hl-update)))

;; 現在位置表示
(column-number-mode t)

;; 行番号表示
(global-display-line-numbers-mode t)

;; カーソルの色を変更
(set-cursor-color "#F79428")

;; 最初の挨拶非表示
(setq inhibit-startup-message t)

;; 最終行に空行を強制
(setq require-final-newline t)

;; 起動時に最後に開いていたファイルを開く
(desktop-save-mode 1)

;; key bind
(global-set-key (kbd "C-t") 'delete-window)
(global-set-key (kbd "C-h") 'delete-backward-char)

;; UTF-8を優先
(prefer-coding-system 'utf-8)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons beacon blackout cape company corfu doom-modeline
		   doom-themes el-get flycheck gcmh hydra
		   leaf-keywords lsp-ui magit mozc projectile puni
		   shackle undo-tree volatile-highlights wakatime-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
