#
# Class: sssd
#

class sssd {

	package { "sssd": ensure => present, }

	service { "sssd":
		name => "sssd",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["sssd"],
		subscribe => File["sssd.conf"],
	}

	file { "sssd.conf":
		path    => "/etc/sssd/sssd.conf",
		owner   => "root", group => "root", mode => 600,
		require => Package["sssd"],
		content => template("sssd/sssd.conf.erb"),
	}

	# certs for HCC ldap servers
	# without this sss can id, but not auth
	file { "hcc-ldap.crt":
		path    => "/etc/pki/tls/certs/hcc-ldap.crt",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/sssd/hcc-ldap.crt",
	}

}

