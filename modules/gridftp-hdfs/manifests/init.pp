#
# Class: gridftp-hdfs
#
# TODO: make this generic gridftp? we don't need anything but -hdfs right now
#       could add gridftp::hdfs subclass
#

class gridftp-hdfs {

	include fetch-crl
	include globus

	package { "osg-gridftp-hdfs.x86_64": ensure => present, }
	package { "gratia-probe-gridftp-transfer": ensure => present, }

	service { "gridftp-hdfs":
		name       => "gridftp-hdfs",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		require => Package["osg-gridftp-hdfs.x86_64"],
	}

	file { "gridftp-transfer-ProbeConfig":
		path    => "/etc/gratia/gridftp-transfer/ProbeConfig",
		owner   => "root", group => "root", mode => 644,
		content => template("gridftp-hdfs/ProbeConfig.erb"),
		require => Package["gratia-probe-gridftp-transfer"],
	}


#	cron { "gridftp-killer":
#		ensure  => present,
#		command => "/root/gridftp_killer.py",
#		user    => root,
#		minute  => 0,
#	}

#	cron { "gridftp-cleaner":
#		ensure  => present,
#		command => "find /tmp -iname \"gridftp-hdfs-buffer-*\" -type f -mtime +2 -exec rm -f {} \;",
#		user    => root,
#		minute  => 20,
#	}

}

