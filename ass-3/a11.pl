% s(+State0,-State1,-Cost)
s(goal(X1,Y1),goal(X2,Y2),1):-
    land(X2,Y2),
    mandist(X1/Y1,X2/Y2,1).

s(goal(X1,Y1),goal(X2,Y2),1000):-
    % X2 should be in range of(X1-1) and (X1+1)
    % Y2 should be in range of(Y1-1) and (Y1+1)
    between((X1-1),(X+1),X2),
    between((Y1-1),(Y1+1),Y2),
    not (land(X2,Y2))
    mandist(X1/Y1,X2/Y2,1).


mandist(X/Y, X1/Y1, D) :-      % D is Manhattan Dist between two positions
    dif(X, X1, Dx),
    dif(Y, Y1, Dy),
    D is Dx + Dy.

dif(A, B, D) :-                % D is |A-B|
    D is A-B, D >= 0, !.

dif(A, B, D) :-                % D is |A-B|
    D is B-A.

% find path
find(Start,Path):-
    assert(goal(goal(1,1))),
    Start = goal(9,9),
    solve(Start,Path,_,_).
