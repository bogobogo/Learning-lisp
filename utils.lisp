;;;; Flat List Manipulation Utilities

(defun set-nth (lst n elt)
  (append (subseq lst 0 (- n 1)) (cons elt (cdr (subseq lst n)))))

;;; NOTE: This section is knowingly building utilities that are more properly used with arrays than with lists 
;;; The idea is to (a) practice my list manipulation skills and 
;;;                (b) It seems intresting to think of how it might come up useful in the future, however far fetched it might sound


;; TODO: Proper error handling 
;; 1) throw error when lst length is not column-length times row-length

;; TODO: change to recursive, calling setf every time is not very lispy 
(defun rect-columns (lst column-length row-length)
  (let ((column-lst))
    (dotimes (i row-length (reverse column-lst))
      (setf column-lst (cons (rect-column lst i column-length row-length )
                              column-lst))))) 

;; TODO: change to recursive, calling setf every time is not very lispy 
(defun rect-column (lst idx column-length row-length)
  (let ((col))
    (dotimes (i column-length (reverse col))
      (setf col (cons (nth (+ idx (* row-length i)) lst)
                       col)))))

(defun rect-rows (lst row-length)
  (if (< (length lst) row-length )
      nil
      (cons (subseq lst 0 row-length) 
            (rect-rows (subseq lst row-length) row-length))))

(defun square-diagonals (lst)
  (let ((diagonal1 ())
        (diagonal2 ())
        (row-length (round (sqrt (length lst)))))
    (dotimes (i row-length (list diagonal1 diagonal2))
      (setf diagonal1 (cons (nth (* i (+ row-length 1)) lst) diagonal1) 
            diagonal2 (cons (nth (+ (- row-length 1) (* i (- row-length 1))) lst) diagonal2)))))
                            ;;  (cons (nth (+ row-length (* 2 (decf row-length))) lst) (cdr diagonals))
                            
(defun mid (lst)
  (let ((lst-length (length lst)))
    (and (oddp lst-length)
         (nth (/ (decf lst-length) 2) lst))))
         

(defun rotate-list (lst row-length column-length)
  (apply #'append (columns lst row-length column-length)))  

;; 
(defun prompt-read (prompt)
  (format *query-io* "~%~a:" prompt)
  (force-output *query-io*)
  (read-line *query-io*))

