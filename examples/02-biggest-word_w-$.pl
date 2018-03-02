/* Biggest unary word, character w, separator $
 * Rafael p Andrade
 */

% Actually unnecessary
:- dynamic rule/5, init_tapes/1.

init_tapes([[w,w,w,$,w,$,w,w,w,w,w,$,w,w,$],    % Input tape
            []]).                               % Output tape


rule(qin, [w,_], qCopy, [w,$], [s,r]).
rule(qin, [$,X], qin, [$,X], [r,s]).
rule(qin, [null,X], qacc, [null,X], [s,s]).

rule(qCopy, [w,_], qCopy, [w,w], [r,r]).
rule(qCopy, [$,X], qBack, [$,X], [s,l]).
rule(qCopy, [null,X], qacc, [null,X], [s,s]).

rule(qBack, [$,$], qCopy, [$,$], [r,r]).
rule(qBack, [X,w], qBack, [X,w], [s,l]).
