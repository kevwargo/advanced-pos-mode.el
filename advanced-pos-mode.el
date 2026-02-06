;;; advanced-pos-mode.el --- Minor mode for showing extra info about current buffer position -*- lexical-binding: t -*-

;;;###autoload
(define-minor-mode advanced-pos-mode
  "Minor mode for showing extra info about current buffer position"
  :global t
  :lighter nil
  (setq mode-line-position
        (mapcar #'advanced-pos--wrap-ln mode-line-position)))

(defvar advanced-pos-show-region nil
  "When region is active, show its start, end and length")

(defun advanced-pos-toggle-region ()
  (interactive)
  (setq advanced-pos-show-region (null advanced-pos-show-region)))

(defun advanced-pos--render ()
  (let ((point
         (if (and advanced-pos-show-region (region-active-p))
             (let* ((p (point))
                    (m (mark))
                    (l (abs (- p m))))
               (if (< p m)
                   (format "%d%s" p (propertize (format ":%d=%d" m l)
                                                'face 'font-lock-comment-face))
                 (format "%s%d%s"
                         (propertize (format "%d:" m)
                                     'face 'font-lock-comment-face)
                         p
                         (propertize (format "=%d" l)
                                     'face 'font-lock-comment-face))))
           (format "%d" (point)))))
    (if (eobp)
        (format "(%s: EOF)" point)
      (let ((c (char-after)))
        (concat (format "(%s: #%x %d " point c c)
                (propertize (if (= (char-after) ?%) "%%" (format "%c" c))
                            'face 'help-key-binding)
                ")")))))

(defun advanced-pos--wrap-ln (elt)
  "This function wraps top-level `line-number-mode' element inside `mode-line-position'.
Other elements of `mode-line-position' are returned unchanged."
  (if (eq (car-safe elt) 'line-number-mode)
      `(advanced-pos-mode
        (25 (" %l:%c " (:eval (advanced-pos--render))))
        ,elt)
    elt))

(provide 'advanced-pos-mode)

;;; advanced-pos-mode.el ends here
