---
title: Attributes and Methods
teaching: 40
exercises: 10
---

::::::::::::::::::::::::::::::::::::::: objectives

- Declaring an attribute
- Installing a method
- Understanding method selection
- Using debugging tools

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How to record information in GAP objects

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::  callout

## Which function is faster?

Try to repeatedly calculate `AvgOrdOfGroup(M11)` and `AvgOrdOfCollection(M11)`
and compare runtimes. Do this for a new copy of `M11` and for the one for which
this parameter has already been observed. What do you observe?


::::::::::::::::::::::::::::::::::::::::::::::::::

Of course, for any given group the average order of its elements needs to
be calculated only once, as the next time it will return the same value.
However, as we see from the runtimes below, each new call of `AvgOrdOfGroup`
will repeat the same computation again, with slightly varying runtime:

```gap
A:=AlternatingGroup(10);
```

```output
Alt( [ 1 .. 10 ] )
```

```gap
AvgOrdOfCollection(A); time; AvgOrdOfCollection(A); time;
```

```output
2587393/259200
8226
2587393/259200
8118
```

In the last example, the group in question was the same -- we haven't
constructed another copy of `AlternatingGroup(10)`; however, the result
of the calculation was not stored in `A`.

If you need to reuse this value, one option could be to store it in some
variable, but then you should be careful about matching such variables
with corresponding groups, and the code could become quite convoluted
and unreadable. On the other hand, GAP has the notion of an *attribute* -- a
data structure that is used to accumulate information that an object learns about itself
during its lifetime. Consider the following example:

```gap
G:=Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ]);
gap> NrConjugacyClasses(G);time;NrConjugacyClasses(G);time;
```

```output
Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ])
10
39
10
0
```

In this case, the group `G` has 10 conjugacy classes, and it took 39 ms to
establish that in the first call. The second call has zero cost since the
result was stored in `G`, since `NrConjugacyClasses` is an attribute:

```gap
NrConjugacyClasses;
```

```output
<Attribute "NrConjugacyClasses">
```

Our goal is now to learn how to create own attributes.

Since we already have a function `AvgOrdOfCollection` which
does the calculation, the simplest way to turn it into
an attribute is as follows:

```gap
AverageOrder := NewAttribute("AverageOrder", IsCollection);
InstallMethod( AverageOrder, "for a collection", [IsCollection], AvgOrdOfCollection);
```

In this example, first we declared an attribute `AverageOrder` for
objects in the category `IsCollection`, and then installed the function
`AvgOrdOfCollection` as a method for this attribute. Instead of calling
the function `AvgOrdOfCollection`, we may now call `AverageOrder`.

Now we may check that subsequent calls of `AverageOrder` with the same argument
are performed at zero cost. In this example the time is reduced from more than
16 seconds to zero:

```gap
S:=SymmetricGroup(10);; AverageOrder(S); time; AverageOrder(S); time;
```

```output
39020911/3628800
16445
39020911/3628800
0
```

You may wonder why we have declared the operation for a collection and not only
for a group, and why we have installed the inefficient `AvgOrdOfCollection`.
After all, we have already developed the much more efficient `AvgOrdOfGroup`.

Imagine that you would like to be able to compute an average order
both for a group and for a list which consists of objects having a multiplicative
order. You may have a special function for each case, as we have. If it
could happen that you don't know in advance the type of the object in question,
you may add checks into the code and dispatch to a suitable function. This could
quickly become complicated if you have several different functions for various
types of objects. Instead of that, attributes are bunches of functions, called
*methods*, and GAP's *method selection* will choose the most efficient method
based on the type of all arguments.

To illustrate this, we will now install a method for `AverageOrder` for a group:

```gap
InstallMethod( AverageOrder, [IsGroup], AvgOrdOfGroup);
```

If you apply it to a group whose `AverageOrder` has already been computed, nothing
will happen, since GAP will use the stored value. However, for a newly created group,
this new method will be called:

```gap
S:=SymmetricGroup(10);; AverageOrder(S); time; AverageOrder(S); time;
```

```output
39020911/3628800
26
39020911/3628800
0
```

:::::::::::::::::::::::::::::::::::::::::  callout

## Which method is being called

- Try to call `AverageOrder` for a collection which is not a group
  (a list of group elements and/or a conjugacy class of group elements).

- Debugging tools like `TraceMethods` may help you see which method is
  being called.

- `ApplicableMethod` in combination with `PageSource` may point you to
  the source code with all the comments.


::::::::::::::::::::::::::::::::::::::::::::::::::

A *property* is a boolean-valued attribute. It can be created using `NewProperty`

```gap
IsIntegerAverageOrder := NewProperty("IsIntegerAverageOrder", IsCollection);
```

Now we will install a method for `IsIntegerAverageOrder` for a collection.
Observe that it is never necessary to create
a function first and then install it as a method. The following method installation
instead creates a new function as one of its arguments:

```gap
InstallMethod( IsIntegerAverageOrder,
  "for a collection",
  [IsCollection],
  coll -> IsInt( AverageOrder( coll ) )
);
```

Note that because `AverageOrder` is an attribute it will take care of the selection of
the most suitable method.

:::::::::::::::::::::::::::::::::::::::::  callout

## Does such a method always exist?

No. "No-method-found" is a special kind of error, and there are tools to
investigate such errors: see `?ShowArguments`, `?ShowDetails`, `?ShowMethods`
and `?ShowOtherMethods`.


::::::::::::::::::::::::::::::::::::::::::::::::::

The following calculation shows that despite our success with calculating
the average order for large permutation groups via conjugacy classes of
elements, for pc groups from the Small Groups Library it could be faster
to iterate over their elements than to calculate conjugacy classes:

```gap
l:=List([1..1000],i->SmallGroup(1536,i));; List(l,AvgOrdOfGroup);;time;
```

```output
56231
```

```gap
l:=List([1..1000],i->SmallGroup(1536,i));; List(l,AvgOrdOfCollection);;time;
```

```output
9141
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Don't panic!

- Install a method for `IsPcGroup` that iterates over the group elements
  instead of calculations its conjugacy classes.

- Estimate practical boundaries of its feasibility. Can you find an example
  of a pc group where iterating is slower than calculating conjugacy classes?


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- *Positional* objects may accumulate information about themselves during their lifetime.
- This means that next time the stored information may be retrieved at zero cost.
- *Methods* are bunches of functions; GAP's *method selection* will choose the most efficient method based on the type of all arguments.
- 'No-method-found' is a special kind of error with useful debugging tools helping to understand it.

::::::::::::::::::::::::::::::::::::::::::::::::::


