vertex(a).
vertex(b).
vertex(c).
vertex(d).
vertex(e).
vertex(f).

edge(a,f).
edge(b,c).
edge(c,d).
edge(c,e).
edge(d,g).
edge(g,h).
edge(a,e).
edge(a,h).
edge(e,g).
edge(f,h).

blocked(e,g).
blocked(f,h).


connected(X,Y) :- edge(X,Y),not blocked(X,Y).
connected(X,Y) :- edge(X,Z), connected(Z,Y), vertex(Z),not blocked(X,Y).
%%connected(X,Y) :- edge(X,Y).
%%connected(X,Y) :- edge(X,Z), connected(Z,Y), vertex(Z).


%%#show connected/2.
#show blocked/2.