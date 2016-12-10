object(phone).
object(chihuahua).
object(towel).

person(claire).
person(rod).

location(library).
location(home).
location(store).

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
-holds(at(P1,L), I) :- holds(at(P2,L),I), person(P2), person(P1), location(L), P1 != P2.

%move to same place is not allowed
-holds(move(P1,L), I) :- holds(move(P2,L),I), person(P2), person(P1), location(L), P1 != P2.
holds(on(O, L), I) :- holds(carried(O, P), I), holds(at(P, L), I),object(O),person(P).

%CWA for defined fluent
-holds(F, I) :- fluent(defined, F), step(I),
				not holds(F, I).

%inertial
holds(F,I+1) :- fluent(inertial, F), holds(F,I), not -holds(F, I+1), I<n.
-holds(F, I+1) :- fluent(inertial, F), -holds(F,I), not holds(F, I+1), I<n.

%CWA for action
-occurs(A, I) :- action(A), step(I), not occurs(A, I).


%initial state
carried(phone, claire).
carried(towel,rod).
at(claire, library).
% at(rod, store).

% occurs(move(claire, home),0).
% occurs(move(rod,home),0).

occurs(move(claire, home),0).
occurs(move(rod, library),0).

#show holds/2.
