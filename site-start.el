;;; package --- summary: entry point for emacs configuration
;;;
;;; author:  Alessandro Molari <molari.alessandro@gmail.com>
;;;
;;; license: Apache 2.0
;;;
;;; commentary:
;;;
;;; here are the guidelines used / contribution rules:
;;; - packages
;;;   - any package should be installed with gs-elpa
;;;   - when a package is installed, its autoloads are automatically added to
;;;     the feature `site-gentoo', so `(require 'site-gentoo)' provides all of
;;;     the installed packages in an automatic fashon, like
;;;     `(package-initialize)' provided by `package.el'
;;;   - use as much as possible the custom system provided by Emacs; so
;;;     configurations are usually stored inside the `custom-file-name'
;;; - functions
;;;   - functions cannot be defined in the customization system; the generic
;;;     convention is to define functions in files named `funcs-*' and
;;;     loaded using the autoload system by prepending `;;;###autoload' to
;;;     the function definition
;;;   - remember to run `update-directory-autoloads` to regenerate the file
;;;     `autoload-file-name` after adding new functions
;;; - hotkeys
;;;   - hotkeys cannot be defined in the customization system nor autoloaded,
;;;     those are manually required in the `after-init-hook'
;;; - non-custom variables
;;;   - sometimes configuration variables which aren't customs, in that case
;;;     they are not configurable using the customize system: they are defined
;;;     using the `setq` macro
;;; - manual initialization
;;;   - some packages require a manual initialization, typically in a hook
;;;     not handled by the customization system
;;; - files associations
;;;   - associate files with major modes
;;;   - currently this is not possible using the customize system
;;;
;;; Make sure you install the wanted flycheck linters!
;;; List: http://flycheck.readthedocs.org/en/latest/guide/languages.html
;;;
;;; code:
;;;

;; enable common Lisp extensions
(require 'cl-lib)

;; {{{ configuration

(defconst config-root-path (file-name-as-directory "/etc/emacs/")
  "The root path for the Emacs config (be sure to include trailing slash).")

(defconst custom-file-name "customs.el"
  "The name of the custom file.")

(defconst autoload-file-name "autoloads.el"
  "The name of the file where autoload definitions will be generated.")

;; }}}

;; { non-custom variables

(setq inferior-lisp-program "/usr/bin/sbcl")

;; }

;; { autoload

;; autoload packages
(require 'site-gentoo)

;; autoload dotfiles
(setq autoload-file (concat config-root-path autoload-file-name))
(load autoload-file-name nil t)

;; }

;; { customs

(setq custom-file (concat config-root-path custom-file-name))
(load custom-file)

;; }

;; { manual initialization

;; helm-mode
(add-hook 'after-init-hook (lambda () (require 'helm-config)))

;; company-mode
(add-hook 'after-init-hook
          (lambda ()
            (company-mode t)
            (global-company-mode)))

;; magit-gitflow
(add-hook 'magit-mode-hook
          (lambda ()
            (require 'magit-gitflow)
            (turn-on-magit-gitflow)))

;; anaconda-mode
(add-hook 'python-mode-hook 'anaconda-mode)

;; {{{ ruby-mode / robe-mode

(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook 'robe-start)

;; }}}

;; haml-mode
(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)))

;; ac-js2-mode
;(add-hook 'js2-mode-hook (lambda () (ac-js2-mode)))

;; js2-refactor
;(add-hook 'js2-mode-hook
;          (lambda ()
;            (js2r-add-keybindings-with-prefix "C-c C-m")))

;; skewer-mode
(add-hook 'after-init-hook 'skewer-setup)

;; {{{ eldoc-mode

(add-hook 'emacs-lisp-mode-hook       'eldoc-mode)
(add-hook 'ielm-mode-hook             'eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'eldoc-mode)
(add-hook 'org-mode-hook              'eldoc-mode)
(add-hook 'python-mode-hook           'eldoc-mode)
(add-hook 'ruby-mode-hook             'eldoc-mode)

;; }}}

;; flycheck mode
(add-hook 'after-init-hook 'global-flycheck-mode)

;; smart-mode-line + powerline
(add-hook 'after-init-hook
          (lambda ()
            (sml/setup)
            (sml/apply-theme 'powerline)))

;; {{{ whitespace mode

(add-hook 'css-mode-hook        'whitespace-mode)
(add-hook 'emacs-lisp-mode-hook 'whitespace-mode)
(add-hook 'html-mode-hook       'whitespace-mode)
(add-hook 'haml-mode-hook       'whitespace-mode)
(add-hook 'js-mode-hook         'whitespace-mode)
(add-hook 'python-mode-hook     'whitespace-mode)
(add-hook 'ruby-mode-hook       'whitespace-mode)
(add-hook 'scss-mode-hook       'whitespace-mode)
(add-hook 'yaml-mode-hook       'whitespace-mode)

;; }}}

;; {{{ folding mode

(add-hook 'after-init-hook
          (lambda ()
            (load "folding" 'nomessage 'noerror)
            (folding-add-to-marks-list 'css-mode        "// {{{"   "// }}}"   nil t)
            (folding-add-to-marks-list 'emacs-lisp-mode ";; {{{"   ";; }}}"   nil t)
            (folding-add-to-marks-list 'haml-mode       ";; {{{"   ";; }}}"   nil t)
            (folding-add-to-marks-list 'html-mode       "<!-- {{{" "<!-- }}}" nil t)
            (folding-add-to-marks-list 'js-mode         "// {{{"   "// }}}"   nil t)
            (folding-add-to-marks-list 'python-mode     "# {{{"    "# }}}"    nil t)
            (folding-add-to-marks-list 'ruby-mode       "# {{{"    "# }}}"    nil t)
            (folding-add-to-marks-list 'scss-mode       "// {{{"   "// }}}"   nil t)
            (folding-add-to-marks-list 'yaml-mode       "# {{{"    "# }}}"    nil t)
            )
          )

(add-hook 'css-mode-hook        'folding-mode)
(add-hook 'emacs-lisp-mode-hook 'folding-mode)
(add-hook 'html-mode-hook       'folding-mode)
(add-hook 'haml-mode-hook       'folding-mode)
(add-hook 'js-mode-hook         'folding-mode)
(add-hook 'python-mode-hook     'folding-mode)
(add-hook 'ruby-mode-hook       'folding-mode)
(add-hook 'scss-mode-hook       'folding-mode)
(add-hook 'yaml-mode-hook       'folding-mode)

;; }}}

;; vagrant/tramp integration
(eval-after-load 'tramp '(vagrant-tramp-enable))

;; perform cleanup before exiting (suggested by emacs-helm.sh)
(add-hook 'kill-emacs-hook
          #'(lambda () (and (file-exists-p "$TMP") (delete-file "$TMP"))))

;; enable vagrant/tramp integration
(eval-after-load 'tramp
  '(vagrant-tramp-enable))

;; }

;; { files associations

(add-to-list 'auto-mode-alist '("^/etc/mutt/" . muttrc-mode))
(add-to-list 'auto-mode-alist '("muttrc$"     . muttrc-mode))

(add-to-list 'auto-mode-alist '("^/mutt" . mail-mode))

(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.js$"      . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;; }

;; {{{ hotkeys

;; {{{ navigation hotkeys

;; disable suspend
(global-unset-key (kbd "C-z"))

;; switch window
(global-set-key (kbd "C-<tab>") 'other-window)
;; disable arrows-based hotkeys
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; remap C-a to `'smarter-move-beginning-of-line`
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

;; }}}

;; {{{ helm hotkeys

;; replacing different commands
(global-set-key (kbd "C-x f") 'helm-recentf)
(global-set-key (kbd "C-h g") 'helm-man-woman)
(global-set-key (kbd "C-h s") 'helm-surfraw)
;; replacing plain versions of the same command
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-h d") 'helm-info-at-point)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-d") 'helm-browse-project)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-.") 'helm-etags-select)
(global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
(global-set-key (kbd "C-x r j") 'helm-register)
(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
;; using free hotkeys (not used by default)
(global-set-key (kbd "C-:")       'helm-eval-expression-with-eldoc)
(global-set-key (kbd "C-,")       'helm-calcul-expression)
(global-set-key (kbd "C-r")       'helm-regexp)
(global-set-key (kbd "C-c s")     'helm-do-grep)
(global-set-key (kbd "C-c f")     'helm-for-files)
(global-set-key (kbd "C-c <SPC>") 'helm-all-mark-rings)
(global-set-key (kbd "C-c C-x")   'helm-run-external-command)
(global-set-key (kbd "C-c p")     'helm-list-emacs-process)
(global-set-key (kbd "C-c t")     'helm-top)
(global-set-key (kbd "C-c i")     'helm-semantic-or-imenu)
(global-set-key (kbd "C-c C-p")   'helm-projectile)
(global-set-key (kbd "C-c <f5>")  'helm-execute-kmacro)
(global-set-key (kbd "C-c <f6>")  'helm-resume)

;; }}}

;; {{{ yasnippet hotkeys
;;(add-hook 'yas-minor-mode-hook
;;          '(define-key yas-minor-mode-map (kbd "<tab>") nil))
(define-key yas-minor-mode-map (kbd "<tab>") nil)
;; }}}

;; expand-region hotkeys
(global-set-key (kbd "C-=") 'er/expand-region)

;; company-mode hotkeys
(global-set-key (kbd "C-c c") 'company-complete)

;; {{{ major-mode specific hotkeys

;; display yari using helm, shadowing the global hotkey to show the emacs info
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-h r") 'yari-helm)))

;; }}}

;; }}}

(provide 'site-start)
;;; site-start.el ends here
