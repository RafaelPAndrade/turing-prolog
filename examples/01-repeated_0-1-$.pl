/* Repeated words (0,1) separated by $
 * Rafael P Andrade
 */

:- dynamic rule/5, tape/1.

tape([[0,0,1,0,1,$,0,0,1,0,1,$,0,0,1,0,1]]).

rule(qin, [0], q0, [x], [r]).         % Verify if all words have 0
rule(qin, [1], q1, [x], [r]).         % Verify if all words have 0
rule(qin, [$], q_sep, [$], [r]).      % Verify if everyone ended


rule(qBack, [x], qin, [x], [r]).      % Start analysing next symbol in word
rule(qBack, [A], qBack, [A], [l]).    % Anything else, continue going left


rule(q0, [$], qConf0, [$], [r]).      % Lets confirm the 0 on this word
rule(q0, [null], qBack, [null], [l]). % Lets go to next symbol
rule(q0, [0], q0, [0], [r]).          % Step over rest of the current word
rule(q0, [1], q0, [1], [r]).          % Idem

rule(qConf0, [0], q0, [y], [r]).      % Confirmed; next word
rule(qConf0, [y], qConf0, [y], [r]).  % Looking for a symbol(0/1)
rule(qConf0, [1], qrej, [1], [r]).    % Should have been a 0/y
rule(qConf0, [$], qrej, [$], [r]).    % Idem


rule(q1, [$], qConf1, [$], [r]).      % Lets confirm the 1.
rule(q1, [null], qBack, [null], [l]). % Lets go to next symbol
rule(q1, [0], q1, [0], [r]).          % Step over rest of the current word
rule(q1, [1], q1, [1], [r]).          % Idem

rule(qConf1, [1], q1, [y], [r]).      % Confirmed; next word
rule(qConf1, [y], qConf1, [y], [r]).  % Looking for a symbol(0/1)
rule(qConf1, [0], qrej, [0], [r]).    % Should have been a 1/y
rule(qConf1, [$], qrej, [$], [r]).    % Idem


rule(q_sep, [null], qacc, [null], [r]). % Done
rule(q_sep, [y], q_sep, [y], [r]).      % Everything should be y by now
rule(q_sep, [$], q_sep, [$], [r]).      % or a separator
rule(q_sep, [0], qrej, [0], [r]).       % Reject anything else
rule(q_sep, [1], qrej, [1], [r]).       % Idem
