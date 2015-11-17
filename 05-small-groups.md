---
layout: page
title: Programming with GAP
subtitle: Small groups search
minutes: 20
---
> ## Learning Objectives {.objectives}
>
> * Using Small Groups Library
> * Designing a system of functions to fit together

In this section, we are interested to discover some non-trivial groups
such that the average order of their elements is an integer.

GAP distribution includes a number of data libraries (see an overview
[here](http://www.gap-system.org/Datalib/datalib.html). One of them is
the [Small Groups Library](http://www.gap-system.org/Packages/sgl.html) by
Hans Ulrich Besche, Bettina Eick and Eamonn O'Brien.

This library provides various utilities to determine which information
is stored there and submit queries to search for groups with desired
properties. In particular, one should be familiar with the functions
`SmallGroup`, `AllSmallGroups`, `NrSmallGroups` and `SmallGroupsInformation`.

We would like to use our own testing function, which we will create here,
using inline notation (available for one-argument functions):

~~~ {.gap}
TestOneGroup := G -> IsInt( AvgOrdOfGroup(G) );
~~~

Now try, for example

~~~ {.gap}
List([TrivialGroup(),Group((1,2))],TestOneGroup);
~~~

~~~ {.output}
[ true, false ]
~~~

> ## Modular programming begins here {.callout}
>
> Why a good design decision is for such function to return booleans,
> and not just print information or return a string like `"YES"`.

This is a simple example of a function which tests all groups of a given order.
It creates one group at a time, checks the desired property, and returns as soon
as an example is discovered. Otherwise it returns `fail` which is a special kind
of boolean variable in GAP.

~~~ {.gap}
TestOneOrderEasy := function(n)
local i;
for i in [1..NrSmallGroups(n)] do
  if TestOneGroup( SmallGroup( n, i ) ) then
    return [n,i];
  fi;
od;
return fail;
end;
~~~

For example,

~~~ {.gap}
TestOneOrderEasy(1);
~~~

~~~ {.output}
[ 1, 1 ]
~~~

~~~ {.gap}
TestOneOrderEasy(24);
~~~

~~~ {.output}
fail
~~~

The next version shows how to print additional information about the progress
of computation. It also supplies the testing function as an argument (why do
you think this is better?).

~~~ {.gap}
TestOneOrder := function(f,n)
local i, G;
for i in [1..NrSmallGroups(n)] do
  Print(n, ":", i, "/", NrSmallGroups(n), "\r");
  G := SmallGroup( n, i );
  if f(G) then
    Print("\n");
    return [n,i];
  fi;
od;
Print("\n");
return fail;
end;
~~~

For example,

~~~ {.gap}
TestOneOrder(TestOneGroup,64);
~~~

will display a changing counter during calculation and then return `fail`:

~~~ {.output}
64:267/267
fail
~~~

The next step is to write a function which will test all orders from 2 to `n`
and stop as soon as it will find an example of a group with the average order
of an element being an integer:

~~~ {.gap}
TestAllOrders:=function(f,n)
local i, res;
for i in [2..n] do
  res:=TestOneOrder(f,i);
  if res <> fail then
    return res;
  fi;
od;
return fail;
end;
~~~

It reports that there is such group of order 105:

~~~ {.gap}
TestAllOrders(TestOneGroup,128);
~~~

~~~ {.output}
2:1/1
3:1/1
4:2/2
5:1/1
6:2/2
7:1/1
8:5/5
...
...
...
100:16/16
101:1/1
102:4/4
103:1/1
104:14/14
105:1/2
[ 105, 1 ]
~~~

It reports that there is such group of order 105:

~~~ {.gap}
G:=SmallGroup(105,1);AvgOrdOfGroup(G);StructureDescription(G);
~~~

~~~ {.output}
<pc group of size 105 with 3 generators>
17
"C5 x (C7 : C3)"
~~~

To explore it further,

~~~ {.gap}
H:=SimplifiedFpGroup(Image(IsomorphismFpGroup(G)));
RelatorsOfFpGroup(H);
~~~

~~~ {.output}
<fp group on the generators [ F1, F2, F3 ]>
[ F1^3, F2^-1*F1^-1*F2*F1, F3^-1*F2^-1*F3*F2, F3^-1*F1^-1*F3*F1*F3^-1, F2^5,
  F3^7 ]
~~~

Now we want to try larger groups, starting from the order 106 (we check that
the other group of order 105 possesses no such property)

~~~ {.gap}
List(AllSmallGroups(105),AvgOrdOfGroup);
~~~

~~~ {.output}
[ 17, 301/5 ]
~~~

With a little modification, we add an extra argument specifying the order from
which to start:

~~~ {.gap}
TestRangeOfOrders:=function(f,n1,n2)
local n, res;
for n in [n1..n2] do
  res:=TestOneOrder(f,n);
  if res <> fail then
    return res;
  fi;
od;
return fail;
end;
~~~

But now we call it with

~~~ {.gap}
TestRangeOfOrders(TestOneGroup,106,256);
~~~

and discover that testing 2328 groups of order 128 and moreover 56092 groups
of order 256 is already too long.

> ## Don't panic! {.callout}
>
> Find out how to interrupt a long computation and leave the break loop.

This is another situation where theoretical knowledge helps much more than
brute-force approach. If the group is a _p_ group, then the order of each
conjugacy class of a non-identity element of a group is divisible by _p_,
therefore, the average order of a group element can not be an integer. These
groups could be excluded from calculation. So, the new version of the code
is

~~~ {.gap}
TestRangeOfOrders:=function(f,n1,n2)
local n, res;
for n in [n1..n2] do
  if not IsPrimePowerInt(n) then
     res:=TestOneOrder(f,n);
     if res <> fail then
       return res;
     fi;
   fi;
od;
return fail;
end;
~~~

and using it we discover a group of order 357 with the same property:

~~~ {.gap}
gap> TestRangeOfOrders(TestOneGroup,106,512);
~~~

~~~ {.output}
106:2/2
108:45/45
...
350:10/10
351:14/14
352:195/195
354:4/4
355:2/2
356:5/5
357:1/2
[ 357, 1 ]
~~~

The next function shows even further flexibility: it is variadic, i.e.
it may accept arbitrary number of arguments that will be available as
the list `arg` (special name for this kind of situation, don't use it
otherwise). It also introduces Info messages that may be displayed
or not dependently on the corresponding Info level:

~~~ {.gap}
InfoSmallGroupsSearch := NewInfoClass("InfoSmallGroupsSearch");

TestOneOrderVariadic := function(arg)
local f, n, n1, n2, i;

if not Length(arg) in [2..4] then
  Error("The number of arguments must be 2,3 or 4\n" );
fi;

if not IsFunction( arg[1] ) then
  Error("The first argument must be a function\n" );
else
  f := arg[1];
fi;

if not IsPosInt( arg[2] ) then
  Error("The second argument must be a positive integer\n" );
else
  n := arg[2];
fi;

if IsBound(arg[3]) then
  n1:=arg[3];
  if not n1 in [1..NrSmallGroups(n)] then
    Error("The 3rd argument must belong to ", [1..NrSmallGroups(n)], "\n" );
  fi;
else
  n1:=1;
fi;

if IsBound(arg[4]) then
  n2:=arg[4];
  if not n2 in [1..NrSmallGroups(n)] then
    Error("The 4th argument must belong to ", [1..NrSmallGroups(n)], "\n" );
  elif n2 < n1 then
    Error("The 4th argument must be greater or equal to the 3rd \n" );
  fi;
else
  n2:=NrSmallGroups(n);
fi;

Info( InfoSmallGroupsSearch, 1,
      "Checking groups ", n1, " ... ", n2, " of order ", n );
for i in [n1..n2] do
  if InfoLevel( InfoSmallGroupsSearch ) > 1 then
    Print(i, "/", NrSmallGroups(n), "\r");
  fi;
  if f(SmallGroup(n,i)) then
    Info( InfoSmallGroupsSearch, 1,
          "Discovered counterexample: SmallGroup( ", n, ", ", i, " )" );
    return [n,i];
  fi;
od;
Info( InfoSmallGroupsSearch, 1,
      "Search completed - no counterexample discovered" );
return fail;
end;
~~~

Because now the test output may not be reproducible at some other Info levels,
we would like to ensure that we remember the value of the Info level before the
test and restore it after the test:

~~~ {.gap}
# Finding groups with integer average order
gap> INFO_SSS:=InfoLevel(InfoSmallGroupsSearch);;
gap> res:=[];;
gap> for n in [1..360] do
>      if not IsPrimePowerInt(n) then
>        t := TestOneOrderVariadic( IsIntegerAverageOrder,n,1,NrSmallGroups(n) );
>        if t <> fail then
>          Add(res,t);
>        fi;
>      fi;
>    od;
gap> res;
[ [ 1, 1 ], [ 105, 1 ], [ 357, 1 ] ]
gap> SetInfoLevel( InfoSmallGroupsSearch, INFO_SSS);
~~~

> ## Does the Small Groups Library contain another group with this property? {.challenge}
>
> * What can you say about the order of the groups with this property?
>
> * Can you estimate how long it may take to check all 408641062 groups of order 1536 ?
>
> * How many groups you need to check, excluding p-groups and those of order 1536?
>
> * Can you find another group (of order not equal to 1536)
>   with this property containing in the Small Groups Library?
