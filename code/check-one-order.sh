#!/bin/sh

gap -r -b -q avgord.g << EOI
TestOneOrderEasy( $1 );
quit;
EOI
