color(white).
color(yellow).

wall(w).

fluent(inertial, on(C,W)) :- color(C), wall(W).

action(paint(C,W)) :- color(C), wall(W).

#const n = 1.
step(0..n).
%causal law
holds(on(C,W), I+1) :- occurs(paint(C,W), I), I< n.

%state constrains:
-holds(on(C,W), I+1) :- occurs(paint(C1,W), I), holds(on(C,W), I), I<n.

-holds(on(C,W), I+1) :- occurs(paint(C1,W), I), color(C1),color(C), C1 != C, I<n.

-holds(on(C,W), I) :- holds(on(C1,W),I), color(C1), color(C), wall(W), C1 != C.

%inertial
holds(F,I+1) :- fluent(inertial, F), holds(F,I), not -holds(F, I+1), I<n.
-holds(F, I+1) :- fluent(inertial, F), -holds(F,I), not holds(F, I+1), I<n.

%CWA for action
-occurs(A, I) :- action(A), step(I), not occurs(A, I).

%initial state
on(yellow, w).

%action 1
occurs(paint(white,w),0).

#show holds/2.