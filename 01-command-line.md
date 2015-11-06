---
layout: page
title: Introduction
subtitle: First session in GAP
minutes: 10
---
> ## Learning Objectives {.objectives}
>
> * Learning objective 1
> * Learning objective 2

If GAP is installed correctly you should be able to start it some way that
depends on your operating system. GAP starts with the banner displaying
information about the version of the system and loaded components, and then
displays the command line prompt `>gap`, for example:

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
including this, must be finished with a semicolon! Try to practice this, then
restart GAP again.

Now you can use GAP as a calculator:

~~~ {.gap}
gap> ( 1 + 2^32 ) / (1 - 2*3*107 );
~~~

~~~ {.output}
gap> (1+2^32)/(1-2*3*107);
-6700417
~~~

TODO:

* Remark on whitespaces in input.

* Command line editing before hitting the return key. Multi-line commands.

* Scrolling history. Scrolling partial history. Editing command line from history.

* Remark on customising GAP to save command line history between sessions

* Show some library functions

* Error - GAP is case - sensitive

* Tab for name completion

* Invoking help

* Copying and pasting (from manual examples)

* Using `LogTo`

* Comments start with `#`

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

* explore list properties

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
