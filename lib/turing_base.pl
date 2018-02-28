% Turing Machine
% Helpful predicates

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

show_machine_state(N, StateP, StateQ, In, Out, Head_Mov, TLQ, TRQ) :-
    format("Transition Number:~24+~d~n", [N]),
    format("State transition:~24+~w~8+ ---> ~w~n", [StateP, StateQ]),
    format("Head read/write:~24+~w~8+ ---> ~w~n", [In, Out]),
    format("Head movement:~24+~w~n", Head_Mov),
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
