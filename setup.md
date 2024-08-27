---
title: Setup
permalink: /setup/
---

## Windows

From the [GAP Downloads page](https://www.gap-system.org/Releases/),
download the `.exe` installer and double click on the file to run it.
When you are asked for the installation path, note that it should
not contain spaces. For example, you may install GAP 4.X.Y in `C:\gap-4.X.Y`
(default), `D:\gap-4.X.Y` or `C:\Math\GAP\gap-4.X.Y`, but you must not
install it in a directory such as `C:\Program Files\gap-4.X.Y` or
`C:\Users\alice\My Documents\gap-4.X.Y`.

## macOS

On macOS, you need to install GAP from source as explained
at the [GAP Downloads page](https://www.gap-system.org/Releases/).
Download one of the archives provided there, unpack it and run
`./configure && make` in the unpacked directory. Then change to the
`pkg` subdirectory and call `../bin/BuildPackages.sh` to run the
script which will build most of the packages that require compilation
(provided sufficiently many libraries, headers and tools are available).

Alternatively, you may also install GAP using [Homebrew](https://brew.sh/).
After installing Homebrew, follow the instructions for the
[GAP Homebrew tap](https://github.com/gap-system/homebrew-gap).

## Linux

On Linux, you need to install GAP from source as explained at the
[GAP Downloads page](https://www.gap-system.org/Releases/).
Download one of the archives provided there, unpack it and run
`./configure && make` in the unpacked directory. Then change to the
`pkg` subdirectory and call `../bin/BuildPackages.sh` to run the
script which will build most of the packages that require compilation
(provided sufficiently many libraries, headers and tools are available).


