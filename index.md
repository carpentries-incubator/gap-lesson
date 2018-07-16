---
layout: lesson
root: .
---

[GAP](http://www.gap-system.org) is a system for discrete computational algebra,
with particular emphasis on Computational Group Theory. GAP provides a
programming language, a library of thousands of functions implementing algebraic
algorithms written in the GAP language as well as large data libraries of algebraic
objects, for example the [Small Groups Library](http://www.gap-system.org/Packages/sgl.html)
which contains, among others, all 423 164 062 groups of order at most 2000 except 1024.

This lesson gives an introduction to GAP. It is centred around a common task of
searching in the Small Groups Library for interesting examples and counterexamples,
and a particular research problem in which we will be interested is to **find
examples of groups such that the average order of their elements is an integer**.

The lesson will lead the learner along the path from working in the GAP command
line and exploring algebraic objects interactively to saving the GAP code into
files, creating functions and regression tests, and further to performing
comprehensive search and extending the system by adding new attributes.

On this path, the learner will become familiar with:

* basic constructions of the GAP programming language,

* ways to find necessary information in the GAP system, and

* good design practices to organise GAP code into complex programs.

> ## Prerequisites
>
> The lesson is oriented on learners possessing the minimal theoretical
> background (at least at the level of undergraduate group theory course)
> and willing to learn how the concepts from abstract algebra may be
> explored using computational tools.
> No previous experience of working with GAP is required.
>
> Learners need to understand the concepts of files and directories
> (including home and working directories) and know only how to start GAP.
{: .prereq}

> ## Getting ready
> 1. In your home directory, create a new directory called `avgord`.
> 2. Start GAP:
> * on Linux and OS X, call `path-to-your-gap-installation/gap-4.X.Y/bin/gap.sh`
>    (edit the path as necessary);
> * on Windows, call it via the appropriate menu or
>    by double-clicking on the `gap-4.X.Y/bin/gap.bat` file in your GAP installation.
> 3. Set your current directory to `avgord` calling `ChangeDirectoryCurrent` from
>    the IO package (if GAP is installed correctly, by default it should be loaded
>    when GAP starts):
> * on Linux and OS X, call `ChangeDirectoryCurrent("/home/username/avgord");`
>    (edit the path as necessary; remember to type the full path to your home
>    directory instead of `~`).
> * on Windows, call `ChangeDirectoryCurrent("C:/Users/username/avgord");`
>    (edit the path as necessary; remember to use `/` instead of `\`).
> 4. Verify that your current directory is set up properly: call `DirectoryCurrent();`
>    on Windows or `Exec("pwd");` on Linux and OS X and check that the path in the
>    output points to the `avgord` directory.
{: .checklist}

[contributing]: {{ site.github.repository_url }}/blob/gh-pages/CONTRIBUTING.md
[styles]: https://github.com/swcarpentry/styles/
