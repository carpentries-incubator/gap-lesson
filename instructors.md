---
layout: page
title: Programming with GAP
subtitle: Instructor's Guide
---
## Overall

* For the first lesson, good to have access to Windows (VM or remote desktop) to
demonstrate some Windows-specific aspects of working with GAP.

* Before start, check that everyone has installed GAP and knows how to start it.
Also remind that it's not advised to install in in the path with spaces, e.g. in
"My Documents".

* Help to adjust terminal settings, especially show to Windows users that they
can permanently change colours and fonts in mintty shell (the one started with
`gap.bat`).

* Explain how to copy and paste input and output (especially on Windows).

* Explain how to read lesson pages: GAP input is types without GAP prompt.
GAP output is ion blue colour. Errors are displayed in red. GAP promts is
not displayed, unless this is really necessary (e.g. to demonstrate how the
multi-line input works).

## [First session with GAP](01-command-line.html)

* Emphasize that the banner contains version info useful for citing GAP or
reporting bugs.

* A second call to `LogTo("logfile");` will not open the new file but will report
that GAP is already logging to another file. In this case, either ignore it if
you would like to continue logging to the file already in use, or call `LogTo();`
to close the current log file and then call `LogTo` with an argument to start
logging to a new file.

* Discuss why it's a bad practice to Google for the GAP manual instead of
using the GAP help system.

* Be aware that help selection screen will look differently if **Browse**
package is not compiled.

* Explain how to switch to view HTML version of the Manual with MathJax support.

* Give a hint that the sitemap on the [GAP website](http://www.gap-system.org)
shows the [Search the GAP web site](http://www.gap-system.org/search.html) page
which allows some specific search requests.

* Help to call `WriteGapIniFile` and customise GAP e.g. to use browser as a
viewer.

* Use Etherpad to vote for approaches to calculate the average order of a list.
After that discuss situations when each of them may be more preferable than others.

* Emphasize that organising complex objects into nested records may
be more efficient than nested lists.

* Beware that `w:="supercalifragilisticexpialidocious"; IsSubset(w,'s');`
results in a no-method-found error. This may be a good moment to introduce
this special kind of error messages.

1.  Solution of the challenge: `r:=c[1]; for i in [2..Length(c)] do if c[i][2]>r[2] then r:=c[i]; fi; od; r;`


## [Some more GAP objects](02-some-objects.html)


## [Functions in GAP](03-func.html)

* Spend some time on the structure of the GAP function: keywords `function`,
`local`, `return`, `end`, and other language constructions exposed there.

* Tell how to explore the break loop while showing an example of an error
message.


## [Using regression tests](04-testing.html)


## [Small groups search](05-small-groups.html)

* Live coding is preferred way to teach how to develop most of the functions
from this lesson.


## [Attributes and Methods](06-attributes.html)

1.  Ideas for the challenge: try `k:=1` and then `k:=k+1;n:=2^k;AvgOrdOfCollection(DihedralGroup(n));time;AvgOrdOfGroup(DihedralGroup(n));time;`.
Even for `k=20`, the 1st function takes about 15s and the 2nd - about 115s on a MacBook Pro.
