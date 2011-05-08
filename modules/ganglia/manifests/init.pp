#
# Class: ganglia
#
# manages ganglia
#
class ganglia {

	package { ganglia-gmond:
			name => "ganglia-gmond", 
			ensure => present,
	}

	service { "gmond":
		name       => "gmond",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => Package["ganglia-gmond"],
		subscribe  => File["gmond.conf"],
	}

	file { "gmond.conf":
		path    => "/etc/ganglia/gmond.conf",
		mode    => 644,
		owner   => "root",
		group   => "root",
		content => template("ganglia/gmond.conf.erb"),
		require => Package[ganglia-gmond],
		ensure  => present,
	}

}
