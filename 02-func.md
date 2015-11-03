---
layout: page
title: Functions in GAP
subtitle: Writing reusable, robust and modular code
minutes: 20
---
> ## Learning Objectives {.objectives}
>
> * Use command line for prototyping
> * Create functions
> * Read GAP code from a file

Let’s consider the following exercise: for a finite group _G_, calculate the average
order of its element (that is, the sum of orders of its elements divided by the
order of the group).

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

Now we may copy and paste it into the GAP session when we will need it next time.
And here we see the first inconvenience: the code expects that the group in question
must be stored in a variable named `S`:

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

> ## For prototyping only {.callout}
> This approach is good for a rapid prototyping only:
>
> * incidentally, one could copy and paste only a part of the code, and
> incomplete input may trigger a break loop;
> * even more dangerous: one could forget to reset `sum` to zero prior to the new
> calculation and obtain incorrect results;
> * the group in question may have a different variable name, so the code will
> have to be changed;
> * finally, when GAP code is pasted into the interpreter, it is evaluated line
> by line. If you have a long file with many commands, and the syntax error is
> in the line N, this error will be reported only when GAP will complete
> the evaluation of all preceding lines, and that might be quite time-consuming.

Next we will consider giving GAP code more structure by organising it
into functions:

* functions are parsed first and may be called later;
* any syntax errors will be detected in the parsing stage, and not at the time
of the call;
* functions may have local variables, and this prevents them
being accidentally overwritten just because of reusing the same name of the
variable to store something else.

The following function takes an argument `S` and computes the average order
of its elements:

~~~ {.gap}
AvgOrdOfGroup := function (S)
local sum, g;
sum:=0;
for g in S do
  sum := sum + Order(g);
od;
return sum/Size(S);
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

> ## Paths {.challenge}
>
> Fully understand to to specify paths to files in all operating systems.
