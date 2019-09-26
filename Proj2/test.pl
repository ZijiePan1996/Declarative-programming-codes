partial_eval(X, _, _, X) :- number(X).
partial_eval(X, X, V, V) :- atom(X).
partial_eval(X, Y, _, X) :- atom(X), X \= Y.
partial_eval(X+Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    number(EX),number(EY),!,
    E is EX + EY.
partial_eval(X+Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    E = EX + EY.
partial_eval(X-Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    number(EX),number(EY),!,
    E is EX - EY.
partial_eval(X-Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    E = EX - EY.
partial_eval(X*Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    number(EX),number(EY),!,
    E is EX * EY.
partial_eval(X*Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    E = EX * EY.
partial_eval(X/Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    number(EX),number(EY),!,
    E is EX / EY.
partial_eval(X/Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    E = EX / EY.
partial_eval(X//Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    number(EX),number(EY),!,
    E is EX // EY.
partial_eval(X//Y, Var, Val, E) :-
    partial_eval(X,Var,Val,EX),
    partial_eval(Y,Var,Val,EY),
    E = EX // EY.