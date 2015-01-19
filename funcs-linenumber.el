;;; package --- summary: functions for line numbers
;;;
;;; author:  Luca Molari <molari.luca@gmail.com>
;;;
;;; license: Apache 2.0
;;;
;;; more informations:
;;;
;;; commentary:
;;;
;;; code:
;;;


;;;###autoload
(defun custom-line-number-format (offset)
  "Format the line numbers.
Return the string to display at the given OFFSET from the current one."
  (if (eq offset 0)
      (format "%d" (line-number-at-pos))
    (format "%d" offset))
  )


(provide 'funcs-linenumber)
;;; funcs-linenumber ends here
