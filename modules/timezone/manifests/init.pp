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
			Debian  => "/etc/timezone",
			Ubuntu  => "/etc/timezone",
			RedHat  => "/etc/sysconfig/clock",
			CentOS  => "/etc/sysconfig/clock",
			SuSE    => "/etc/sysconfig/clock",
			FreeBSD => "/etc/timezone-puppet",
		},

		content => $operatingsystem ? {
			default => template("timezone/timezone-${operatingsystem}" ),
		},

		notify => Exec['set-timezone'],
	}

	exec { "set-timezone":
		command => $operatingsystem ? {
			Debian  => "dpkg-reconfigure -f noninteractive tzdata",
			Ubuntu  => "dpkg-reconfigure -f noninteractive tzdata",
			RedHat  => "tzdata-update",
			CentOS  => "tzdata-update",
			SuSE    => "FIX ME",
			FreeBSD => "cp /usr/share/zoneinfo/${timezone} /etc/localtime && adjkerntz -a",
		},

		require => File["timezone"],
		subscribe => File["timezone"],
		refreshonly => true,
	}

}
