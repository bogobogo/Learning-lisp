;; solution to 3
(defun our-nth (lst position)
  (if (= 0 position)
      (car lst)
      (if (cdr lst)
          (our-nth  (cdr lst) (- position 1))
          nil)))

;;  4
(defun greater (a b)
  (if (> a b)
      a
      b))

(defun a (a b)
  ((let ((x 1))
    ((if (test)
      ())))))
;; 5
(defun enigma (x)
 (and (not (null x))
  (or (null (car x))
   (enigma (cdr x)))))
(defun mystery (x y)
 (if (null y)
  nil
  (if (eql (car y) x)
   0
   (let ((z (mystery x (cdr y))))
    (and z (+ z 1))))))

(defun main (&rest argv)
  (declare (ignorable argv)))

`(1 2 '(3 5) 4 (3 1)) => '(1 2 5 5 5 4 1 1 1)
(defun uncompress (lst)
  (if (null lst)
      nil
      (let ((element (car lst)))
        (if (consp element)
            (append (list-of (car element) (cdr element)) (uncompress (cdr lst)) )
            (cons element (uncompress (cdr lst)))))))
(defun list-of (n el)
  (if (zerop n)
      nil
      (cons el (list-of (- n 1) el))))
;;; vim: set ft=lisp lisp:
