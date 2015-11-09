---
layout: lesson
title: Introduction to GAP
---

[GAP](http://www-gap.system.org) is a system for discrete computational algebra,
with particular emphasis on Computational Group Theory. GAP provides a
programming language, a library of thousands of functions implementing algebraic
algorithms written in the GAP language as well as large data libraries of algebraic
objects, for example the [Small Groups Library](http://www.gap-system.org/Packages/sgl.html)
which contains, among others, all 423 164 062 groups of order at most 2000 except 1024.

This lesson gives an introduction to GAP. It is centred around a common task of
searching in the Small Groups Library for interesting examples and counterexamples,
and a particular research problem in which we will be interested is to **find
examples of groups such that the average order of their element is an integer**.

The lesson will lead the learner along the path from working in the GAP command
line and exploring algebraic objects interactively to saving the GAP code into
files, creating functions and regression tests, and further to performing
comprehensive search and extending the system by adding new attributes.

On this path, the learner will became familiar with:

* basic constructions of the GAP programming language,

* ways to find necessary information in the GAP system, and

* good design practices to organise GAP code into complex programs.

> ## Prerequisites {.prereq}
>
> Learners need to understand the concepts of files and directories
> (including home and working directories) and know how to start GAP.

> ## Getting ready {.getready}
> 1. In your home directory, create a new directory called `avgord`
> 2. Change to that directory
> 3. Start GAP

## Topics

1.  [First session in GAP](01-command-line.html)
2.  [Functions in GAP](02-func.html)
3.  [Using regression tests](03-testing.html)
4.  [Small groups search](04-small-groups.html)
5.  [Attributes and Methods](05-attributes.html)

## Other Resources

*   [Reference](reference.html)
*   [Discussion](discussion.html)
*   [Instructor's Guide](instructors.html)
