
class condor {

#	package { condor: ensure => latest }

#	file { "/opt/condor/etc/condor/condor_config":
#		owner   => "root",
#		group   => "root",
#		mode    => 644,
#		source  => "puppet://red-man.unl.edu/modules/condor/condor_config",
#	}

#	file { "/opt/condor/etc/condor/condor_config.local":
#		owner   => "root",
#		group   => "root",
#		mode    => 644,
#		source  => "puppet://red-man.unl.edu/modules/condor/condor_config.local",
#	}

	file { "/opt/condor/etc/condor/condor_test.conf":
		owner   => "root",
		group   => "root",
		mode    => 644,
		content => template("condor/condor_test.erb"),
	}
}

