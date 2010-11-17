# Class: fetch-crl
#
# This class maintains /etc/fetch-crl.conf
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#


class fetch-crl {

	$squidServer = ['red-squid1.unl.edu']

	package { fetch-crl: ensure => latest }

	file { "/etc/fetch-crl.conf":
		owner  => "root",
		group  => "root",
		mode   => 644,
		content => template("fetch-crl/fetch-crl.conf.erb"),
		ensure => present,
		require => Package["fetch-crl"],
	}

	service { "fetch-crl-boot":
		enable => true,
		require => Package["fetch-crl"],
	}

	service { "fetch-crl-cron":
		enable => true,
		require => Package["fetch-crl"],
	}

} # class fetch-crl
