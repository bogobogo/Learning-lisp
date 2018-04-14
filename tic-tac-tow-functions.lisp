(defvar *side-length* 3)
(defparameter *player1-name* nil)
(defparameter *player2-name* nil)

(load "messages.lisp")
(load "utils.lisp")

(defun tic-tac-toe ()
  (let ((board (create-board)))
    (welcome-msg)
    (set-players-prompt)
    (how-to-play-msg board)
    (if (null (are-u-ready-prompt))
        (close-game-msg)
        (play 1 2 board))))

(defun create-board ()
   (make-list 9 :initial-element 0))

(defun play (player nextPlayer board)
  (render-board board)
  (let ((game-done (analyse-board board)))
     (if game-done
         (progn 
          (game-done-msg game-done)
          (if (play-again-prompt)
              (play 1 2 (create-board))
              (quit))) 
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
                    ((eql dataSquare 1) (x-mark))
                    ((eql dataSquare 2) (o-mark))))
          board
          '(1 2 3 4 5 6 7 8 9)))

(defun move (player board)
  (let ((square-n 0))
     (setf square-n (parse-integer (prompt-read "Make a move") :junk-allowed t))
     (if (can-make-move square-n board )
         (make-move square-n player board )
         (move player board))))


(defun make-move (square-n player board )
  (setf (nth (- square-n 1) board ) player))

(defun valid-n (square-n board)
  (and (plusp square-n)
        (<= square-n (length board))))

(defun can-make-move (square-n board)
  (cond ((null square-n)  (not-a-number-msg) )
        ((not (valid-n square-n board))  (invalid-move-msg square-n) )
        ((not (zerop (nth (- square-n 1) board)))  (square-taken-msg square-n) )
        (t)))


  
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

(tic-tac-toe)