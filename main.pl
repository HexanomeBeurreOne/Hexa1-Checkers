%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Checkers game             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Module Imports */
?- ['actions/queen.pl'].
?- ['actions/eat.pl'].
?- ['actions/move.pl'].
?- ['helpers/drawBoard.pl'].
?- ['helpers/pieceFacts.pl'].
?- ['helpers/rules.pl'].
?- ['helpers/turn.pl'].
?- ['helpers/util.pl'].
?- ['ia/helpersIA.pl'].
?- ['ia/randomIA.pl'].
?- ['ia/IALevelUno.pl'].
?- ['ia/minimaxIA.pl'].
?- ['ia/simulate-actions/queen.pl'].
?- ['ia/simulate-actions/eat.pl'].
?- ['ia/simulate-actions/move.pl'].
?- ['ia/simulate-actions/simulation-helpers.pl'].
%?- ['ia/worthToMove.pl'].

%% Set IA %%
setIA(0) :-
    b_setval(iaChoice, randomIA).
setIA(1) :-
    b_setval(iaChoice, level1).
setIA(2) :-
    b_setval(iaChoice, minmax).

playCheckers:-
  getIALevel(Level),
  setIA(Level),
  setState(board),
  initBoard,
  printBoard,
  play(white, human).

play(Player, human):-
  continuePlaying,
  nl, write('Player '), write(Player), write(' plays.'),nl,
  userMove(X,Y,NewX,NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  zombieToEmpty,
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, ia).
play(Player, ia):-
  b_getval(iaChoice, IAChoice),
  continuePlaying,
  nl, write('Player '), write(IAChoice), write(' plays.'),nl,
  iaMove(IAChoice, Player, X, Y, NewX, NewY),
  nl, write('Move: ('), write(X), write(', '), write(Y), write(') to ('), write(NewX), write(' , '), write(NewY), write(').'),nl,
  processTurn(Player, X, Y, NewX, NewY),
  zombieToEmpty,
  nl, printBoard,
  nextPlayer(Player, NextPlayer),
  play(NextPlayer, human).
play(Player, _):-
  %GameOver for a player
  not(continuePlaying),
  %TODO: Find who has won
  write('GameOver').
