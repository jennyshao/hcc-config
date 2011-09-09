#
# Class: bestman
#

class xrootd {

	package { "bestman2":
		ensure => present,
	}

	service { "bestman2":
		name => "bestman2",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["bestman2"],
		subscribe => File["bestman2.rc"],
	}

	file { "bestman2.rc":
		path    => "/opt/bestman2/conf/bestman2.rc",
		owner   => "root", group => "root", mode => 644,
		require => Package["bestman2"],
		content => template("bestman/bestman2.rc.erb"),
	}

 ### certs

}

