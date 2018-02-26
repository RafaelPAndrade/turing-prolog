% Turing Machine
% Infinite to the Right

% Predicates
% rule/5
% parsed from dcg. has all the transition rules indexed


% tape_movimentation/5
% Transfers elements from the 2 sides of the tape,
% according to the asked movimentation
tape_movimentation(l, [H | TapeL1], TapeR0, TapeL1, [H | TapeR0]).
tape_movimentation(r, TapeL0, [H | TapeR1], [H | TapeL0], TapeR1).


% showing things
% Show tapes
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
    format("Head movement:~24+~w~nTape:~n", Head_Mov),
    show_left_tape(TLQ), show_right_tape(TRQ).
