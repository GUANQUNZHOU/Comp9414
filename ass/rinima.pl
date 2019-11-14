%
full name:GUANQUN ZHOU.
student number:z5174741.
assignment name:Assignment 1 - Prolog Programming.
%
%base case
find_the_end(Head,[],End):-
End = Head.
find_the_end(Head,[H|Tail],End):-
Head is H - 1,
find_the_end(H, Tail, End_1),
End is End_1.
find_the_end(Head,[H|_],End):-
Head \= H - 1,
End = Head.
%
cut(Num,[Num|Tail],Tail).
cut(Num,[Head|Tail],Rest) :-
Num \= Head,
cut(Num, Tail, Rest).
%
chop_up([],[]).
chop_up([X],[X]).
chop_up([Head|Tail],Result):-
find_the_end(Head,Tail,End),
Head \= End,
append([[Head,End]],Result_1,Result),
cut(End,[Head|Tail], Rest),
chop_up(Rest, Result_1).

chop_up([Head|Tail],Result):-
find_the_end(Head,Tail,End),
Head = End,
append([Head],Result_1,Result),
cut(End,[Head|Tail], Rest),
chop_up(Rest, Result_1).












