---
layout: page
title: Programming with GAP
subtitle: Instructor's Guide
---
## Overall

* For the first lesson, good to have access to Windows (VM or remote desktop) to
demonstrate some Windows-specific aspects of working with GAP.

* Before start, check that everyone has installed GAP and knows how to start it.

* Help to adjust terminal settings, especially show to Windows users that they
can permanently change colours and fonts in mintty shell (the one started with
`gap.bat`).

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

* Give a hint that the sitemap on the [GAP website](http://www.gap-system.org)
shows the [Search the GAP web site](http://www.gap-system.org/search.html) page
which allows some specific search requests.

1.  Discussion of first challenge.

2.  Discussion of second challenge.

## [Functions in GAP](02-func.html)

* Do not use paths with spaces

* Point

1.  Discussion of first challenge.

2.  Discussion of second challenge.

## [Using regression tests](03-testing.html)

## [Small groups search](04-small-groups.html)

* Live coding is preferred way to teach how to develop most of the functions
from this lesson.

## [Attributes and Methods](05-attributes.html)
