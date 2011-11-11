#
# Class: gridftp-hdfs
#
# TODO: make this generic gridftp? we don't need anything but -hdfs right now
#       could add gridftp::hdfs subclass
#

class gridftp-hdfs {

	include fetch-crl
	include globus
	include hadoop

	package { "osg-gridftp-hdfs.x86_64": ensure => present, }
	package { "gratia-probe-gridftp-transfer": ensure => present, }
	package { "sysklogd": ensure => present, }

	service { "gridftp-hdfs":
		name       => "gridftp-hdfs",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		require    => [ Package["osg-gridftp-hdfs.x86_64"], Class["hadoop"], ],
		subscribe  => File["gridftp.conf"],
	}

	service { "syslog":
		name       => "syslog",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		subscribe  => File["gridftp-syslog.conf"],
	}

	file { "gridftp-syslog.conf":
		path    => "/etc/syslog.conf",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/gridftp-hdfs/gridftp-syslog.conf",
		require => Package["sysklogd"],
	}

	file { "gridftp-transfer-ProbeConfig":
		path    => "/etc/gratia/gridftp-transfer/ProbeConfig",
		owner   => "root", group => "root", mode => 644,
		content => template("gridftp-hdfs/ProbeConfig.erb"),
		require => Package["gratia-probe-gridftp-transfer"],
	}

	file { "gridftp.conf":
		path    => "/etc/gridftp-hdfs/gridftp.conf",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/gridftp-hdfs/gridftp.conf",
		require => Package["osg-gridftp-hdfs.x86_64"],
	}

	file { "gridftp_killer.py":
		path    => "/root/gridftp_killer.py",
		owner   => "root", group => "root", mode => 744,
		source  => "puppet:///modules/gridftp-hdfs/gridftp_killer.py",
	}

	# runs gridftp_killer.py which should kill transfers over 12 hours old
	cron { "gridftp_killer":
		ensure  => present,
		command => "/root/gridftp_killer.py",
		user    => root,
		minute  => 0,
	}

	# removes stale buffers after 14 hours on disk
	cron { "gridftp-cleaner":
		ensure  => present,
		command => "find /tmp -iname \"gridftp-hdfs-buffer-*\" -type f -mmin +840 -exec rm -f {} \\;",
		user    => root,
		minute  => 20,
	}

}

