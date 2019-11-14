% test for question 1
% using from assignment 2 puzzle&pathsearch&dijkstra

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



%% appendix

s(goal(X1,Y1), goal(X2,Y2), 1) :-
land_or_dropped(X2,Y2),
distance((X1,Y1), (X2,Y2), 1).

s(goal(X1,Y1), goal(X2,Y2), 1000) :-
UX1 is X1 + 1,
DX1 is X1 - 1,
UY1 is Y1 + 1,
DY1 is Y1 - 1,
between(DY1, UY1, Y2),
between(DX1, UX1, X2),
distance((X1,Y1), (X2,Y2), 1).

solve(goal(X1, Y1), Solution, G, N) :-
goal(goal(X1, Y1)),
UX1 is X1 + 1,
DX1 is X1 - 1,
UY1 is Y1 + 1,
DY1 is Y1 - 1,
between(DY1, UY1, Y2),
between(DX1, UX1, X2),
land_or_dropped(X2, Y2),
distance((X1,Y1), (X2,Y2), 1),
Solution = [goal(X2, Y2), goal(X1, Y1)],
G = 2,
N = 1.

:- dynamic s/3.
initial_intentions(intents(L, [])) :-
    agent_at(X0, Y0),
    assert(goal(goal(X0, Y0))),
    monster(XM, YM),
    solve(goal(XM, YM), Path, _ ,_),
    findall(X, (member(goal(G1, G2), Path), not(land(G1, G2)), X = [goal(G1, G2), []]), L),
    retract(goal(goal(X0, Y0))),
    retractall(s(_, _, 1000)).


trigger([],[]) :-!.

trigger([stone(X,Y)|T1], [goal(X,Y)|T2]) :-
trigger(T1, T2).














