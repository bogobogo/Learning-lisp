(load "strings.lisp")
(load "utils.lisp")
;; refactor them to not be global.
(defun create-board (len)
  (defparameter *board* (make-list len :initial-element 0))) 
(defvar *side-length* 3)
(defvar *player1-name* nil)
(defvar *player2-name* nil)
;; m (tic-tac-tow)
(defun tic-tac-tow ()
  (create-board 9)
  (introduction)
  (let ((x (y-or-n-p "Are you ready?~%")))
    (if (null x)
        (close-game-msg)
        (play 1 2 *board*))))

(defun introduction ()
  (welcome-msg )
  (setf *player1-name* (prompt-read "Please enter player 1 name"))
  (setf *player2-name* (prompt-read "Please enter player 2 name"))
  (format t "~%~%Alright ~a and ~a, here is how you play!~%~%" *player1-name* *player2-name*)
  (render-board *board*)
  (how-to-play-msg))

(defun play (player nextPlayer board)
  (render-board board)
  (let ((game-winner (analyse-board board)))
     (if game-winner
         (game-done-msg game-winner) 
         (progn
            (move player board)
            (play nextPlayer player board)))))
            

(defun render-board (board)
  (let ((board-layout (parse-board board)))
     (apply #'format `(,*terminal-io* ,*board-ascii* ,@board-layout))
     (force-output t)))

(defun parse-board (board)
  (mapcar #'(lambda (dataSquare dataIndex) 
              (cond ((eql dataSquare 0) dataIndex)
                    ((eql dataSquare 1) "X")
                    ((eql dataSquare 2) "O")))
          board
          '(1 2 3 4 5 6 7 8 9)))

(defun move (player board)
  (let ((square-n 0))
     (setf square-n (or (parse-integer (prompt-read "Make a move:") :junk-allowed t) 0))
     (if (can-make-move square-n board )
         (make-move square-n player board )
         (move player board))))

;; todo: make immutalbe to support going back
(defun make-move (square-n player board )
  (setf (nth (- square-n 1) board ) player))

(defun can-make-move (square-n board)
  (cond ((null square-n) (progn (not-a-number-msg) (return-from can-make-move nil)))
        ((not (valid-n square-n board)) (progn (invalid-move-msg square-n) (return-from can-make-move nil)))
        ((not (zerop (nth (- square-n 1) board))) (progn (square-taken-msg square-n) (return-from can-make-move nil)))
        (t)))

(defun valid-n (square-n board)
  (and (plusp square-n)
        (<= square-n (length board))))
  
(defun find-winner (options)
  (mapcar 
    #'(lambda (x) 
        (cond ((zerop (car x)) nil)
              ((every #'(lambda (y) (eql y (car x) )) x) (return-from find-winner (car x) ))))
    options)
  nil)

(defun board-full (board)
  (null (some #'zerop board)))

(defun analyse-board (board)
    (let ((columns (rect-columns board *side-length* *side-length*))
          (rows (rect-rows board *side-length*))
          (diagonals (square-diagonals board)))

      (or (find-winner (append columns rows diagonals))
          (and (board-full board)
                0))))