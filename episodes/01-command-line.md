---
title: First session with GAP
teaching: 30
exercises: 10
---

::::::::::::::::::::::::::::::::::::::: objectives

- Time-saving tips and tricks
- Using GAP's help system
- Basic objects and constructions in the GAP language

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- Working with the GAP command line

::::::::::::::::::::::::::::::::::::::::::::::::::

If GAP is installed correctly you should be able to start it. Exactly how
you start GAP will depend on your operating system and how you installed
GAP. GAP starts with the *banner* displaying information about the version of
the system and loaded components, and then displays the command line prompt
`gap>`, for example:

```output
 ┌───────┐   GAP 4.9.2 of 04-Jul-2018
 │  GAP  │   https://www.gap-system.org
 └───────┘   Architecture: x86_64-apple-darwin16.7.0-default64
 Configuration:  gmp 6.1.2, readline
 Loading the library and packages ...
 Packages:   AClib 1.3, Alnuth 3.1.0, AtlasRep 1.5.1, AutPGrp 1.9,
             Browse 1.8.8, CRISP 1.4.4, Cryst 4.1.17, CrystCat 1.1.8,
             CTblLib 1.2.2, FactInt 1.6.2, FGA 1.4.0, GAPDoc 1.6.1, IO 4.5.1,
             IRREDSOL 1.4, LAGUNA 3.9.0, Polenta 1.3.8, Polycyclic 2.14,
             PrimGrp 3.3.1, RadiRoot 2.8, ResClasses 4.7.1, SmallGrp 1.3,
             Sophus 1.24, SpinSym 1.5, TomLib 1.2.6, TransGrp 2.0.2,
             utils 0.54
 Try '??help' for help. See also '?copyright', '?cite' and '?authors'
gap>
```

To leave GAP, type `quit;` at the GAP prompt. Remember that all GAP commands,
including this one, must be finished with a semicolon! Practice entering
`quit;` to leave GAP, and then starting a new GAP session. Before continuing, you
may wish to enter the following command to display GAP prompts and user inputs
in different colours:

```gap
 ColorPrompt(true);
```

The easiest way to start trying GAP out is as a calculator:

```gap
( 1 + 2^32 ) / (1 - 2*3*107 );
```

```output
-6700417
```

If you want to record what you did in a GAP session, so you can look over it
later, you can enable logging with the `LogTo` function, like this.

```gap
LogTo("gap-intro.log");
```

This will create a file file `gap-intro.log` in the current directory which
will contain all subsequent input and output that appears on your terminal.
To stop logging, you can call `LogTo` without arguments, as in `LogTo();`,
or leave GAP. Note that `LogTo` blanks the file before starting, if it
already exists!

It can be useful to leave some comments in the log file in case you
return to it in the future. A comment in GAP starts with the symbol `#` and
continues to the end of the line. You can enter the following after the
GAP prompt:

```gap
# GAP Software Carpentry Lesson
```

then after pressing the Return key, GAP will display a new prompt but the comment
will be written to the log file.

The log file records all interaction with GAP that happens after the call
to `LogTo`, but not before. We can repeat our calculation from above
if we want to record it as well. Instead of retyping it, we will use the Up and Down
arrow keys to scroll the *command line history*. Repeat this until you see
the formula again, then press Return (the location of the cursor in the command
line does not matter):

```gap
( 1 + 2^32 ) / (1 - 2*3*107 );
```

```output
-6700417
```

You can also edit existing commands. Press Up once more, and then use the
Left and Right arrow keys, Delete or Backspace to edit it and replace
32 by 64 (some other useful shortcuts are
Ctrl-A and Ctrl-E to move the cursor to the beginning and end of the
line, respectively). Now press the Return key (at any position of the
cursor in the command line):

```gap
( 1 + 2^64 ) / (1 - 2*3*107 );
```

```output
-18446744073709551617/641
```

It is useful to know that if the command line history is long, one could
perform a partial search by typing the initial part of the command and using
Up and Down arrow keys after that, to scroll only the lines that begin with
the same string.

If you want to store a value for later use, you can assign it to a name
using `:=`

```gap
universe := 6*7;
```

:::::::::::::::::::::::::::::::::::::::::  callout

## `:=`, `=` and `<>`

- In other languages you might be more familiar with using `=`, to assign
  variables, but GAP uses `:=`.

- GAP uses `=` to compare if two things are the same (where other languages might
  use `==`).

- Finally, GAP uses `<>` to check if two things are not equal (rather than the `!=`
  you might have seen before).


::::::::::::::::::::::::::::::::::::::::::::::::::

Whitespace characters (i.e. Spaces, Tabs and Returns) are insignificant in GAP,
except if they occur inside a string. For example, the previous input
could be typed without spaces:

```gap
(1+2^64)/(1-2*3*107);
```

```output
-18446744073709551617/641
```

Whitespace symbols are often used to format more complicated commands for
better readability. For example, the following input which creates a 3×3 matrix:

```gap
m:=[[1,2,3],[4,5,6],[7,8,9]];
```

```output
[ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]
```

We can instead write our matrix over 3 lines. In this case, instead of the full prompt
`gap>`, a partial prompt `>` will be displayed until the user finishes
the input with a semicolon:

```gap
gap> m:=[[ 1, 2, 3 ],
>        [ 4, 5, 6 ],
>        [ 7, 8, 9 ]];
```

```output
[ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ]
```

You can use `Display` to pretty-print variables, including this matrix:

```gap
Display(m);
```

```output
[ [  1,  2,  3 ],
  [  4,  5,  6 ],
  [  7,  8,  9 ] ]
```

In general GAP functions like `LogTo` and `Display` are called using brackets,
which contain a (possibly empty) list of arguments.

:::::::::::::::::::::::::::::::::::::::::  callout

## Functions are also GAP objects

Check what happens if you forget to add brackets,
e.g. type `LogTo;` and `Factorial;`
We will explain the differences in these outputs later.


::::::::::::::::::::::::::::::::::::::::::::::::::

Here are some examples of calling other GAP functions:

```gap
Factorial(100);
```

```output
93326215443944152681699238856266700490715968264381621468\
59296389521759999322991560894146397615651828625369792082\
7223758251185210916864000000000000000000000000
```

(the exact width of output will depend on your terminal settings),

```gap
Determinant(m);
```

```output
0
```

and

```gap
Factors(2^64-1);
```

```output
[ 3, 5, 17, 257, 641, 65537, 6700417 ]
```

Functions may be combined in various ways, and may be
used as arguments of other functions, for example, the
`Filtered` function takes a list and a function, returning
all elements of the list which satisfy the function.
`IsEvenInt`, unsurprisingly, checks if an integer is even!

```gap
Filtered( [2,9,6,3,4,5], IsEvenInt);
```

```output
[ 2, 6, 4 ]
```

A useful time-saving feature of the GAP command-line interfaces is completion
of identifiers when the Tab key is pressed. For example, type `Fib` and then
press the Tab key to complete the input to `Fibonacci`:

```gap
Fibonacci(100);
```

```output
354224848179261915075
```

In the case that a unique completion is not possible, GAP will try to perform
partial completion, and pressing the Tab key second time will display all possible
completions of the identifier. Try, for example, to enter `GroupHomomorphismByImages`
or `NaturalHomomorphismByNormalSubgroup` using completion.

The way functions are named in GAP will hopefully help you to memorise or even guess names
of library functions. If a variable name consists of several words then the
first letter of each word is capitalised (remember that GAP is case-sensitive!).
Further details on naming conventions used in GAP are documented
[in the GAP manual here](https://docs.gap-system.org/doc/ref/chap5.html#X81F732457F7BC851).
Functions with names in `ALL_CAPITAL_LETTERS` are internal functions not intended
for general use. Use them with extreme care!

It is important to remember that GAP is case-sensitive. For example, the following
input causes an error:

```gap
factorial(100);
```

```error
Error, Variable: 'factorial' must have a value
not in any function at line 14 of *stdin*
```

because the name of the GAP library function is `Factorial`. Using lowercase
instead of uppercase or vice versa also affects name completion.

Now let's consider the following problem: for a finite group *G*, calculate the
average order of its elements (that is, the sum of orders of its elements divided
by the order of the group). Where to start?

Enter `?Group`, and you will see all help entries, starting with `Group`:

```output
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
```

You may use arrow keys to move up and down the list, and open help pages by
pressing Return key. For this exercise, open `Tutorial: Groups and Homomorphisms`
first. Note the navigation instructions at the bottom of the screen. Look at
first two pages, then press `q` to return to the selection menu. Next, navigate to
`Reference: Groups` and open it. Within two first pages you will find the
function `Group` and mentioning of `Order`.

GAP manual comes in several formats: text is good to view in a terminal,
PDF is good for printing and HTML (especially with MathJax support) is
very efficient for exploring with a browser. If you are running GAP on your
own computer, you can set the help viewer to the default browser. If you are
running GAP on a remote machine, this (probably) will not work. (see
`?WriteGapIniFile` on how to make this setting permanent):

```gap
SetHelpViewer("browser");
```

After that, invoke the help again, and see the difference!

Let's now copy the following input from the first example of the GAP Reference
manual chapter on groups. It shows how to create permutations, and assign values
to variables. This is `Reference: Groups`. You can select it by typing `?11`, where
you replace `11` with whatever number appears before `Reference: Groups` on your machine.

If you are viewing the GAP documentation in a terminal, you might find it helpful to
open two copies of GAP, one for reading documentation and one for writing code!

This guide shows how permutations in GAP are written in cycle notation, and also
shows common functions which are used with groups. Also, in some places two semi-colons
are used at the end of a line. This stops GAP from showing the result of a computation.

```gap
a:=(1,2,3);;b:=(2,3,4);;
```

Next, let `G` be a group generated by `a` and `b`:

```gap
G:=Group(a,b);
```

```output
Group([ (1,2,3), (2,3,4) ])
```

We may explore some properties of `G` and its generators:

```gap
Size(G); IsAbelian(G); StructureDescription(G); Order(a);
```

```output
12
false
"A4"
3
```

Our next task is to find out how to obtain a list of `G`'s elements and their orders.
Enter `?elements` and explore the list of help topics. After inspection,
the entry from the Tutorial does not seem relevant, but the entry from the
Reference manual is. It also explains the difference between using `AsSSortedList`
and `AsList`. So, this is the list of elements of `G`:

```gap
AsList(G);
```

```output
[ (), (2,3,4), (2,4,3), (1,2)(3,4), (1,2,3), (1,2,4), (1,3,2), (1,3,4),
  (1,3)(2,4), (1,4,2), (1,4,3), (1,4)(2,3) ]
```

The returned object is a *list*. We would like to assign it to a variable
to explore and reuse. We forgot to do it when we were calculating it. Of
course, we may use the command line history to restore the last command, edit
it and call again. But instead, we will use `last` which is a special variable
holding the last result returned by GAP:

```gap
elts:=last;
```

```output
[ (), (2,3,4), (2,4,3), (1,2)(3,4), (1,2,3), (1,2,4), (1,3,2), (1,3,4),
  (1,3)(2,4), (1,4,2), (1,4,3), (1,4)(2,3) ]
```

This is a list. Lists in GAP are indexed from 1.
The following commands are (hopefully!) self-explanatory:

```gap
gap> elts[1]; elts[3]; Length(elts);
```

```output
()
(2,4,3)
12
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Lists are more than arrays

- May contain holes or be empty

- May dynamically change their length (with `Add`, `Append` or direct assigment)

- Not required to contain objects of the same type

- See more in [GAP Tutorial: Lists and Records](https://docs.gap-system.org/doc/tut/chap3.html)


::::::::::::::::::::::::::::::::::::::::::::::::::

Many functions in GAP refer to `Set`s. A set in GAP is just a list that happens to have
no repetitions, no holes, and elements in increasing order. Here are some examples:

```gap
gap> IsSet([1,3,5]); IsSet([1,5,3]); IsSet([1,3,3]);
```

```output
true
false
false
```

Now let us consider an interesting calculation -- the average order of elements
of `G`. There are many different ways to do this, we will consider a few of them
here.

A `for` loop in GAP allows you to do something for every member of a collection.
The general form of a `for` loop is:

```gap
for val in collection do
  <something with val>
od;
```

For example, to find the average order of our group `G` we can do.

```gap
s:=0;;
for g in elts do
  s := s + Order(g);
od;
s/Length(elts);
```

```output
31/12
```

Actually, we can just directly loop over the elements of `G` (in general GAP
will let you loop over most types of object). We have to switch to using `Size`
instead of `Length`, as groups don't have a length!

```gap
s:=0;;
for g in G do
  s := s + Order(g);
od;
s/Size(G);
```

```output
31/12
```

There are other ways of looping. For example, we can instead loop over a range of integers,
and accept `elts` like an array:

```gap
s:=0;;
for i in [ 1 .. Length(elts) ] do
  s := s + Order( elts[i] );
od;
s/Length(elts);
```

```output
31/12
```

However, often there are more compact ways of doing things. Here is a very
short way:

```gap
Sum( List( elts, Order ) ) / Length( elts );
```

```output
31/12
```

Let's break this last part down:

- `Order` finds the order of a single permutation.
- `List(L,F)` makes a new list where the function `F` is applied to each
  member of the list `L`.
- `Sum(L)` adds up the members of a list `L`.

:::::::::::::::::::::::::::::::::::::::::  callout

## Which approach is best?

Compare these approaches. Which one would you prefer to use?


::::::::::::::::::::::::::::::::::::::::::::::::::

GAP has very helpful list manipulation tools. We will now show a few more examples.

Sometimes, GAP does not have the exact function we want.
For example, `NrMovedPoints` gives the number of moved points of a permutation,
but what if we want to find all permutations which move `4` points? This is where
GAP's arrow notation comes in. `g -> e` makes a new function which takes one argument `g`,
and returns the value of the expression `e`. Here are some examples:

- finding all elements of `G` with no fixed points:

```gap
Filtered( elts, g -> NrMovedPoints(g) = 4 );
```

```output
[ (1,2)(3,4), (1,3)(2,4), (1,4)(2,3) ]
```

- finding a permutation in `G` that conjugates (1,2) to (2,3)

```gap
First( elts, g -> (1,2)^g = (2,3) );
```

```output
(1,2,3)
```

Let's check this (remember that in GAP permutations are multiplied from left to right!):

```gap
(1,2,3)^-1*(1,2)*(1,2,3)=(2,3);
```

```output
true
```

- checking whether all elements of `G` move the point 1 to 2:

```gap
ForAll( elts, g -> 1^g <> 2 );
```

```output
false
```

- checking whether there is an element in `G` which moves exactly two points:

```gap
ForAny( elts, g -> NrMovedPoints(g) = 2 );
```

```output
false
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Use list operations to select from `elts` the stabiliser of the point 2 and the centraliser of the permutation (1,2)

- `Filtered( elts, g -> 2^g = 2 );`

- `Filtered( elts, g -> (1,2)^g = (1,2) );`


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Remember that GAP is case-sensitive!
- Do not panic if you see `Error, Variable: 'FuncName' must have a value`.
- Care about names of variables and functions.
- Use command line editing.
- Use autocompletion instead of typing names of functions and variables in full.
- Use `?` and `??` to view help pages.
- Set the default help format to HTML using `SetHelpViewer`.
- Use the `LogTo` function to save all GAP input and output into a text file.
- If calculation takes too long, press <Control>\-C to interrupt it.
- Read 'A First Session with GAP' from the GAP Tutorial.

::::::::::::::::::::::::::::::::::::::::::::::::::


