color(white).
color(yellow).
color(black).
person(jenny).
person(jill).
wall(w1).
wall(w2).

fluent(inertial, on(C,W)) :- color(C), wall(W).

action(paint(P,C,W)) :- person(P), color(C), wall(W).

#const n = 2.
step(0..n).

holds(on(C,W), I+1) :- occurs(paint(P,C,W), I), I< n.

%state constrains:
-holds(on(C,W), I+1) :- occurs(paint(P,C1,W), I), holds(on(C,W), I), I<n.

-holds(on(C,W), I+1) :- occurs(paint(P,C1,W), I), color(C1),color(C), C1 != C, I<n.

-holds(on(C,W), I) :- holds(on(C1,W),I), color(C1), color(C), wall(W), C1 != C.


%inertial
holds(F,I+1) :- fluent(inertial, F), holds(F,I), not -holds(F, I+1), I<n.
-holds(F, I+1) :- fluent(inertial, F), -holds(F,I), not holds(F, I+1), I<n.


% CWA for action
-occurs(A, I) :- action(A), step(I), not occurs(A, I).

%concurrently action constrains
-occurs(paint(P1, C, W), I) | -occurs(paint(P2, C, W), I) :- step(I), action(paint(P1,C,W)), action(paint(P2,C,W)).

%initial
on(yellow, w).

%temporal
occurs(paint(jenny,white,w),0).
occurs(paint(jenny,black,w),1).


#show holds/2.