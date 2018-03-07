Prolog Turing Machine Emulator
==============================

by Rafael P. Andrade

*Disclaimer*: This is a pet/personal project, use at your own risk!


What?
-----

This is an attempt to emulate Turing Machines, using Prolog (only tested
with swipl...), in a extensible, terminal-friendly way.

Currently, it emulates a multi-tape, bidirectional and deterministic
Turing Machine, with S-transitions.


Why?
----

Because I am having a class that uses Turing Machines, and the suggested
emulator was a Java .jar file with a Swing UI. Currently, I cannot run
that emulator.


How?
----

### To run ###


Stepping execution:

	swipl -s load.pl
	[....]
	1 ?- go.

or (once everything is loaded)

	2 ?- step.


Running execution (no stops):

	3 ?- run.


### To configure the machine ###

The tapes are specified using the predicate init_tapes/1 or init_tapes/2, the
argument is/are a list of lists of symbols (stand for a list of tapes with
symbols). Each symbol must be a valid, definite Prolog atom.

The rules are specified using the predicate rule/5, with the arguments being:

  - Name of the input state
  - Input symbols
  - Name of the ouput state
  - Output symbols
  - Tape movimentation (l/r/s).


Please consult the `examples/` for some sample programs.
