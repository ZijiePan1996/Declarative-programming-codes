% Title: COMP90048 Declarative Programming project 2 
% Date: 20/05/2019
% Author: Zijie Pan
% Uni-id: 1059454
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This prolog program aims to solve the Maths Puzzles problem. 
% A maths puzzle should satisfy the following constraints:
% -- Rows and columns should be filled with valid digits (integers range from 
%    1 to 9). Row and column headings are not considered to be part of the row
%    or column, so they may be filled with larger digits; @constraint1
% -- Each row and each column contains no repeated digits; @constraint2
% -- All squares on the diagonal line from upper left to lower right contain
%    the same value; @constraint3
% -- The heading of each row and column (leftmost square in a row and topmost
%    square in a column) holds either the sum or the product of all the digits
%    in that row or column. @constraint4
% When the puzzle is posed, most of all of the squares will be empty, with the
% headings filled in. The goal of the puzzle is to fill in all the squares 
% according to the rules. A proper maths puzzle will have at most one solution.
% An example of a 3x3 puzzle as posed (left) and solved (right):
% 
%   |    | 14 | 10 | 35 |     %%    |    | 14 | 10 | 35 |
%   | 14 |    |    |    |     %%    | 14 |  7 |  2 |  1 |
%   | 15 |    |    |    |     %%    | 15 |  3 |  7 |  5 |
%   | 28 |    |  1 |    |     %%    | 28 |  1 |  1 |  7 |
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The program reads a puzzle as input. The puzzle_solution predicate holds 
% when all the conditions (predicates) are satisfied. The transpose/2 predicate
% is used to transpose the input puzzle so that the columns become rows, so 
% that the columns can be checked by checking the rows of the transposed 
% puzzle. The not_repeated/1 predicate checks constraint1 and constraint2, 
% while the equal_diagonal/1 and check_all_headings/1 predicates check 
% constraint3 and constraint4 seperately. The ground_puzzle/1 predicate is 
% used to make sure that the puzzle is ground when the test is performed. 

:- use_module(library(clpfd)).
:- use_module(library(apply)).

puzzle_solution([Heading | TailPuzzle]):-
    transpose([Heading | TailPuzzle], ReversedPuzzle),
    not_repeated([Heading | TailPuzzle]),
    not_repeated(ReversedPuzzle),
    equal_diagonal(TailPuzzle),
    check_all_headings([Heading | TailPuzzle]),
    check_all_headings(ReversedPuzzle),
    ground_vars([Heading | TailPuzzle]).

%%%%%%%%%%%%%%%%%%%%% Check constraint1 and constraint2 %%%%%%%%%%%%%%%%%%%%%%

not_repeated([_| TailPuzzle]) :-
    maplist(check_digits, TailPuzzle),
    maplist(all_distinct, TailPuzzle).

% Make sure elements in a given row is a valid integer between 1 and 9.
check_digits([_|Digit]) :-
        Digit ins 1..9.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Check constraint3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

equal_diagonal([Firstrow|Rows]) :-
    nth1(2, Firstrow, X),
    all_equal(Rows, 3, X).

% The all_equal/1 predicate takes rows of the puzzle as an argument, it holds
% when the Nth element of the row and the Nth+1 element of the next row are 
% equal to X, where X is the topleft element of the diagonal. Unlike other 
% constraints, this constraint only needs to be checked once.
all_equal([], _, _).
all_equal([Row|Rows], N, X) :-
    nth1(N, Row, X),
    Next #= N + 1,
    all_equal(Rows, Next, X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Check constraint4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apply the check_headings/1 predicate to the entire puzzle.
check_all_headings([_|TailPuzzle]) :-
    maplist(check_headings, TailPuzzle).

% Check if the heading of a given row is either the sum or product of the row 
% values.
check_headings([H|T]) :-
    (check_sum([H|T]);
    check_product(T, H)).

check_sum([Head|Tail]) :- sum(Tail, #=, Head).

% Check if the heading of a row is the product of the elements.
check_product([],1).
check_product([Head|Tail], Product) :-
        check_product(Tail, Accumulator),
        Product #= Accumulator * Head.

%%%%%%%%%%%%%%%%%%%%%%% Make sure the puzzle is ground %%%%%%%%%%%%%%%%%%%%%%%

ground_puzzle([_|TailPuzzle]) :- maplist(label, TailPuzzle).