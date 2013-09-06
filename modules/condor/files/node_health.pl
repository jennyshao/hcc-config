#!/usr/bin/perl -w

my $probe_status;
my $status = TRUE;
@files = </etc/condor/node_tests.d/*>;
foreach $file (@files) {
    $probe_status = `$file`;
    if ($probe_status =~ "FALSE") {$status = FALSE;}
}
print "MOUNTS_OK = $status \n";
