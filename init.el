;; MELPA
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


(package-initialize)
;;(unless package-archive-contents
;;  (package-refresh-contents))

;;(require 'use-package)
;;'(setq use-package-always-ensure t)

;; Simplify the UI
(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)          ; Disable the menu bar


;; Set up the visible bell
(setq ring-bell-function 'ignore)
(setq sentence-end-double-space nil)

;; Set the fixed pitch face
(set-face-attribute 'default nil :height 150) ;; 15pt font

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Inter" :height 175 :weight 'regular)
;(set-face-attribute 'variable-pitch nil :font "Lucida Grande" :height 175 :weight 'regular)
(set-face-attribute 'variable-pitch nil :height 175 :weight 'regular)

(setq make-backup-files nil) ;turn off the backup files

(setq save-interprogram-paste-before-kill t)
;;(setq select-enable-clipboard t)
(setq select-enable-clipboard nil)

;; Make cut and paste work with the macOS clipboard
(defun yank-from-osx-clipboard ()
  "Insert the contents of the macOS clipboard at point."
  (interactive)
  (insert (shell-command-to-string "pbpaste")))

(global-set-key (kbd "s-v") 'yank-from-osx-clipboard)

(defun copy-region-to-pbcopy ()
  "Copy the current region to the clipboard using pbcopy."
  (interactive)
  (if (use-region-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "pbcopy")
        (deactivate-mark) ; Optionally deactivate the mark
        (message "Region copied to clipboard using pbcopy!"))
    (message "No active region!")))


(global-set-key "\C-ce" 'copy-region-to-pbcopy)

(defalias 'scroll-ahead `scroll-up)
(defalias 'scroll-behind `scroll-down)

(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))


(global-set-key "\C-q" 'scroll-n-lines-behind)
(global-set-key "\C-x\C-q" 'quoted-insert)
(global-set-key "\C-z" 'scroll-n-lines-ahead)


(defun point-to-top ()
  "Put point on the top line of window"
  (interactive)
  (move-to-window-line 0))

(defun point-to-bottom ()
  "Put point on the top line of window"
  (interactive)
  (move-to-window-line -1))

(defun line-to-top ()
  "Move the current line to top of window."
  (interactive)
  (recenter 0))


(global-set-key "\M-," 'point-to-top)
(global-set-key "\M-." 'point-to-bottom)
(global-set-key "\M-!" 'line-to-top)

(use-package savehist
  :init
  (savehist-mode))

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key "\M-h" 'backward-kill-word)
;;(global-set-key "\M-w" 'ispell-word)
(global-set-key "\M-#" 'ispell-region)

;;(global-set-key "\C-l" 'goto-line)
(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-p" 'backward-paragraph)

(global-set-key (kbd "C-c r") 'revert-buffer-quick)
(global-set-key "\M-?" 'help-command)
(global-set-key (kbd "<backtab>") 'dabbrev-expand)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

(use-package counsel
  :bind (("M-X" . counsel-M-x)
         ("C-x B" . counsel-ibuffer)
	 ;;("C-x F" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

; Check buffer exists before switching there
(defadvice switch-to-buffer (before existing-buffer
				    activate compile)
  "When interactive, swtich to existing buffers only,
   unless given a prefex argument."
  (interactive
   (list (read-buffer "Switch to buffer: "
		      (other-buffer)
		      (null current-prefix-arg)))))

(setq display-buffer-alist
      '(

	;; Anatomy of a an entry:
	;; (BUFFER-MATCHER
	;;  LIST-OF-DISPLAY-ACTIONS
	;;  &optional PARAMETERS)

	("\\*Org todo\\*"
	 ;; list of display functions
	 (display-buffer-reuse-window
	  display-buffer-below-selected)
	 ;; Parameters
	 (window-height . fit-window-to-buffer)
	 (dedicated . t)
	 )

	("\\*wclock\\*"
	 ;; list of display functions
	 (display-buffer-reuse-window
	  display-buffer-below-selected)
	 ;; Parameters
	 (window-height . fit-window-to-buffer)
	 (dedicated . t)
	 )

	
	))

(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(defun replace-blank-lines-with-true-blanks ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "^[ \t]+$" nil t)
      (replace-match "" nil nil))))

(defun remove-trailing-whitespace ()
  (interactive)
  (when (derived-mode-p 'python-mode 'emacs-lisp-mode)
    (delete-trailing-whitespace)))

(add-hook 'before-save-hook 'remove-trailing-whitespace)

;; Setting up copilot
(add-to-list 'load-path "~/emacs/copilot.el")
(require 'editorconfig)
(require 'copilot)
(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "<backtab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C-c C-f") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-M-<tab>") 'copilot-accept-completion-by-line)  

(define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion)
(define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "C-g") 'copilot-clear-overlay)

(setq warning-suppress-types '((copilot)))

(add-hook 'git-commit-setup-hook 'copilot-chat-insert-commit-message)
(global-set-key (kbd "C-c c") 'copilot-chat-transient)

;; Setting up gptel
;; (add-to-list 'load-path "~/emacs/gptel")

(use-package gptel
  :ensure t
  :config
  ;; either hard‑code it (not recommended for shared configs):
  ;;(setq gptel-api-key "sk‑YOUR_SECRET_KEY_HERE")

  ;; or, read from your shell’s env var:
  (setq gptel-api-key (getenv "OPENAI_API_KEY")))


(add-to-list 'gptel-directives '(dict . "Provide synonyms for the word I provide. Respond with a list of words separated by commas; respond in one line."))
(add-to-list 'gptel-directives '(math . "I want you to act like a mathematician. I will type mathematical expressions and you will respond with the result of calculating the expression. I want you to answer only with the final amount and nothing else. Do not write explanations. When I need to tell you something in English, I'll do it by putting the text inside square brackets {like this}."))

(global-set-key (kbd "C-c g") 'gptel-send)
(global-set-key (kbd "C-c m") 'gptel-menu)


(defun gptel-send-with-options (&optional arg)
  "Send query.  With prefix ARG open gptel's menu instead."
  (interactive "P")
  (if arg
      (call-interactively 'gptel-menu)
    (gptel--suffix-send (transient-args 'gptel-menu))))


;; Optional defaults
(setq gptel-use-tools t                 ; allow tool use by default
      gptel-confirm-tool-calls nil        ; ask before each invocation
      gptel-include-tool-results nil)     ; echo results back to the model


(gptel-make-preset 'proofreading
  :description "Preset for proofreading tasks"
  :system "Please copy edit this text. The replace will applied in place so only return the edited text."
  :use-context 'system)

(defvar gptel-lookup--history nil)

(defun gptel-lookup (prompt)
  (interactive (list (read-string "Ask ChatGPT: " nil gptel-lookup--history)))
  (when (string= prompt "") (user-error "A prompt is required."))
  (gptel-request
      prompt
    :system "You LLM living in Emacs and a helpful assistant. Be concise"      ;; <- Your system directive here
    :callback
    (lambda (response info)
      (if (not response)
          (message "gptel-lookup failed with message: %s" (plist-get info :status))
	(with-current-buffer (get-buffer-create "*gptel-lookup*")
          (let ((inhibit-read-only t))
            (erase-buffer)
            (insert response))
          (special-mode)
          (display-buffer (current-buffer)
                          `((display-buffer-in-side-window)
                            (side . bottom)
                            (window-height . ,#'fit-window-to-buffer))))))))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))


(keymap-set vertico-map "?" #'minibuffer-completion-help)
(keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
(keymap-set vertico-map "M-TAB" #'minibuffer-complete)
(keymap-set vertico-map "TAB" #'minibuffer-complete)

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult
  :ensure t
  :bind (;; A recursive grep
         ("M-s g" . consult-grep)
         ;; Search for files names recursively
         ("M-s f" . consult-find)
         ;; Search through the outline (headings) of the file
         ("M-s M-o" . consult-outline)
         ;; Search the current buffer
         ("M-s M-l" . consult-line)
         ;; Switch to another buffer, or bookmarked file, or recently
         ;; opened file.
         ("M-s b" . consult-buffer)))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ;("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
   ) 

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package magit
  :ensure t)

(use-package dired
  :ensure nil              ;; dired is built-in
  :bind (:map dired-mode-map
              ("b" . dired-up-directory))
  :custom ((insert-directory-program "gls")
	   (dired-listing-switches "-agho --group-directories-first")
	   ;;(dired-dwim-target t)
	   ;;(dired-recursive-copies 'always)
	   ;;(dired-recursive-deletes 'top)
	   )
  )


(with-eval-after-load 'dired
  (require 'dired-x))

(use-package dired-open
  :config
  ;; Doesn't work as expected!
  (add-to-list 'dired-open-functions #'dired-open-xdg t)
  ;; -- OR! --
  (setq dired-open-extensions '(("key" . "open")
				("docx". "open")
				("xlsx". "open")
				("pdf" . "open"))))


(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind(:map dired-mode-map
	("H" . dired-hide-dotfiles-mode)
  ))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(setq remote-lpc-coffea4bees-path "/ssh:jda102@cmslpc-el9.fnal.gov:/uscms/home/jda102/nobackup/HH4b/Run3/coffea4bees/")

;; Example of using the variable
(defun open-lpc-coffea4bees ()
  "Open the remote HH4b directory on the LPC."
  (interactive)
  (find-file remote-lpc-coffea4bees-path))

(setq remote-falcon-coffea4bees-path "/ssh:jalison@falcon.phys.cmu.edu:/home/export/jalison/work/coffea4bees/python")

;; Example of using the variable
(defun open-falcon-coffea4bees ()
  "Open the remote HH4b directory on falcon.phys.cmu.edu"
  (interactive)
  (find-file remote-falcon-coffea4bees-path))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 150
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

(defun efs/lookup-password (&rest keys)
  (let ((result (apply #'auth-source-search keys)))
    (if result
        (funcall (plist-get (car result) :secret))
        nil)))

(use-package consult-mu
  :load-path ("~/emacs/consult-mu" "~/emacs/consult-mu/extras")
  :after (consult mu4e)
  :custom
  ;;maximum number of results shown in minibuffer
  (consult-mu-maxnum 200)
  ;;show preview when pressing any keys
  (consult-mu-preview-key 'any)
  ;;do not mark email as read when previewed
  (consult-mu-mark-previewed-as-read nil)
  ;; do not amrk email as read when selected. This is a good starting point to ensure you would
  ;; not miss important emails marked as read by mistake especially when trying this package out.
  ;;  Later you can change this to t.
  (consult-mu-mark-viewed-as-read nil)
  ;; open the message in mu4e-view-buffer when selected.
  (consult-mu-action #'consult-mu--view-action)

  :config
  ;;create a list of saved searches for quick access using `histroy-next-element'
  ;; with `M-n' in minibuffer. Note the "#" character at the beginning of each query! Change these according to
  (setq consult-mu-saved-searches-dynamics '("#flag:unread"))
  (setq consult-mu-saved-searches-async '("#flag:unread"))
  ;; require extra module for searching contacts and runing embark actions on contacts
  (require 'consult-mu-contacts)
  (setq consult-mu-contacts-ignore-list '("^.*no.*reply.*"))
  (setq consult-mu-contacts-ignore-case-fold-search t)
  )

(define-abbrev global-abbrev-table "myzoom" "https://cmu.zoom.us/j/4126571061")
(define-abbrev global-abbrev-table "yield" "yeild")

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package lsp-mode
    :commands (lsp lsp-deferred)
    :init
    (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
    :config
    (lsp-enable-which-key-integration t)

;;    ;; Essential for TRAMP
;;    (setq lsp-auto-guess-root t)
;;    (setq lsp-enable-file-watchers nil)
;;    (setq lsp-response-timeout 30)
;;
;;    ;; Enable TRAMP support
;;    (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-tramp-connection "pylsp")
;;                      :major-modes '(python-mode)
;;                      :remote? t
;;                      :server-id 'pylsp-tramp))
    )

(use-package python-mode
  :ensure nil
  :hook (python-mode . lsp-deferred)
  :bind (:map python-mode-map
	      :package python
              ("<backtab>" . dabbrev-expand))
  )


(use-package pyvenv
  :config
  (pyvenv-mode 1))


(add-hook 'python-mode-hook (lambda () (company-mode -1)))


(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :custom
  ;; Configure pylsp to use pylint
  (lsp-completion-enable nil)

  (lsp-pylsp-plugins-pylint-enabled t)
  (lsp-pylsp-plugins-flake8-enabled nil)

  (lsp-pylsp-plugins-autopep8-enabled t) ;; Turn on for code style
  (lsp-pylsp-plugins-black-enabled nil)
  (lsp-pylsp-plugins-yapf-enabled nil)

  (lsp-pylsp-plugins-pycodestyle-enabled nil)
  (lsp-pylsp-plugins-pyflakes-enabled nil)
  (lsp-pylsp-plugins-pylint-args ["--max-line-length=88" "--disable=C0103"]))

;;;    (use-package company
;;;      :after lsp-mode
;;;      :hook (prog-mode . company-mode)
;;;      :bind (:map company-active-map
;;;  		("<tab>" . company-complete-selection)
;;;  		("C-h" .   nil)
;;;  		("C-?" .   company-show-doc-buffer)
;;;  		)
;;;            (:map lsp-mode-map
;;;             ("<tab>" . company-indent-or-complete-common))
;;;      :custom
;;;      (company-minimum-prefix-length 1)
;;;      (company-idle-delay 0.0))
;;;
;;;  ;;   (use-package company-box
;;;  ;;    :hook (company-mode . company-box-mode))

;;:init (load-theme 'modus-operandi t)))

(unless (eq window-system nil)
  (use-package doom-themes
    :init (load-theme 'modus-operandi-tritanopia t)))

(unless (eq window-system nil)
  (load "~/dotfiles/init-org.el"))

(setq world-clock-list
      '(("America/New_York" "Pittsburgh")
        ("Europe/Zurich" "CERN")
        ("America/Chicago" "Chicago")
	("America/Los_Angeles" "Santa Barbara")
        ("Asia/Shanghai" "China")))
