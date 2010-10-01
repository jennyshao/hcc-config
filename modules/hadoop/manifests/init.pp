
class hadoop {

	file { "/etc/hadoop/hadoop-metrics.properties":
		owner   => "root",
		group   => "root",
		mode    => "644",
		source  => "puppet://red-man.unl.edu/modules/hadoop/hadoop-metrics.properties",
	}

}

