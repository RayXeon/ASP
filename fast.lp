class(flyingObject).

class(plane).
class(jet).

class(bird).
class(eagle).
class(robin).

is_subclass(plane,flyingObject).
is_subclass(bird,flyingObject).
is_subclass(jet,plane).
is_subclass(eagle,bird).
is_subclass(robin,bird).

subclass(C1,C2) :- is_subclass(C1,C2).
subclass(C1,C3) :- is_subclass(C1,C2),subclass(C2,C3).

-subclass(C1,C2) : class(C1), class(C2), not subclass(C1,C2).

object(jo).
object(sr_71).

is_a(jo,robin).
is_a(sr_71,jet).

member(X,C) :- is_a(X,C).
member(X,C) :- is_a(X,C0), subclass(C0,C).

is_faster(plane,bird).
is_faster(eagle,robin).

faster(X,Y) :- object(X), object(Y),
			   class(C1), class(C2),
			   member(X,C1), member(Y,C2),
			   is_faster(C1, C2).
			   
#show faster/2.