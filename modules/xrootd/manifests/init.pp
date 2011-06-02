#
# Class: xrootd
#

class xrootd {

	group { "xrootd":
		name => "xrootd",
		ensure => present,
		gid => 108,
	}

	user { "xrootd":
		name => "xrootd",
		ensure => present,
		uid => 108,
		gid => "xrootd",
		managehome => false,
		shell => "/sbin/nologin",
	}

	package { "xrootd-server":
		ensure => present,
		require => [
			User["xrootd"],
			File["/usr/lib64/libjvm.so"],
		]
	}


	package { "xrootd-hdfs":
		ensure => present,
		require => Package["xrootd-server"],
	}

	package { "xrootd-lcmaps":
		ensure => present,
		require => Package["xrootd-server"],
	}

	package { "xrootd-cmstfc":
		require => Package["xrootd-server"],
		ensure => present,
	}

	package { "xrootd-status-probe":
		require => Package["nrpe"],
		ensure => present,
	}

	service { "xrootd":
		name => "xrootd",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["xrootd-server"],
		subscribe => File["xrootd.cf"],
	}

	service { "cmsd":
		name => "cmsd",
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["xrootd-server"],
		subscribe => File["xrootd.cf"],
	}

	# xrootd needs libjvm.so, sun jdk doesn't make the link
	file { "/usr/lib64/libjvm.so":
		ensure => link,
		target => "../java/latest/jre/lib/amd64/server/libjvm.so",
	}

	file { "xrootd.cf":
		path    => "/etc/xrootd/xrootd.cf",
		owner   => "root", group => "root", mode => 644,
		require => Package["xrootd-server"],
		content => template("xrootd/xrootd.cf.erb"),
	}

	file { "storage.xml":
		path    => "/etc/xrootd/storage.xml",
		owner   => "root", group => "root", mode => 644,
		require => Package["xrootd-cmstfc"],
		source  => "puppet://red-man.unl.edu/xrootd/storage.xml",
	}

	file { "lcmaps.cfg":
		path    => "/etc/xrootd/lcmaps.cfg",
		owner   => "root", group => "root", mode => 644,
		require => Package["xrootd-lcmaps"],
		content => template("xrootd/lcmaps.cfg.erb"),
	}


	# xrootd certificates are just a copy of hostcerts owned by xrootd:xrootd
	file { "xrd":
		path => "/etc/grid-security/xrd",
		ensure => directory,
		owner   => "xrootd", group => "xrootd", mode => 0755,
		require => Package["xrootd-server"],
	}

	file { "xrdcert":
		path  => "/etc/grid-security/xrd/xrdcert.pem",
		owner => "xrootd", group => "xrootd", mode => 0644,
		source => "/etc/grid-security/hostcert.pem",
		require => Package["xrootd-server"],
	}

	file { "xrdkey":
		path  => "/etc/grid-security/xrd/xrdkey.pem",
		owner => "xrootd", group => "xrootd", mode => 0400,
		source => "/etc/grid-security/hostkey.pem",
		require => Package["xrootd-server"],
	}

}

