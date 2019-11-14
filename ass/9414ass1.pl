%
%full name:GUANQUN ZHOU.
%student number:z5174741.
%assignment name:Assignment 1 - Prolog Programming.
%
%Q1
%sum every element in a list
:- discontiguous sumsq_neg/2.
sumsq_neg([],0).
neg_or_not(N) :-
N<0.
pos_or_not(N) :-
N>0.
sumsq_neg([Head|Tail],Sum) :-
neg_or_not(Head),
sumsq_neg(Tail, S),
Sum is S+(Head * Head).
sumsq_neg([Head|Tail], Sum) :-
pos_or_not(Head),
sumsq_neg(Tail, S),
Sum is S.

%Q2
%everyone of list of people likes all the iterms in iterm list.
%
like_all(_,[]) :-
true.
like_all(M, [HEad|TAil]) :-
likes(M,HEad),
like_all(M, TAil).
all_like_all([],_) :-
true.
all_like_all(Who_List, What_List):-
Who_List = [Head1|Tail1],
like_all(Head1,What_List),
all_like_all(Tail1, What_List).

%Q3
%generate a list of pairs of number and  square root ;from N to M,when N and M are both positive numbers and N>=M.
% find the square root of H
squ(H,X) :-
X is sqrt(H).

%generate a list of pairs of number and  square root ;from N to M,when N and M are both positive numbers and N>=M.
%base case
sqrt_table(N,M,List):-
M>0,
N=M,
squ(M,X),
List = [[M,X]].
%
sqrt_table(N,M,List):-
M>0,
N >= M,
squ(N,X),
N1 is N-1,
sqrt_table(N1,M,NextList),
List = [[N,X]|NextList].

%Q4
%a list of numbers,generate a new list where the sequences of old list are replaced by lists of lists consisting of head and end of each sequence.

%find the last on number of a sequence
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

%cut the former list of sequence or single number
cut_former_list(Num,[Num|Tail],Rest):-
Rest = Tail.
cut_former_list(Num,[Head|Tail],Rest) :-
Num \= Head,
cut_former_list(Num, Tail, Rest).
%a list of numbers,generate a new list where the sequences of old list are replaced by lists of lists consisting of head and end of each sequence.
chop_up([],[]).
chop_up([X],[X]).
chop_up([Head|Tail],Result):-
find_the_end(Head,Tail,End),
Head \= End,
append([[Head,End]],Result_1,Result),
cut_former_list(End,[Head|Tail], Rest),
chop_up(Rest, Result_1).

chop_up([Head|Tail],Result):-
find_the_end(Head,Tail,End),
Head = End,
append([Head],Result_1,Result),
cut_former_list(End,[Head|Tail], Rest),
chop_up(Rest, Result_1).


%Q5
%binary expression-trees whose leaves are either tree(empty, Num, empty) where Num is a number, or tree(empty, z, empty) where the letter z as a "variable". Every tree is either a leaf or tree(L, Op, R) where L and R are the left and right subtrees, and Op is one of  '+', '-', '*', '/'
%base case
tree_eval(Value,tree(empty,z,empty),Eval):-
Eval = Value.
tree_eval(Value,tree(empty,X,empty),Eval):-
X \= Value,
Eval = X.
%'+'
tree_eval(Value,tree(Left,'+',Right),Eval):-
tree_eval(Value,Left,Left_Evall),
tree_eval(Value,Right,Right_Evall),
Eval is Left_Evall+Right_Evall.
%'-'
tree_eval(Value,tree(Left,'-',Right),Eval):-
tree_eval(Value,Left,Left_Evall),
tree_eval(Value,Right,Right_Evall),
Eval is Left_Evall-Right_Evall.
%'*'
tree_eval(Value,tree(Left,'*',Right),Eval):-
tree_eval(Value,Left,Left_Evall),
tree_eval(Value,Right,Right_Evall),
Eval is Left_Evall*Right_Evall.
%'/'
tree_eval(Value,tree(Left,'/',Right),Eval):-
tree_eval(Value,Left,Left_Evall),
tree_eval(Value,Right,Right_Evall),
Eval is Left_Evall/Right_Evall.
