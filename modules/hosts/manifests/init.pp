
class hosts {

	file { "/etc/hosts":
		owner  => "root",
		group  => "root",
		mode   => 644,
		source => "puppet://red-man.unl.edu/modules/hosts/hosts",
		ensure => present,
	}

}
