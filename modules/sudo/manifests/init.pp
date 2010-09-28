
class sudo {

	package { sudo: ensure => latest }

	file { "/etc/sudoers":
		owner   => "root",
		group   => "root",
		mode    => 440,
		source  => "puppet://red-man.unl.edu/modules/sudo/sudoers",
		require => Package["sudo"],
	}
}

