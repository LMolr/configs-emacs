;;; package --- summary: functions for apropos
;;;
;;; author:  Alessandro Molari <molari.alessandro@gmail.com>
;;;
;;; license: Apache 2.0
;;;
;;; more informations:
;;; - http://www.emacswiki.org/AproposMode
;;;
;;; commentary:
;;;
;;; code:
;;;


;;;###autoload
(defun apropos-package (package-name)
    "Show all Lisp symbols are part of a package named PACKAGE-NAME.
When printing them out, removes the PACKAGE-NAME prefix.
For example, a search for ``apropos'' will display ``print'', ``command'',
etc... in the *Apropos* buffer.
Return list of symbols and documentation found."
    (interactive "sEnter the package name: ")
    (let ((package (concat package-name "-")))
      (setq apropos-accumulator (apropos (concat "^" package)))
      (apropos-print nil nil (concat "Package prefix: " package))
      (set-buffer "*Apropos*")
      (toggle-read-only)
      (search-forward "Package prefix: ")
      (let ((start (point)))
        (end-of-line)
        (put-text-property start (point) 'face apropos-symbol-face))
      (while (not (null (search-forward package nil t)))
        ;; hide the package prefix
        (let ((end (point)))
          (beginning-of-line)
          (put-text-property (point) end 'invisible t)
          (end-of-line)))
          (toggle-read-only)))


(provide 'funcs-apropos)
;;; funcs-apropos.el ends here
