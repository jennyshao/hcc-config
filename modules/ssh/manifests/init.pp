#
# Class: ssh
#
class ssh {

	package { "openssh-server":
		name   => "openssh-server",
		ensure => "present",
	}

	service { "sshd":
		name       => "sshd",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => Package["openssh-server"],
		subscribe  => File["sshd_config"],
	}

	file { "sshd_config":
		path    => "/etc/ssh/sshd_config",
		owner   => "root", group => "root", mode => 0600,
		ensure  => present,
		require => Package["openssh-server"],
		notify  => Service["sshd"],
		content => [ template("ssh/sshd_config-$hostname.erb"), template("ssh/sshd_config.erb"), ],
	}

	file { "sshdir":
		path    => "/root/.ssh",
      ensure  => directory,
		owner   => "root", group => "root", mode => 0700,
		recurse => true,
		before  => File["authorized_keys"],
	}

	file { "authorized_keys":
		path    => "/root/.ssh/authorized_keys",
		owner   => "root", group => "root", mode => 0600,
		ensure  => present,
		require => Package["openssh-server"],
		source  => "puppet:///modules/ssh/authorized_keys",
	}


#	augeas { "sshd_config":
#		context => "/files/etc/ssh/sshd_config",
#		changes => [
#			"set PermitRootLogin no",
#		]
#	}

}
