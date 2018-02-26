% Prolog predicates to interact with user


readable_file(File) :-
    access_file(File, read).

writeable_file(File) :-
    access_file(File, write).


is_yes_no_answer(Ans) :-
    member(Ans, ["y","s","n"]).

is_yes_answer(Ans) :-
    member(Ans, ["y", "s"]).

ask_question_answer(Input, Output, Question, Answer) :-
    format(Output, Question, []),
    read_string(Input, "\n", "\r\t", _, Answer).


ask_question_answer_accept(Input, Output, Question, Answer, Accept) :-
    repeat,
    ask_question_answer(Input, Output, Question, Answer),
    ( call(Accept, Answer)
    -> !
    ;  fail
    ).

ask_question_yes_no(Input, Output, Question) :-
    ask_question_answer_accept(
        Input,
        Output,
        Question,
        Answer,
        is_yes_no_answer
    ), is_yes_answer(Answer), !.

