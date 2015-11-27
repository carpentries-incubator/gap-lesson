---
layout: lesson
title: Programming with GAP
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
> The lesson is oriented on learners possessing the minimal theoretical
> background (at least at the level of undergraduate group theory course)
> and willing to learn how the concepts from abstract algebra may be
> explored using computational tools.
> No previous experience of working with GAP is required.
>
> Learners need to understand the concepts of files and directories
> (including home and working directories) and know only how to start GAP.

> ## Getting ready {.getready}
> 1. In your home directory, create a new directory called `avgord`.
> 2. **Only on Linux and OS X:** in the terminal, navigate to that directory
>    using the `cd` command.
> 3. Start GAP: on Linux and OS X, call `gap4r7/bin/gap.sh` (edit the path as
>    needed); on Windows, call it via the appropriate menu or by double-clicking
>    on the `gap4r7/bin/gap.bat` file in your GAP installation.
> 4. **Only on Windows:** set `avgord` to be your current directory using the
>    command `ChangeDirectoryCurrent("C:/Users/username/avgord");` (edit the
path as needed, remember to use `/`" instead of `\`).
> 5. Check that your current directory is set up properly: on Linux and OS X,
>    call `Exec("pwd");`; on Windows, call `Exec("DIR");`. The path that you
>    will see in the output should be the path to the `avgord` directory.

## Topics

1.  [First session with GAP](01-command-line.html)
2.  [Some more GAP objects](02-some-objects.html)
3.  [Functions in GAP](03-func.html)
4.  [Using regression tests](04-testing.html)
5.  [Small groups search](05-small-groups.html)
6.  [Attributes and Methods](06-attributes.html)

## Other Resources

*   [Reference](reference.html)
*   [Discussion](discussion.html)
*   [Instructor's Guide](instructors.html)
