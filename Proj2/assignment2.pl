% answer for Q1
correspond(E1,L1,E2,L2) :-
	nth1(N,L1,E1),
	nth1(N,L2,E2).

% answer for Q2
interleave(Ls,[]) :- check_empty(Ls),!.
interleave(Ls, L):-
    get_head(Ls,Hs),
    get_tail(Ls,Ts),
    append(Hs,LT,L),
    interleave(Ts,LT).

get_head([],[]).
get_head([[H|_]|T],[H|LT]):-
    get_head(T,LT).

get_tail([],[]).
get_tail([[_|T1]|T],[T1|LT]):-
    get_tail(T,LT).

check_empty([]).%
check_empty([[]|T]):-
    check_empty(T).
%
% answer for Q3%
partial_eval(X, _, _, X) :- number(X).
partial_eval(X, X, Val, Val) :- atom(X).
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