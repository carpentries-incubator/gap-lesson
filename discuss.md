---
title: Discussion
permalink: /discuss/
---

## Ten hints for GAP beginners

1. **Remember that GAP is case-sensitive!** That means that `ABC`, `Abc` and `abc`
  are three different identifiers. A call to `SymmetricGroup(3)` works, but
  `Symmetricgroup(3)` will cause an error.

2. An error message **`"Error, Variable: 'FuncName' must have a value"`** in a
  function call usually points to a typo in the function name (see the previous hint),
  or to some package that must be loaded in advance using
  [**`LoadPackage`**](https://docs.gap-system.org/doc/ref/chap76.html#X79B373A77B29D1F5).

3. **Do not hesitate to use longer and more informative variable names where
  appropriate.** For example, `x` looks perfectly suitable for `List([1..10], x -> x^2)`,
  while `ConClassesReps` may be more informative than just `x` for a list of
  representatives of conjugacy classes of a group.

4. **Use command line editing:** scroll the history of commands and navigate within
  the command line using arrow keys to edit it.

5. **Use autocompletion instead of typing names of functions and variables in full.**
  Type the initial part of the identifier and then press `<Tab>`. It will be
  completed if its unique completion is possible. If not, you may press `<Tab>`
  again to see all possible suggestions.

6. **To view help pages, use `?` and `??` commands**. This will search not only
  in the GAP manuals, but also in the manuals of all GAP packages available
  in your GAP installation.

7. **Set default help format to HTML.** Use
  [**`SetHelpViewer`**](https://docs.gap-system.org/doc/ref/chap2.html#X87C1BFB2826488B0)
  to view it with your preferred browser.

8. **Use [**`LogTo`**](https://docs.gap-system.org/doc/ref/chap9.html#X79813A6686894960)
  to save all GAP input and output into a text file.** It should be called before
  calculations, not after!

9. **If the calculation takes too long, press `<Control>-C` to interrupt it**.
  Then type quit; to leave the break loop.

10. **Read [A First Session with GAP](https://docs.gap-system.org/doc/tut/chap2.html)**
  from the GAP Tutorial.

## Writing programs in GAP

- Use direct calculations in the command line for object exploration and prototyping,
  then think how to organise your code to make it reusable.

- Use [**`LogTo`**](https://docs.gap-system.org/doc/ref/chap9.html#X79813A6686894960)
  to save inputs and outputs to a logfile which then you can edit in a text editor.

- Save code in text files and use
  [**`Read`**](https://docs.gap-system.org/doc/ref/chap9.html#X8373AC6B7D5F9167)
  to load them. Find some advanced text editor to edit these files.

- Make your code modular and reusable by organising it into functions.

- Write comments in the code – this will help you when you will return to it after a while.

- Understand [break loops](https://docs.gap-system.org/doc/ref/chap6.html#X8593B49F8705B486):
  you may [explore variables](https://docs.gap-system.org/doc/ref/chap6.html#X7EE5CF2C8419F061)
  on the current break level and use
  [**`Where`**](https://docs.gap-system.org/doc/ref/chap6.html#X7A7FFA2B7C1EF5A3)
  to show the last commands before the error occurred.

- Use [preferences mechanism](https://docs.gap-system.org/doc/ref/chap3.html#X7FD66F977A3B02DF)
  to customise GAP, for example, to set help viewer to HTML or to make command line history available
  after quitting GAP in the next GAP session.

- Understand the theory behind calculations: theoretical improvements could improve
  the performance much more than highly optimised code which still does a brute-force calculation.

- Implementing algorithms, do not forget corner cases. For example, does the implementation
  work on a trivial group or an identity element?

- Do not rely that GAP functions return results in a particular order, unless this
  is documented. For example, dependently on the method, it may be not guaranteed
  that conjugacy classes or irreducible characters are listed in some particular
  order, or that the first element in their list is the conjugacy class of an identity
  element or the trivial character.

- Don't ask for more than you need as this may have performance implications.
  For example:

  - If the property is an invariant of a conjugacy class (of elements or of
    subgroups), you may be interested only at looking at the representatives
    of conjugacy classes.

  - If you are interested in a list of elements of a collection, without a
    particular order, use `AsList` instead of `AsSSortedList`.

  - Do not calculate conjugacy classes of all subgroups, if e.g. you are
    interested only in normal or maximal subgroups - there are special
    methods to compute them.

  - If you are looking for *p*\-subgroups, first you may calculate
    a Sylow *p*\-subgroup of a group, and then look at its subgroups
    and their conjugates.

  - Representation matters: it may be worth to convert a group from fp group
    to an isomorphic pc group or a permutation group to use faster methods.

- See [GAP Frequently Asked Questions](https://www.gap-system.org/faq/) for further hints.

## Stay in touch

- Subscribe to the **[GAP Forum](https://www.gap-system.org/forum/)**.

- If you need help, choose among these three options, dependently on the question:

  - ask questions in the [GAP Forum](https://www.gap-system.org/forum/)

  - send them to the [GAP Support](https://www.gap-system.org/issues/)

  - post them at the [Mathematics Q\&A site](https://math.stackexchange.com/questions/tagged/gap?sort=frequent&pageSize=50)

## Contributing to GAP

- If you think that you've found a bug: please
  [create an issue on GitHub](https://github.com/gap-system/gap/issues) or
  report it by email to [GAP Support](https://www.gap-system.org/issues/).

- Please cite GAP if you use it. This helps for the community to grow,
  and this will help you in return.
  [This page](https://www.gap-system.org/cite/)
  suggests how to cite GAP, and the function
  [**`Cite`**](https://docs.gap-system.org/doc/ref/chap76.html#X79637D9A7B1AD7F7)
  will help to generate citation sample for precisely the same version of GAP that is used.

- Consider sharing your GAP developments with others, from sharing your code by
  available means to organising it into a GAP package, submitted for the redistribution
  with GAP and optionally for the refereeing.

- Contribute to the further development of this lesson itself.

## Tips and tricks

- This is a simples approach to call GAP from a shell script. Create the shell
  script called `check-one-order.sh` with the following content:

```gap
#!/bin/sh

gap -r -b -q avgord.g << EOI
TestOneOrderEasy( $1 );
quit;
EOI
```

and make it executable using `chmod u+x check-one-order.sh`. Now you may call
it as follows:

```gap
$ ./check-one-order.sh 24
```

```output
fail
```

```gap
$ ./check-one-order.sh 105
```

```output
[ 105, 1 ]
```

- Reading data files

GAP can read any valid GAP input from the code using `Read`. The contents will
be read and evaluated in the main read-evaluate-print loop, but the results will
not printed. Sometimes you may want to read the content of the file as a function
and return that function - for that purpose you may find `ReadAsFunction` useful.
But what to do if you have some a data file coming from other source, and it is
not a valid GAP input? Sometimes you may have control over the tool that exports
data, and may be able to tweak it to generate GAP input file. But where to look
if this option is not possible?

`ReadCSV( filename[, nohead][, separator] )` reads a file in a CSV (comma
separated values) format and returns its entries as a list of records
(see [documentation](https://docs.gap-system.org/doc/ref/chap10.html#X848DD7DC79363341)).
The entries of the first line of the file will be used for the names
of the record components (blanks will be translated into underscores).
One could also indicate that the first line contains data instead of
field names, and also specify a custom separator. Conversely, `PrintCSV`
may be used to output CSV files.

To read arbitrary (binary or text) files as strings, use the `StringFile`
function provided by the GAPDoc package (see
[documentation](https://docs.gap-system.org/pkg/gapdoc/doc/chap6.html#X7E14D32181FBC3C3)).
It will return the content of the file as a string.
After that, you may use various string manipulation tools (see
[Strings and Characters](https://docs.gap-system.org/doc/ref/chap27.html)
in the GAP reference manual) to process it in the way you need. GAPDoc package
also provides the `FileString` function which writes the content of a string
into a file.

If you need to organise reading/writing line by line, instead of reading or
writing the whole file/string at once, we suggest to look at the functionality
provided by the IO package
(see [documentation](https://docs.gap-system.org/pkg/io/doc/chap4.html)),
in particular at `IO_ReadLine` and `IO_WriteLine`.


