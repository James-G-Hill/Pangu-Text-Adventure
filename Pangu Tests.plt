:- begin_tests(pangutest).

:- consult('Pangu.pl').
:- use_module(library(pangu)).

test(N) :-
	n,
	years(X),
	X == 17000.

:- end_tests(pangutest).