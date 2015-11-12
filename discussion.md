---
layout: page
title: Programming with GAP
subtitle: Discussion
---

## Ten hints for GAP beginners

1. **Remember that GAP is case-sensitive!** That means that `ABC`, `Abc` and `abc`
are three different identifiers. A call to `SymmetricGroup(3)` works, but
`Symmetricgroup(3)` will cause an error.

2. An error message **`“Error, Variable: 'FuncName' must have a value”`** in a
function call usually points to a typo in the function name (see the previous hint),
or to some package that must be loaded in advance using
[**`LoadPackage`**](http://www.gap-system.org/Manuals/doc/ref/chap76.html#X79B373A77B29D1F5).

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
[**`SetHelpViewer`**](http://www.gap-system.org/Manuals/doc/ref/chap2.html#X87C1BFB2826488B0)
to view it with your preferred browser.

8. **Use [**`LogTo`**](http://www.gap-system.org/Manuals/doc/ref/chap9.html#X79813A6686894960)
to save all GAP input and output into a text file.** It should be called before calculations, not after!

9. **If the calculation takes too long, press `<Control>-C` to interrupt it**. Then type quit; to leave the break loop.

10. **Read [A First Session with GAP](http://www.gap-system.org/Manuals/doc/tut/chap2.html)** from the GAP Tutorial.


## Writing programs in GAP

* Use direct calculations in the command line for object exploration and prototyping,
then think how to organise your code to make it reusable.

* Use [**`LogTo`**](http://www.gap-system.org/Manuals/doc/ref/chap9.html#X79813A6686894960)
to save inputs and outputs to a logfile which then you can edit in a text editor.

* Save code in text files and use
[**`Read`**](http://www.gap-system.org/Manuals/doc/ref/chap9.html#X8373AC6B7D5F9167)
to load them. Find some advanced text editor to edit these files.

* Make your code modular and reusable by organising it into functions.

* Write comments in the code – this will help you when you will return to it after a while.

* Understand [break loops](http://www.gap-system.org/Manuals/doc/ref/chap6.html#X8593B49F8705B486):
you may [explore variables](http://www.gap-system.org/Manuals/doc/ref/chap6.html#X7EE5CF2C8419F061)
on the current break level and use
[**`Where`**](http://www.gap-system.org/Manuals/doc/ref/chap6.html#X7A7FFA2B7C1EF5A3)
to show the last commands before the error occurred.

* Use [preferences mechanism](http://www.gap-system.org/Manuals/doc/ref/chap3.html#X7FD66F977A3B02DF)
to customise GAP, for example, to set help viewer to HTML or to make command line history available
after quitting GAP in the next GAP session.

* Understand the theory behind calculations: theoretical improvements could improve
the performance much more than highly optimised code which still does a brute-force calculation.

* Implementing algorithms, do not forget corner cases. For example, does the implementation
work on a trivial group or an identity element?

* Do not rely that GAP functions return results in a particular order, unless this
is documented. For example, dependently on the method, it may be not guaranteed
that conjugacy classes or irreducible characters are listed in some particular
order, or that the first element in their list is the conjugacy class of an identity
element or the trivial character.

* Don't ask for more than you need as this may have performance implications.
For example:

    * If the property is an invariant of a conjugacy class (of elements or of
      subgroups), you may be interested only at looking at the representatives
      of conjugacy classes.

    * Do not calculate conjugacy classes of all subgroups, if e.g. you are
      interested only in normal or maximal subgroups - there are special
      methods to compute them.

    * If you are looking for _p_-subgroups, first you may calculate
      a Sylow _p_-subgroup of a group, and then look at its subgroups
      and their conjugates.

* See [GAP Frequently Asked Questions](http://www.gap-system.org/Faq/faq.html) for further hints.

## Stay in touch

* Subscribe to the **[GAP Forum](http://mail.gap-system.org/mailman/listinfo/forum)**.

* If you are on Twitter, follow **[gap_system](https://twitter.com/gap_system)**.

* If you need help, choose among these three options, dependently on the question:

    * ask questions in the [GAP Forum](http://www.gap-system.org/Contacts/Forum/forum.html)

    * send them to the [GAP Support](http://www.gap-system.org/Contacts/People/supportgroup.html)

    * post them at the [Mathematics Q&A site](http://math.stackexchange.com/questions/tagged/gap?sort=frequent&pageSize=50)


## Contributing to GAP

* If you think that you’ve found a bug: please
[create an issue on GitHub](https://github.com/gap-system/gap/issues) or
report it by email to [GAP Support](http://www.gap-system.org/Contacts/People/supportgroup.html).

* Please cite GAP if you use it. This helps for the community to grow,
and this will help you in return.
[This page](http://www.gap-system.org/Contacts/cite.html)
suggests how to cite GAP, and the function
[**`Cite`**](http://www.gap-system.org/Manuals/doc/ref/chap76.html#X79637D9A7B1AD7F7)
will help to generate citation sample for precisely the same version of GAP that is used.

* TODO: GAP packages



## Tips and tricks

* TODO: how to start GAP with a shell script and supply arguments
