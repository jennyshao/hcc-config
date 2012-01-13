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
		require => Package["cvmfs"],
		managehome => false,
		shell => '/sbin/nologin',
	}

## Files for talking to UW's CVMFS.
##
   file { "wisc_pubkey":
      path    => "/etc/cvmfs/keys/cms.hep.wisc.edu.pub",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/cvmfs/cms.hep.wisc.edu.pub",
      ensure  => present,
   }

   file { "wisc_conf":
      path    => "/etc/cvmfs/config.d/cms.hep.wisc.edu.conf",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/cvmfs/cms.hep.wisc.edu.conf",
      ensure  => present,
   }

	file { "default.local":
		path    => "${cvmfs::params::cvmfs_config_file}",
		mode    => "0644",
		owner   => "root",
		group   => "root",
		source  => "puppet:///modules/cvmfs/default.local",
		require => Package["cvmfs"],
		ensure  => present,
	}

## Files for making CMS CVMFS work.
##
   file { "SITECONF_dir":
      path    => "/etc/cvmfs/SITECONF",
      mode    => "0644", owner => "root", group => "root",
      recurse => true,
      ensure  => directory,
   }

   file { "JobConfig_dir":
      path    => "/etc/cvmfs/SITECONF/JobConfig",
      mode    => "0644", owner => "root", group => "root",
      recurse => true,
      ensure  => directory,
      require => File["SITECONF_dir"],
   }

   file { "site-local-config.xml":
      path    => "/etc/cvmfs/SITECONF/JobConfig/site-local-config.xml",
      source  => "puppet:///modules/cvmfs/site-local-config.xml",
      mode    => "0644", owner => "root", group => "root",
      ensure  => present,
      require => File["JobConfig_dir"],
   }

## Use FNAL stratum one
##
   file { "FNAL_stratum_one":
      path    => "/etc/cvmfs/domain.d/cern.ch.local",
      source  => "puppet:///modules/cvmfs/cern.ch.local",
      mode    => "0644", owner => "root", group => "root",
      ensure  => present,
   }

   file { "fuse.conf":
      path    => "/etc/fuse.conf",
      mode    => "0644",
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/cvmfs/fuse.conf",
      ensure  => present,
   }

   file { "cvmfs_cache":
      path    => "/var/cache/cvmfs2",
      ensure  => directory,
      owner   => "cvmfs",
      group   => "cvmfs",
      mode    => 0700,
      require => [User["cvmfs"], Group["cvmfs"], Package["cvmfs"]],
   }

	service { "cvmfs":
		name       => "${cvmfs::params::cvmfs_service_name}",
		ensure     => running,
		enable     => true,
		hasrestart => true,
		hasstatus  => true,
		require    => [Package["cvmfs"], File["default.local"], File["fuse.conf"], File["cvmfs_cache"]],
		subscribe  => File["${cvmfs::params::cvmfs_config_file}"],
	}

}

