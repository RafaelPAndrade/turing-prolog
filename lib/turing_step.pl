:- ensure_loaded('turing_base.pl').

% stepping slowly thru the execution
step :-
    init_tapes(TLI, TRI), step(TLI, TRI).

step(TLI, TRI) :-
    step(TLI, TRI, _, _).

step(TLI, TRI, TapesLeftFinal, TapesRightFinal) :-
    show_machine_state(0, '-', qin, TLI, TRI), get_char(_),
    step(qin, TLI, TRI, 1, TapesLeftFinal, TapesRightFinal).

% step/6
% Show the full state of the machine, one configuration at a time
step(qacc, TapeLeftN, TapeRightN, N, TapeLeftN, TapeRightN) :-
    format("End of computation, at step ~d~n", [N]),
    show_machine_state(N, qacc, qacc, TapeLeftN, TapeRightN).

step(qrej, TapeLeftN, TapeRightN, N, TapeLeftN, TapeRightN) :-
    format("End of computation, at step ~d~n", [N]),
    show_machine_state(N, qrej, qrej, TapeLeftN, TapeRightN).


step(StateN, TapeLN, [In | TapeRN], N, TapeLF, TapeRF) :-
    ( rule(StateN, In, StateM, Out, Mov)
      ; format("ABORTED: No rule found for state '~w', input '~w'~n",
        [StateN, In]), !, fail
    ),
    show_machine_state(N, StateN, StateM, In, Out, Mov, TapeLN, [Out | TapeRN]),
    tape_movimentation(Mov, TapeLN, [Out | TapeRN], TapeLM, TapeRM),
    M is N+1, get_char(_),
    step(StateM, TapeLM, TapeRM, M, TapeLF, TapeRF).


% add a null element at the right, if tape ended
step(StateN, TapeLN, [], N, TapeLF, TapeRF) :-
    step(StateN, TapeLN, [null], N, TapeLF, TapeRF).
