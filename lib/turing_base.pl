% Turing Machine
% Helpful predicates

:- dynamic rule/5, init_tapes/1, init_tapes/2.

% tape_movimentation/5
% Transfers elements from the 2 sides of the tape,
% according to the asked movimentation
tape_movimentation(l, [H | TapeL1], TapeR0, TapeL1, [H | TapeR0]).
tape_movimentation(r, TapeL0, [H | TapeR1], [H | TapeL0], TapeR1).
tape_movimentation(s, TapeL0, TapeR0, TapeL0, TapeR0).

% tape_head/3
% Gets the head and tail of the given tape. Previously done in run and
% step directly, now a new predicate because tapes_heads/3.
tape_head([],    null, []).
tape_head([H|T], H,    T).

% showing things
% Show tapes
show_tapes(TapesLeft, TapesRight) :-
    length(TapesLeft, X),
    numlist(1, X, Ns),
    maplist(show_tape, TapesLeft, TapesRight, Ns).

show_tape(TapeLeft, TapeRight) :-
    format("Tape:~n"),
    show_left_tape(TapeLeft), show_right_tape(TapeRight).

show_tape(TapeLeft, TapeRight, N) :-
    format("Tape ~d:~n", [N]),
    show_left_tape(TapeLeft), show_right_tape(TapeRight).

show_left_tape(TapeLeft) :-
    reverse(TapeLeft, X),
    format("Left tape: ~w~n", [X]).

show_right_tape(TapeRight) :-
    format("Right tape: ~w~n", [TapeRight]).


% Show state
show_machine_state(N, StateP, StateQ, TLQ, TRQ) :-
    show_machine_state(N, StateP, StateQ, '-', '-', '-', TLQ, TRQ).

show_machine_state(N, StateP, StateQ, Ins, Outs, Head_Movs, TLQ, TRQ) :-
    format("Transition Number:~24+~d~n", [N]),
    format("State transition:~24+~w~8+ ---> ~w~n", [StateP, StateQ]),
    format("Head read/write:~24+~w~8+ ---> ~w~n", [Ins, Outs]),
    format("Head movement:~38+~w~n", [Head_Movs]),
    show_tapes(TLQ, TRQ).


% maplist/6
% Used for multi-tape machine, to apply the predicate
% tape_movimentation/5 to multiple tapes
maplist(_,[],[],[],[],[]).
maplist(Predicate, [A|As], [B|Bs], [C|Cs], [D|Ds], [E|Es]) :-
    call(Predicate, A, B, C, D, E),
    maplist(Predicate, As, Bs, Cs, Ds, Es).

% tapes_movimentations/5
% Same as tape_movimentation/5, applied to multiple tapes
tapes_movimentations(Movs, TapesL0, TapesR0, TapesL1, TapesR1) :-
    maplist(tape_movimentation, Movs, TapesL0, TapesR0, TapesL1, TapesR1).

% tapes_heads/3
% Gets the input/writes the output in a multi-tape setting
tapes_heads(Tapes, Heads, Rests) :-
    maplist(tape_head, Tapes, Heads, Rests).


% tapes_initial_state/2
% Provides the initial tape configuration, loaded from the user provided
% file, in predicates init_tapes/1 or init_tapes/2.
% This predicate adapts the input, if the user provided only the
% right tapes (init_tapes/1); left tapes are blank by default

tapes_initial_state(TapesL, TapesR) :-
    init_tapes(TapesR),
    length(TapesR, N),
    make_empty_tapes_(N, TapesL).

tapes_initial_state(TapesL, TapesR) :-
    init_tapes(TapesL0, TapesR),
    maplist(reverse, TapesL0, TapesL).

make_empty_tapes_(1,[[]]):-!.
make_empty_tapes_(N, [[] | R]) :-
    N > 1, M is N-1,
    make_empty_tapes_(M, R).


% verify_tapes/2
% Verifies if the set of the left parts of the tapes and the right parts
% match in number, and if everything is a proper list, etc.
verify_tapes(TapesL, TapesR) :-
    ( is_list(TapesR)
    ; format("ERROR: The set of the right parts of the tapes is not a list~n"),
      !, fail),
    ( is_list(TapesL)
    ; format("ERROR: The set of the left parts of the tapes is not a list~n"),
      !, fail),
    ( length(TapesR, N), length(TapesL, N)
    ; format("ERROR: The two sets of partial tapes don't have equal lengths~n"),
      !, fail),
    maplist(verify_tape, TapesR), maplist(verify_tape, TapesL).

% verify_tape/1
% Just verifies that the argument is a list with no variables, and prints a
% error message otherwise. Created to use with maplist.
verify_tape(Tape) :-
    ( is_list(Tape)
    ; format("ERROR: The given tape is not a list: ~w~n", [Tape]),
      !, fail),
    ( maplist(nonvar, Tape)
    ; format("ERROR: The given tape has a variable: ~w~n", [Tape]),
      !, fail).


% clean_db/0
% Previously on load.pl, but should be here
% Clears the initial configuration info loaded by the user
clean_db :-
    retractall(rule(_,_,_,_,_)),
    retractall(init_tapes(_,_)),
    retractall(init_tapes(_)).
