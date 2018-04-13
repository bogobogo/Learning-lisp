(defvar *welcome-msg*
"Hello and welcome to (tic tac tow)! its like tic-tac-tow, except it is... no actually it's exactly like tic-tac-tow.
But it's written in common lisp. Its a programming language. never mind.
To begin, please enter the first player name and the second player name!")

(defun welcome-msg ()
  (format t "~a~%~%" *welcome-msg* ))

 (defvar *how-to-play-msg* 
"Above this message is your game board.
Each player in his turn can put his mark on a square in the board by typing the number that corresponds to the square.
First player's mark is X.
Second player's mark is 0.
The first one to have three marks in a cloumn, row, or diagonal wins!")

(defun how-to-play-msg ()
  (format t "~%~%~a~%~%" *how-to-play-msg* ))

 (defvar *board-ascii* "╔══════╤═════╤══════╗
║   ~a  │  ~a  │  ~a   ║
╟──────┼─────┼──────╢
║   ~a  │  ~a  │  ~a   ║
╟──────┼─────┼──────╢
║   ~a  │  ~a  │  ~a   ║
╚══════╧═════╧══════╝")

(defun square-taken-msg (square-n) 
(format t "~%Sorry, square ~A is already taken.
Please use an availabe square.~%" square-n))

(defun invalid-move-msg (square-n) 
(format t "~%Sorry, move ~A is not possible.
Are you sure it is one of the available numbers?~%" square-n))



(defun  tie-msg ()
(format t "~%~A~%" "Well well well....
It seems like we have a tie!! 
Thank you for playing! "))

(defun win-msg (game-winner)
(format t "~%Congrats player ~A, you won!!!....
as a prize here is a link to a nice book  
Thank you for playing!" game-winner))

(defun game-done-msg (game-winner)
  (cond ((zerop game-winner) (tie-msg))
        ((win-msg game-winner)))
   (quit))

(defun close-game-msg ()
  (format t "ok, bye...."))

