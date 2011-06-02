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

	service { "xinetd":
		name       => "xinetd",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		require => Package["gridftp-hdfs"],
	}

	file { "gridftp-hdfs":
		path    => "/etc/xinetd.d/gridftp-hdfs",
		owner   => "root", group => "root", mode => 644,
		require => Package["gridftp-hdfs"],
		source  => "puppet://red-man.unl.edu/gridftp-hdfs/gridftp-hdfs",
	}

	file { "gridftp-transfer-ProbeConfig":
		path    => "/opt/vdt/gratia/probe/gridftp-transfer/ProbeConfig",
		owner   => "root", group => "root", mode => 600,
		require => Package["gridftp-hdfs"],
		content => template("gridftp-hdfs/ProbeConfig.erb"),
	}

}

