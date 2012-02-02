#
# Class: tester
#

class tester {

	group { "xrootd":
		name => "xrootd",
		ensure => present,
		gid => 108,
	}

	user { "xrootd":
		name => "xrootd",
		ensure => present,
		uid => 108,
		gid => "xrootd",
		managehome => false,
		shell => "/sbin/nologin",
	}

}
