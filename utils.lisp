(defun prompt-read (prompt)
  (format *query-io* "~%~a:" prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun getas (asc key)
  (cdr (assoc key asc)))

(defmacro set-player-v (key prop val)
  `(setf (,prop (getas *players* ,key)) ,val))

(defmacro get-player-v (key prop)
  `(,prop (getas *players* ,key)))
  
;;; NOTE: This section is knowingly building utilities that are more properly used with arrays than with lists 
;;; The idea is to (a) practice my list manipulation skills and 
;;;                (b) It seems intresting to think of how it might come up useful in the future, however far fetched it might sound

(defun rect-columns (lst column-length row-length)
  (let ((column-lst))
    (dotimes (i row-length (reverse column-lst))
      (setf column-lst (cons (rect-column lst i column-length row-length )
                              column-lst))))) 

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
                            




