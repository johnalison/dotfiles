(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  ;(font-lock-add-keywords 'org-mode
  ;			  '(("^ *\\([-]\\) "
  ;			     (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))


  ;; Set faces for heading levels with colors
  ;;(set-face-attribute 'org-level-1 nil :font "Lucida Grande" :weight 'bold    :height 1.1 :foreground "#8350ef")
  (set-face-attribute 'org-level-1 nil :font "Lucida Grande" :weight 'bold    :height 1.1 :foreground "mediumblue")
  (set-face-attribute 'org-level-2 nil :font "Lucida Grande" :weight 'bold    :height 1.1 ) 
  (set-face-attribute 'org-level-3 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 
  (set-face-attribute 'org-level-4 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 
  (set-face-attribute 'org-level-5 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 
  (set-face-attribute 'org-level-6 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 
  (set-face-attribute 'org-level-7 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 
  (set-face-attribute 'org-level-8 nil :font "Lucida Grande" :weight 'regular :height 1.1 ) 

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit '(shadow fixed-pitch) :height 1.0)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch) :height 0.9)
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  )

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  ;;(setq-default line-spacing 0.5) ;; 0.2 means 20% extra space
  (visual-line-mode 1))


(use-package org
  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-files
	'("~/RoamNotes/Tasks.org"
	  "~/RoamNotes/Mail.org"
	  "~/RoamNotes/Archive.org"
	  "~/RoamNotes/Birthdays.org"
	  "~/RoamNotes/gcal.org"
	  ))
  (setq org-hide-emphasis-markers t)
  (setq org-hide-block-startup t)
  (efs/org-font-setup)

  (setq org-insert-heading-respect-content t)
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)


  (setq org-todo-keywords
	'((sequence "TODO(t)" "The ONE thing(o)" "Now(n)" "Someday Maybe(s)" "Waiting(w)" "|" "CANCEL(c!)" "DONE(d!)")
	  ))

  (setq org-refile-targets
	'(("Archive.org" :maxlevel . 1)
	  ("Tasks.org" :maxlevel . 1)
	  ))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  ;;
  (setq org-tag-alist
	'((:startgroup)
					; Put mutually exclusive tags here
	  (:endgroup)
	  ;;("@errand" . ?E)
	  ;;("@home" . ?H)
	  ;;("@work" . ?W)
	  ;;("meeting" . ?m)
	  ;;("planning" . ?p)
	  ("teaching" . ?t)
	  ("emacs" . ?e)
	  ("HGC" . ?H)
	  ("4b" . ?4)
	  ("bbWW" . ?W)
	  ;;("publish" . ?P)
	  ("idea" . ?i)
	  ("question" . ?q)
	  ))


  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
	'(("d" "Dashboard"
	   ((agenda "" ((org-deadline-warning-days 7)))
	    (todo "The ONE thing"
		  ((org-agenda-overriding-header "The ONE Thing")))
	    (todo "Now"
		  ((org-agenda-overriding-header "To do:")))
	    (todo "Waiting"
		  ((org-agenda-overriding-header "Waiting on")))
	    ;;(tags-todo "agenda/Waiting" ((org-agenda-overriding-header "Waiting on")))
	    ))

	  ("t" "To do"
	   ((todo "TODO"
		  ((org-agenda-overriding-header "Open Items")))))

	  ("n" "To do now"
	   ((todo "Now"
		  ((org-agenda-overriding-header "Now:")))))


	  ("o" "The ONE Thing"
	   ((todo "The ONE thing"
		  ((org-agenda-overriding-header "The ONE Thing")))))

	  ("s" "Someday Maybe"
	   ((todo "Someday Maybe"
		  ((org-agenda-overriding-header "Someday Maybe")))))

	  ;; The + [tag-name] means that the tag is required the - [tag-name] means that the tag is excluded
	  ;;("W" "Work Tasks" tags-todo "+work-email")

	  ))

  (setq org-capture-templates
	`(("a" "Appointment" entry (file "~/RoamNotes/gcal.org" )
	   "* %?")
	  ("t" "Tasks / Projects")

	  ;; %? is for the cursor /  %U is the time stamp  / %a is the link to the file / %i is the current region
	  ;;("tt" "Task" entry (file+olp "~/RoamNotes/Tasks.org" "Inbox")
	  ;; "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)
	  ("tt" "Task" entry (file "~/RoamNotes/Tasks.org")
           "* TODO %?\n  %U\n " :empty-lines 1)

	  ("m", "Email Workflow")
	  ("mf", "Follow Up" entry (file+olp "~/RoamNotes/Mail.org" "Follow Up")
	   "* TODO %a\n\n %i"
	   :immediate-finish t)

	  ("mr", "Read Later" entry (file+olp "~/RoamNotes/Mail.org" "Read Later")
	   "* TODO %a\n\n %i"
	   :immediate-finish t))
	)
  )

;
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "<M-left>") nil)
  (define-key org-mode-map (kbd "<backtab>") nil)
  (define-key org-mode-map (kbd "<M-right>") nil))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("○" "-" "" "" "" "" "")))

  ;; Other options: "◉" "○" "●" "○" "●" "○" "●"

(setq org-latex-create-formula-image-program 'dvipng) ;; or 'dvisvgm for SVG output
(setq org-export-with-broken-links t)  ;; Allow all broken links
(setq org-startup-with-latex-preview t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width '(300))

;; adjust image size, scale, background, etc.
(setq org-format-latex-options
      ;; (see C-h v org-format-latex-options for all settings)
      '(:foreground default :background default
        :scale 2.0   ; 1.0 = 100% size
        :html-foreground "Black" :html-background "Transparent"
        :html-scale 1.0))

(add-to-list 'display-buffer-alist
             '("\\*Calendar\\*"
               (display-buffer-in-side-window)
               (side . top)
               (window-height . 20)))

(setq org-agenda-span 'day)

(define-prefix-command 'org-roam-prefix-map)
(global-set-key (kbd "C-c n") 'org-roam-prefix-map)


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-dailies-directory   "Journal/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      (file "~/RoamNotes/Templates/DailyTemplate.org")
      :target (file+head "%<%Y/%m-%B/%d-%B-%Y-%A>.org" "#+title: %<%d %B %Y %A>\n")))
   )
  (org-roam-capture-templates
   '(("d" "default" plain
      "\n\n %?\n" :empty-lines-before 1
      :if-new (file+head "Notes/${slug}-%<%Y%m%d%H%M%S>.org" "#+title: ${title}\n")
      :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies) ;; Ensure the keymap is available
  ;; Configure backlinks buffer to always appear at the bottom
  (add-to-list 'display-buffer-alist
               '("\\*org-roam\\*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (slot . 0)
                 (window-width . 0.33)
                 (window-height . 0.4)
                 (window-parameters . ((no-delete-other-windows . t)))))
  (org-roam-setup))
(org-roam-db-autosync-mode)

(require 'org-roam-dailies)

(defun my/roam-dailies--today-filepath ()
  "Return the absolute path of today’s Org-roam daily note."
  (let* ((fname (format-time-string "%Y/%m-%B/%d-%B-%Y-%A.org" (current-time)))
         (dir   (expand-file-name org-roam-dailies-directory
                                  org-roam-directory)))
    (expand-file-name fname dir)))

(defun my/roam-dailies-goto-or-capture-today ()
  "If today’s daily file exists, `goto` it; otherwise `capture` it."
  (interactive)
  (let ((file (my/roam-dailies--today-filepath)))
    ;; ensure the dailies directory is there
    (unless (file-directory-p (file-name-directory file))
      (make-directory (file-name-directory file) :parents))
    (if (file-exists-p file)
        ;; ── already there → just visit it ──
        (org-roam-dailies-goto-today)
      ;; ── absent → create via your capture template “d” ──
      (org-roam-dailies-capture-today))))

(defun org-roam-dailies--list-files-recursively ()
  "List all Org files in `org-roam-dailies-directory' and its subdirectories."
  (let ((dailies-dir (expand-file-name org-roam-dailies-directory org-roam-directory)))
    (directory-files-recursively dailies-dir "\\.org$")))

(advice-add 'org-roam-dailies--list-files :override #'org-roam-dailies--list-files-recursively)

;(global-set-key (kbd "s-d") 'org-roam-dailies-goto-today)
(global-set-key (kbd "s-d") 'my/roam-dailies-goto-or-capture-today)
(global-set-key (kbd "s-c") 'org-roam-dailies-goto-date)
(global-set-key (kbd "s-a") (lambda () (interactive) (org-agenda nil "d")))
(global-set-key (kbd "C-s-{") 'org-roam-dailies-find-previous-note)
(global-set-key (kbd "C-s-}") 'org-roam-dailies-find-next-note)
(global-set-key (kbd "s-t") (lambda () (interactive) (org-capture nil "tt")))
(global-set-key (kbd "s-q") 'org-roam-node-insert-immediate)
(global-set-key (kbd "s-i") 'org-roam-node-insert)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-<tab>") 'org-shifttab)
(global-set-key (kbd "C-c s") 'org-store-link)

(add-to-list
 'display-buffer-alist
 '("^\\*Org Agenda\\*$"                           ; any agenda buffer
   (display-buffer-reuse-window                  ; ► first try to reuse…
    )               ; ► …else make a side‑window
   (side         . right)                        ; right edge of the frame
   (slot         . 0)                            ; topmost slot on that side
   (window-width . 0.50)                         ; half the frame’s width
   ;; optional niceties
   ;;(window-parameters . ((no-delete-other-windows . t) ; keep layout stable
   ;;                      ))
   )) ; M‐p / M‐n ignore

(use-package consult-org-roam
   :ensure t
   :after org-roam
   :init
   (require 'consult-org-roam)
   ;; Activate the minor mode
   (consult-org-roam-mode 1)
   :custom
   ;; Use `ripgrep' for searching with `consult-org-roam-search'
   ;(consult-org-roam-grep-func #'consult-ripgrep)
   ;; Configure a custom narrow key for `consult-buffer'
   (consult-org-roam-buffer-narrow-key ?r)
   ;; Display org-roam buffers right after non-org-roam buffers
   ;; in consult-buffer (and not down at the bottom)
   (consult-org-roam-buffer-after-buffers t)
   :config
   ;; Eventually suppress previewing for certain functions
   (consult-customize
    consult-org-roam-forward-links
    :preview-key "M-.")
   :bind
   ;; Define some convenient keybindings as an addition
   ("C-c n e" . consult-org-roam-file-find)
   ("C-c n b" . consult-org-roam-backlinks)
   ("C-c n B" . consult-org-roam-backlinks-recursive)
   ("C-c n b" . consult-org-roam-backlinks)     
   ("C-c n l" . consult-org-roam-forward-links)
   ("C-c n g" . consult-org-roam-search)
   )

(defun my/org-notes-auto-commit ()
  "Auto-commit and push all changes in the notes repository, including untracked files."
  (let ((default-directory "~/RoamNotes")) ;; Replace with your notes repo path
    (when (file-directory-p default-directory)
      (require 'magit)
      ;; Save all modified buffers before Git actions
      (save-some-buffers t)
      ;; Stage all changes
      (magit-run-git "add" "-A")
      ;; Commit only if something is staged
      (when (magit-staged-files)
        (magit-commit-create
         `("-m" ,(format "Auto-commit notes: %s" (format-time-string "%F %T"))))
	(magit-push-current-to-pushremote nil)))))

(run-at-time "0 min" 3600 #'my/org-notes-auto-commit)

(defun my/org-open-at-point-no-select ()
  "Open the Org link at point but keep focus in the current window."
  (interactive)
  (save-selected-window
    (org-open-at-point)))

;; rebind C-c p in Org mode to our new version
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c p") #'my/org-open-at-point-no-select))

(defun my/org-open-at-point-no-select-mouse (event)
  "Call my/org-open-at-point-no-select at the position of mouse click EVENT."
  (interactive "e")
  (let* ((pos (event-start event))
         (window (posn-window pos))
         (buffer (window-buffer window))
         (position (posn-point pos)))
    (with-current-buffer buffer
      (goto-char position)
      (my/org-open-at-point-no-select))))

(global-set-key [M-S-mouse-1] 'my/org-open-at-point-no-select-mouse)

(require 'org-contacts)
(setq org-contacts-files '("~/RoamNotes/Contacts.org"))

(defun jda/org-contacts-groups ()
  "Return a list of all unique group names in org-contacts."
  (let ((groups '()))
    (org-map-entries
     (lambda ()
       (let ((contact-groups (org-entry-get nil "GROUP")))
         (when contact-groups
           (dolist (group (split-string contact-groups))
             (add-to-list 'groups group)))))
     nil
     (org-contacts-files))
    groups))


(defun jda/get-group-emails (group)
  "Return a list of emails for contacts in GROUP."
  (let ((emails '()))
    (org-map-entries
     (lambda ()
       (let ((contact-groups (org-entry-get nil "GROUP"))
             (email (org-entry-get nil "EMAIL")))
	 (when (and contact-groups email
                    (string-match (regexp-quote group) contact-groups))
           (push email emails))))
     nil
     (org-contacts-files))
    emails))


(defun jda/insert-group-emails (group)
  "Insert comma-separated list of emails for GROUP.
 With completion for available groups."
  (interactive
   (list (completing-read "Group name: " (jda/org-contacts-groups))))
  (let ((emails (jda/get-group-emails group)))
    (insert (mapconcat 'identity emails ", "))))

(org-babel-do-load-languages
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(setq org-babel-python-command "/opt/homebrew/bin/python3")
(setq org-confirm-babel-evaluate nil)


(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

(require 'plstore)
(add-to-list 'plstore-encrypt-to "D37214566A581BF2")


(setq plstore-cache-passphrase-for-symmetric-encryption t)

(setq org-gcal-client-id "57759006028-j8fafbn9prevdvjihbrf7hslpf0g09aa.apps.googleusercontent.com"
      org-gcal-client-secret (efs/lookup-password :host "org-gal-client")
      org-gcal-fetch-file-alist '(("johnda102@gmail.com" .  "~/RoamNotes/gcal.org")))

(require 'org-gcal)
(setq org-gcal-auto-archive t)
(setq org-gcal-remove-api-cancelled-events t)

;;(add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync)))
;;(add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync)))

;; adjust path if needed
(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e")

(defun efs/capture-mail-follow-up (msg)
  "Capture a follow-up task from an email."
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mf"))

(defun efs/capture-mail-read-later (msg)
  "Capture a readlater task from an email."
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "mr"))

(use-package mu4e
  :ensure nil
  ;:load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e"
  :defer 20 ; Wait until 20 seconds after startup
  :bind(:map mu4e-search-minor-mode-map
	     ("M-<right>" . right-word)
	     ("M-<left>" .  left-word)
	     )
  :bind(:map mu4e-compose-mode-map
  	         ("M-n" .  forward-paragraph)
	     ("M-p" .  backward-paragraph)
	     )

  :config
  (require 'mu4e-org)
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 30 minutes
  (setq mu4e-update-interval (* 30 60))
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/Mail")
  (setq mu4b-mu-binary "/opt/homebrew/bin/mu")
  (setq user-mail-address  "johnalison@cmu.edu")
  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")
  (setq mu4e-compose-format-flowed t)
  (setq mu4e-compose-signature nil)
  (setq mu4e-attachment-dir "~/Downloads")

  (setq mu4e-headers-show-threads nil)      ;; Main option to disable threading
  (setq mu4e-headers-include-related nil)   ;; Don't include related messages
  (setq mu4e-headers-skip-duplicates nil)   ;; Show all messages, even duplicates


  ;; Add custom actions for our capture templates
  (add-to-list 'mu4e-headers-actions
	       '("follow up" . efs/capture-mail-follow-up) t)
  (add-to-list 'mu4e-view-actions
	       '("follow up" . efs/capture-mail-follow-up) t)
  (add-to-list 'mu4e-headers-actions
	       '("read later" . efs/capture-mail-read-later) t)
  (add-to-list 'mu4e-view-actions
	       '("read later" . efs/capture-mail-read-later) t)


  (setq mu4e-bookmarks
	'(("flag:unread AND NOT flag:trashed" "Unread messages"      ?i)
	  ("flag:flagged AND NOT flag:trashed"                     "Flagged"             ?f)
	  ("maildir:\"/Inbox\" and date:today..now AND NOT flag:trashed"                  "Today's messages"     ?t)
	  ("maildir:\"/Inbox\" and date:7d..now AND NOT flag:trashed"                  "This Weeks's messages"     ?w)
	  ("maildir:\"/Inbox\" and date:30d..now AND NOT flag:trashed"                  "This Months's messages"     ?m)
	))


  (setq mu4e-maildir-shortcuts
      '(("/Inbox"             . ?i)
        ("/[Gmail]/Sent Mail" . ?s)
        ("/[Gmail]/Trash"     . ?t)
        ;;("/[Gmail]/Important" . ?m)
        ("/[Gmail]/Drafts"    . ?d)
        ("/[Gmail]/All Mail"  . ?a)))

  (setq
   message-send-mail-function 'smtpmail-send-it
   smtpmail-smtp-user "johnda102@gmail.com"
   smtpmail-smtp-server "smtp.gmail.com"
   smtpmail-smtp-service 587
   smtpmail-stream-type 'starttls
   smtpmail-auth-credentials "~/.authinfo.gpg")


  (mu4e t)
  )

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/dotfiles/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))
