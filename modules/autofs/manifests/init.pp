#
# Class: autofs
#
# manages autofs (master and maps)
#
class autofs {

	package { autofs: name => "autofs", ensure => present }

	service { "autofs":
		name       => "autofs",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => Package["autofs"],
		subscribe  => File["autofs.master"],
	}

	file { "autofs.master":
		path    => "/etc/auto.master",
		mode    => 644,
		owner   => "root",
		group   => "root",
		content => template("autofs/auto.master.erb"),
		require => Package[autofs],
		ensure  => present,
	}

	file { "autofs.red":
		path    => "/etc/auto.red",
		mode    => 644,
		owner   => "root",
		group   => "root",
		content => template("autofs/auto.red.erb"),
		require => Package[autofs],
		notify  => Service[autofs],
		ensure  => present,
	}

}
