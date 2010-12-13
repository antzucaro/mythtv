#!/usr/bin/perl

use POSIX qw/strftime/;

# This is the file into which we will store the
# UTC wakeup time
my $alarm_file = "/proc/acpi/alarm";

# When the computer should wake back up (in local epoch time)
my $wake_time = $ARGV[0];
print "Wakeup time passed by MythTV: $wake_time \n";

my $diff = $wake_time - time();

# If wake up time is <= 5 mins or negative, we aren't going to sleep
if (($diff <= 300) || ($diff < 0)) {
     print "Wakeup in $diff seconds is too soon. Exiting. \n";
     exit 1;
}

my $local_wake_time = strftime("%F %T", localtime($wake_time));
print "Local wakeup time: $local_wake_time \n";

my $utc_wake_time = strftime("%F %T", gmtime($wake_time));
print "UTC wakeup time: $utc_wake_time \n";

`echo $utc_wake_time > $alarm_file`;

exit 0;
