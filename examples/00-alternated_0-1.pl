/* Alternated 0-1
 * Rafael P Andrade
 */

:- dynamic rule/5, tape/1.

tape([[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]]).

rule(qin, [0], q0, [0], [r]).         % Got a 0
rule(qin, [1], q1, [1], [r]).         % Got a 1
rule(qin, [null], qacc, [null], [r]). % End of tape

rule(q0, [0], qrej, [0], [r]).        % Should have gotten a 1
rule(q0, [1], q1, [1], [r]).          % Got a 1, alternated, continue
rule(q0, [null], qacc, [null], [r]).  % End of tape

rule(q1, [0], q0, [0], [r]).          % Should have gotten a 1
rule(q1, [1], qrej, [1], [r]).        % Got a 0, alternated, continue
rule(q1, [null], qacc, [null], [r]).  % End of tape
