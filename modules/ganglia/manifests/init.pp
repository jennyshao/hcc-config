#
# Class: ganglia
#
# manages ganglia
#
class ganglia {

	package { ganglia-gmond:
		name   => "ganglia-gmond", 
		ensure => latest,
	}

	package { ganglia-gmond-modules-python:
		name   => "ganglia-gmond-modules-python",
		ensure => latest,
	}


	group { "ganglia":
		name => "ganglia",
		ensure => present,
	}

	user { "ganglia":
		name => "ganglia",
		ensure => present,
		system => true,
		gid => "ganglia",
		managehome => false,
		shell => "/sbin/nologin",
	}


	service { "gmond":
		name       => "gmond",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [ Package["ganglia-gmond"], User["ganglia"], ],
		subscribe  => File["gmond.conf"],
	}


	file { "gmond.conf":
		path    => "/etc/ganglia/gmond.conf",
		mode    => 644,
		owner   => "root",
		group   => "root",
		content => template("ganglia/gmond.conf.erb"),
		require => [ Package[ganglia-gmond], User["ganglia"], ],
		ensure  => present,
	}

}
