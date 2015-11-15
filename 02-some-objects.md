---
layout: page
title: Programming with GAP
subtitle: Some more GAP objects
minutes: 30
---
> ## Learning Objectives {.objectives}
>
> * See further examples of some objects existing in GAP.

So far you have met:

* _immediate_ object such as integers, rationals, booleans, permutations,

* _positional_ objects such as _lists_,

* objects with obviously more complex internal representation such as groups.

In this section, we will demonstrate some other examples of basic objects
existing in GAP (the system is extendable, so one could introduce new types
of objects, but this is beyond the scope of this lesson).

Further immediate objects are floats, cyclotomics and finite field elements:

~~~ {.gap}
1.15; Float(1232/3456567);
~~~

~~~ {.output}
1.15
0.000356423
~~~

~~~ {.gap}
E(4); E(4)^2; E(6);
~~~

~~~ {.output}
E(4)
-1
-E(3)^2
~~~

~~~ {.gap}
AsList(GF(2)); Z(5); Z(5)^4;
~~~

~~~ {.output}
[ 0*Z(2), Z(2)^0 ]
Z(5)
Z(5)^0
~~~

The next type of composite objects are **records**. While the list contains subobjects indexed
by their positions in the list, a record contains subobjects, called _record
components_, which are indexed by their names.

~~~ {.gap}
date:= rec(year:= 2015, month:= "Nov", day:= 17);
~~~

~~~ {.output}
rec( day := 17, month := "Nov", year := 2015 )
~~~

~~~ {.gap}
date.year;
~~~

~~~ {.output}
2015
~~~

~~~ {.gap}
date.time:= rec(hour:= 14, minute:= 55, second:= 12);
~~~

~~~ {.output}
rec( hour := 14, minute := 55, second := 12 )
~~~

~~~ {.gap}
date;
~~~

~~~ {.output}
rec( day := 17, month := "Nov",
  time := rec( hour := 14, minute := 55, second := 12 ), year := 2015 )
~~~

~~~ {.gap}
RecNames(date);
~~~

~~~ {.output}
[ "time", "year", "month", "day" ]
~~~

Next, there are **strings** and **characters**. Strings are lists of
characters:

~~~ {.gap}
gap> w:="supercalifragilisticexpialidocious"; Length(w);
~~~

~~~ {.output}
"supercalifragilisticexpialidocious"
34
~~~

Strings are denoted by double quotes, and characters by single ones.

~~~ {.gap}
gap> "s" in w; 's' in w; IsSubset(w,"s");  IsSubset(w,['s','f']);
~~~

~~~ {.output}
false
true
true
true
~~~

Note that

~~~ {.gap}
gap> PositionSublist(w,"sf"); PositionSublist(w,"fr");
~~~

~~~ {.output}
fail
10
~~~

Be careful that some operations may create a new list, and some may be
destructive, for example:

~~~ {.gap}
gap> SortedList(w); w;
~~~

~~~ {.output}
"aaacccdeefgiiiiiiillloopprrssstuux"
"supercalifragilisticexpialidocious"
~~~

but

~~~ {.gap}
gap> Sort(w); w;
~~~

~~~ {.output}
"aaacccdeefgiiiiiiillloopprrssstuux"
~~~

Which letter is occurring in "supercalifragilisticexpialidocious" most often?

~~~ {.gap}
gap> c := Collected(w);
~~~

~~~ {.output}
[ [ 'a', 3 ], [ 'c', 3 ], [ 'd', 1 ], [ 'e', 2 ], [ 'f', 1 ], [ 'g', 1 ],
  [ 'i', 7 ], [ 'l', 3 ], [ 'o', 2 ], [ 'p', 2 ], [ 'r', 2 ], [ 's', 3 ],
  [ 't', 1 ], [ 'u', 2 ], [ 'x', 1 ] ]
~~~

~~~ {.gap}
gap> k := Maximum( List( c, v -> v[2] ) ); Filtered( c, v -> v[2] = 7 );
~~~

~~~ {.output}
7
[ [ 'i', 7 ] ]
~~~

> ## How to do this in one pass over the list `c` ? {.challenge}
>
> One pass over `c` required to find the number of appearances of the most
> common letter(s), and another one to select all pairs where this number
> appears. Can you suggest how to do this in one pass?
