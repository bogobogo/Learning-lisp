#!/bin/sh
#|-*- mode:lisp -*-|#
#|
exec ros -Q -- $0 "$@"
|#
(progn ;;init forms
  (ros:ensure-asdf))
  ;;#+quicklisp (ql:quickload '() :silent t)
  
(defpackage :ros.script.tic-tac-tow-functions.3732121908
  (:use :cl))
(in-package :ros.script.tic-tac-tow-functions.3732121908)

(load "strings.lisp")
(load "utls.lisp")
;; refactor them to not be global.
(defvar *board* (make-list 9 :initial-element 0))
(defvar *player1-name* nil)
(defvar *player2-name* nil)

(defun start-game ()
  (introduction)
  (let ((x (y-or-n-p "Are you ready?~%")))
    (if (null x)
        (format t "ok bye..")
        (play 1 2 *board*))))

(defun introduction ()
  (format t "~a~%~%" *welcome-message* )
  (setf *player1-name* (prompt-read "Please enter player 1 name"))
  (setf *player2-name* (prompt-read "Please enter player 2 name"))
  (format t "~%~%Alright ~a and ~a, here is how you play!~%~%" *player1-name* *player2-name*)
  (render-board *board*)
  (format t "~%~a~%~%~%"  *how-to-play-message*))
(start-game)
(defun prompt-read (prompt)
  (format *query-io* "~%~a:" prompt)
  (force-output *query-io*)
  (read-line *query-io*))


(defun render-board (board)
  (let ((board-layout (parse-board board)))
     (apply #'format `(,*terminal-io* ,*board-ascii* ,@board-layout))
     (force-output t)))

(render-board *board*)
(defun parse-board (board)
  (mapcar #'(lambda (dataSquare dataIndex) 
              (cond ((eql dataSquare 0) dataIndex)
                    ((eql dataSquare 1) "X")
                    ((eql dataSquare 2) "O")))
          board
          '(1 2 3 4 5 6 7 8 9)))

(defun play (player nextPlayer board)
  (render-board board)
  (if (game-over board)
      (nil) 
      (progn
        (move player board)
        (play nextPlayer player board))))
(play 1 2 *board*)

(defun move (player board)
  (let ((square-n 0))
     (setf square-n (parse-integer (prompt-read "Make a move")))
     (if (can-make-move square-n board )
         (make-move square-n player board )
         (progn
            (cant-move-msg square-n)
            (move player board)))))

(defun make-move (square-n player board )
  (setf (nth (decf square-n) board ) player))

(defun can-make-move (square-n board)
  (and (valid-n square-n board)
       (zerop (nth (decf square-n) board))))

(defun valid-n (square-n board)
  (and (plusp square-n)
        (<= square-n (length board))))

(defun game-over (board)
    (or (column-streak board)
        (row-streak board)
        (diagonal-streak board)
        (board-full board)))

(defun cloumn-streak (board)
  (dotimes (i (sqrt (length board) )
    (when (plusp (nth i board))
      (when (= (nth i board) (nth ( +i rowlength) board) (nth (+ i ( * 2 rowlength)) board ))   
            (return (nth i board)))))))
(defun row-streak (board)
  body)
(defun diagonal-streak (board)
  body)





;; this is imprtant because problems with prompt read - dont delete!
(defun make-turn ()
  (if (not (game-over *board*) )
      (progn (format *terminal-io* "x equals now to ~A ~%" *board*)
              ;; this is due to weird behavior with query-io in SBCL
              (force-output t)
        (let ((x 0))
         
          (setf *board* (parse-integer (prompt-read "Make a turn")))
        
         )
      (make-turn) )
      (format t "Thank you for playing!!!!!") )
  ) 
(progn (format *terminal-io* "hello") (finish-output *terminal-io*) (fo)) 

(defun main (&rest argv)
  (declare (ignorable argv)))