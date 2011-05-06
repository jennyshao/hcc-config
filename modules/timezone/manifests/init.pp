# Class: timezone
#
# maintains the timezone
#

class timezone {

	file { "timezone":
		ensure => present,
		owner  => "root",
		group  => "root",
		mode   => 644,
		path   => $operatingsystem ? {
			debian  => "/etc/timezone",
			ubuntu  => "/etc/timezone",
			redhat  => "/etc/sysconfig/clock",
			centos  => "/etc/sysconfig/clock",
			suse    => "/etc/sysconfig/clock",
			freebsd => "/etc/timezone-puppet",
		},

		content => $operatingsystem ? {
			default => template("timezone/timezone-${operatingsystem}" ),
		},

		notify => Exec['set-timezone'],
	}

	exec { "set-timezone":
		command => $operatingsystem ? {
			debian  => "dpkg-reconfigure -f noninteractive tzdata",
			ubuntu  => "dpkg-reconfigure -f noninteractive tzdata",
			redhat  => "tzdata-update",
			centos  => "tzdata-update",
			suse    => "FIX ME",
			freebsd => "cp /usr/share/zoneinfo/${timezone} /etc/localtime && adjkerntz -a",
		},

		require => File["timezone"],
		subscribe => File["timezone"],
		refreshonly => true,
	}

}
