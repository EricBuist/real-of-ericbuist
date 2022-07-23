#!/usr/bin/perl

$blankFound=0;

while (<>) {
    if ($blankFound) {
        print;
    }
    elsif (/^$/) {
        $blankFound=1;
    }
}
