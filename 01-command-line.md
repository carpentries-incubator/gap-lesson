---
layout: page
title: Programming with GAP
subtitle: First session with GAP
minutes: 10
---
> ## Learning Objectives {.objectives}
>
> * Learning objective 1
> * Learning objective 2

If GAP is installed correctly you should be able to start it some way that
depends on your operating system. GAP starts with the banner displaying
information about the version of the system and loaded components, and then
displays the command line prompt `gap>`, for example:

~~~ {.output}
┌───────┐   GAP, Version 4.7.8 of 09-Jun-2015 (free software, GPL)
│  GAP  │   http://www.gap-system.org
└───────┘   Architecture: x86_64-apple-darwin14.5.0-gcc-5-default64
Libs used:  gmp, readline
Loading the library and packages ...
Components: trans 1.0, prim 2.1, small* 1.0, id* 1.0
Packages:   AClib 1.2, Alnuth 3.0.0, AtlasRep 1.5.0, AutPGrp 1.6,
            Browse 1.8.6, CRISP 1.3.8, Cryst 4.1.12, CrystCat 1.1.6,
            CTblLib 1.2.2, FactInt 1.5.3, FGA 1.2.0, GAPDoc 1.5.1, IO 4.4.4,
            IRREDSOL 1.2.4, LAGUNA 3.7.0, Polenta 1.3.2, Polycyclic 2.11,
            RadiRoot 2.7, ResClasses 3.4.0, Sophus 1.23, SpinSym 1.5,
            TomLib 1.2.5
Try '?help' for help. See also  '?copyright' and  '?authors'
gap>
~~~

To leave GAP, type `quit;` at the GAP prompt. Remember that all GAP commands,
including this one, must be finished with a semicolon! Practice this entering
`quit;` to leave GAP, and then start a new GAP session.

Now you can use GAP as a calculator:

~~~ {.gap}
( 1 + 2^32 ) / (1 - 2*3*107 );
~~~

~~~ {.output}
-6700417
~~~

Now we will turn on logging to save all subsequent interaction with GAP into a
log file. Assuming that you do not have a file named "gap-intro.log" in the GAP
current directory (i.e. the directory where you have started GAP on Unix systems,
and the working directory for GAP on Windows), enter the following:

~~~ {.gap}
LogTo("gap-intro.log");
~~~

Then the file "gap-intro.log" in the GAP current directory will contain all
subsequent input and output that will appear on your terminal. To stop logging,
you will need to call `LogTo` without arguments, as in `LogTo();` (but
don't do this now, as we don't want to stop it), or leave GAP.

It will be useful to leave some comments in the log file in case you will
return to it in the future. A comment in GAP starts with the symbol `#` and
continues to the end of the line. Now, if you enter the following after the
GAP prompt:

~~~ {.gap}
# GAP Software Carpentry Lesson
~~~

then after pressing Return key, GAP will display new prompt, but the comment
will be written to the log file. To check that this works, open another terminal
window, locate the log file and print it using `cat` to verify this.

The log file records all interaction with GAP that is happening after the call
to `LogTo`, but not before. We can certainly repeat the calculation from above
if we want to record it as well. Instead of retyping it, we will use Up and Down
arrow keys to scroll the *command line history*. Repeat this until you will see
the formula again, then press Return (the location of the cursor in the command
line does not matter):

~~~ {.gap}
( 1 + 2^32 ) / (1 - 2*3*107 );
~~~

~~~ {.output}
-6700417
~~~

Now restore the previous command, use Left and Right arrow keys, Delete or
Backspace to edit it and replace 32 by 64, then press the Return key:

~~~ {.gap}
( 1 + 2^64 ) / (1 - 2*3*107 );
~~~

~~~ {.output}
-18446744073709551617/641
~~~

It is useful to know that if the command line history is long, one could
perform a partial search by typing the initial part of the command and using
Up and Down arrow keys after that, to scroll only the lines that begin with
the same string.

Whitespace characters (i.e. Spaces, Tabs and Returns) are insignificant for
the meaning of GAP input in most places. For example, the previous input
could be typed without spaces:

~~~ {.gap}
(1+2^64)/(1-2*3*107);
~~~

~~~ {.output}
-18446744073709551617/641
~~~

Whitespace symbols are often used to format more complicated commands for
better readability. For example, the following input which creates a 3x3 matrix

~~~ {.gap}
m:=[[1,2,3],[4,5,6],[7,8,9]];
~~~

~~~ {.output}
[ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]
~~~

may be spread over three lines. In this case, instead of the full prompt
`gap>`, a partial prompt `>` will be displayed until the user will finish
the input by a semicolon:

~~~ {.gap}
gap> m:=[[ 1, 2, 3 ],
>        [ 4, 5, 6 ],
>        [ 7, 8, 9 ]];
~~~

~~~ {.output}
[ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]
~~~

Note that you may use `Display` to pretty-print the matrix:

~~~ {.gap}
Display(m);
~~~

~~~ {.output}
[ [  1,  2,  3 ],
  [  4,  5,  6 ],
  [  7,  8,  9 ] ]
~~~

You have met by now some GAP functions, e.g. `LogTo` and `Display`, and observed
that to call them, one needs to use brackets with no or some arguments in them.

> ## Functions are also GAP objects {.callout}
>
> Check what happens if you forget to add brackets,
> e.g. type `LogTo;` and `Factorial;`
> We will explain the differences in these outputs later.

Here there are examples of calling some other GAP functions:

~~~ {.gap}
Factorial(100);
~~~

~~~ {.gap}
93326215443944152681699238856266700490715968264381621468\
59296389521759999322991560894146397615651828625369792082\
7223758251185210916864000000000000000000000000
~~~

(this also displays multi-line output; the exact width may depend
on the terminal settings),

~~~ {.gap}
Determinant(m);
~~~

~~~ {.gap}
-30
~~~

and

~~~ {.gap}
Factors(2^64-1);
~~~

~~~ {.gap}
[ 3, 5, 17, 257, 641, 65537, 6700417 ]
~~~

Functions may be combined in various ways, and may be
used as arguments of other functions, for example:

~~~ {.gap}
Filtered( Partitions(10), x -> 5 in x);
~~~

~~~ {.gap}
[ [ 5, 1, 1, 1, 1, 1 ], [ 5, 2, 1, 1, 1 ], [ 5, 2, 2, 1 ],
  [ 5, 3, 1, 1 ], [ 5, 3, 2 ], [ 5, 4, 1 ], [ 5, 5 ] ]
~~~

> ## What does the last command calculate?{.callout}
>
> Also, how many functions can you see in the input?

TODO:

* Show some library functions with long names

* Tab for name completion

* Error - GAP is case - sensitive (also impacts name completion)

* Remark on customising GAP to save command line history between sessions

* Invoking help

* Copying and pasting (from manual examples)

Now let's consider the following problem: for a finite group _G_, calculate the
average order of its element (that is, the sum of orders of its elements divided
by the order of the group). Where to start?

Enter `?Group`, and you will see all help entries, starting with `Group`:

~~~ {.output}
┌──────────────────────────────────────────────────────────────────────────────┐
│   Choose an entry to view, 'q' for none (or use ?<nr> later):                │
│[1]    AutoDoc (not loaded): @Group                                           │
│[2]    loops (not loaded): group                                              │
│[3]    polycyclic: Group                                                      │
│[4]    RCWA (not loaded): Group                                               │
│[5]    Tutorial: Groups and Homomorphisms                                     │
│[6]    Tutorial: Group Homomorphisms by Images                                │
│[7]    Tutorial: group general mapping                                        │
│[8]    Tutorial: GroupHomomorphismByImages vs. GroupGeneralMappingByImages    │
│[9]    Tutorial: group general mapping single-valued                          │
│[10]   Tutorial: group general mapping total                                  │
│[11]   Reference: Groups                                                      │
│[12]   Reference: Group Elements                                              │
│[13]   Reference: Group Properties                                            │
│[14]   Reference: Group Homomorphisms                                         │
│[15]   Reference: GroupHomomorphismByFunction                                 │
│[16]   Reference: Group Automorphisms                                         │
│[17]   Reference: Groups of Automorphisms                                     │
│[18]   Reference: Group Actions                                               │
│[19]   Reference: Group Products                                              │
│[20]   Reference: Group Libraries                                             │
│ > > >                                                                        │
└─────────────── [ <Up>/<Down> select, <Return> show, q quit ] ────────────────┘
~~~

* TODO: what you will see if the Browse package is not compiled?

You may use arrow keys to move up and down the list, and open help pages by
pressing Return key. For this exercise, open `Tutorial: Groups and Homomorphisms`
first. Note navigation instructions at the bottom of the screen. Look at
first two pages, then press `q` to return to the selection menu. Next, navigate to
`Reference: Groups` and open it. Within two first pages you will find the
function `Group` and mentioning of `Order`.

* TODO: How to use `SetHelpViewer` to use browser for help and how to
customise GAP to use this setting automatically.

* TODO: If Browse package is not compiled, this step will look differently.
There will be no frame like above.

Let's copy the following input from  the first example of the GAP Reference
manual Chapter on groups. It shows how to create permutations, and assign values
to variables; also it is finished by a double semicolon to suppress output:

~~~ {.gap}
a:=(1,2,3);;b:=(2,3,4);;
~~~

Next, let `G` be a group generated by `a` and `b`:

~~~ {.gap}
G:=Group(a,b);
~~~

~~~ {.output}
Group([ (1,2,3), (2,3,4) ])
~~~

We may explore some of its properties:

~~~ {.gap}
Size(G); IsAbelian(G); StructureDescription(G);
~~~

~~~ {.output}
12
false
"A4"
~~~

Our next task is to find out how to obtain a list of element and their orders.
Enter `?elements` and explore the list of help topics. After its inspection,
the entry from the Tutorial does not seem relevant, but the entry from the
Reference manual is. It also tells the difference between using `AsSSortedList`
and `AsList`. So, this is the list of elements of `G`:

~~~ {.gap}
AsList(G);
~~~

~~~ {.output}
[ (), (2,3,4), (2,4,3), (1,2)(3,4), (1,2,3), (1,2,4), (1,3,2), (1,3,4),
  (1,3)(2,4), (1,4,2), (1,4,3), (1,4)(2,3) ]
~~~

The returned object is a _list_. We would like to assign it to a variable
to explore and reuse. We forgot to do it when we were calculating it. Of
course, we may use the command line history to restore the last command, edit
it and call again. But instead, we will use `last` which is a special variable
holding the last result returned by GAP:

~~~ {.gap}
x:=last;
~~~

~~~ {.output}
[ (), (2,3,4), (2,4,3), (1,2)(3,4), (1,2,3), (1,2,4), (1,3,2), (1,3,4),
  (1,3)(2,4), (1,4,2), (1,4,3), (1,4)(2,3) ]
~~~

TODO:

* explore list properties. Show Filter, List and other useful tips

* Show how records look like. When records better than lists?

* Introduce programming language

* Somewhere on the way introduce break loop

* Show Print

* Good design: not output but return for further use

* Introduce functional notation for Sum(List(...))

Paragraphs of text
--- possibly including [definitions](reference.html#definitions) ---
mixed with:

~~~ {.gap}
some code:
    to be displayed
~~~

and:

~~~ {.output}
output
from
program
~~~

and:

~~~ {.error}
error reports from programs (if any)
~~~

and possibly including some of these:

> ## Callout Box {.callout}
>
> An aside of some kind.

and one or more of these at the end:

> ## Challenge Title {.challenge}
>
> Description of a single challenge,
> separated from the title by a blank line.
> There may be several challenges;
> they should all come at the end of the file,
> and each should have a short, meaningful title.
