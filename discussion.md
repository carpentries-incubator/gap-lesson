---
layout: page
title: Introduction to GAP
subtitle: Discussion
---

## Ten hints for GAP beginners

1. **Remember that GAP is case-sensitive!** That means that `ABC`, `Abc` and `abc`
are three different identifiers. A call to `SymmetricGroup(3)` works, but
`Symmetricgroup(3)` will cause an error.

2. An error message **`“Error, Variable: 'FuncName' must have a value”`** in a
function call usually points to a typo in the function name (see the previous hint),
or to some package that must be loaded in advance using
[LoadPackage](http://www.gap-system.org/Manuals/doc/ref/chap76.html#X79B373A77B29D1F5).

3. **Do not hesitate to use longer and more informative variable names where
appropriate.** For example, `x` looks perfectly suitable for `List([1..10], x -> x^2)`,
while `ConClassesReps` may be more informative than just `x` for a list of
representatives of conjugacy classes of a group.

4. **Use command line editing:** scroll the history of commands and navigate within
the command line using arrow keys.

5. **Use autocompletion instead of typing names of functions and variables in full.**
Type the initial part of the identifier and then press `<Tab>`. It will be
completed if its unique completion is possible. If not, you may press `<Tab>`
again to see all possible suggestions.

6. **To view help pages, use `?` and `??` commands**. This will search not only
in the GAP manuals, but also in the manuals of all GAP packages available
in your GAP installation.

7. **Set default help format to HTML.** Use
[`SetHelpViewer`](http://www.gap-system.org/Manuals/doc/ref/chap2.html#X87C1BFB2826488B0)
to view it with your preferred browser.

8. **Use `[LogTo](http://www.gap-system.org/Manuals/doc/ref/chap9.html#X79813A6686894960)`
to save all GAP input and output into a text file.** It should be called before calculations, not after!

9. **If the calculation takes too long, press `<Control>-C` to interrupt it**. Then type quit; to leave the break loop.

10. **Read [A First Session with GAP](http://www.gap-system.org/Manuals/doc/tut/chap2.html)** from the GAP Tutorial.


## Something That May Be Useful

Paragraphs of general discussion

## Something Else

More general discussion, with links.
