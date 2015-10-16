-module(knight_tour).
-export([solve/3]).

get_length(L, Size) ->
  [ M || M <- lists:map( fun([X, Y]) -> [length(neighbours(X, Y, Size)), [X, Y]] end, L) ].


get_move(L) ->
  lists:last( lists:min(lists:filter( fun([H|_T]) -> H > 0 end, L)) ).

solve(X, Y, Size) ->
  solve(X, Y, Size, neighbours(X, Y, Size), [[X, Y]]).


solve(X, Y, Size, _Neighbours, Moves) ->

  NewNeighbours = neighbours(X, Y, Size) -- Moves,

  case length(NewNeighbours) == 0 of
    true -> lists:reverse(Moves);
    false -> [X1, Y1] = get_move(get_length(NewNeighbours, Size)),
             solve(X1, Y1, Size, NewNeighbours, lists:append(Moves, [[X1, Y1]]))
  end.

  

is_valid_point([X, Y], Size) ->
  is_integer(X) andalso X >= 0 andalso X < Size andalso
  is_integer(Y) andalso Y >= 0 andalso Y < Size.


neighbours(X, Y, Size) ->
  Candidate = [[X+1, Y-2], [X+1, Y+2], [X+2, Y+1], [X+2, Y-1], [X-1, Y-2], [X-1, Y+2], [X-2, Y+1], [X-2, Y-1]],
  [R || [_X, _Y] = R <- Candidate, is_valid_point(R, Size)].
