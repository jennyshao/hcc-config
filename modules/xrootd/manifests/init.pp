#
# Class: xrootd
#

class xrootd {

	package { "xrootd-server":
		name   => "xrootd-server",
		ensure => present,
	}

	file { "xrootd.cf":
		path    => "/etc/xrootd/xrootd.cf",
		owner   => "root", group => "root", mode => 644,
		require => Package["xrootd-server"],
		content => template("xrootd/xrootd.cf.erb"),
	}

}

