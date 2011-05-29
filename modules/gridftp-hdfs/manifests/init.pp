#
# Class: gridftp-hdfs
#
# TODO: make this generic gridftp? we don't need anything but -hdfs right now
#       could add gridftp::hdfs subclass
#

class gridftp-hdfs {

	package { "gridftp-hdfs":
		name   => "gridftp-hdfs",
		ensure => present,
	}


	file { "gridftp-hdfs":
		path    => "/etc/xinetd.d/gridftp-hdfs",
		owner   => "root", group => "root", mode => 644,
		require => Package["gridftp-hdfs"],
		source  => "puppet://red-man.unl.edu/gridftp-hdfs/gridftp-hdfs",
	}

}

