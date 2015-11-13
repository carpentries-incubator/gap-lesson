---
layout: page
title: Programming with GAP
subtitle: Functions in GAP
minutes: 20
---
> ## Learning Objectives {.objectives}
>
> * Using command line for prototyping
> * Creating functions
> * Reading GAP code from a file

Just to remind our task: for a finite group _G_, we would like to calculate
the average order of its elements (that is, the sum of orders of its elements
divided by the order of the group).

We begin with a very straightforward approach, iterating
over all elements of the group in question:

~~~ {.gap}
S:=SymmetricGroup(10);
~~~
~~~ {.output}
Sym( [ 1 .. 10 ] )
~~~

~~~ {.gap}
sum:=0;
~~~
~~~ {.output}
0
~~~

~~~ {.gap}
for g in S do
  sum := sum + Order(g);
od;
sum/Size(S);
~~~
~~~ {.output}
39020911/3628800
~~~

Now assume that we would like to save this fragment of the GAP code and later
repeat this calculation for some other groups. We may even reformat it to fit
it into one line and use double semicolon to suppress the output of `sum`:

~~~ {.gap}
sum:=0;; for g in S do sum := sum + Order(g); od; sum/Size(S);
~~~

~~~ {.output}
39020911/3628800
~~~

Now we may easily copy and paste it into the GAP session when we will need it next time.
But here we see the first inconvenience: the code expects that the group in question
must be stored in a variable named `S`, so either we can have only with one group `S`
at a time, or we need to edit the code:

~~~ {.gap}
S:=AlternatingGroup(10);
~~~

~~~ {.output}
Alt( [ 1 .. 10 ] )
~~~

~~~ {.gap}
sum:=0;; for g in S do sum := sum + Order(g); od; sum/Size(S);
~~~

~~~ {.output}
2587393/259200
~~~

> ## This works only for rapid prototyping {.callout}
>
> * incidentally, one could copy and paste only a part of the code, and
> incomplete input may trigger a break loop;
> * even more dangerous: one could forget to reset `sum` to zero prior to the new
> calculation and obtain incorrect results;
> * the group in question may have a different variable name, so the code will
> have to be changed;
> **last, but not least:** when GAP code is pasted into the interpreter, it is evaluated line
> by line. If you have a long file with many commands, and the syntax error is
> in the line N, this error will be reported only when GAP will complete
> the evaluation of all preceding lines, and that might be quite time-consuming.

That is why we need to give the GAP code more structure by organising it
into functions:

* functions are parsed first and may be called later;
* any **syntax** errors will be detected in the parsing stage, and not at the time
of the call;
* functions may have local variables, and this prevents them
being accidentally overwritten just because of reusing the same name of the
variable to store something else.

The following function takes an argument `S` and computes the average order
of its elements:

~~~ {.gap}
AvgOrdOfGroup := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~

~~~{.output}
function( S ) ... end
~~~

Now we can apply it to another group, passing the group as an argument:

~~~ {.gap}
A:=AlternatingGroup(10); AvgOrdOfGroup(A); time;
~~~

~~~{.output}
Alt( [ 1 .. 10 ] )
2587393/259200
837
~~~

The example above also demonstrates `time` - this is the variable which stores
the CPU time in milliseconds spent by the last command.

Thus, now we may create new groups and reuse `AvgOrdOfGroup` to calculate average
order of their elements in the same GAP session. Our next goal is to make it
reusable for the future calculations.

Using a text editor (for example, the one that you have used for the previous
Software Carpentry lessons), create a text file called `avgord.g` containing
the code of the function and comments (a good practice to use them!):

~~~ {.gap}
#####################################################################
#
# AvgOrdOfGroup(G)
#
# Calculating the average order of an element of G, where G meant to
# be a group but in fact may be any collection of objects having
# multiplicative order
#
AvgOrdOfGroup := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~

Now start a new GAP session and create another group, for example

~~~ {.gap}
M11:=MathieuGroup(11);
~~~

~~~ {.output}
Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ])
~~~

Clearly, `AvgOrdOfGroup` is not defined in this session, so an attempt to
call this function results in an error:

~~~ {.gap}
AvgOrdOfGroup(M11);
~~~

~~~ {.error}
Error, Variable: 'AvgOrdOfGroup' must have a value
not in any function at line 2 of *stdin*
~~~

To be available, first it should be loaded using the function `Read`. Below
we assume that the file is in the current directory, so no path is needed).

~~~ {.gap}
Read("avgord.g");
~~~

This loads the file into GAP, and the function `AvgOrdOfGroup` is now
available:

~~~ {.gap}
AvgOrdOfGroup(M11);
~~~

~~~ {.output}
53131/7920
~~~

> ## Which function is faster?{.callout}
>
> Try to repeatedly calculate `AvgOrdOfGroup(M11)` and `AvgOrdOfCollection(M11)`
> and compare runtimes. Do this for new copy of `M11` and for the one for which
> this parameter has already been observed. What do you observe?

In the example of using `Read`, new GAP session was started to make it clear
that `AvgOrdOfGroup` did not exist before the call of `Read` and was loaded
from the file. However, a file with a function like this could be read multiple
times in the same GAP session (later you will see cases when re-reading a
file is more complicated). Calling `Read` again executes all code in the file
being read. This means that if the code of the function has been modified, and
it has no errors (but possibly has warnings), the function will be
overwritten. **Never ignore the warnings!**

For example, let us edit the file and replace the line

~~~ {.gap}
return sum/Size(G);
~~~

by the line with a deliberate syntax error:

~~~ {.gap}
return Float(sum/Size(G);
~~~

Now read this file with

~~~ {.gap}
Read("avgord.g");
~~~

and you will see an error message:

~~~ {.error}
Syntax error: ) expected in avgord.g line 7
return Float(sum/Size(G);
                        ^
~~~

In this case, the function remains the same:

~~~ {.gap}
Print(AvgOrdOfGroup);
~~~

~~~ {.output}
function ( G )
    for g  in G  do
        sum := sum + Order( g );
    od;
    return sum / Size( G );
end
~~~

Now correct the error by adding a missing closing bracket,
read the file again and recalculate the average order of an element for `M11`:

~~~ {.gap}
Read("avgord.g");
AvgOrdOfGroup(M11);
~~~

~~~ {.output}
6.70846
~~~

Now let's see an example of a _warning_. Since it is only a warning, it will
redefine the function, and this may cause some unexpected result. To see what
could happen, first edit the file to rollback the change in the type of the
result (so it will return a rational instead of a float), and then comment
out two lines as follows:

~~~ {.gap}
AvgOrdOfGroup := function(G)
# local sum, g;
# sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~

Now, when you read the file, you will see warnings:

~~~ {.gap}
Read("avgord.g");
~~~

~~~ {.error}
Syntax error: warning: unbound global variable in avgord.g line 4
for g in G do
       ^
Syntax error: warning: unbound global variable in avgord.g line 5
  sum := sum + Order(g);
       ^
Syntax error: warning: unbound global variable in avgord.g line 5
  sum := sum + Order(g);
             ^
Syntax error: warning: unbound global variable in avgord.g line 7
return sum/Size(G);
          ^
~~~

These warnings mean because `g` and `sum` are not declared as `local`
variables, GAP will expect them to be global variables at the time when
the function will be called. Because they did not exist when `Read`
was called, a warning was displayed. However, if they would be existing
by that time, there would be no warning, and they may be still overwritten
during the call to `AvgOrdOfGroup`! This shows how important is to
declare local variables. Let us investigate what happened in slightly
more details:

The function is now re-defined, as we can see from its output (or can
inspect with `PageSource(AvgOrdOfGroup)` which will also display comments,
if any):

~~~ {.gap}
Print(AvgOrdOfGroup);
~~~

~~~ {.output}
function ( G )
    for g in G  do
        sum := sum + Order( g );
    od;
    return sum / Size( G );
end
~~~

but an attempt to run it results in an break loop:

~~~ {.gap}
AvgOrdOfGroup(M11);
~~~

~~~ {.output}
Error, Variable: 'sum' must have an assigned value in
  sum := sum + Order( g ); called from
<function "AvgOrdOfGroup">( <arguments> )
 called from read-eval loop at line 24 of *stdin*
you can 'return;' after assigning a value
brk>
~~~

from which you can exit by entering `quit;`.

What happens next demonstrates how things may go wrong:

~~~ {.gap}
sum:=2^64; g:=[1];
~~~

~~~ {.output}
18446744073709551616
[ 1 ]
~~~

~~~ {.gap}
AvgOrdOfGroup(M11);
~~~

~~~ {.output}
18446744073709604747/7920
~~~

~~~ {.gap}
sum; g;
~~~

~~~ {.output}
18446744073709604747
(1,2)(3,10,5,6,8,9)(4,7,11)
~~~

Now, before reading the next part of the lesson, please
revert the last change by uncommenting the two commented lines, so that
you have initial version of `AvgOrdOfGroup` in the file `avgord.g` again:

~~~ {.gap}
AvgOrdOfGroup := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~

> ## Paths {.challenge}
>
> How to specify paths to files in all operating systems and where to find
> your home and current directory.
