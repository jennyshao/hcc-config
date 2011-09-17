#
# Class: sudo
#

class sudo {

	package { sudo: ensure => present }

	file { "/etc/sudoers":
		owner   => "root", group => "root", mode => 0440,
		content => template("sudo/sudoers.erb"),
		require => Package["sudo"],
	}

	file { "/etc/sudoers.d":
		ensure => directory,
		owner  => "root", group => "root", mode => 0755,
	}

}
