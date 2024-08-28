---
title: Instructor Notes
permalink: /guide/
---

## Overall

- For the first lesson, good to have access to Windows (VM or remote desktop) to
  demonstrate some Windows-specific aspects of working with GAP.

- Before start, check that everyone has installed GAP and knows how to start it.
  Also remind that it's not advised to install in in the path with spaces, e.g. in
  "My Documents".

- It is important that learners will understand how to operate with files
  located in different directories. `ChangeDirectoryCurrent` is the function
  from the IO package (requires compulation), which should be available if
  GAP is properly installed (i.e. installed following instructions for the
  workshop). In case of any problems, the first step of troubleshooting is
  to check whether `LoadPackage("io");` returns `fail`. If so, the remedy
  for Windows users is to type full paths to files. Linux and macOS users
  are less affected as for the, the way how they should start GAP is to
  navigate to the needed directory in the Terminal and start GAP from there.

- Help to adjust terminal settings, especially show to Windows users that they
  can permanently change colours and fonts in mintty shell (the one started with
  `gap.bat`).

- Explain how to copy and paste input and output (especially on Windows).

- Explain how to read lesson pages: GAP input is types without GAP prompt.
  GAP output is ion blue colour. Errors are displayed in red. GAP promts is
  not displayed, unless this is really necessary (e.g. to demonstrate how the
  multi-line input works).

- It is important that instructor starts GAP with `-r` option to avoid
  interfering with own GAP settings e.g. locally installed packages and
  other content of `.gap` directory.

- To use color prompt when GAP is started with `-r` option to ignore all user
  preferences, including this (if set), call `ColorPrompt(true);`.

## [First session with GAP]({% link \_episodes/01-command-line.md %})

- Emphasize that the banner contains version info useful for citing GAP or
  reporting bugs. Selection of packages may differ, but missing **IO** and
  **Browse** packages indicate that these and perhaps some other packages
  that require compilation were not compiled.

- A second call to `LogTo("logfile");` will not open the new file but will report
  that GAP is already logging to another file. In this case, either ignore it if
  you would like to continue logging to the file already in use, or call `LogTo();`
  to close the current log file and then call `LogTo` with an argument to start
  logging to a new file.

- Showing an example of the error with `factorial`, mention that such error
  also happens if e.g. some file has to be read or some package should be loaded
  to define the function.

- Discuss why it's a bad practice to Google for the GAP manual instead of
  using the GAP help system.

- Be aware that help selection screen will look differently if **Browse**
  package is not compiled.

- Explain how to switch to view HTML version of the Manual with MathJax support.

- Draw attention to the difference between `AsList` and `AsSSortedList`.

- Help to call `WriteGapIniFile` and customise GAP e.g. to use browser as a
  viewer.

- Demonstrating how to type `Sum( List( elts, Order ) ) / Length( elts );`
  show how to assemble this command using command line editing and moving
  around the line, perhaps executing partial command to see their results,
  instead of typing the whole command from first to last character sequentially.

- Use Etherpad to vote for approaches to calculate the average order of a list.
  After that discuss situations when each of them may be more preferable than others.

1. Solution of the challenge: `Filtered( elts, g -> 2^g = 2 );` and
  `Filtered( elts, g -> (1,2)^g = (1,2) );`.

## [Some more GAP objects]({% link \_episodes/02-some-objects.md %})

- Floats, cyclotomics, finite fields elements are not used further in the
  lesson, but we mention them briefly to show that they exist.

- Emphasize that organising complex objects into nested records may
  be more efficient than nested lists.

- Beware that `w:="supercalifragilisticexpialidocious"; IsSubset(w,'s');`
  results in a no-method-found error. This may be a good moment to introduce
  this special kind of error messages.

- For extending GAP with new types of objects, refer to
  [Creating New Objects](https://docs.gap-system.org/doc/ref/chap79.html)
  and [Examples of Extending the System](https://docs.gap-system.org/doc/ref/chap80.html)
  of the GAP Reference Manual.
  Also, the [Circle package](https://gap-packages.github.io/circle/)
  provides an example of extending GAP with new multiplicative objects.

1. Solution of the challenge:
  `r:=c[1]; for i in [2..Length(c)] do if c[i][2]>r[2] then r:=c[i]; fi; od; r;`

## [Functions in GAP]({% link \_episodes/03-func.md %})

- Spend some time on the structure of the GAP function: keywords `function`,
  `local`, `return`, `end`, and other language constructions exposed there.

- Tell how to explore the break loop while showing an example of an error
  message.

## [Using regression tests]({% link \_episodes/01-command-line.md %})(04-testing.html)

- Learners may need help with formatting the test because of misplaced comments
  and/or different formatting of the output.

- Cover aspects of making test files reproducible: random vs explicit examples,
  suppressing output with double semicolon, etc.

- Refer to other options of `Test` such as comparing the output up to
  whitespaces, displaying the progress of the test, etc.

- Mention `TestDirectory` function to run a collection of tests.

- Mention profiling and code coverage tools.

## [Small groups search]({% link \_episodes/05-small-groups.md %})

- Give an overview of `SmallGroup`, `AllSmallGroups`, `NrSmallGroups` and
  `SmallGroupsInformation` with some examples.

- Discuss, why iterating is better than AllSmallGroups exhausting memory
  (mention the concept of self-learning objects).

- A side question is how to convert a pc group, returned by `SmallGroup`, to
  some other representation, e.g. permutation or fp group.

- Live coding is preferred way to teach how to develop most of the functions
  from this lesson.

1. Solution of the challenge:
  `Sum(List(Filtered([1..2000], n -> not IsPrimePowerInt(n)),NrSmallGroups)); NrSmallGroups(1536); last2-last;`.
  In addition to `SmallGroup(105,1)` and `SmallGroup(357,1)`, another
  group is `SmallGroup(1785,1)`.

## [Attributes and Methods]({% link \_episodes/06-attributes.md %})

- Why it is not a good idea to declare `Random` as an attribute?

1. Ideas for the challenge: try `k:=1` and then `k:=k+1;n:=2^k;AvgOrdOfCollection(DihedralGroup(n));time;AvgOrdOfGroup(DihedralGroup(n));time;`.
  Even for `k=20`, the 1st function takes about 15s and the 2nd - about 115s
  on a MacBook Pro.


