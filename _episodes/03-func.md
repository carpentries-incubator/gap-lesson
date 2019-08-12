---
title: "Functions in GAP"
teaching: 40
exercises: 15
questions:
- "Functions as a way of code re-use"
objectives:
- "Using command line for prototyping"
- "Creating functions"
- "Reading GAP code from a file"
keypoints:
- "Command line is good for prototyping; functions are good for repeated calculations."
- "Informative function names and comments will make code more readable to your future self and to others."
- "Beware of undeclared local variables!"
---

Just to remind us of our task: for a finite group _G_, we would like to calculate
the average order of its elements (that is, the sum of the orders of its elements
divided by the order of the group).

We begin with a very straightforward approach, iterating
over all elements of the group in question:

~~~
S:=SymmetricGroup(10);
~~~
{: .source}

~~~
Sym( [ 1 .. 10 ] )
~~~
{: .output}

~~~
sum:=0;
~~~
{: .source}

~~~
0
~~~
{: .output}

~~~
for g in S do
  sum := sum + Order(g);
od;
sum/Size(S);
~~~
{: .source}

~~~
39020911/3628800
~~~
{: .output}

Now assume that we would like to save this fragment of GAP code and later
repeat this calculation for some other groups. We may even reformat it to fit
it into one line and use a double semicolon to suppress the output of `sum`:

~~~
sum:=0;; for g in S do sum := sum + Order(g); od; sum/Size(S);
~~~
{: .source}

~~~
39020911/3628800
~~~
{: .output}

Now we may easily copy and paste it into the GAP session the next time we need it.
But here we see the first inconvenience: the code expects that the group in question
must be stored in a variable named `S`, so either we have to reset `S` each
time, or we need to edit the code:

~~~
S:=AlternatingGroup(10);
~~~
{: .source}

~~~
Alt( [ 1 .. 10 ] )
~~~
{: .output}

~~~
sum:=0;; for g in S do sum := sum + Order(g); od; sum/Size(S);
~~~
{: .source}

~~~
2587393/259200
~~~
{: .output}

> ## This works only for rapid prototyping
>
> * one could accidentally copy and paste only a part of the code, and
> incomplete input may trigger a break loop;
> * even more dangerous: one could forget to reset `sum` to zero prior to the new
> calculation and obtain incorrect results;
> * the group in question may have a different variable name, so the code will
> have to be changed;
> * **last, but not least:** when GAP code is pasted into the interpreter, it is evaluated line
> by line. If you have a long file with many commands, and a syntax error is
> in line _N_, this error will be reported only when GAP completes
> the evaluation of all preceding lines, and that might be quite time-consuming.
{: .callout}

That is why we need to give our GAP code more structure by organising it
into functions:

* functions are parsed first and may be called later;
* any **syntax** errors will be detected in the parsing stage, and not at the time
  of the call;
* functions may have local variables, and this prevents them
  being accidentally overwritten just because of reusing the same name of the
  variable to store something else.

The following function takes an argument `G` and computes the average order
of its elements:

~~~
AvgOrdOfGroup := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~
{: .source}

~~~
function( G ) ... end
~~~
{: .output}

Now we can apply it to another group, passing the group as an argument:

~~~
A:=AlternatingGroup(10); AvgOrdOfGroup(A); time;
~~~
{: .source}

~~~
Alt( [ 1 .. 10 ] )
2587393/259200
837
~~~
{: .output}

The example above also demonstrates `time` -- this is the variable which stores
the CPU time in milliseconds spent by the last command.

Thus, we may now create new groups and reuse `AvgOrdOfGroup` to calculate the average
order of their elements in the same GAP session. Our next goal is to make it
reusable for calculations in future sessions.

Using a text editor (for example, the one that you may have used for previous
Software Carpentry lessons), create a text file called `avgord.g` containing
the following function code and comments (a good chance to practise using them!):

~~~
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
{: .source}

Now start a new GAP session and create another group, for example `MathieuGroup(11)`:

~~~
M11:=MathieuGroup(11);
~~~
{: .source}

~~~
Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ])
~~~
{: .output}

Clearly, `AvgOrdOfGroup` is not defined in this session, so an attempt to
call this function results in an error:

~~~
AvgOrdOfGroup(M11);
~~~
{: .source}

~~~
Error, Variable: 'AvgOrdOfGroup' must have a value
not in any function at line 2 of *stdin*
~~~
{: .error}

To be available, it should first be loaded using the function `Read`. Below
we assume that the file is in the current directory, so no path is needed.

~~~
Read("avgord.g");
~~~
{: .source}

This loads the file into GAP, and the function `AvgOrdOfGroup` is now
available:

~~~
AvgOrdOfGroup(M11);
~~~
{: .source}

~~~
53131/7920
~~~
{: .output}

In this example of using `Read`, a new GAP session was started to make it clear
that `AvgOrdOfGroup` did not exist before the call of `Read` and was loaded
from the file. However, a file with a function like this could be read multiple
times in the same GAP session (later you will see cases when re-reading a
file is more complicated). Calling `Read` again executes all code in the file
being read. This means that if the code of the function has been modified, and
it has no errors (but possibly has warnings), the function will be
overwritten. **Never ignore the warnings!**

For example, let us edit the file and replace the line

~~~
return sum/Size(G);
~~~
{: .source}

by the line with a deliberate syntax error:

~~~
return Float(sum/Size(G);
~~~
{: .source}

Now read this file with

~~~
Read("avgord.g");
~~~
{: .source}

and you will see an error message:

~~~
Syntax error: ) expected in avgord.g line 7
return Float(sum/Size(G);
                        ^
~~~
{: .error}

Since there was an error, the `AvgOrdOfGroup` function in our session was not
redefined, and remains the same as last time it was successfully read:

~~~
Print(AvgOrdOfGroup);
~~~
{: .source}

~~~
function ( G )
    for g  in G  do
        sum := sum + Order( g );
    od;
    return sum / Size( G );
end
~~~
{: .output}

Now correct the error by adding the missing closing bracket,
read the file again and recalculate the average order of an element for `M11`:

~~~
Read("avgord.g");
AvgOrdOfGroup(M11);
~~~
{: .source}

~~~
6.70846
~~~
{: .output}

Now let's see an example of a _warning_. Since it is only a warning, it will
redefine the function, and this may cause some unexpected result. To see what
could happen, first edit the file to roll back the change in the type of the
result (so it will return a rational instead of a float), and then comment
out two lines as follows:

~~~
AvgOrdOfGroup := function(G)
# local sum, g;
# sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~
{: .source}

Now, when you read the file, you will see warnings:

~~~
Read("avgord.g");
~~~
{: .source}

~~~
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
{: .error}

These warnings mean that because `g` and `sum` are not declared as `local`
variables, GAP will expect them to be global variables at the time when
the function will be called. Because they did not exist when `Read`
was called, a warning was displayed. However, if they happened to exist
by that time, there would be no warning, and any call to `AvgOrdOfGroup` would
overwrite them! This shows how important it is to
declare local variables. Let us investigate what happened in slightly
more detail:

The function is now redefined, as we can see from its output (or can
inspect with `PageSource(AvgOrdOfGroup)` which will also display any comments):

~~~
Print(AvgOrdOfGroup);
~~~
{: .source}

~~~
function ( G )
    for g in G  do
        sum := sum + Order( g );
    od;
    return sum / Size( G );
end
~~~
{: .output}

but an attempt to run it results in a break loop:

~~~
AvgOrdOfGroup(M11);
~~~
{: .source}

~~~
Error, Variable: 'sum' must have an assigned value in
  sum := sum + Order( g ); called from
<function "AvgOrdOfGroup">( <arguments> )
 called from read-eval loop at line 24 of *stdin*
you can 'return;' after assigning a value
brk>
~~~
{: .error}

which you can exit using `quit;`.

What happens next demonstrates how things may go wrong:

~~~
sum:=2^64; g:=[1];
~~~
{: .source}

~~~
18446744073709551616
[ 1 ]
~~~
{: .output}

~~~
AvgOrdOfGroup(M11);
~~~
{: .source}

~~~
18446744073709604747/7920
~~~
{: .output}

~~~
sum; g;
~~~
{: .source}

~~~
18446744073709604747
(1,2)(3,10,5,6,8,9)(4,7,11)
~~~
{: .output}

Now, before reading the next part of the lesson, please
revert the last change by uncommenting the two commented lines, so that
you have initial version of `AvgOrdOfGroup` in the file `avgord.g` again:

~~~
AvgOrdOfGroup := function(G)
local sum, g;
sum := 0;
for g in G do
  sum := sum + Order(g);
od;
return sum/Size(G);
end;
~~~
{: .source}

> ## Paths
>
> * It is important to know how to specify paths to files in all operating
> systems and where to find your home and current directory.
>
> * It is useful to know that path and filename completion is activated by
> pressing Esc two or four times.
>
{: .callout}
