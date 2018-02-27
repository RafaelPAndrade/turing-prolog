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
% we have no indexes in prolog.
% Current pos is first element of the right tape
% We stop, by default, on qacc or qrej, ugly abort on undefined.

% run/5
% the predicate that does the iteration of states, quickly
run(qacc, TapesLF, TapesRF, TapesLF, TapesRF):-!, format('ACCEPTED~n').
run(qrej, TapesLF, TapesRF, TapesLF, TapesRF):-!, format('REJECTED~n').
run(State0, TapesL0, TapesR0, TapesLF, TapesRF) :-
    tapes_heads(TapesR0, Ins, TapesRest),
    rule(State0, Ins, State1, Outs, Movs),
    tapes_heads(TapesRMod, Outs, TapesRest),
    tapes_movimentations(Movs, TapesL0, TapesRMod, TapesL1, TapesR1),
    run(State1, TapesL1, TapesR1, TapesLF, TapesRF).
