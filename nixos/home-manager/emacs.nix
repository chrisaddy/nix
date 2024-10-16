{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs.emacsPackages; [
    pkgs.libvterm
    pkgs.texliveFull
    pkgs.texlivePackages.dvisvgm
    pkgs.ghostscript
    pkgs.rustfmt
    pkgs.cargo
    pkgs.rust-analyzer

    all-the-icons
    auto-package-update
    command-log-mode
    company
    company-box
    dap-mode
    dashboard
    dirvish
    doom-modeline
    doom-themes
    elfeed
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
    org
    org-bullets
    org-drill
    org-roam
    pdf-tools
    org-pdftools
    python-mode
    rainbow-mode
    rustic
    vertico
    vterm
  ];

  programs.emacs = {
    enable = true;
    extraConfig = ''
      (setq gc-cons-threshold (* 50 1000 1000))
      (defun hyperprior/display-startup-time ()
        (message "emacs loaded in %s with %d garbage collections."
          (format "%.2f seconds"
                  (float-time
                    (time-subtract after-init-time before-init-time)))
          gcs-done))
      (add-hook 'emacs-startup-hook #'hyperprior/display-startup-time)

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
      (defun hyperprior/org-font-setup ()
        (font-lock-add-keywords 'org-mode
          '(("^ *\\([-]\\) "
          (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
         (dolist (face '((org-level-1 . 1.2)
                          (org-level-2 . 1.1)
                          (org-level-3 . 1.05)
                          (org-level-4 . 1.0)
                          (org-level-5 . 1.1)
                          (org-level-6 . 1.1)
                          (org-level-7 . 1.1)
                          (org-level-8 . 1.1)))))

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
      (setq org-ellipsis " ▾")
      (setq org-agenda-start-with-log-mode t)
      (setq org-log-done 'time)
      (setq org-log-into-drawer t)
      (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
      (global-set-key "\C-cl" 'org-store-link)
      (global-set-key "\C-ca" 'org-agenda)
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
           ("@errand" . ?E)
           ("@home" . ?H)
           ("@work" . ?W)
           ("agenda" . ?a)
           ("publish" . ?P)
           ("batch" . ?b)
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

      (use-package org-bullets
        :hook (org-mode . org-bullets-mode)
        :custom
        (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

      (with-eval-after-load 'org
        (org-babel-do-load-languages
          'org-babel-load-languages
          '((emacs-lisp . t)
          (python . t)))
          (push '("conf-unix" . conf-unix) org-src-lang-modes))

      (with-eval-after-load 'org
        (org-return-follows-link t))

      (use-package org-roam
        :custom
        (org-roam-directory (file-truename "~/notes"))
        :config
        (org-roam-db-autosync-mode))

        
      ;;(require 'org-roam-protocol)

      (use-package pdf-tools)
      (use-package org-pdftools
        :hook (org-mode . org-pdftools-setup-link))

      (use-package elfeed
        :config
        (setq elfeed-feeds
          '(("http://nullprogram.com/feed" blog emacs)
            ("http://export.arxiv.org/rss/stat.ML/" stats ml)
            ("http://labs.spotify.com/feed/" engineering)
            ("http://bair.berkeley.edu/blog/feed.xml" ai)
            ("https://code.fb.com/category/ai-research/feed/" ai engineering)
            ("https://blog.github.com/changelog/all.atom" engineering)
            ("https://tech.dropbox.com/feed/" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCUzmizB92LJ9oxf5T_snZNA" politics youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA" linux youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2EQzAewrC10KCDFSS4j-zA" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCfz8x0lVzJpb_dgWm9kPVrw" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC8ENHE5xdFSwx71u3fDH5Xw" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCIFk2uvCNcEmZ77g0ESKLcQ" alt)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCbtV5L8TVB0zQ9khThGApLw" alt)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC6biysICWOJ-C3P4Tyeggzg" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9H0HzpKf5JlazkADWnW1Jw" youtube programming)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVk4b-svNJoeytrrlOixebQ" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCUyeluBRhGPCW4rPe_UvBZQ" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYeiozh-4QwuC1sjgCmB92w" programming youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCvcEBQ0K3UsQ8bzWKHKQmbw" productivity health youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBX_-ls-dXuhFNSWSXcHrTA" productivity youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJ24N4O0bP7LGLBDvye7oCA" productivity youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCftSbpEaMtTWcaFnvjwCvXw" productivity youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC358urzyldvD78E9o2sR-Og" politics youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4gHQVTdWoU40Lm-dqhe0UQ" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCByZMNYpHFEetI0s3deYH2g" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCkS_HP3m9NXOgswVAKbMeJQ" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCxTdWpLJurbGlFMWOwXWG_A" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCqU_vPg5x9rULpjxunpW-vg" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCpBRZBzWQ_cCc_9zKG08L-g" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCK5R1BsMtGd4DtI5uGQRHIg" youtube productivity gear)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCq6aw03lNILzV96UvEAASfQ" youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJl3rlunlzq0-sMnXM_HRAg" youtube)
            ("http://export.arxiv.org/rss/cs.LG" ml cs)
            ("https://code.facebook.com/posts/rss" engineering ml)
            ("https://flowingdata.com/feed" engineering dataviz)
            ("hannel_id=UCXZCJLdBC09xxGZ6gcdrc6A" youtube ai engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCPPZoYsfoSekIpLcz9plX1Q" youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCSBHtM-U0q5dR7YE_aYcWzQ" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYyaQsm2HyneP9CsIOdihBw" youtube productivity)
            ("http://feeds.feedburner.com/zenhabits" habits)
            ("http://www.argmin.net/feed.xml" engineering)
            ("https://medium.com/feed/medium-eng" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCntrDMFntic0pULIhVFZ8qw" youtube funny)
            ("http://martinfowler.com/bliki/bliki.atom" engineering)
            ("http://topics.nytimes.com/top/reference/timestopics/subjects/a/artificial_intelligence/?rss=1" ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC1rFmaGLYr0Ve_Y_soxZNWQ" youtube scifi)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVIFCOJwv3emlVmBbPCZrvw" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCLuYADJ6hESLHX87JnsGbjA" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCfJxmjbygyA5KEdzzZv6Pbw" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9Kq-yEt1iYsbUzNOoIRK0g" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCrr7y8rEXb7_RiVniwvzk9w" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCq3Wpi10SyZkzVeS7vzB5Lw" youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCvlj0IzjSnNoduQF0l3VGng" youtube news funny)
            ("https://aws.amazon.com/blogs/aws/feed/" engineering)
            ("https://eng.uber.com/feed/" engineering)
            ("http://feeds.feedburner.com/blogspot/gJZg" research)
            ("https://www.joelonsoftware.com/feed/" blog)
            ("http://www.smbc-comics.com/rss.php" comics)
            ("http://xkcd.com/rss.xml" comics)
            ("http://feeds.feedburner.com/Explosm" comics)
            ("https://theoatmeal.com/feed/rss" comics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQWoY8CkEGeE4t62djCZk-A" youtube philosophy)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHKZdDf09_8vVHm102fu0sg" youtube philosophy)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJ6o36XL0CpYb6U5dNBiXHQ" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtUId5WFnN82GdDy7DgaQ7w" youtube politics)
            ("http://newleftreview.org/feed" politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UChBD4NpITiW2CzIz5GwppDA" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHiwtz2tCEfS17N9A-WoSSw" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UClt01z1wHHT7c5lKcU8pxRQ" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UComkllJTMHNZr4UNxCThdcw" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCs8mbJ-M142ZskR5VR0gBig" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCSkzHxIcfoEr69MWBdo0ppg" politics)
            ("http://monthlyreview.org/feed" politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2PA-AKmVpU6NKCGtZq_rKQ" youtube politics)
            ("https://prolespod.libsyn.com/rss" politics)
            ("http://www.revolutionarycommunist.org/index.php?format=feed&type=rss" politics)
            ("https://firstlook.org/theintercept/staff/jeremy-scahill/feed/" politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCCvdjsJtifsZoShjcAAHZpA" youtube politics)
            ("http://varianceexplained.org/feed.xml" engineering statistics)
            ("https://eng.uber.com/feed/" engineering)
            ("https://slack.engineering/feed" engineering)
            ("https://thegradient.pub/rss/" engineering)
            ("http://dataelixir.com/issues.rss" engineering ml)
            ("http://feeds.feedburner.com/statsblogs" statistics)
            ("https://blogs.microsoft.com/ai/feed/" engineering ai)
            ("https://github.blog/category/engineering/feed/" engineering)
            ("http://codeascraft.etsy.com/feed/" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA" youtube computing)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCaiL2GDNpLYH6Wokkk1VNcg" youtube computing)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCfe_znKY1ukrqlGActlFmaQ" youtube engineering career health)
            ("http://engineering.squarespace.com/blog?format=RSS" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC6nSFpj9HTCZ5t-N3Rm3-HA" youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA" computing youtube)
            ("https://deepmind.com/blog/feed/basic/" ai)
            ("http://blog.discordapp.com/rss/" engineering)
            ("https://robinhood.engineering/feed" engineering)
            ("http://web.mit.edu/newsoffice/topic/mitcomputers-rss.xml" engineering ai)
            ("https://engineering.linkedin.com/blog.rss" engineering)
            ("http://coding-is-like-cooking.info/feed/" engineering)
            ("http://gdata.youtube.com/feeds/base/users/minutephysics/uploads?alt=rss&v=2&orderby=published&client=ytapi-youtube-profile" youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCg98oJZNffR9nDLJNkorjqw" youtube keebs)
            ("https://understandlegacycode.com/rss.xml" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UChnxLLvzviaR5NeKOevB8iQ" youtube music)
            ("http://googleresearch.blogspot.com/atom.xml" engineering ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCCBSoR9ZO0Uj7W6jH9Y317g" youtube)
            ("http://news.mit.edu/rss/topic/artificial-intelligence2" ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCllGwtW6scxAjM28fIgEozg" youtube)
            ("http://blog.stackoverflow.com/feed/" engineering)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMHXMAeKkI6HXlPfLiYvo9g" youtube keebs)
            ("http://engineeringblog.yelp.com/feed.xml" engineering)
            ("https://towardsdatascience.com/feed" ml)
            ("https://medium.com/feed/zendesk-engineering" engineering)
            ("http://lambda-the-ultimate.org/rss.xml" engineering)
            ("http://blog.cleancoder.com/atom.xml" engineering)
            ("https://medium.com/feed/paypal-engineering" engineering)
            ("https://eng.lyft.com/feed" engineering)
            ("https://paperswithcode.com/latest" engineering ai)
            ("http://techblog.netflix.com/feeds/posts/default" engineering)
            ("http://www.fast.ai/atom.xml" engineering ai)
            ("https://eng.uber.com/tag/ai/feed/" engineering ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCoxcjq-8xIDTYp3uz647V5A" youtube math)
            ("https://www.deeplearning.ai/feed/" ai)
            ("http://www.countbayesie.com/blog?format=RSS" statistics)
            ("https://thesequence.substack.com/feed" ml ai)
            ("http://cacm.acm.org/browse-by-subject/theory.rss" computing)
            ("http://simplystatistics.org/feed/" statistics)
            ("http://ai.stanford.edu/blog/feed.xml" ai)
            ("https://www.eeddit.com/r/vim/.rss" reddit vim)
            ("https://www.reddit.com/r/neovim/.rss" reddit vim)
            ("https://www.reddit.com/r/emacs/.rss" reddit emacs)
            ("https://www.reddit.com/r/orgmode/.rss" reddit emacs)
            ("https://www.reddit.com/r/commandline/.rss" reddit programming)
            ("https://www.reddit.com/r/Bayes/.rss" reddit statistics)
            ("https://www.reddit.com/r/BayesianProgramming/.rss" reddit statistics)
            ("https://www.reddit.com/r/machinelearningnews/.rss" reddit ml)
            ("https://www.reddit.com/r/MachineLearening/.rss" reddit ml)
            ("https://www.reddit.com/r/MechanicalKeyboards/.rss" reddit)
            ("https://www.reddit.com/r/MLPapersQandA/.rss" reddit ml)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC_rI3y1DzDULTr-UIvshiwg" youtube productivity gear)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNvsIonJdJ5E4EXMa65VYpA" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCbbsW7_Esx8QZ8PgJ13pGxw" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9XFvuObhfVUNAGNcH8Y_fw" politics youtube philosophy)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQpltQMhYFvyeS5M6P0Zg-Q" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCDq5v10l4wkV5-ZBIJJFbzQ" youtube cooking)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCh9IfI45mmk59eDvSWtuuhQ" youtube funny)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC5fdssPqmmGhkhsJi4VcckA" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9infsKo33_2LUoiqXGgQWg" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCj7ML5-da-bCCcHz0ipUmYQ" youtube gear)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCgBVkKoOAr3ajSdFFLp13_A" youtube engineering funny)
            ("https://feeds.feedburner.com/amazingsuperpowers" comics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-nPM1_kSZf91ZGkcgy_95Q" youtube health)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC__xRB5L4toU9yYawt_lIKg" youtube news politics french)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYpRDnhk5H8h16jpS84uqsA" youtube news politics french)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHGMBrXUzClgjEzBMei-Jdw" youtube news politics french)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCvWRKmcplBTYQS49AVGsLgw" youtube philosophy)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXlDgfWY2JbsYEam2m68Hyw" youtube keebs)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC_SLXSHcCwK2RSZTXVL26SA" youtube religion islam)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCAAJCQ0FCqRmAEv95SyTfNg" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCB9JcmYVd-oHcZyCNraCiug" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCrR45-PQv6TCwUCSPJ1ud2g" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCg2vrLOhBWk7ZQy3pnzIYgQ" youtube relgion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCBTO34CZcIYGK6Qm2vQ-SMA" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UChhMB_J0kz8eBJECy4d5uSQ" youtube religion folklore)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCMLtBahI5DMrt0NPvDSoIRQ" youtube ml)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UChpleBmo18P08aKCIgti38g" youtube ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCG6qpjVnBTTT8wLGBygANOQ" youtube ml)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNJ1Ymd5yFuUPtn21xtRbbw" youtube ai)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCjm0K6zj7H3FIX-K8Y1bSBw" youtube spanish philosophy)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC75suCpChvMVC_9ij7rUpxw" youtube news)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCSYCo8uRGF39qDCxF870K5Q" youtube news)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCK5-hzSvMAPSSo2vH_LtNKw" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC604SM0YhltEKZ5hmDs_Gqw" youtube esoteric)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC48MclMZIY_EaOQwatzCpvw" youtube magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCPSbip_LX2AxbGeAQfLp-Ig" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC6DkPfjmk6B97oODNzqWxqA" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-TXAaA8TjO1-TE9qAfc5dA" youtube esoteric)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVtWVX2xirq6Nybf5bumqwg" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQud0oTvNbSM58ZUAZwm_RQ" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCuulUz5sIdikcX8F5mbP2YA" youtube esoteric magic)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCos-4AWoJFDR27m3XhC9zvQ" youtube esoteric)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2D2CMWXMOVWx7giW1n3LIg" youtube health productivity)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWVCimOe67LOfyi9PjUeGgA" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCgLZ5SDuR1W_xO8y3A_4VVw" youtube religion)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtdweFMJ5DGj7_q5IcpQhPQ" youtube esoteric)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCoydhtfFSk1fZXNRnkGnneQ" youtube esoteric)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCIhJnsJ0HlVNnYfp-gw_5Q" productivity youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCyNtlmLB73-7gtlBz00XOQQ" politics youtube)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4dBHeQ4xfz5zBwaIcmEJfg" youtube politics)
            ("https://www.youtube.com/feeds/videos.xml?channel_id=UCmvYCRYPDlzSHVNCI_ViJDQ" youtube productivity))))

      (defun elfeed-update-and-show ()
        (interactive)
        (elfeed)
        (elfeed-search-fetch nil))

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
          "fc"    'hyperprior/jump-to-config
          "fi"    'hyperprior/jump-to-inbox
          "ff"    'find-file
          "fj"    'dirvish-quick-access
          "fn"    'elfeed-update-and-show
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
	  "od"    'org-drill-directory
          "tt"    'org-todo
          "wd"    ' kill-buffer-and-window
          "wh"    'windmove-left
          "wj"    'windmove-down
          "wk"    'windmove-up
          "wl"    'windmove-right
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

      (use-package python-mode
        :hook (python-mode . lsp-deferred)
        :custom
        (dap-python-debugger 'debugpy)
        :config
        (require 'dap-python))

      (use-package rustic
        :config
        (setq rustic-format-on-save t)
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

      (use-package evil-commentary :config (evil-commentary-mode))

      (use-package vterm
        :commands vterm
        :config
        (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
        ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
        (setq vterm-max-scrollback 10000))

      (use-package vertico
        :config
        (vertico-mode))

      (use-package dirvish
        :config
        (dirvish-override-dired-mode)
        :custom
        (dirvish-quick-access-entries
        '(("h" "~/" "home")
        ("d" "~/Downloads" "downloads")
        ("n" "~/notes" "notes")
        ("p" "~/projects/psf/pocketsizefund" "pocketsizefund")
        ))
        :config
        ;;(dirvish-vc-mode 1)
        ;;(dirvish-icon-mode 1)
        (setq dirvish-mode-line-format '(:left (sort file-time " " file-size symlink) 
                                         :right (omit yank index)))
        (setq dirvish-attributes '(all-the-icons file-size vc-state git-msg))
        (setq dirvish-header-line-format '(:left (path) :right (free-space)))
        (setq dirvish-header-line-height '(25 . 25)))

      (with-eval-after-load 'dirvish
        (defun dirvish-jump-with-zoxide (&optional other-window)
        (interactive "P")
        (zoxide-open-with
         nil
         (lambda (file)
           (if other-window
	     (dirvish-other-window file)
	     (dirvish file)))
           t)))

      (defun hyperprior/jump-to-config ()
        "Jump to emacs config directory"
        (interactive)
        (find-file "~/.config/nixos/home-manager/emacs.nix"))

      (defun hyperprior/jump-to-psf-notes ()
        "Jump to pocketsizefund notes"
        (interactive)
        (find-file "~/projects/pocketsizefund/pocketsizefund/notes.org"))

      (defun hyperprior/jump-to-inbox ()
        "Jump to org inbox"
        (interactive)
        (find-file "~/notes/brain-dump.org"))

      (use-package gptel)
      (use-package markdown-mode)

      ;;(gptel-make-anthropic "Claude"
      ;; :stream t
      ;; :key (getenv "ANTHROPIC_API_KEY"))

      ;; Make gc pauses faster by decreasing the threshold.
      (setq gc-cons-threshold (* 2 1000 1000))
    '';

  };
}
