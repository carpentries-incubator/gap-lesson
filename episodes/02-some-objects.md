---
title: Some more GAP objects
teaching: 15
exercises: 5
---

::::::::::::::::::::::::::::::::::::::: objectives

- See examples of types that are built-in in GAP but may be missing in other systems
- See examples of list arithmetic

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- Further examples of objects and operations with them

::::::::::::::::::::::::::::::::::::::::::::::::::

So far we have met three types of GAP types:

- simple objects such as integers, rationals, booleans, permutations;

- composite objects such as *lists*;

- objects with more complex internal representation, such as groups.

In this section, we will demonstrate some other examples of basic objects
that exist in GAP (the system is extendable, so one can introduce new types
of objects, but this is beyond the scope of this lesson!).

Some other simple objects are floats, cyclotomics and finite field elements:

```gap
1.15; Float(1232/3456567);
```

```output
1.15
0.000356423
```

```gap
E(4); E(4)^2; E(6);
```

```output
E(4)
-1
-E(3)^2
```

```gap
AsList(GF(2)); Z(5); Z(5)^4;
```

```output
[ 0*Z(2), Z(2)^0 ]
Z(5)
Z(5)^0
```

You already know about lists.
Another type of composite objects is **records**. While a list contains subobjects indexed
by their positions in the list, a record contains subobjects, called *record
components*, which are indexed by their names. Elements of a record are accessed with `.`

```gap
date:= rec(year:= 2015, month:= "Nov", day:= 17);
```

```output
rec( day := 17, month := "Nov", year := 2015 )
```

```gap
date.year;
```

```output
2015
```

```gap
date.time:= rec(hour:= 14, minute:= 55, second:= 12);
```

```output
rec( hour := 14, minute := 55, second := 12 )
```

```gap
date;
```

```output
rec( day := 17, month := "Nov",
  time := rec( hour := 14, minute := 55, second := 12 ), year := 2015 )
```

```gap
RecNames(date);
```

```output
[ "time", "year", "month", "day" ]
```

Next, there are **strings** and **characters**. While strings are printed
specially by GAP, a string is really just a list of characters, and any
function which takes a list will also take a string. In contrast, characters
are simple objects like integers.

```gap
gap> w:="supercalifragilisticexpialidocious"; Length(w);
```

```output
"supercalifragilisticexpialidocious"
34
```

Strings are denoted by double quotes, and characters by single ones.

```gap
gap> "s" in w; 's' in w; IsSubset(w,"s");  IsSubset(w,['s','f']); ['c','a','t'] = "cat";
```

```output
false
true
true
true
true
```

Note that

```gap
gap> PositionSublist(w,"sf"); PositionSublist(w,"fr");
```

```output
fail
10
```

Be careful! Some operations may create a new list, while others are
destructive. For example:

```gap
gap> SortedList(w); w;
```

```output
"aaacccdeefgiiiiiiillloopprrssstuux"
"supercalifragilisticexpialidocious"
```

but

```gap
gap> Sort(w); w;
```

```output
"aaacccdeefgiiiiiiillloopprrssstuux"
```

Which letter occurs in "supercalifragilisticexpialidocious" most often?

```gap
gap> c := Collected(w);
```

```output
[ [ 'a', 3 ], [ 'c', 3 ], [ 'd', 1 ], [ 'e', 2 ], [ 'f', 1 ], [ 'g', 1 ],
  [ 'i', 7 ], [ 'l', 3 ], [ 'o', 2 ], [ 'p', 2 ], [ 'r', 2 ], [ 's', 3 ],
  [ 't', 1 ], [ 'u', 2 ], [ 'x', 1 ] ]
```

```gap
gap> k := Maximum( List( c, v -> v[2] ) ); Filtered( c, v -> v[2] = 7 );
```

```output
7
[ [ 'i', 7 ] ]
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Finding the most common letter(s) in a list using only one pass

The command

`k := Maximum( List( c, v -> v[2] ) ); Filtered( c, v -> v[2] = 7 );`

iterates over the list `c` twice (in `List` and in `Filtered`), and
it also iterates over another list of the same length as `c` in the call
to `Maximum`. If the list is long, this will impose certain performance
and memory penalties. Try to write code that finds the letters that occur most
in `c` without producing an intermediate list.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- GAP has a plethora of various immediate, positional and component objects.
- List arithmetic is very flexible and powerful.
- Objects like lists and records are good to keep structured and related data.

::::::::::::::::::::::::::::::::::::::::::::::::::


