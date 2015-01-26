;;; autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "funcs-apropos" "funcs-apropos.el" (21702 18152
;;;;;;  104201 204000))
;;; Generated autoloads from funcs-apropos.el

(autoload 'apropos-package "funcs-apropos" "\
Show all Lisp symbols are part of a package named PACKAGE-NAME.
When printing them out, removes the PACKAGE-NAME prefix.
For example, a search for ``apropos'' will display ``print'', ``command'',
etc... in the *Apropos* buffer.
Return list of symbols and documentation found.

\(fn PACKAGE-NAME)" t nil)

;;;***

;;;### (autoloads nil "funcs-linenumber" "funcs-linenumber.el" (21693
;;;;;;  31127 10255 524000))
;;; Generated autoloads from funcs-linenumber.el

(autoload 'custom-line-number-format "funcs-linenumber" "\
Format the line numbers.
Return the string to display at the given OFFSET from the current one.

\(fn OFFSET)" nil nil)

;;;***

;;;### (autoloads nil "funcs-motion" "funcs-motion.el" (21702 19876
;;;;;;  239500 100000))
;;; Generated autoloads from funcs-motion.el

(autoload 'smarter-move-beginning-of-line "funcs-motion" "\
Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("customs.el" "site-start.el") (21702 28981
;;;;;;  593708 976000))

;;;***

(provide 'autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; autoloads.el ends here
