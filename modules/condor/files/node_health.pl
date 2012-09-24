#!/usr/bin/perl

$out = `/usr/lib64/nagios/plugins/check_mountpoints`;
if($out =~ "not" ) 
	{print "MOUNTS_OK = FALSE\n";}
else
	{print "MOUNTS_OK = TRUE\n";}

