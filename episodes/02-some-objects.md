---
title: "Some more GAP objects"
teaching: 20
exercises: 10
questions:
- "Further examples of immediate and positional objects and operations with them"
objectives:
- "See examples of types that are built-in in GAP but may be missing in other systems"
- "See examples of list arithmetic"
keypoints:
- "List arithmetic is very flexible and powerful"
- "Objects like lists and records are good to keep structured and related data"
---

So far you have met:

* _immediate_ objects such as integers, rationals, booleans, permutations,

* _positional_ objects such as _lists_,

* objects with obviously more complex internal representation such as groups.

In this section, we will demonstrate some other examples of basic objects
existing in GAP (the system is extendable, so one could introduce new types
of objects, but this is beyond the scope of this lesson).

Further immediate objects are floats, cyclotomics and finite field elements:

~~~
1.15; Float(1232/3456567);
~~~
{: .source}

~~~
1.15
0.000356423
~~~
{: .output}

~~~
E(4); E(4)^2; E(6);
~~~
{: .source}

~~~
E(4)
-1
-E(3)^2
~~~
{: .output}

~~~
AsList(GF(2)); Z(5); Z(5)^4;
~~~
{: .source}

~~~
[ 0*Z(2), Z(2)^0 ]
Z(5)
Z(5)^0
~~~
{: .output}

The next type of composite objects are **records**. While the list contains subobjects indexed
by their positions in the list, a record contains subobjects, called _record
components_, which are indexed by their names.

~~~
date:= rec(year:= 2015, month:= "Nov", day:= 17);
~~~
{: .source}

~~~
rec( day := 17, month := "Nov", year := 2015 )
~~~
{: .output}

~~~
date.year;
~~~
{: .source}

~~~
2015
~~~
{: .output}

~~~
date.time:= rec(hour:= 14, minute:= 55, second:= 12);
~~~
{: .source}

~~~
rec( hour := 14, minute := 55, second := 12 )
~~~
{: .output}

~~~
date;
~~~
{: .source}

~~~
rec( day := 17, month := "Nov",
  time := rec( hour := 14, minute := 55, second := 12 ), year := 2015 )
~~~
{: .output}

~~~
RecNames(date);
~~~
{: .source}

~~~
[ "time", "year", "month", "day" ]
~~~
{: .output}

Next, there are **strings** and **characters**. Strings are lists of
characters:

~~~
gap> w:="supercalifragilisticexpialidocious"; Length(w);
~~~
{: .source}

~~~
"supercalifragilisticexpialidocious"
34
~~~
{: .output}

Strings are denoted by double quotes, and characters by single ones.

~~~
gap> "s" in w; 's' in w; IsSubset(w,"s");  IsSubset(w,['s','f']);
~~~
{: .source}

~~~
false
true
true
true
~~~
{: .output}

Note that

~~~
gap> PositionSublist(w,"sf"); PositionSublist(w,"fr");
~~~
{: .source}

~~~
fail
10
~~~
{: .output}

Be careful that some operations may create a new list, and some may be
destructive, for example:

~~~
gap> SortedList(w); w;
~~~
{: .source}

~~~
"aaacccdeefgiiiiiiillloopprrssstuux"
"supercalifragilisticexpialidocious"
~~~
{: .output}

but

~~~
gap> Sort(w); w;
~~~
{: .source}

~~~
"aaacccdeefgiiiiiiillloopprrssstuux"
~~~
{: .output}

Which letter is occurring in "supercalifragilisticexpialidocious" most often?

~~~
gap> c := Collected(w);
~~~
{: .source}

~~~
[ [ 'a', 3 ], [ 'c', 3 ], [ 'd', 1 ], [ 'e', 2 ], [ 'f', 1 ], [ 'g', 1 ],
  [ 'i', 7 ], [ 'l', 3 ], [ 'o', 2 ], [ 'p', 2 ], [ 'r', 2 ], [ 's', 3 ],
  [ 't', 1 ], [ 'u', 2 ], [ 'x', 1 ] ]
~~~
{: .output}

~~~
gap> k := Maximum( List( c, v -> v[2] ) ); Filtered( c, v -> v[2] = 7 );
~~~
{: .source}

~~~
7
[ [ 'i', 7 ] ]
~~~
{: .output}

> ## How to do this in one pass over the list `c` ?
>
> One pass over `c` required to find the number of appearances of the most
> common letter(s), and another one to select all pairs where this number
> appears. Can you suggest how to do this in one pass?
{: .challenge}
