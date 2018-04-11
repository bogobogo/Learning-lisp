(defvar *welcome-message* 
"Hello and welcome to (tic tac tow)! its like tic-tac-tow, except it is... no actually it's exactly like tic-tac-tow.
But it's written in common lisp. Its a programming language. never mind.
To begin, please enter the first player name and the second player name!")

 (defvar *how-to-play-message* 
"Above this message is your game board.
Each player in his turn can put his mark on a square in the board by typing the number that corrosponds to the square.
First player's mark is X.
Second player's mark is 0.
The first one to have three marks in a cloumn, row, or diagonal wins!")

 (defvar *board-ascii* "╔══════╤═════╤══════╗
║   ~a  │  ~a  │  ~a   ║
╟──────┼─────┼──────╢
║   ~a  │  ~a  │  ~a   ║
╟──────┼─────┼──────╢
║   ~a  │  ~a  │  ~a   ║
╚══════╧═════╧══════╝")

(defvar *cant-move* "Sorry, but the move ~A is not possible.
Are you sure it is one of the available numbers?")

(defun cant-move-msg (square-n)
  (format *terminal-io* *cant-move* square-n )
  (force-output t)) 