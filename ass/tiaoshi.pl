%
room(kitchen).
room(office).
room(hall).
room('dining room').
room(cellar).
door(office, hall).
door(kitchen, office).
door(hall, 'dining room').
door(kitchen, cellar).
door('dining room', kitchen).

location(desk, office).
location(apple, kitchen).
location(flashlight, desk).
location('washing machine', cellar).
location(nani, 'washing machine').
location(broccoli, kitchen).
location(crackers, kitchen).
location(computer, office).

edible(apple).
edible(crackers).
tastes_yucky(broccoli).
here(kitchen).  

% reverse list to find the last one
rev(List,R_List,F_List):-
List=[Head|_],
reverse(List,R_List),
R_List=[Head1|_],
append([Head,Head1],[],F_List).
%
sub_chop_up(List,S_List):-
List = [First | Tail],
Tail = [Second | _],
First is Second - 1,
sub_chop_up(Tail, S_List2),
S_List = [First,Second|S_List2],
%
chop_up([],[]).
chop_up([_],[]).
%
chop_up(List_1,Result):-
sub_chop_up(List_1,S_List),
rev(S_List,R_List),
R_List=[Head1|_],
append([Head,Head1],[],Result).





