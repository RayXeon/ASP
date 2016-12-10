object(phone).
object(chihuahua).

person(claire).

location(library).
location(home).
location(ttt).

fluent(inertial, carried(Obj, P)) :- object(Obj), person(P).
fluent(inertial, at(P,L)) :- person(P), location(L).
fluent(defined, on(O,L)) :- object(O),location(L).
action(move(P, L)) :- person(P), location(L).


#const n = 1.
step(0..1).

holds(at(P, L), I+1) :- occurs(move(P,L),I), I<n.
holds(on(O, L), I+1) :- occurs(move(P,L),I),object(O),carried(O,P), I<n.

-holds(at(P,L1), I) :- holds(at(P,L2),I), location(L2),location(L1), L1 != L2.

%two men at same place
%% -holds(at(P1,L1), I) :- holds(at(P2,L1),I), person(P2), P1 != P2.

holds(on(O, L), I) :- holds(carried(O, P), I), holds(at(P, L), I), object(O), person(P).

%CWA for defined fluent
-holds(F, I) :- fluent(defined, F), step(I),
				not holds(F, I).

%inertial
holds(F,I+1) :- fluent(inertial, F), holds(F,I), not -holds(F, I+1), I<n.
-holds(F, I+1) :- fluent(inertial, F), -holds(F,I), not holds(F, I+1), I<n.

%CWA for action
-occurs(A, I) :- action(A), step(I), not occurs(A, I).

%initial
carried(chihuahua, claire).
at(claire, library).

occurs(move(claire, home),0).

#show holds/2.
