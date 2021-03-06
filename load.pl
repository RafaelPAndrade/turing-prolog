% Menu to make using this emulator more pleasant

:- [ 'lib/utils.pl',
     'lib/turing_base.pl',
     'lib/turing_run.pl',
     'lib/turing_step.pl'
   ].

go :- go(user_input, user_output, user_error).
go(Input, Output, _) :-
    format(Output, "Starting.~n", []),
    get_data(Input, Output),!,
    once(step).


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

