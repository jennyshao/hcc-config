
class autofs {

	package { autofs: ensure => latest }
	package { autofs: ensure => running }

	file { "/etc/auto.t3":
		owner    => "root",
		group    => "root",
		mode     => 644,
		source   => "puppet:///modules/autofs/auto.t3",
		requires => Package["autofs"],
	}

	file { "/etc/auto.master":
		owner    => "root",
		group    => "root",
		mode     => 644,
#		source   => "puppet:///modules/autofs/auto.master",
		content  => template("autofs/auto.master.erb"),
		requires => Package["autofs"],
	}
}

