
trigger([],[]) :-!.

trigger([stone(X,Y)|T1], [goal(X,Y)|T2]) :-
trigger(T1, T2).
