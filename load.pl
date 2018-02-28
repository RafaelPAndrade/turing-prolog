% Menu to make using this emulator more pleasant

:- dynamic rule/5, init_tapes/2, init_tapes/1.
:- [ 'lib/utils.pl',
     'lib/turing_base.pl',
     'lib/turing_run.pl',
     'lib/turing_step.pl'
   ].


clean_db :-
        retractall(rule(_,_,_,_,_)),
        retractall(tape(_)).



go :- go(user_input, user_output, user_error).
go(Input, Output, _) :-
    format(Output, "Starting.~n", []),
    get_data(Input, Output),!,
    step.


get_data(Input, Output) :-
    format(Output, "Cleaning in-memory data base...~n", []),
    clean_db,!,
    get_input_files(Input, Output, RulesFile),
    consult(RulesFile).

get_input_files(Input, Output, RulesFile) :-
    ask_question_answer_accept(
        Input, Output,
        "Which (Prolog) file has the machine rules?~n",
        RulesFile,
        readable_file
    ).

