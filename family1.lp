person(john).
person(sam).
person(alice).
person(bob).

gender(male).
gender(female).
father(john,sam).
mother(alice,sam).

gender_of(john,male).
gender_of(alice,female).
gender_of(sam,male).

parent(X,Y) :- father(X,Y).
parent(X,Y) :- mother(X,Y).

child(X,Y) :- parent(Y,X).
person(bill).
father(john,bill).
mother(alice,bill).
gender_of(bill,male).

brother(X,Y) :- gender_of(X,male),
			father(F,X),
			father(F,Y),
			mother(M,X),
			mother(M,Y),
			X != Y.

-father(X,Y) :- person(X),gender_of(X,famale).

-father(X,Y) :-	 person(X),person(Y),
	            father(Z,Y),
	            X != Z.


-father(X,Y) :- person(X), person(Y), 
	            not father(X,Y).


#show father/2.
%%#show -father/2.



			   