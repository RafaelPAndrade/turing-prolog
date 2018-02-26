:- ensure_loaded('turing_base.pl').


% runnning the emulation full speed
run :-
    tape(T), run(T).

run(T) :-
    run(T, LF, RF),
    show_left_tape(LF), show_right_tape(RF).

run(T, LF, RF) :-
    run(qin, [], T, LF, RF).


% run/5
% run(State0,TapeL0,TapeR0,TapeLFinal,TapeRFinal)
% We use left to the head and right to the head, because
% we have no indexes in prolog. So, in the beginning TapeL0 = [].
% Current pos is first element of the right tape
% We stop, by default, on qacc or qrej, ugly abort on undefined.

% run/5
% the predicate that does the iteration of states, quickly
run(qacc, TapeLF, TapeRF, TapeLF, TapeRF):-!, format('ACCEPTED~n').
run(qrej, TapeLF, TapeRF, TapeLF, TapeRF):-!, format('REJECTED~n').
run(State0, TapeL0, [In | TapeR0], TapeLF, TapeRF) :-
    rule(State0, In, State1, Out, Mov),
    tape_movimentation(Mov, TapeL0, [Out | TapeR0], TapeL1, TapeR1),!,
    run(State1, TapeL1, TapeR1, TapeLF, TapeRF).

% add the null element if already ended right of the tape
run(State0, TapeL0, [], TapeLF, TapeRF) :-
    run(State0, TapeL0, [null], TapeLF, TapeRF).

