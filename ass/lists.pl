%is_a_list
%
is_a_list([]).
is_a_list(.(Head, Tail)) :-
is_a_list(Tail).

%
head_tail(List, Head, Tail) :-
List = .(Head, Tail).

% base case
is_member(Element, list(Element, _)).

% recursive case 
is_member(Element, list(_, Tail)) ：-
is_member（Element， list（Tail））.

%
cons([Head|Tail], List, Result) :-
Result = [Tail|List].

