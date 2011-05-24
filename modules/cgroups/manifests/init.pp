#
# Class: cgroups
#
# Manages cgroup configs
#

class cgroups {

	service { "cgconfig":
		name       => "cgconfig",
		ensure     => running,
		before     => Service["cgred"],
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
	}

	service { "cgred":
		name       => "cgred",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
	}

	file { "cgconfig.conf":
		path    => "/etc/cgconfig.conf",
		ensure  => present,
		owner   => "root", group => "root", mode => 644,
		notify  => [ Service["cgconfig"], Service["cgred"] ],
		content => template("cgroups/cgconfig.conf.erb"),
	}

	file { "cgrules.conf":
		path    => "/etc/cgrules.conf",
		ensure  => present,
		owner   => "root", group => "root", mode => 644,
		notify  => [ Service["cgconfig"], Service["cgred"] ],
		content => template("cgroups/cgrules.conf.erb"),
	}

}
