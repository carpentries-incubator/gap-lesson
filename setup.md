---
layout: page
title: Setup
permalink: /setup/
---

## Windows

From the [GAP Downloads page](http://www.gap-system.org/Releases/),
download the `.exe` installer and double click on the file to run it.
When you will be asked for the installation path, note that it should
not contain spaces. For example, you may install GAP in `C:\gap4r8`
(default), `D:\gap4r8p4` or `C:\Math\GAP\gap4r8`, but you must not
install it in a directory named like `C:\Program files\gap4r8` or
`C:\Users\alice\My Documents\gap4r8` etc.

## OS X

On OS X, you need to install GAP from source as explained
at the [GAP Downloads page](http://www.gap-system.org/Releases/).
Download one of the archives provided there, unpack it and run
`./configure; make` in the unpacked directory. Then change to the
`pkg` subdirectory and call `../bin/BuildPackages.sh` to run the
script which will build most of the packages that require compilation
(provided sufficiently many libraries, headers and tools are available).

## Linux

On Linux, you need to install GAP from source as explained at the
[GAP Downloads page](http://www.gap-system.org/Releases/).
Download one of the archives provided there, unpack it and run
`./configure; make` in the unpacked directory. Then change to the
`pkg` subdirectory and call `../bin/BuildPackages.sh` to run the
script which will build most of the packages that require compilation
(provided sufficiently many libraries, headers and tools are available).
