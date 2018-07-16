---
title: "Attributes and Methods"
teaching: 40
exercises: 10
questions:
- "How to record information in GAP objects"
objectives:
- "Declaring an attribute"
- "Installing a method"
- "Understanding method selection"
- "Using debugging tools"
keypoints:
- "_Positional_ objects may accumulate information about themselves during their lifetime."
- "This means that next time the stored information may be retrieved at zero costs."
- "_Methods_ are bunches of functions; the _method selection_ will choose the most efficient method based on the type of all arguments."
- "'No-method-found' is a special kind of error with useful debugging tools helping to understand it."
---

> ## Which function is faster?
>
> Try to repeatedly calculate `AvgOrdOfGroup(M11)` and `AvgOrdOfCollection(M11)`
> and compare runtimes. Do this for new copy of `M11` and for the one for which
> this parameter has already been observed. What do you observe?
{: .callout}

Of course, for any given group the average order of its elements needs to
be calculated only once, as the next time it will return the same value.
However, as we see from the runtimes below, each new call of `AvgOrdOfGroup`
will repeat the same computation again, with slightly varying runtime:

~~~
A:=AlternatingGroup(10);
~~~
{: .source}

~~~
Alt( [ 1 .. 10 ] )
~~~
{: .output}

~~~
AvgOrdOfCollection(A); time; AvgOrdOfCollection(A); time;
~~~
{: .source}

~~~
2587393/259200
8226
2587393/259200
8118
~~~
{: .output}

In the last example, the group in question was the same - we haven't
constructed another copy of `AlternatingGroup(10)`; however, the result
of the calculation was not stored in `A`.

If you need to reuse this value, one option could be to store it in some
variable, but then you should be careful about matching such variables
with corresponding groups, and the code could become quite convoluted
and unreadable. On the other hand, GAP has a notion of attributes which
are used to accumulate information that objects learn about themselves
during their lifetime. Consider the following example:

~~~
G:=Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ]);
gap> NrConjugacyClasses(G);time;NrConjugacyClasses(G);time;
~~~
{: .source}

~~~
Group([ (1,2,3,4,5,6,7,8,9,10,11), (3,7,11,8)(4,10,5,6) ])
10
39
10
0
~~~
{: .output}

In this case, the group `G` has 10 conjugacy classes, and it took 39 ms to
establish that in the first call. The second call has zero cost since the
result was stored in `G`, since `NrConjugacyClasses` is an attribute:

~~~
NrConjugacyClasses;
~~~
{: .source}

~~~
<Attribute "NrConjugacyClasses">
~~~
{: .output}

Our goal is now to learn how to create own attributes.

Since we already have a function `AvgOrdOfCollection` which
does the calculation, the simplest example of turning it into
an attribute could look as follows:

~~~
AverageOrder := NewAttribute("AverageOrder", IsCollection);
InstallMethod( AverageOrder, "for a collection", [IsCollection], AvgOrdOfCollection);
~~~
{: .source}

In this example, first we declared an attribute `AverageOrder` for
objects in the category `IsCollection`, and then installed the function
`AvgOrdOfCollection` as a method for this attribute. Instead of calling
the function `AvgOrdOfCollection`, we may now call `AverageOrder`.

Now we may check that subsequent calls of `AverageOrder` with the same argument
are performed at zero cost. In this example the time is reduced from more than
16 seconds to zero:

~~~
S:=SymmetricGroup(10);; AverageOrder(S); time; AverageOrder(S); time;
~~~
{: .source}

~~~
39020911/3628800
16445
39020911/3628800
0
~~~
{: .output}

You may be interested why we have declared the operation for a collection and
not only for a group and then used the non-efficient method for a group again,
while we have already developed an efficient one?

Imagine the situation when you would like to be able to compute an average order
both for a group and for a list which consists of objects having a multiplicative
order. You may have a special function for each case, as we have already. If it
could happen that you don't know in advance the type of the object in question,
you may add checks into the code and dispatch to a suitable function. This could
quickly became complicated if you have several different functions for various
types of objects. Instead of that, attributes are bunches of functions, called
_methods_, and the _method selection_ will choose the most efficient method
based on the type of all arguments.

To illustrate this, we will now install a method for `AverageOrder` for a group:

~~~
InstallMethod( AverageOrder, [IsGroup], AvgOrdOfGroup);
~~~
{: .source}

If you will apply it to the group which already has `AverageOrder`, nothing
will happen, since GAP will use the stored value. For a newly created group,
this new method will be called indeed:

~~~
S:=SymmetricGroup(10);; AverageOrder(S); time; AverageOrder(S); time;
~~~
{: .source}

~~~
39020911/3628800
26
39020911/3628800
0
~~~
{: .output}

> ## Which method is being called
>
> * Try to call `AverageOrder` for a collection which is not a group
>   (a list of group elements and/or a conjugacy class of group elements).
>
> * Debugging tools like `TraceMethods` may help to see which method is
>   being called.
>
> * `ApplicableMethod` in combination with `PageSource` may point you to
>   the source code with all the comments.
{: .callout}

A _property_ is a boolean-valued attribute. It can be created using `NewProperty`

~~~
IsIntegerAverageOrder := NewProperty("IsIntegerAverageOrder", IsCollection);
~~~
{: .source}

Now we will install a method for `IsIntegerAverageOrder` for a collection.
Observe that neither below nor in the examples above it is not necessary to create
a function first and then install it as a method. The following method installation
just creates a new function as one of its arguments:

~~~
InstallMethod( IsIntegerAverageOrder,
  "for a collection",
  [IsCollection],
  coll -> IsInt( AverageOrder( coll ) )
);
~~~
{: .source}

Note that because `AverageOrder` is an operation it will take care of the selection of
the most suitable method.

> ## Does such method always exist?
>
> No. "No-method-found" is a special kind of error, and there are tools to
> investigate such errors: see `?ShowArguments`, `?ShowDetails`, `?ShowMethods`
> and `?ShowOtherMethods`.
{: .callout}

The following calculation shows that despite our success with calculating
the average order for large permutation groups via conjugacy classes of
elements, for pc groups from the Small Groups Library it could be faster
to iterate over their elements than to calculate conjugacy classes:

~~~
l:=List([1..1000],i->SmallGroup(1536,i));; List(l,AvgOrdOfGroup);;time;
~~~
{: .source}

~~~
56231
~~~
{: .output}

~~~
l:=List([1..1000],i->SmallGroup(1536,i));; List(l,AvgOrdOfCollection);;time;
~~~
{: .source}

~~~
9141
~~~
{: .output}

> ## Don't panic!
>
> * Install a method for `IsPcGroup` that iterates over the group elements
>   instead of calculations its conjugacy classes.
>
> * Estimate practical boundaries of its feasibility. Can you find an example
>   of a pc group when iterating is slower than calculating conjugacy classes?
{: .challenge}
