:- ['familytree.pl'].
:- ['task3.pl'].

relation(father, Father, Person):- parent(Father, Person), sex(Father, m).
relation(mother, Mother, Person):- parent(Mother, Person), sex(Mother, f).
relation(son, Son, Person):- sex(Person, m), parent(Person, Son).
relation(daugther, Daugther, Person):- sex(Daugther, f), parent(Person, Daugther).
relation(brother, Brother, Person):- sex(Brother, m), parent(HelpPerson, Brother), parent(HelpPerson, Person), Brother \= Person, !.
relation(sister, Sister, Person):- sex(Sister, f), parent(HelpPerson, Sister), parent(HelpPerson, Person), Sister \= Person, !.
relation(husband, Husband, Wife):- parent(Husband, Person), parent(Wife, Person), sex(Husband, m), Husband \= Wife, !.
relation(wife, Wife, Husband):- parent(Wife, Person), parent(Husband, Person), sex(Wife, f), Wife \= Husband, !.
relation(grand_father, GrandFather, Person):- parent(HelpPerson, Person), relation(father, GrandFather, HelpPerson).
relation(grand_mother, GrandMother, Person):- parent(HelpPerson, Person), relation(mother, GrandMother, HelpPerson).

recursive_way(Current, Previous, Person, Val) :- (relation(Val, Current, Person); relation(Val, Person, Current)), 
not(member(Person, Previous)).
dfs_searching(H, H, _, _).
dfs_searching(Current, Last, H, [Val|T]) :- recursive_way(Current, H, Next, Val), dfs_searching(Next, Last, [Current|H], T).
path_searching(Way, First, Last) :- dfs_searching(First, Last, [], HelpWay), reverse(HelpWay, Way).
relative(A, B, C) :- relation(A, B, C).
relative(A, B, C) :- path_searching(A, B, C), !.
