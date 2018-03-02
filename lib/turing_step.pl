:- ensure_loaded('turing_base.pl').

% stepping slowly thru the execution
step :-
    tapes_initial_state(TLI, TRI), verify_tapes(TLI,TRI), step(TLI, TRI).

step(TLI, TRI) :-
    step(TLI, TRI, _, _).

step(TLI, TRI, TapesLeftFinal, TapesRightFinal) :-
    show_machine_state(0, '-', qin, TLI, TRI), get_char(_),
    step(qin, TLI, TRI, 1, TapesLeftFinal, TapesRightFinal).

% step/6
% Show the full state of the machine, one configuration at a time
step(qacc, TapesLeftN, TapesRightN, N, TapesLeftN, TapesRightN) :-
    format("End of computation, at step ~d~n", [N]),
    show_machine_state(N, qacc, qacc, TapesLeftN, TapesRightN).

step(qrej, TapesLeftN, TapesRightN, N, TapesLeftN, TapesRightN) :-
    format("End of computation, at step ~d~n", [N]),
    show_machine_state(N, qrej, qrej, TapesLeftN, TapesRightN).


step(StateN, TapesLN, TapesRN, N, TapesLF, TapesRF) :-
    tapes_heads(TapesRN, Ins, TapesRest),
    ( rule(StateN, Ins, StateM, Outs, Movs)
      ; format("ABORTED: No rule found for state '~w', inputs '~w'~n",
        [StateN, Ins]), !, fail
    ),
    tapes_heads(TapesRMod, Outs, TapesRest),
    show_machine_state(N, StateN, StateM, Ins, Outs, Movs, TapesLN, TapesRMod),
    tapes_movimentations(Movs, TapesLN, TapesRMod, TapesLM, TapesRM),
    M is N+1, get_char(_),
    step(StateM, TapesLM, TapesRM, M, TapesLF, TapesRF).
