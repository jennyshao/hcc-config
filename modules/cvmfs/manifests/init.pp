#
# Class: cvmfs
#
# manages install and configuration of CVMFS
#
class cvmfs {

   include cvmfs::params

	package { "cvmfs":
		name => "${cvmfs::params::cvmfs_package_name}",
		ensure => present,
	}

	# we run cvmfs as a dedicated user
	group { "cvmfs":
		name => "${cvmfs::params::cvmfs_group}",
		ensure => present,
		system => true,
	}

	user { "cvmfs":
		name => "${cvmfs::params::cvmfs_user}",
		ensure => present,
		system => true,
		gid => "${cvmfs::params::cvmfs_group}",
      groups => ["${cvmfs::params::cvmfs_group}", "fuse"],
		managehome => false,
		shell => '/sbin/nologin',
	}

	file { "default.local":
		path    => "${cvmfs::params::cvmfs_config_file}",
		mode    => "0644",
		owner   => "root",
		group   => "root",
		content => "puppet:///modules/cvmfs/default.local",
		require => Package["cvmfs"],
		ensure  => present,
	}

	service { "cvmfs":
		name       => "${cvmfs::params::cvmfs_service_name}",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => File["${cvmfs::params::cvmfs_config_file}"],
		subscribe  => File["${cvmfs::params::cvmfs_config_file}"],
	}

}

