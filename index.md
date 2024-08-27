---
site: sandpaper::sandpaper_site
---

[GAP](https://www.gap-system.org) is a system for discrete computational algebra,
with particular emphasis on Computational Group Theory. GAP provides a
programming language, a library of thousands of functions implementing algebraic
algorithms written in the GAP language as well as large data libraries of algebraic
objects, for example the [Small Groups Library](https://gap-packages.github.io/smallgrp/)
which contains, among others, all 423 164 062 groups of order at most 2000 except 1024.

This lesson gives an introduction to GAP. It is centred around a common task of
searching in the Small Groups Library for interesting examples and counterexamples,
and a particular research problem in which we will be interested is to **find
examples of non-trivial groups such that the average order of their elements is an integer**.

The lesson will lead the learner along the path from working in the GAP command
line and exploring algebraic objects interactively to saving the GAP code into
files, creating functions and regression tests, and further to performing
comprehensive search and extending the system by adding new attributes.

On this path, the learner will become familiar with:

- basic constructions of the GAP programming language,

- ways to find necessary information in the GAP system, and

- good design practices to organise GAP code into complex programs.

::::::::::::::::::::::::::::::::::::::::::  prereq

## Prerequisites

The lesson is oriented on learners possessing the minimal theoretical
background (at least at the level of an undergraduate group theory course)
and willing to learn how concepts from abstract algebra may be
explored using computational tools.
No previous experience of working with GAP is required.

Learners only need to understand the concepts of files and directories
(including home and working directories) and know how to start GAP.


::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::  checklist

## Getting ready

1. In your home directory, create a new directory called `avgord`.
2. Start GAP:

- on Linux and macOS, open the terminal and call `path-to-your-gap-installation/gap-4.X.Y/gap`
  (edit the path as necessary);
- on Windows, start GAP using the Start menu or a desktop shortcut
  created after GAP installation.

3. Set your current directory to `avgord`:

- on Linux and macOS, call `ChangeDirectoryCurrent("/Users/username/avgord");`
  (edit the path as necessary; remember to type the full path to your home
  directory instead of `~`).
- on Windows, call `ChangeDirectoryCurrent("C:/Users/username/avgord");`
  (edit the path as necessary; remember to use `/` instead of `\`);

4. Verify that your current directory is set up properly: call `DirectoryCurrent();`
  and check that the path in the output points to the `avgord` directory.
  

::::::::::::::::::::::::::::::::::::::::::::::::::


