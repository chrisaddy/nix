{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libvterm
    texliveFull
    texlivePackages.dvisvgm
    ghostscript
    rustfmt
    cargo
    rust-analyzer
    wl-clipboard
  ];

  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        dashboard
        all-the-icons
        auto-package-update
        command-log-mode
        company
        company-box
        dap-mode
        direnv
        docker
        dockerfile-mode
        docker-compose-mode
        doom-modeline
        doom-themes
        org
        evil
        evil-collection
        evil-commentary
        evil-leader
        evil-org
        forge
        gptel
        helpful
        lsp-mode
        lsp-treemacs
        lsp-ui
        magit
        markdown-mode
        org-modern
        nix-mode
        org
        org-download
        org-drill
        org-roam
        pdf-tools
        org-pdftools
        python-mode
        rainbow-mode
        rustic
        slime
        vertico
        vterm
        vundo
      ];
    extraConfig = ''
                       (setq gc-cons-threshold (* 50 1000 1000))

                       (set-face-attribute 'default nil :font "FiraCode-24" )

                       (use-package doom-themes
                         :config
                         (setq custom-safe-themes t)
                         (setq doom-themes-enable-bold t)
                  (setq doom-themes-enable-italic t)
                         (load-theme 'doom-tokyo-night))
                         ;;(doom-themes-visual-bell-config)
                         ;;(doom-themes-neotree-config)
                         ;;(setq doom-themes-treemacs-theme "doom-atom")
                         ;;(doom-themes-treemacs-config)
                         ;;(doom-themes-org-config))

                       (use-package doom-modeline
                         :hook (after-init . doom-modeline-mode)
                         :config
                         (setq doom-modeline-support-imenu t)
                         (setq doom-modeline-project-detection 'auto)
                         (setq doom-modeline-buffer-file-name-style 'auto)
                         (setq doom-modeline-icon t)
                         (setq doom-modeline-major-mode-icon t)
                         (setq doom-modeline-major-mode-color-icon t)
                         (setq doom-modeline-buffer-modification-icon t)
                         (setq doom-modeline-lsp-icon t)
                         (setq doom-modeline-time-icon t)
                         (setq doom-modeline-time-live-icon t))

                       (setq inhibit-startup-message t)
                       (use-package dashboard
                         :ensure t
                         :config
                         (dashboard-setup-startup-hook)
                         (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
                         (setq dashboard-banner-log-title "welcome to the command center")
                         (setq dashboard-startup-banner 'official)
                         (setq dashboard-center-content t)
                         (setq dashboard-show-shortcuts nil)
                         (setq dashboard-items '((recents   . 5)
                  		        (bookmarks . 5)
                  		        (projects  . 5)
                  		        (agenda    . 5)
                  		        (registers . 5))))

                       (defvar hyperprior/frame-transparency '(90 . 90))
                       (set-frame-parameter (selected-frame)
                                             'alpha hyperprior/frame-transparency)
                       (add-to-list 'default-frame-alist
                                     `(alpha . ,hyperprior/frame-transparency))
                       (set-frame-parameter (selected-frame) 'fullscreen 'maximized)
                       (add-to-list 'default-frame-alist '(fullscreen . maximized))

                       (scroll-bar-mode -1)
                       (tool-bar-mode -1)
                       (tooltip-mode -1)
                       (menu-bar-mode -1)
                       (set-fringe-mode 10)
                       (setq visible-bell t)

                       (global-display-line-numbers-mode 1)
                       (setq display-line-numbers-type 'relative)
                       (dolist (mode '(term-mode-hook
                                       shell-mode-hook
                                       treemacs-mode-hook
                                       eshell-mode-hook))
                         (add-hook mode (lambda () (display-line-numbers-mode 0))))

                       (use-package rainbow-mode)

                       (global-set-key (kbd "<escape>")
                                       'keyboard-escape-quit)

                       (use-package evil
                         :init
                         (setq evil-want-integration t)
                         (setq evil-want-keybinding nil)
                         (setq evil-want-C-u-scroll t)
                         (setq evil-want-C-i-jump nil)
                         :config
                         (evil-mode 1)
                         (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
                         (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
                         (evil-global-set-key 'motion "j" 'evil-next-visual-line)
                         (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
                         (evil-set-initial-state 'messages-buffer-mode 'normal)
                         (evil-set-initial-state 'dashboard-mode 'normal))

                       (use-package evil-collection
                         :after evil
                         :config
                         (evil-collection-init))

                       ;; org mode
                       (defun hyperprior/org-agenda-add-current-file ()
                         (when (and buffer-file-name
                           (string-match "\\.org$" buffer-file-name)
                             (not (member buffer-file-name org-agenda-files)))
                           (org-agenda-file-to-front)))

                       (add-hook 'after-save-hook #'hyperprior/org-agenda-add-current-file)

                     (use-package org
                       :pin org
                       :commands (org-capture org-agenda)
                       :hook (org-mode . hyperprior/org-mode-setup)
                       :config
                       (setq org-default-notes-file (concat org-directory "~/notes/20241007124018-brain_dump.org"))

                       (setq org-ellipsis " ▾")
                       (setq org-agenda-start-with-log-mode t)
                       (setq org-log-done 'time)
                       (setq org-log-into-drawer t)
                       (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
                       (global-set-key "\C-cl" 'org-store-link)
                       (require 'org-habit)
                       (add-to-list 'org-modules 'org-habit)
                       (setq org-habit-graph-column 60)
                       (setq org-todo-keywords
                         '((sequence "TODO(t)"
                                     "NEXT(n)"
                                     "|"
                                     "DONE(d!)")
                           (sequence "BACKLOG(b)"
                                     "READY(r)"
                                     "ACTIVE(a)"
                                     "REVIEW(v)"
                                     "HOLD(h)"
                                     "|"
                                     "COMPLETED(c)"
                                     "CANC(k@)")))
                       (setq org-refile-targets
                             '(("Archive.org" :maxlevel . 1)
                             ("Tasks.org" :maxlevel . 1)))
                       (advice-add 'org-refile :after 'org-save-all-org-buffers)
                       (setq org-tag-alist
                         '((:startgroup)
                            (:endgroup)
                            ("@home" . ?H)
                            ("@work" . ?W)
                            ("note" . ?n)
                            ("idea" . ?i)))
                       (setq org-agenda-custom-commands
                         '(("d" "Dashboard"
                          ((agenda "" ((org-deadline-warning-days 7)))
                           (todo "NEXT"
                             ((org-agenda-overriding-header "Next Tasks")))
                           (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

                          ("n" "Next Tasks"
                          ((todo "NEXT"
                             ((org-agenda-overriding-header "Next Tasks")))))
                         ("W" "Work Tasks" tags-todo "+work-email")
                         ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
                          ((org-agenda-overriding-header "Low Effort Tasks")
                           (org-agenda-max-todos 20)
                           (org-agenda-files org-agenda-files)))
                         ("w" "Workflow Status"
                        (
                         (todo "REVIEW"
                               ((org-agenda-overriding-header "In Review")
                                (org-agenda-files org-agenda-files)))
                         (todo "BACKLOG"
                               ((org-agenda-overriding-header "Project Backlog")
                                (org-agenda-todo-list-sublevels nil)
                                (org-agenda-files org-agenda-files)))
                         (todo "READY"
                               ((org-agenda-overriding-header "Ready for Work")
                                (org-agenda-files org-agenda-files)))
                         (todo "ACTIVE"
                               ((org-agenda-overriding-header "Active Projects")
                                (org-agenda-files org-agenda-files)))
                         (todo "COMPLETED"
                               ((org-agenda-overriding-header "Completed Projects")
                                (org-agenda-files org-agenda-files)))
                         (todo "CANC"
                               ((org-agenda-overriding-header "Cancelled Projects")
                                (org-agenda-files org-agenda-files)))))))

                       (setq org-agenda-files (directory-files-recursively "~/notes" "\\.org$"))


                       (define-key global-map (kbd "C-c j")
                         (lambda () (interactive) (org-capture nil "jj")))

                       (setq org-capture-templates
                         '(("t" "Todo" entry (file+headline "~/notes/20241007124018-brain_dump.org" "Tasks")
                            "* TODO %?\n %i\n %a")))

                       (hyperprior/org-font-setup))

                       (use-package evil-org
                         :after org
                         :hook (org-mode . (lambda () evil-org-mode))
                         :config
                         (require 'evil-org-agenda)
                         (evil-org-agenda-set-keys))

                       (setq org-latex-create-formula-image-program 'dvisvgm)
                       (setq org-preview-latex-default-process 'dvisvgm)
                       ;(setq org-format-latex-options
                       ;  (plist-put org-format-latex-options :scale 1.5))
                       ;(setq org-latex-packages-alist '(("" "amsmath" t)
                       ;                                 ("" "amsthm" t)
                       ;                                 ("" "amssymb" t)))
                       ;(setq org-startup-with-latex-preview t)

                       (use-package org-drill
                         :config
                         (progn
                           (add-to-list 'org-modules 'org-drill)
                           (setq org-drill-add-random-noise-to-intervals-p t)))

                       (with-eval-after-load 'org
                         (org-babel-do-load-languages
                           'org-babel-load-languages
                           '((emacs-lisp . t)
                           (python . t)))
                           (push '("conf-unix" . conf-unix) org-src-lang-modes))

                       (use-package org-roam
                         :custom
                         (org-roam-directory (file-truename "~/notes"))
                         :config
                         (org-roam-db-autosync-mode))

                       (setq org-agenda-files (list org-roam-directory))

                       (use-package org-modern
                         :config
                         (with-eval-after-load 'org (global-org-modern-mode)))

                       (use-package org-download
                         :config
                         (add-hook 'dired-mode-hook 'org-download-enable)
                         (setq-default
                           org-download-method 'directory
                           org-download-image "images"
                           org-download-heading-lvl nil))



                       (use-package evil-leader
                         :config
                         (global-evil-leader-mode)
                         (evil-leader/set-leader "<SPC>")
                         (evil-leader/set-key
                           "<SPC>" 'execute-extended-command
                           "bd"    'kill-buffer
                           "bj"    'next-buffer
                           "bk"    'previous-buffer
                           "bm"    'buffer-menu
                           "cb"    'rustic-cargo-build
                           "cc"    'rustic-cargo-clippy-fix
                           "cr"    'rustic-cargo-run
                           "ct"    'rustic-cargo-test
                           "da"    'direnv-update-environment
                           "fc"    'hyperprior/jump-to-config
                           "ff"    'find-file
                           "fp"    'project-switch-project
                    "fs"    'save-buffer
                           "gil"   'forge-topics-menu
                           "gm"    'forge-dispatch
                           "gprl"  'forge-list-pullreqs
                    "hh"    'dashboard-open
                           "nn"    'org-roam-node-insert
                           "np"    'hyperprior/jump-to-psf-notes
                           "ns"    'org-roam-node-find
                           "oa"    'org-agenda
                    "oc"    'org-capture
                    "od"    'org-drill-directory
                           "tt"    'org-todo
                           "wd"    'delete-window
                           "wm"    'windmove-left
                           "wn"    'windmove-down
                           "we"    'windmove-up
                           "wi"    'windmove-right
                           "ws"    'split-window-below
                           "wv"    'split-window-right
                           ))
                       (evil-mode 1)

                       ;; LSP
                       (defun hyperprior/lsp-mode-setup ()
                         (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
                         (lsp-headerline-breadcrumb-mode))

                       (use-package lsp-mode
                         :commands (lsp lsp-deferred)
                         :hook (lsp-mode . hyperprior/lsp-mode-setup)
                         :init
                         (setq lsp-keymap-prefix "C-c l"))

                       (use-package lsp-ui
                         :hook (lsp-mode . lsp-ui-mode)
                         :custom
                         (lsp-ui-doc-position 'bottom))

                       (use-package lsp-treemacs
                         :after lsp)

                       (use-package dap-mode
                         :custom
                         (lsp-enable-dap-auto-configure nil)
                         :config
                         (dap-ui-mode 1)
                         :commands dap-debug
                         :config
                         (require 'dap-node)
                         (dap-node-setup))

                       (use-package docker)
                       (use-package dockerfile-mode)
                       (use-package docker-compose-mode)

                       (use-package direnv
                         :config
                         (direnv-mode)
                         (add-hook 'after-init-hook 'direnv-update-environment))

                       (use-package nix-mode
                         :mode "\\.nix\\'")

                       (use-package python-mode
                         :hook (python-mode . lsp-deferred)
                         :custom
                         (dap-python-debugger 'debugpy)
                         :config
                         (require 'dap-python))

                       (use-package rustic
                         :config
                         (setq rustic-format-on-save t)
                         (setq rustic-rustflags "--edition=2021")
                         (setq rustic-lsp-server 'rust-analyzer)
                         :custom
                         (rust-cargo-use-last-stored-arguments t))

                       (use-package company
                         :after lsp-mode
                         :hook (lsp-mode . company-mode)
                         :bind (:map company-active-map
                                ("<tab>" . company-complete-selection))
                                (:map lsp-mode-map
                                ("<tab>" . company-indent-or-complete-common))
                         :custom
                         (company-minimum-prefix-length 1)
                         (company-idle-delay 0.0))

                       (use-package company-box
                         :hook (company-mode . company-box-mode))

                       (use-package magit
                         :commands magit-status
                         :custom
                         (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

                       (use-package forge
                         :config
                         (setq auth-sources '("~/.authinfo")))

                       (use-package magit
                         :commands magit-status
                         :custom
                         (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

                       (use-package evil-commentary
                         :config (evil-commentary-mode))

                       (use-package vterm
                         :commands vterm
                         :config
                         (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
                         ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
                         (setq vterm-max-scrollback 10000))

                       (use-package vertico
                         :config
                         (vertico-mode))

                       (defun hyperprior/jump-to-config ()
                         "Jump to emacs config directory"
                         (interactive)
                         (find-file "~/.config/nixos/home-manager/emacs.nix"))

                       (use-package gptel)
                       (use-package markdown-mode)

                       ;; Make gc pauses faster by decreasing the threshold.
                       (setq gc-cons-threshold (* 2 1000 1000))

                       (use-package vundo)

                       (add-hook 'org-mode-hook (lambda ()
                                     (visual-line-mode)
                                     (org-indent-mode)))

                      ; (org-startup-with-latex-preview t)
                       ;(org-format-latex-options :scale 2.0)


            (org-babel-do-load-languages
             'org-babel-load-languages
             '((lisp . t)))
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((python . t)))

    '';
  };
}
