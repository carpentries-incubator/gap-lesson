---
layout: page
title: Programming with GAP
subtitle: Using regression tests
minutes: 20
---
> ## Learning Objectives {.objectives}
>
> * Be able to create and run test files
> * Understand how test discrepancies and runtime regressions
>   could be identified and interpreted
> * Understand how to adjust tests to check randomised algorithms
> * Learn the "Make it right, then make it fast" concept

The code of `AvgOrdOfGroup` is very simple and possibly nothing could go wrong
with it. It avoids problems with running out of memory because of iterating
over the group instead of creating a list of its elements
(calling `AsList(SymmetricGroup(11))` already results in exceeding the permitted
memory), however it takes several minutes to calculate an average order of an
element of `SymmetricGroup(11)`. But at least we are confident that it is
correct.

Now we would like to write a better version of this function using some
theoretical facts we know from the Group Theory. We may put
`avgorg.g` under version control to revert changes if need be;
we may create a new function to keep the old one around and compare the
results of both; but this could be made even more efficient if we will
use **regression testing**: this is the term for the testing based on
rerunning previously completed tests to check that new changes do not
impact their correctness or worsen their performance.

To start with, we need to create a **test file**. The test file looks
exactly like the GAP session, so it is easy to create it by copying and
pasting the GAP session with all GAP prompts, inputs and outputs into a
text file (a test file could be also created from the log file with a
GAP session recorded with the help of `LogTo`). During the test, GAP will
run all inputs from the test, compare the outputs with those in the test
file and will report any differences.

GAP test files are just text files, but the common practice is to name
them with the extension `.tst`. Now create in the current directory (to
avoid typing the full path), the file `avgord.tst` with the following content:

~~~ {.gap}
# tests for average order of a group element

# permutation Group
gap> S:=SymmetricGroup(9);
Sym( [ 1 .. 9 ] )
gap> AvgOrdOfGroup(S);
3291487/362880
~~~

As you see, the test file may include comments, with certain rules specifying
where they may be placed, because one should be able to distinguish comments
in the test file from GAP output started with `#`. For that purpose,
lines at the beginning of the test file that start with `#`", and one empty line
together with one or more lines starting with `#` are considered as comments.
All other lines are considered as GAP output from the preceding GAP input.

To run the test, one should use the function `Test`, as documented [here](http://www.gap-system.org/Manuals/doc/ref/chap7.html#X87712F9D8732193C).
For example (assuming that the function `AvgOrdOfGroup` is already loaded):

~~~ {.gap}
Test("avgord.tst");
~~~

~~~ {.output}
true
~~~

In this case, `Test` reported no discrepancies and returned `true`, so we
conclude that the test has passed.

We will not cover a topic of writing a good and comprehensive test suite here,
and also will not cover various options of the `Test` function, permitting, for
example, to ignore differences in the output formatting, or to display progress
of the test, as these are described in its documentation.

Instead, we will now add more groups to `avgord.tst`, to demonstrate that the
code also works with other kinds of groups, and to show various ways of
combining commands in the test file:

~~~ {.gap}
# tests for average order of a group element

# permutation group
gap> S:=SymmetricGroup(9);
Sym( [ 1 .. 9 ] )
gap> AvgOrdOfGroup(S);
3291487/362880

# pc group
gap> D:=DihedralGroup(512);
<pc group of size 512 with 9 generators>
gap> AvgOrdOfGroup(D);
44203/512
gap> G:=TrivialGroup();; # suppress output
gap> AvgOrdOfGroup(G);
1

# fp group
gap> F:=FreeGroup("a","b");
<free group on the generators [ a, b ]>
gap> G:=F/ParseRelators(GeneratorsOfGroup(F),"a^8=b^2=1, b^-1ab=a^-1");
<fp group on the generators [ a, b ]>
gap> AvgOrdOfGroup(G);
59/16

# finite matrix group over integers

# matrix group over a finite field
gap> AvgOrdOfGroup(SL(2,5));
221/40
~~~

Let us test the extended version of the test again and check that it works:

~~~ {.gap}
Test("avgord.tst");
~~~

~~~ {.output}
true
~~~

Now we will work on a better implementation. Of course, the order of an element
is an invariant of a conjugacy class of elements of a group, so we need only to
know the orders of conjugacy classes of elements and their representatives. The
following code, being added into `avgord.g`, reads into GAP and returns the answer
without going into an error

~~~ {.gap}
AvgOrdOfGroup := function(G)
local cc, sum, c;
cc:=ConjugacyClasses(G);
sum:=0;
for c in cc do
  sum := sum + Order( Representative(c) ) * Size(cc);
od;
return sum/Size(G);
end;
~~~

but when we run the test, here comes a surprise!

~~~ {.gap}
Read("avgord.g");
Test("avgord.tst");
~~~

~~~ {.output}
########> Diff in avgord.tst, line 6:
# Input is:
AvgOrdOfGroup(S);
# Expected output:
3291487/362880
# But found:
11/672
########
########> Diff in avgord.tst, line 12:
# Input is:
AvgOrdOfGroup(D);
# Expected output:
44203/512
# But found:
2862481/512
########
########> Diff in avgord.tst, line 23:
# Input is:
AvgOrdOfGroup(G);
# Expected output:
59/16
# But found:
189/16
########
########> Diff in avgord.tst, line 29:
# Input is:
AvgOrdOfGroup(SL(2,5));
# Expected output:
221/40
# But found:
69/20
########
false
~~~

Indeed, we made (deliberately) a typo and replaced `Size(c)` by `Size(cc)`.
The correct version of course should look as follows:

~~~ {.gap}
AvgOrdOfGroup := function(G)
local cc, sum, c;
cc:=ConjugacyClasses(G);
sum:=0;
for c in cc do
  sum := sum + Order( Representative(c) ) * Size(c);
od;
return sum/Size(G);
end;
~~~

Now we will fix this in `avgord.g`, and read and test it again to check that
the tests run correctly.

~~~ {.gap}
Read("avgord.g");
Test("avgord.tst");
~~~

~~~ {.output}
true
~~~

Thus, the approach "Make it right, then make it fast" helped to detect a bug
immediately after it has been introduced.
