
% Uniform Cost Search, using Dijkstras Algorithm

% COMP3411/9414/9814 Artificial Intelligence, UNSW, Alan Blair

% solve(Start, Solution, G, N)
% Solution is a path (in reverse order) from start node to a goal state.
% G is the length of the path, N is the number of nodes expanded.

solve(Start, Solution, G, N)  :-
    consult(pathsearch), % insert_legs(), head_member(), build_path()
    ucsdijkstra([[Start,Start,0]], [], Solution, G, 1, N).

% ucsdijkstra(Generated, Expanded, Solution, L, N)
%
% The algorithm builds a list of generated "legs" in the form
% Generated = [[Node1,Prev1,G1],[Node2,Prev2,G2],...,[Start,Start,0]]
% The path length G from the start node is stored with each leg,
% and the legs are listed in increasing order of G.
% The expanded nodes are moved to another list (G is discarded)
%  Expanded = [[Node1,Prev1],[Node2,Prev2],...,[Start,Start]]

% If the next leg to be expanded reaches a goal node,
% stop searching, build the path and return it.
ucsdijkstra([[Node,Pred,G]|_Generated], Expanded, Path, G, N, N)  :-
    goal(Node),
    build_path([[Node,Pred]|Expanded], Path).

% Extend the leg at the head of the queue by generating the
% successors of its destination node.
% Insert these newly created legs into the list of generated nodes,
% keeping it sorted in increasing order of G; and continue searching.
ucsdijkstra([[Node,Pred,G]| Generated], Expanded, Solution, G1, L, N) :-
    extend(Node, G, Expanded, NewLegs),
    M is L + 1,
    insert_legs(Generated, NewLegs, Generated1),
    ucsdijkstra(Generated1, [[Node,Pred]|Expanded], Solution, G1, M, N).

% Find all successor nodes to this node, and check in each case
% that the new node has not previously been expanded.
extend(Node, G, Expanded, NewLegs) :-
    % write(Node),nl,   % print nodes as they are expanded
    findall([NewNode, Node, G1], (s(Node, NewNode, C)
    , not(head_member(NewNode, Expanded))
    , G1 is G + C
    ), NewLegs).

% base case: insert leg into an empty list.
insert_one_leg([], Leg, [Leg]).

% If we already knew a shorter path to the same node, discard the new one.
insert_one_leg([Leg1|Generated], Leg, [Leg1|Generated]) :-
    Leg  = [Node,_Pred, G ],
    Leg1 = [Node,_Pred1,G1],
    G >= G1, ! .

% Insert the new leg in its correct place in the list (ordered by G).
insert_one_leg([Leg1|Generated], Leg, [Leg,Leg1|Generated]) :-
    Leg  = [_Node, _Pred, G ],
    Leg1 = [_Node1,_Pred1,G1],
    G < G1, ! .

% Search recursively for the correct place to insert.
insert_one_leg([Leg1|Generated], Leg, [Leg1|Generated1]) :-
    insert_one_leg(Generated, Leg, Generated1).



% s(+State0,-State1,-Cost)
s(goal(X1,Y1),goal(X2,Y2),1):-
land(X2,Y2),
mandist(X1/Y1,X2/Y2,1).

s(goal(X1,Y1),goal(X2,Y2),1000):-
% X2 should be in range of 1 and 10
% Y2 should be in range of 1 and 10

between(1,10,Y2),
between(1,10,X2),
not(land(X2,Y2)),
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
    solve(Start,Path,_,_),
    retract(goal(goal(1,1))).

initial_intentions(intents(L,[])):-
    find(goal(9,9),Path),
    findall(Res,(member(goal(X,Y),Path),not(land(X,Y)),Res = [goal(X,Y),[]]),L).

trigger([],[]) :-!.

trigger([stone(X,Y)|T1], [goal(X,Y)|T2]) :-
trigger(T1, T2).

















