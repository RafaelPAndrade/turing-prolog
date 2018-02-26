Prolog Turing Machine Emulator
==============================

by Rafael P. Andrade

*Disclaimer*: This is a pet/personal project, use at your own risk!


What?
-----

This is an attempt to emulate Turing Machines, using Prolog (only tested
with swipl...), in a extensible, terminal-friendly way.

Currently, it only emulates the most basic Turing Machine: single-tape,
finite to the left, deterministic.


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

The tape is specified using the predicate tape/1, the argument a list of
symbols. Each symbol must be a valid, definite Prolog atom.

The rules are specified using the predicate rule/5, with the arguments being:

  - Name of the input state
  - Input symbol
  - Name of the ouput state
  - Output symbol
  - Tape movimentation (l/r).


Please consult the `examples/` for some sample programs.
