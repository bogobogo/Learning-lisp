;; 2
(defun longer (lst1 lst2)
    (if (not (consp lst1))
        (if (not (consp lst2))
            nil
            lst2)
        (if (not (consp lst2))
            lst1
            (if (> (length lst1) (length lst2))
                lst1
                lst2))))

;;  tests - still todo: unittest framework!!
(longer 1 2)
(longer '(1) 2)
(longer '(1 2 3) '( 2 3 4 5))
(longer nil '( 2 3 4 5))
(longer '(1 2 3 4 5 6) '( 2 3 4 5))

(defun combine-lists-inorder (lst1 lst2)
    (let ((result nil))
        (dotimes (x (+ (length lst1) (length lst2)))
        (cond ((and (null lst1) 
                    (null lst2)) result)
              ((null lst1) (setf result (cons (pop lst2) result ) ))
              ((null lst2) (setf result (cons (pop lst1) result ) ))
              ((not (oddp x)) (setf result (cons (pop lst1) result ) ))
              ((oddp x) (setf result (cons (pop lst2) result )))))
        (reverse result)))

(combine-lists-inorder '(1 2 3) '(4 2 1 5 6))

(defun new-union-non-refursive (lst1 lst2)
    (let ((combinedlist (combine-lists-inorder lst1 lst2))
          (our-numbers ()))
        (dolist (obj combinedlist)
            (if (member obj our-numbers)
                nil
                (setf our-numbers (cons obj our-numbers))))
        (reverse our-numbers)))

(new-union-non-refursive '(1 2 3 6 7 7 7 7 7 7 7 7 ) '(4 2 1 5 6))


(defvar *try* nil)
(dotimes (x 5) (print x))
(dolist (obj '(1 4 2 2 3 1)) (if (member obj flatList) nil (setf result (cons obj result)) ))
(not (member 4 '(4 1 2 2 1 3)))
;; (1 4 2 3)
;; 3
(let ((result nil))
    (setf result (cons '(4 . 1) result))
    (setf result (cons '(5 . 1) result))
    (setf ( cdr (assoc 4 result))  5)
    (assoc 4 result)
    (assoc 5 result))

(defun occourences (lst)
    (let ((dict nil))
    (dolist (obj lst)
        (if (assoc obj dict)
            (incf ( cdr (assoc obj dict)) 1)
            (setf dict (cons (cons obj 1) dict) ) ))
    (sort dict #'(lambda (x y) (> (cdr x) (cdr y))))))
(occourences '(1 2 3 1 3 6 8 8 8 8))
;; 4
(member 'a '((a) (b c)) :key #'car :test #'equal)
;; you have to set the key to equal because the default is eql and it checks if both are the same objects instead of whats inside the object
;; 5
;; mapcar 
(defun pos+1 (ls) 
    (let ((index 0)) 
    (mapcar #'(lambda (x) (incf index) (+ x (- index 1)) ) ls)))
(pos+1 '(7 5 1 4))
;; iteration
(defun pos+2 (ls)
    (let ((index 0)
          (result nil))
      (dolist (obj ls) (setf result (cons (+ obj index) result)) (incf index))
      (reverse result)))
(pos+2 '(7 5 1 4))
;; recursion 
(defun pos+3 (ls)
    (let ((n (length ls)))
        (format t "~A~%~A~%" ls n )
        (if (= n 1)
            ls
            (append (pos+3 (subseq ls 0 (- n 1)))
             (list (+ (car (subseq ls (- n 1)) ) (- n 1))) ))))
(pos+3 '(7 5 1 4))  
(subseq '(7 5 1 4) (- n 1)  
(+ (car (reverse '(7 5 1 4))) 4 - 1)
(+ (car (reverse '(4 1 5 6))) 1)
((subseq '(7 5 1 4) (- (length '(7 5 1 4)) 1)))
(reverse (cdr (reverse '(1))))
(length '(1))
;; 6
;; a

;; 7
(defun compress(x)
  (if (consp x)
      (compr (car x) 1 (cdr x))
      x))
(defun compr (elt n lst)
    (if (null lst)
        (list n-elts elt n)
        (let ((next (car lst)))
          (if (eql next elt )
              (compr elt ( + n 1) (cdr lst) )
              (cons (n-elts elt n)
                    (compr next 1 (cdr lst)) )) )))

(defun n-elts (elt n)
  (if (> n 1 )
      (cons n elt ) ;; change this to use one cons instead of a proper list with 2 cons
      elt )) 
(n-elts 'a 10)


(defun list-of (elt n)
  (if (zerop n )
      nil 
      (cons elt (list-of elt (- n 1) )) ))
(list-of 'a 10)

;; 8 showdots

;; 9 
(defun shortest-path (start end next)
  (bfs end (list (list start)) net)) 
