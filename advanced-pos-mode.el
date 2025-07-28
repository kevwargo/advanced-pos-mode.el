;;; advanced-pos-mode.el --- Minor mode for showing extra info about current buffer position -*- lexical-binding: t -*-

;;;###autoload
(define-minor-mode advanced-pos-mode
  "Minor mode for showing extra info about current buffer position"
  :global t
  :lighter nil
  )

;; (setq mode-line-position
;;       '(25 ("%l:%c " (:eval
;;                   (if (eobp)
;;                       (format "(%d: EOF)" (point))
;;                     (let ((c (char-after)))
;;                       (concat (format "(%d: #%x %d " (point) c c)
;;                               (propertize (if (= (char-after) ?%) "%%" (format "%c" c))
;;                                           'face 'help-key-binding)
;;                               ")")))))))

(provide 'advanced-pos-mode)

;;; advanced-pos-mode.el ends here
