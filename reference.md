---
layout: reference
permalink: /reference/
---

## [First session with GAP]({% link _episodes/01-command-line.md %})

* [GAP Tutorial: A First session with GAP](https://www.gap-system.org/Manuals/doc/tut/chap2.html)

* [GAP Reference Manual: Naming Conventions](https://plus.google.com/events/cfm3tc375c142qtodvlvcfs82l4)

* [GAP Reference Manual: The Help System](https://www.gap-system.org/Manuals/doc/ref/chap2.html)

* [GAP Tutorial: Lists and Records](https://www.gap-system.org/Manuals/doc/tut/chap3.html)

* [GAP Reference Manual: Strings and Characters](https://www.gap-system.org/Manuals/doc/ref/chap27.html)

* [GAP Reference Manual: The Programming Language]( https://www.gap-system.org/Manuals/doc/ref/chap4.html#X7FE7C0C17E1ED118)


## [Some more GAP objects]({% link _episodes/02-some-objects.md %})

* [Integers](https://www.gap-system.org/Manuals/doc/ref/chap14.html)

* [Rationals](https://www.gap-system.org/Manuals/doc/ref/chap17.html)

* [Cyclotomic numbers](https://www.gap-system.org/Manuals/doc/ref/chap18.html)

* [Floats](https://www.gap-system.org/Manuals/doc/ref/chap19.html)

* [Finite Field Elements](https://www.gap-system.org/Manuals/doc/ref/chap59.html)

* [Permutations](https://www.gap-system.org/Manuals/doc/ref/chap42.html)

* [Lists](https://www.gap-system.org/Manuals/doc/ref/chap21.html)

* [Records](https://www.gap-system.org/Manuals/doc/ref/chap29.html)

* [Strings and Characters](https://www.gap-system.org/Manuals/doc/ref/chap27.html)


## [Functions in GAP]({% link _episodes/03-func.md %})

* [GAP Tutorial: Functions](https://www.gap-system.org/Manuals/doc/tut/chap4.html)


## [Using regression tests]({% link _episodes/04-testing.md %})

* [GAP Reference Manual: Test](https://www.gap-system.org/Manuals/doc/ref/chap7.html#X87712F9D8732193C)


## [Small groups search]({% link _episodes/05-small-groups.md %})

* [GAP Reference Manual: Group Libraries](https://www.gap-system.org/Manuals/doc/ref/chap50.html)


## [Attributes and Methods]({% link _episodes/06-attributes.md %})

* [GAP Tutorial: Operations and Methods](https://www.gap-system.org/Manuals/doc/tut/chap8.html)

* [GAP Reference Manual: Adding a new Attribute](https://www.gap-system.org/Manuals/doc/ref/chap80.html#X874AF11D864AEC1B)

## Glossary

Attribute
:    Operation (normally, one-argument), the result of which is stored in its
     argument and cannot be changed any more.

List
:    Data structure whose elements are indexed by their _position_ in the list.

Method
:    Function that will be called for an operation for arguments of the
     specified type.

Operation
:    GAP function for which several _methods_ may be available (the particular
     method that will be used depends on the type of the arguments).

Property
:    Boolean-valued attribute

Record
:    Data structure which is a collection of _components_, each having a unique
     _name_, which is an _identifier_ that distinguishes this component, and a
     _value_, which is an object of arbitrary type.

Regression testing
:    Testing based on rerunning previously completed tests to check that new
     changes do not impact their correctness or worsen their performance.
