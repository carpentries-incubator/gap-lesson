---
title: Small groups search
teaching: 40
exercises: 15
---

::::::::::::::::::::::::::::::::::::::: objectives

- Using the Small Groups Library
- Designing a system of functions to fit together

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- Modular programming: putting functions together
- How to check some conjecture for all groups of a given order

::::::::::::::::::::::::::::::::::::::::::::::::::

In this section, we wish to discover some non-trivial groups with an interesting
property: namely, that the average order of their elements is an integer.

The GAP distribution includes a number of data libraries
(for example, search for the word "library" in the
[list of packages distributed with GAP](https://www.gap-system.org/packages/)).
One of them is the [Small Groups Library](https://gap-packages.github.io/smallgrp/) by
Hans Ulrich Besche, Bettina Eick and Eamonn O'Brien.

This library provides various utilities to determine which information
is stored there and submit queries to search for groups with desired
properties. The key functions are `SmallGroup`, `AllSmallGroups`,
`NrSmallGroups`, `SmallGroupsInformation` and `IdGroup`. For example:

```output
gap> NrSmallGroups(64);
267
gap> SmallGroupsInformation(64);

  There are 267 groups of order 64.
  They are sorted by their ranks.
     1 is cyclic.
     2 - 54 have rank 2.
     55 - 191 have rank 3.
     192 - 259 have rank 4.
     260 - 266 have rank 5.
     267 is elementary abelian.

  For the selection functions the values of the following attributes
  are precomputed and stored:
     IsAbelian, PClassPGroup, RankPGroup, FrattinifactorSize and
     FrattinifactorId.

  This size belongs to layer 2 of the SmallGroups library.
  IdSmallGroup is available for this size.

gap> G:=SmallGroup(64,2);
<pc group of size 64 with 6 generators>
gap> AllSmallGroups(Size,64,NilpotencyClassOfGroup,5);
[ <pc group of size 64 with 6 generators>, <pc group of size 64 with 6 generators>,
  <pc group of size 64 with 6 generators> ]
gap> List(last,IdGroup);
[ [ 64, 52 ], [ 64, 53 ], [ 64, 54 ] ]
```

We would like to use our own testing function, which we will create here,
using inline notation (available for one-argument functions):

```gap
TestOneGroup := G -> IsInt( AvgOrdOfGroup(G) );
```

Now try, for example

```gap
List([TrivialGroup(),Group((1,2))],TestOneGroup);
```

```output
[ true, false ]
```

```gap
gap> AllSmallGroups(Size,24,TestOneGroup,true);
```

```output
[ ]
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Modular programming begins here

Why is returning booleans a good design decision for such functions,
instead of just printing information or returning a string such as `"YES"` ?


::::::::::::::::::::::::::::::::::::::::::::::::::

This is a simple example of a function which tests all groups of a given order.
It creates one group at a time, checks the desired property, and returns as soon
as an example is discovered. Otherwise it returns `fail` which is a special kind
of boolean variable in GAP.

```gap
TestOneOrderEasy := function(n)
local i;
for i in [1..NrSmallGroups(n)] do
  if TestOneGroup( SmallGroup( n, i ) ) then
    return [n,i];
  fi;
od;
return fail;
end;
```

For example,

```gap
TestOneOrderEasy(1);
```

```output
[ 1, 1 ]
```

```gap
TestOneOrderEasy(24);
```

```output
fail
```

:::::::::::::::::::::::::::::::::::::::::  callout

## `AllSmallGroups` runs out of memory -- what to do?

- Use iteration over `[1..NrSmallGroups(n)]` as shown in the function above
- Use `IdsOfAllSmallGroups` which accepts same arguments as `AllSmallGroups`
  but returns ids instead of groups.


::::::::::::::::::::::::::::::::::::::::::::::::::

Iterating over `[1..NrSmallGroups(n)]` gives you more flexibility if you need
more control over the progress of calculation. For example, the next version
of our testing function prints additional information about the number of the
group being tested. It also supplies the testing function as an argument (why do
you think this is better?).

```gap
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
```

For example,

```gap
TestOneOrder(TestOneGroup,64);
```

will display a changing counter during calculation and then return `fail`:

```output
64:267/267
fail
```

The next step is to integrate `TestOneOrder` into a function which will test
all orders from 2 to `n` and stop as soon as it finds an example of a
group with the average order of an element being an integer:

```gap
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
```

It reports that there is such a group of order 105:

```gap
TestAllOrders(TestOneGroup,128);
```

```output
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
```

To explore it further, we can get its `StructureDescription` (see
[documentation](https://docs.gap-system.org/doc/ref/chap39.html#X87BF1B887C91CA2E)
for the explanation of the notation it uses):

```gap
G:=SmallGroup(105,1); AvgOrdOfGroup(G); StructureDescription(G);
```

```output
<pc group of size 105 with 3 generators>
17
"C5 x (C7 : C3)"
```

and then convert it to a finitely presented group to see its generators and relators:

```gap
H:=SimplifiedFpGroup(Image(IsomorphismFpGroup(G)));
RelatorsOfFpGroup(H);
```

```output
<fp group on the generators [ F1, F2, F3 ]>
[ F1^3, F2^-1*F1^-1*F2*F1, F3^-1*F2^-1*F3*F2, F3^-1*F1^-1*F3*F1*F3^-1, F2^5,
  F3^7 ]
```

Now we want to try larger groups, starting from order 106 (we check that
the other group of order 105 possesses no such property)

```gap
List(AllSmallGroups(105),AvgOrdOfGroup);
```

```output
[ 17, 301/5 ]
```

With a little modification, we add an extra argument specifying the order from
which to start:

```gap
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
```

But now we call it with

```gap
TestRangeOfOrders(TestOneGroup,106,256);
```

and discover that testing 2328 groups of order 128 and additionally 56092 groups
of order 256 already takes too long.

:::::::::::::::::::::::::::::::::::::::::  callout

## Don't panic!

You can interrupt GAP by pressing Ctrl-C once. After that, GAP will enter
a break loop, designated by the break prompt `brk>`. You can leave it by
typing `quit;` (beware of pressing Ctrl-C twice within a second -- that will
terminate GAP session completely).


::::::::::::::::::::::::::::::::::::::::::::::::::

This is another situation where theoretical knowledge helps much more than the
brute-force approach. If the group is a *p*\-group, then the order of each
conjugacy class of a non-identity element of the group is divisible by *p*;
therefore, the average order of a group element may not be an integer. Therefore,
*p*\-groups can be excluded from calculation. So, the new version of the code is

```gap
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
```

and using it we are able to discover a group of order 357 with the same property:

```gap
gap> TestRangeOfOrders(TestOneGroup,106,512);
```

```output
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
```

The next function shows even further flexibility: it is variadic, i.e.
it may accept two or more arguments, the first two of which will be assigned to
the variables `f` and `n`, and the rest of which will be available in the list `r`
(this is indicated by `...` after `r`). The first argument is the testing
function, the second is the order to check, and the third and the fourth
are the numbers of the first and last groups of this order that should be
checked. By default, the last two are equal to 1 and `NrSmallGroups(n)`
respectively. This function also shows how to validate the input and
produce user-friendly error messages in case of invalid arguments.

In addition, this function demonstrates how to use `Info` messages that
may be switched on and off by setting appropriate `Info` level. The need
we address here is to be able to switch the levels of verbosity of the
output without error-prone approach of walking through the code and commenting
`Print` statements in and out. It is achieved by creating an info class:

```gap
gap> InfoSmallGroupsSearch := NewInfoClass("InfoSmallGroupsSearch");
```

```output
InfoSmallGroupsSearch
```

Now instead of `Print("something");` one could use
`Info( InfoSmallGroupsSearch, infolevel, "something" );`
where `infolevel` is a positive integer specifying the level of verbosity.
This level could be changed to `n` using the command
`SetInfoLevel( InfoSmallGroupsSearch, n);`. See actual calls of `Info` in
the code below:

```gap
TestOneOrderVariadic := function(f,n,r...)
local n1, n2, i;

if not Length(r) in [0..2] then
  Error("The number of arguments must be 2,3 or 4\n" );
fi;

if not IsFunction( f ) then
  Error("The first argument must be a function\n" );
fi;

if not IsPosInt( n ) then
  Error("The second argument must be a positive integer\n" );
fi;

if IsBound(r[1]) then
  n1:=r[1];
  if not n1 in [1..NrSmallGroups(n)] then
    Error("The 3rd argument, if present, must belong to ", [1..NrSmallGroups(n)], "\n" );
  fi;
else
  n1:=1;
fi;

if IsBound(r[2]) then
  n2:=r[2];
  if not n2 in [1..NrSmallGroups(n)] then
    Error("The 4th argument, if present, must belong to ", [1..NrSmallGroups(n)], "\n" );
  elif n2 < n1 then
    Error("The 4th argument, if present, must be greater or equal to the 3rd \n" );
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
```

The following example demonstrates how the output may now be controlled
by switching the info level for `InfoSmallGroupsSearch`:

```output
gap> TestOneOrderVariadic(IsIntegerAverageOrder,24);
fail
gap> SetInfoLevel( InfoSmallGroupsSearch, 1 );
gap> TestOneOrderVariadic(IsIntegerAverageOrder,24);
#I  Checking groups 1 ... 15 of order 24
#I  Search completed - no counterexample discovered
fail
gap> TestOneOrderVariadic(IsIntegerAverageOrder,357);
#I  Checking groups 1 ... 2 of order 357
#I  Discovered counterexample: SmallGroup( 357, 1 )
[ 357, 1 ]
gap> SetInfoLevel( InfoSmallGroupsSearch, 0);
gap> TestOneOrderVariadic(IsIntegerAverageOrder,357);
[ 357, 1 ]
```

Of course, this now introduces some complication for the test file,
which compares the actual output with the reference output. To resolve
this problem, we will decide to run the tests at info level 0 to suppress
all additional outputs. Because the tests may have been started in the
GAP session with a different info level, we will remember that info level
to restore it after the test:

```output
# Finding groups with integer average order
gap> INFO_SSS:=InfoLevel(InfoSmallGroupsSearch);;
gap> SetInfoLevel( InfoSmallGroupsSearch, 0);
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
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Does the Small Groups Library contain another group with this property?

- What can you say about the order of the groups with this property?

- Can you estimate how long it may take to check all 408641062 groups of order 1536?

- How many groups of order not higher than 2000 might you be able to check,
  excluding *p*\-groups and those of order 1536?

- Can you find another group with this property in the Small Groups Library
  (of order not equal to 1536)?


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- Organise the code into functions.
- Create small groups one by one instead of producing a huge list of them.
- Using `SmallGroupsInformation` may help to reduce the search space.
- GAP is not a magic tool: theoretical knowledge may help much more than the brute-force approach.

::::::::::::::::::::::::::::::::::::::::::::::::::


