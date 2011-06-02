#
# Class: sudo
#

class sudo {

	package { sudo: ensure => present }

	file { "/etc/sudoers":
		owner   => "root", group => "root", mode => 0440,
		source  => "puppet://red-man.unl.edu/modules/sudo/sudoers",
		require => Package["sudo"],
	}

}
