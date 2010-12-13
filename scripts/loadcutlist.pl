#!/usr/bin/perl

use strict;
use warnings;

sub usage
{
   print "Syntax:\n";
   print "   loadcutlist.pl <MPG> [...<MPG>]\n\n";
   print "Where:\n";
   print "   MPG = a MythTV MPEG2 filename\n\n";
}

usage() if $#ARGV < 0;
   
for(my $count = 0; $count <= $#ARGV; $count++)
{
   next unless $ARGV[$count] =~ /(\d{4})_(\d{14})\.mpg/i;
   my $command = "mythcommflag -c $1 -s $2 --gencutlist";
   system($command);
}
