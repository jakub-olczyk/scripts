#!/usr/bin/perl
# author : Jakub Olczyk <jakub.olczyk@openmailbox.org>
# date   : 2015-06-01
# license: GPLv3+

use strict;
use feature 'say';

my @cal_output = split "\n", `cal`;
my @calendar_output = split "\n" , `calendar -A 7`;
my @output;

while(my ($i, $line) = each @cal_output){
	$output[$i] = $line."\t".($calendar_output[$i] // "")
}

local $" = "\n";
say "@output";
