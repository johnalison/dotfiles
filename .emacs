(setq load-path
      (cons "~/emacs"
	    load-path))

;; Simplify the UI
(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar


(setq make-backup-files nil) ;turn off the backup files


					;
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-?") 'help-command)
(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\M-w" 'ispell-word)
(global-set-key "\M-#" 'ispell-region)
;(global-set-key "\C-v" 'ispell-word)
;(global-set-key "\C-q" 'query-replace-regexp)
(global-set-key "\C-l" 'goto-line)
(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-p" 'backward-paragraph)
;(global-set-key "\M-v" 'scroll-up-command)
(global-set-key (kbd "C-c r") 'revert-buffer-quick)
(global-set-key "\M-?" 'help-command)


;(global-set-key [S-iso-lefttab] 'dabbrev-expand)
;(global-set-key "\M-z" 'dabbrev-expand)
(global-set-key (kbd "<backtab>") 'dabbrev-expand)
;(global-set-key "\e[Z" 'dabbrev-expand)
;(add-hook 'python-mode-hook
;          (lambda () (define-key python-mode-map [backtab] 'dabbrev-expand)))


;; Set up the visible bell
;;(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq save-interprogram-paste-before-kill t)
(setq select-enable-clipboard t)
					;(setq select-enable-clipboard t)



; MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;(add-to-list 'load-path "~/.emacs.d/site-lisp")





;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;(unless package-archive-contents
;  (package-refresh-contents))
;
;(package-initialize)
;(unless package-archive-contents
; (package-refresh-contents))
;
;;; Initialize use-package on non-Linux platforms
;(unless (package-installed-p 'use-package)
;   (package-install 'use-package))
;
;(require 'use-package)
;(setq use-package-always-ensure t)



;;(use-package ivy
;;  :diminish
;;  :bind (("C-s" . swiper)
;;         :map ivy-minibuffer-map
;;         ("TAB" . ivy-alt-done)
;;         ("C-l" . ivy-alt-done)
;;         ("C-j" . ivy-next-line)
;;         ("C-k" . ivy-previous-line)
;;         :map ivy-switch-buffer-map
;;         ("C-k" . ivy-previous-line)
;;         ("C-l" . ivy-done)
;;         ("C-d" . ivy-switch-buffer-kill)
;;         :map ivy-reverse-i-search-map
;;         ("C-k" . ivy-previous-line)
;;         ("C-d" . ivy-reverse-i-search-kill))
;;  :config
;;  (ivy-mode 1))


(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))



;(use-package ivy-rich
;  :init
;  (ivy-rich-mode 1))


(use-package counsel
  :bind (("M-X" . counsel-M-x)
         ("C-x B" . counsel-ibuffer)
         ;("C-x F" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history)))


;;; force counsel-ibuffer to require a match
;(with-eval-after-load 'counsel
;  (defun my/counsel-ibuffer-require-match (orig-fun &rest args)
;    "Run ORIG‑FUN (counsel‑ibuffer) with `ivy‑require‑match' bound to t."
;    (let ((ivy-require-match t))
;      (apply orig-fun args)))
;  (advice-add 'counsel-ibuffer :around #'my/counsel-ibuffer-require-match))




(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))




(unless (eq window-system nil)
  (use-package doom-themes
    :init (load-theme 'modus-operandi t)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "English")
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages
   '(company consult consult-org-roam counsel doom-themes elgrep
	     gptel-quick helpful ivy-rich marginalia orderless
	     org-bullets org-gcal org-modern org-roam vertico
	     visual-fill-column yaml))
 '(ps-font-size 14)
 '(show-paren-mode t nil (paren)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )





;(global-set-key "\C-p" 'ispell-buffer)
;(define-key global-map [(control return)] 'ispell-word)

; Map C-c C-v to the following function
;(define-key global-map [(control c) (control v)] 'atl-switch-src)

;;; Switches between .h and .cxx files
;;(defun atl-switch-src ()
;;  (interactive)
;;  (setq filename buffer-file-name)
;;  (setq path (split-string filename "/"))
;;  (if (not (string-equal (car path) ""))
;;      (setq path (cons "" path)))
;;  (setq len (length path))
;;  (setq pkg (nth (- len 3) path))
;;
;;  (if (string-match "\\.h" filename)
;;      (progn
;;        (setcar (nthcdr (- len 2) path) "src")
;;        (setq tmppath (mapconcat 'identity path "/"))
;;        (string-match "\\.h" tmppath)
;;        (setq hpath (replace-match ".cxx" nil nil tmppath))))
;;
;;  (if (string-match "\\.cxx" filename)
;;      (progn
;;        (setcar (nthcdr (- len 2) path) pkg)
;;        (setq tmppath (mapconcat 'identity path "/"))
;;        (string-match "\\.cxx" tmppath)
;;        (setq hpath (replace-match ".h" nil nil tmppath))))
;;
;;  (find-file hpath))

;(set-default-font "-adobe-courier-bold-r-normal--14-100-100-100-m-90-iso10646-1")
;(set-default-font "-misc-fixed-medium-r-normal--13-100-100-100-c-70-iso8859-1")
;Get rid of welcome screen?
;(setq inhibit-startup-echo-area-message t)
;(setq initial-scratch-message nil)
;(setq inhibit-splash-screen t)



(add-hook 'encoded-kbd-mode
 (lambda ()
   (define-key encoded-kbd-map (kbd "M-s") 'ispell-buffer)
))

(defun rm-eol-symbols ()
  "Remove the ^M end-of-line symbols that sometimes show up when importing documents"
  (interactive)
  (save-excursion
    (replace-string "^M" "")
  )
)


;(setq auto-mode-alist (remove (rassoc 'vhdl-mode auto-mode-alist) auto-mode-alist))
;(add-to-list 'auto-mode-alist '("\\.vhdl\\'" . c++-mode))

;Py Flakes
;(when (require 'elpy nil t)
;  (elpy-enable))


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


; Check buffer exists before switching there
(defadvice switch-to-buffer (before existing-buffer
				    activate compile)
  "When interactive, swtich to existing buffers only,
   unless given a prefex argument."
  (interactive
   (list (read-buffer "Switch to buffer: "
		      (other-buffer)
		      (null current-prefix-arg)))))

; Unscrolling
(global-set-key "\M-_" 'unscroll)



(defvar unscroll-point (make-marker)
  "Cursor position for next call to 'unscroll'.")
(defvar unscroll-window-start (make-marker)
  "Window start for next call to 'unscroll'.")
(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")



(defun unscroll-maybe-remember ()
  (if (not (get last-command 'unscrollable))
      (progn
	(set-marker unscroll-point (point))
	(set-marker unscroll-window-start (window-start))
	(setq unscroll-hscroll (window-hscroll)))))

(defun unscroll ()
  "revert to 'unscroll-point' and 'unscroll-window-start'."
  (interactive)
  (goto-char unscroll-point)
  (set-window-start nil unscroll-window-start)
  (set-window-hscroll nil unscroll-hscroll))


(put 'scroll-up 'unscrollable t)
(defadvice scroll-up (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(put 'scroll-down 'unscrollable t)
(defadvice scroll-down (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(put 'scroll-left 'unscrollable t)
(defadvice scroll-left (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(put 'scroll-right 'unscrollable t)
(defadvice scroll-right (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

;
; refill
(autoload 'johns-refill-mode "refill" "Refill minor mode." t)


					;
;;					;
;;					; Testing
;;;(set-fill-column 200)
;;;;;
;;(define-minor-mode ospl-mode  "One Sentence Per Line"
;;  :init-value nil
;;  :lighter " ospl"
;;  :keymap (let ((map (make-sparse-keymap)))
;;            (define-key map (kbd "M-q") 'ospl/fill-paragraph)
;;            map)
;;
;;  (if ospl-mode
;;      (progn
;;        (visual-line-mode 1)
;;        ;(setq right-margin-width (- (window-body-width) fill-column)))
;;        (setq right-margin-width 0 ))
;;    (visual-line-mode -1)
;;    (setq right-margin-width 0))
;;
;;  ;; Account for new margin width
;;  (set-window-buffer (selected-window) (current-buffer)))
;;
;;
;;(defun ospl/unfill-paragraph ()
;;  "Unfill the paragraph at point.
;;
;;This repeatedly calls `join-line' until the whole paragraph does
;;not contain hard line breaks any more."
;;  (interactive)
;;  (forward-paragraph 1)
;;  (forward-paragraph -1)
;;  (while (looking-at paragraph-start)
;;    (forward-line 1))
;;  (let ((beg (point)))
;;    (forward-paragraph 1)
;;    (backward-char 1)
;;    (while (> (point) beg)
;;      (join-line)
;;      (beginning-of-line))))
;;
;;
;;(defun ospl/fill-paragraph ()
;;  "Fill the current paragraph until there is one sentence per line.
;;
;;This unfills the paragraph, and places hard line breaks after each sentence."
;;  (interactive)
;;  (save-excursion
;;    (fill-paragraph)         ; takes care of putting 2 spaces if needed
;;    (ospl/unfill-paragraph)  ; remove hard line breaks
;;
;;    ;; insert line breaks again
;;    (let ((end-of-paragraph (make-marker)))
;;      (save-excursion
;;        (forward-paragraph)
;;        (backward-sentence)
;;        (forward-sentence)
;;        (set-marker end-of-paragraph (point)))
;;      (forward-sentence)
;;      (while (< (point) end-of-paragraph)
;;        (just-one-space)
;;        (delete-backward-char 1)
;;        (newline)
;;        (forward-sentence))
;;      (set-marker end-of-paragraph nil))))
;;
;;
;;
;;
;;(fset 'combine-lines
;;   (kmacro-lambda-form [?\C-e ?\C-a ?\C-h ?  ?\C-a] 0 "%d"))
;;
;;(global-set-key "\C-x\C-kL" 'combine-lines)
;;
;; Twikis
;(load "~/emacs/emacs-twiki-mode/twiki.el")
;(add-to-list 'auto-mode-alist'("\\.twiki$" . twiki-mode))


;(fset 'copy-to-clipboard-old
;   (kmacro-lambda-form [?\C-\[ ?< ?\C-@ ?\C-\[ ?> ?\C-\[ ?| ?p ?b ?c ?o ?p ?y ?\C-m] 0 "%d"))

(fset 'copy-to-clipboard-2
      (kmacro-lambda-form [?\C-@ ?\C-\[ ?< ?\C-@ ?\C-\[ ?> ?\C-\[ ?| ?p ?b ?c ?o ?p ?y ?\C-m ?\C-\[ ?x ?p ?o ?p ?\C-i ?t ?o ?\C-i ?m ?\C-i ?\C-m ?\C-\[ ?x ?p ?o ?p ?\C-i ?t ?o ?\C-i ?m ?\C-i ?\C-m] 0 "%d"))


;;
;; twiki-export-to-clipboard ()
;;
(defun copy-to-clipboard ()
  (interactive)
  (copy-to-clipboard-2)
  (message "Exported text to clipboard")
  )

(defun copy-region-to-pbcopy ()
  "Copy the current region to the clipboard using pbcopy."
  (interactive)
  (if (use-region-p)
      (progn
        (shell-command-on-region (region-beginning) (region-end) "pbcopy")
        (deactivate-mark) ; Optionally deactivate the mark
        (message "Region copied to clipboard using pbcopy!"))
    (message "No active region!")))

;(global-set-key "\C-ce" 'copy-to-clipboard)
(global-set-key "\C-ce" 'copy-region-to-pbcopy)

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




;(load "~/lab/emacs/obsidian.el/obsidian.el")
;(add-to-list 'load-path "~/lab/emacs/obsidian.el")
;(add-to-list 'load-path "~/lab/emacs/markdown-mode")
;(add-hook 'after-init-hook 'global-company-mode)

; (require 'obsidian)
; (obsidian-specify-path "~/obsidian-notes/")
; ;; If you want a different directory of `obsidian-capture':
; (setq obsidian-inbox-directory "0-inbox")
; ;; Clicking on a wiki link referring a non-existing file the file can be
; ;; created in the inbox (t) or next to the file with the link (nil).
; ;; Default: t - creating in the inbox
; ;(setq obsidian-wiki-link-create-file-in-inbox nil)
; ;; You may want to define a folder for daily notes. By default it is the inbox.
; (setq obsidian-daily-notes-directory "Journal")
; ;; Directory of note templates, unset (nil) by default
; (setq obsidian-templates-directory "templates")
; ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
; (setq obsidian-daily-note-template "Daily Template.md")


;; Define obsidian-mode bindings
;(add-hook
; 'obsidian-mode-hook
; (lambda ()
;   ;; Replace standard command with Obsidian.el's in obsidian vault:
;   (local-set-key (kbd "C-c o") 'obsidian-follow-link-at-point)
;
;   ;; Use either `obsidian-insert-wikilink' or `obsidian-insert-link':
;   (local-set-key (kbd "C-c l") 'obsidian-insert-wikilink)
;
;   ;; Following backlinks
;   (local-set-key (kbd "C-c b") 'obsidian-backlink-jump)))
;
;;; Optionally you can also bind a few functions:
;;; replace "YOUR_BINDING" with the key of your choice:
;(global-set-key (kbd "C-c j") 'obsidian-jump)       ;; Opening a note
;(global-set-key (kbd "C-c n") 'obsidian-capture)    ;; Capturing a new note in the inbox
;(global-set-key (kbd "C-c d") 'obsidian-daily-note) ;; Creating daily note
;
;;; Activate detection of Obsidian vault
;(global-obsidian-mode t)

;; Setting up copilot
(add-to-list 'load-path "~/emacs/copilot.el")
(require 'editorconfig)
(require 'copilot)
(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "<backtab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C-c C-f") 'copilot-accept-completion-by-word)
(setq warning-suppress-types '((copilot)))


; Setting up gptel
(add-to-list 'load-path "~/emacs/gptel")
(use-package gptel
  :ensure t
  :config
  ;; either hard‑code it (not recommended for shared configs):
  ;(setq gptel-api-key "sk‑YOUR_SECRET_KEY_HERE")

  ;; or, read from your shell’s env var:
  (setq gptel-api-key (getenv "OPENAI_API_KEY")))

(global-set-key (kbd "C-c RET") 'gptel-send)
(global-set-key (kbd "C-c m") 'gptel-menu)


(defun gptel-send-with-options (&optional arg)
  "Send query.  With prefix ARG open gptel's menu instead."
  (interactive "P")
  (if arg
      (call-interactively 'gptel-menu)
    (gptel--suffix-send (transient-args 'gptel-menu))))

(global-set-key (kbd "C-c g") #'my-gptel-send-via-minibuffer-and-echo)

;(defun my-gptel-send-via-minibuffer-and-echo ()
;  "Read a GPTel prompt from the minibuffer and echo the reply."
;  (interactive)
;  ;; Tell gptel--suffix-send to behave as if you hit `m` then `e`
;  (let ((transient-current-command 'gptel-menu))
;    (gptel--suffix-send '("m" "e"))))

(add-to-list 'load-path "~/emacs/gptel-quick/")


;;; --- web‑search tool for GPT‑el -------------------------------
(require 'gptel)                 ; make sure the package is loaded
(require 'json)                  ; we parse a tiny JSON blob

(defun my/gptel-duck-search (query &optional max)
  "Return MAX (default‑5) DuckDuckGo instant‑answer hits for QUERY."
  (let* ((max   (or max 5))
         (url   (format "https://api.duckduckgo.com/?q=%s&format=json&no_redirect=1&no_html=1"
                        (url-hexify-string query)))
         (buf   (url-retrieve-synchronously url t t 10)))
    (unless buf (error "duckduckgo request failed"))
    (with-current-buffer buf
      (goto-char url-http-end-of-headers)
      (let* ((json-object-type 'alist)
             (json (json-read))
             (hits (alist-get 'RelatedTopics json)))
        (mapconcat
         (lambda (h)
           (when-let* ((txt (alist-get 'Text h))
                       (url (alist-get 'FirstURL h)))
             (format "- %s\n  %s" txt url)))
         (seq-take hits max) "\n\n")))))

(defvar my/gptel-web-search-tool
  (gptel-make-tool
   :name "web_search"
   :description "Search DuckDuckGo and return the top plain‑text results."
   :function #'my/gptel-duck-search
   :args (list '(:name "query"        :type string  :description "Search query")
               '(:name "max_results"  :type integer :optional t
                        :description "How many results to return (≤ 10)"))
   :category "web"))

;; Make it available everywhere.  If you only want it in specific buffers,
;; call `gptel-select-tools' instead of touching the global var.
(add-to-list 'gptel-tools my/gptel-web-search-tool)

;; Optional defaults
(setq gptel-use-tools t                 ; allow tool use by default
      gptel-confirm-tool-calls nil        ; ask before each invocation
      gptel-include-tool-results nil)     ; echo results back to the model


;;;; The `vertico' package applies a vertical layout to the minibuffer.
;;;; It also pops up the minibuffer eagerly so we can see the available
;;;; options without further interactions.  This package is very fast
;;;; and "just works", though it also is highly customisable in case we
;;;; need to modify its behaviour.
;;;;
;;;; Further reading: https://protesilaos.com/emacs/dotemacs#h:cff33514-d3ac-4c16-a889-ea39d7346dc5
;;(use-package vertico
;;  :ensure t
;;  :config
;;  (setq vertico-cycle t)
;;  ;(setq vertico-resize nil)
;;  (vertico-mode 1))

(use-package vertico
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))


; The `marginalia' package provides helpful annotations next to
; completion candidates in the minibuffer.  The information on
; display depends on the type of content.  If it is about files, it
; shows file permissions and the last modified date.  If it is a
; buffer, it shows the buffer's size, major mode, and the like.
;
; Further reading: https://protesilaos.com/emacs/dotemacs#h:bd3f7a1d-a53d-4d3e-860e-25c5b35d8e7e
;;(use-package marginalia
;;  :ensure t
;;  :config
;;  (marginalia-mode 1))

; org roam

; TRAMPS
(setq remote-lpc-coffea4bees-path "/ssh:jda102@cmslpc-el9.fnal.gov:/uscms/home/jda102/nobackup/HH4b/Run3/coffea4bees/")

; Org Mode
(load "~/lab/emacs/johns-org.el")

;; GCal
(load "~/lab/emacs/gcal-setup.el")




;; Example of using the variable
(defun open-lpc-coffea4bees ()
  "Open the remote HH4b directory."
  (interactive)
  (find-file remote-lpc-coffea4bees-path))





;(defun set-help-buffer-font ()
;  "Set help-mode buffers to use Menlo font."
;  (face-remap-add-relative 'default '(:family "Menlo" :height 150)))
;
;(add-hook 'help-mode-hook 'set-help-buffer-font)


(setq select-enable-clipboard nil)

; Make cut and paste work with the macOS clipboard
(defun yank-from-osx-clipboard ()
  "Insert the contents of the macOS clipboard at point."
  (interactive)
  (insert (shell-command-to-string "pbpaste")))

(global-set-key (kbd "s-v") 'yank-from-osx-clipboard)


;; The `orderless' package lets the minibuffer use an out-of-order
;; pattern matching algorithm.  It matches space-separated words or
;; regular expressions in any order.  In its simplest form, something
;; like "ins pac" matches `package-menu-mark-install' as well as
;; `package-install'.  This is a powerful tool because we no longer
;; need to remember exactly how something is named.
;;
;; Note that Emacs has lots of "completion styles" (pattern matching
;; algorithms), but let us keep things simple.
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:7cc77fd0-8f98-4fc0-80be-48a758fcb6e2
(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)))


;; The `consult' package provides lots of commands that are enhanced
;; variants of basic, built-in functionality.  One of the headline
;; features of `consult' is its preview facility, where it shows in
;; another Emacs window the context of what is currently matched in
;; the minibuffer.  Here I define key bindings for some commands you
;; may find useful.  The mnemonic for their prefix is "alternative
;; search" (as opposed to the basic C-s or C-r keys).
;;
;; Further reading: https://protesilaos.com/emacs/dotemacs#h:22e97b4c-d88d-4deb-9ab3-f80631f9ff1d
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
