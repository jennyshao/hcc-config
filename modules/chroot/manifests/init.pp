
#
# Class: chroot
#
# manages install and chroots
#

class chroot {

   include chroot::params

## Base directory
##
   file { "/chroot":
      path   => "${chroot::params::chroot_top}",
      mode   => "0644", owner => "root", group => "root",
      ensure => directory,
   }

   file { "chroot_dir_base":
      path    => "${chroot::params::chroot_base}",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["/chroot"]],
   }

   file { "chroot_dir":
      path    => "${chroot::params::chroot_root}",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => File["chroot_dir_base"],
   }

## resolv.conf
##
   file { "etc_dir":
      path    => "${chroot::params::chroot_root}/etc",
      mode => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   file { "chroot_resolv.conf":
      path    => "${chroot::params::chroot_root}/etc/resolv.conf",
      mode    => "0644", owner => "root", group => "root",
      ensure  => file,
      seltype => "net_conf_t",
      require => File["etc_dir"],
   }

   mount { "chroot_mount_resolv.conf":
      name     => "${chroot::params::chroot_root}/etc/resolv.conf",
      device   => "/etc/resolv.conf",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_resolv.conf"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## Password/group files
##

   file { "chroot_passwd":
      path    => "${chroot::params::chroot_root}/etc/passwd",
      mode    => "0644", owner => "root", group => "root",
      ensure  => file,
      seltype => "etc_t",
      require => File["etc_dir"],
   }

   mount { "chroot_mount_passwd":
      name     => "${chroot::params::chroot_root}/etc/passwd",
      device   => "/etc/passwd",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_passwd"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_group":
      path    => "${chroot::params::chroot_root}/etc/group",
      mode    => "0644", owner => "root", group => "root",
      ensure  => file,
      seltype => "etc_t",
      require => File["etc_dir"],
   }

   mount { "chroot_mount_group":
      name     => "${chroot::params::chroot_root}/etc/group",
      device   => "/etc/group",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_group"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## System directories
##
   file { "chroot_tmp":
      path    => "${chroot::params::chroot_root}/tmp",
      mode    => "1777", owner => "root", group => "root",
      seltype => "tmp_t",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_tmp":
      name     => "${chroot::params::chroot_root}/tmp",
      device   => "/tmp",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_tmp"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_var":
      path    => "${chroot::params::chroot_root}/var",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   file { "chroot_var_tmp":
      path    => "${chroot::params::chroot_root}/var/tmp",
      mode    => "1777", owner => "root", group => "root",
      ensure  => directory,
      require => File["chroot_var"],
   }  
      
   mount { "chroot_mount_var_tmp":
      name     => "${chroot::params::chroot_root}/var/tmp",
      device   => "/var/tmp",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_var_tmp"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }  

   file { "chroot_proc":
      path    => "${chroot::params::chroot_root}/proc",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_proc":
      name     => "${chroot::params::chroot_root}/proc",
      device   => "proc",
      ensure   => mounted,
      options  => "defaults",
      require  => [Exec["mock_cmd"], File["chroot_proc"]],
      fstype   => "proc",
      atboot   => true,
      remounts => true,
   }

   file { "chroot_dev":
      path    => "${chroot::params::chroot_root}/dev",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_dev":
      name     => "${chroot::params::chroot_root}/dev",
      device   => "/dev",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_dev"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_sys":
      path    => "${chroot::params::chroot_root}/sys",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["mock_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_sys":
      name     => "${chroot::params::chroot_root}/sys",
      device   => "/sys",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_sys"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## Home
## Home is managed by autofs, so no bind mount.
##
   file { "chroot_home":
      path    => "${chroot::params::chroot_root}/home",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => Exec["mock_cmd"],
      notify  => Service["autofs"],
   }  

## SSSD
##
   file { "chroot_var_lib":
      path    => "${chroot::params::chroot_root}/var/lib",
      mode    => "0644", owner => "root", group => "root",
      require => File["chroot_var"],
      ensure  => directory,
   }  
      
   file { "chroot_sss":
      path    => "${chroot::params::chroot_root}/var/lib/sss",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => File["chroot_var_lib"],
   }

   file { "chroot_sss_pipes":
      path    => "${chroot::params::chroot_root}/var/lib/sss/pipes",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => File["chroot_sss"],
   }

   file { "chroot_sss_nss":
      path    => "${chroot::params::chroot_root}/var/lib/sss/pipes/nss",
      mode    => "0666", owner => "root", group => "root",
      seluser => "unconfined_u",
      seltype => "sssd_var_lib_t",
      ensure  => present, # No ensure=>file, as it is a socket
      require => File["chroot_sss_pipes"],
   }

   #mount { "chroot_mount_sss":
   #   name     => "${chroot::params::chroot_root}/var/lib/sss",
   #   device   => "/var/lib/sss",
   #   ensure   => mounted,
   #   options  => "bind",
   #   require  => [Exec["mock_cmd"], File["chroot_sss"]],
   #   fstype   => none,
   #   atboot   => true,
   #   remounts => true,
   #}

   mount { "chroot_mount_sss_nss":
      name     => "${chroot::params::chroot_root}/var/lib/sss/pipes/nss",
      device   => "/var/lib/sss/pipes/nss",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_sss_nss"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_nsswitch":
      path    => "${chroot::params::chroot_root}/etc/nsswitch.conf",
      mode    => "0644", owner => "root", group => "root",
      seltype => "etc_t",
      ensure  => file,
      require => File["etc_dir"],
   }

   mount { "chroot_mount_nsswitch":
      name     => "${chroot::params::chroot_root}/etc/nsswitch.conf",
      device   => "/etc/nsswitch.conf",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["mock_cmd"], File["chroot_nsswitch"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## Customize lcmaps.db
##
   file { "lcmaps.db":
      name    => "${chroot::params::chroot_root}/etc/lcmaps.db",
      require => Exec["mock_cmd"],
      ensure  => present,
      mode    => "0600", owner => "root", group => "root",
      content => template("globus/lcmaps.db.erb"),
   }

## Mirror the Condor job wrapper
##
   file { "chroot_condor_job_wrapper":
      path    => "${chroot::params::chroot_root}/usr/local/bin/condor_nfslite_job_wrapper.sh",
      mode    => "0755", owner => "root", group => "root",
      ensure  => file,
      require => Exec["mock_cmd"],
      source  => "puppet:///modules/condor/condor_nfslite_job_wrapper.sh",
   }  
   
## Finally, the mock invocation
## 
   package { "mock":
		name    => "mock",
		ensure  => present,
   }

   file { "mock_cfg":
      name     => "/etc/mock/mock-local.cfg",
      mode     => "0644", owner => "root", group => "root",
      ensure   => present,
      content  => template("chroot/mock-local.cfg.erb"),
      require  => Package["mock"],
   }

	user { "chroot_creator":
		name => "${chroot::params::chroot_user}",
		ensure => present,
		system => true,
      groups => ["mock"],
		require => Package["mock"],
		managehome => false,
		shell => '/sbin/nologin',
	}

   exec { "mock_cmd":
      name     => "/usr/bin/mock -r mock-local --init && touch ${chroot::params::chroot_root}/builddir/mock_successful",
      require  => [User["chroot_creator"], File["mock_cfg"]],
      #creates  => "${chroot::params::chroot_root}/builddir/mock_successful",
      onlyif   => ["test ! -d ${chroot::params::chroot_base}", "test ! -d ${chroot::params::chroot_base}.tmp",
                   "test ! -f ${chroot::params::chroot_root}/builddir/mock_successful", "test ! -f ${chroot::params::chroot_base}/buildroot.lock"],
      user     => "chroot_creator",
      group    => "mock",
      provider => "shell",
      cwd      => "/",
      logoutput => "on_failure",
   }

}

