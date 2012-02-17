
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
      require => [Exec["chroot_initial_cmd"], File["/chroot"]],
   }

   file { "chroot_dir":
      path    => "${chroot::params::chroot_root}",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => File["chroot_dir_base"],
   }

## glexec stuff
##
   file { "chroot_glexex_log_dir":
      path    => "${chroot::params::chroot_root}/var/log/glexec",
      mode => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   file { "chroot_glexex_conf":
      path    => "${chroot::params::chroot_root}/etc/glexec.conf",
      mode => "0640", owner => "root", group => "glexec",
      ensure  => file,
      require => [Exec["chroot_grid_cmd"], File["etc_dir"]],
   }

   file { "chroot_glexec_bin":
      path    => "${chroot::params::chroot_root}/usr/sbin/glexec",
      mode => "6755", owner => "root", group => "glexec",
      ensure  => file,
      seltype => "bin_t",
      require => [Exec["chroot_grid_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_grid_security":
      name     => "${chroot::params::chroot_root}/etc/grid-security",
      device   => "/etc/grid-security",
      ensure   => mounted,
      options  => "bind",
      require  => [File["etc_dir"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## resolv.conf
##
   file { "etc_dir":
      path    => "${chroot::params::chroot_root}/etc",
      mode => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
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
      require  => [Exec["chroot_initial_cmd"], File["chroot_resolv.conf"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_hosts":
      path    => "${chroot::params::chroot_root}/etc/hosts",
      mode    => "0644", owner => "root", group => "root",
      ensure  => file,
      seltype => "net_conf_t",
      seluser => "system_u",
      require => File["etc_dir"],
   }

   mount { "chroot_mount_hosts":
      name     => "${chroot::params::chroot_root}/etc/hosts",
      device   => "/etc/hosts",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["chroot_initial_cmd"], File["chroot_hosts"]],
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
      require  => [Exec["chroot_initial_cmd"], File["chroot_passwd"]],
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
      require  => [Exec["chroot_initial_cmd"], File["chroot_group"]],
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
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_tmp":
      name     => "${chroot::params::chroot_root}/tmp",
      device   => "/tmp",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["chroot_initial_cmd"], File["chroot_tmp"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_var":
      path    => "${chroot::params::chroot_root}/var",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
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
      require  => [Exec["chroot_initial_cmd"], File["chroot_var_tmp"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }  

   file { "chroot_proc":
      path    => "${chroot::params::chroot_root}/proc",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_proc":
      name     => "${chroot::params::chroot_root}/proc",
      device   => "proc",
      ensure   => mounted,
      options  => "defaults",
      require  => [Exec["chroot_initial_cmd"], File["chroot_proc"]],
      fstype   => "proc",
      atboot   => true,
      remounts => true,
   }

   file { "chroot_dev":
      path    => "${chroot::params::chroot_root}/dev",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_dev":
      name     => "${chroot::params::chroot_root}/dev",
      device   => "/dev",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["chroot_initial_cmd"], File["chroot_dev"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

   file { "chroot_sys":
      path    => "${chroot::params::chroot_root}/sys",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   mount { "chroot_mount_sys":
      name     => "${chroot::params::chroot_root}/sys",
      device   => "/sys",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["chroot_initial_cmd"], File["chroot_sys"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## Hadoop?  Don't mind if I do!
## 
   file { "chroot_hadoop":
      path    => "${chroot::params::chroot_root}/mnt/hadoop",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   # See comment below on why this is not a bind mount 
   mount { "chroot_mount_hadoop":
      name     => "${chroot::params::chroot_root}/mnt/hadoop",
      device  => "hdfs",
      fstype  => "fuse",
      ensure  => mounted,
      options => "server=hadoop-name,port=9000,rdbuffer=32768,allow_other",
      atboot  => true,
      remounts => false,
      require => [ File["chroot_hadoop"], File["/etc/hadoop-0.20/conf.red/hdfs-site.xml"], File["/usr/bin/hadoop-fuse-dfs"], ],
   }

## OSG_APP, OSG_DATA, oh my!
##
   file { "chroot_opt":
      path    => "${chroot::params::chroot_root}/opt",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_dir"]],
   }

   file { "chroot_opt_osg":
      path    => "${chroot::params::chroot_root}/opt/osg",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [Exec["chroot_initial_cmd"], File["chroot_opt"]],
   }  

   file { "chroot_opt_osg_app":
      path    => "${chroot::params::chroot_root}/opt/osg/app",
#      mode    => "0744", owner => "root", group => "root",
      ensure  => directory,
      require => [File["chroot_opt_osg"]],
   }  
 
   # Bind mounts do not work because puppet will just do the bind mount twice,
   # but ignore the actual NFS server
   mount { "chroot_mount_opt_osg_app":
      name    => "${chroot::params::chroot_root}/opt/osg/app",
      device  => "hcc-gridnfs:/osg/app",
      fstype  => "nfs4",
      ensure  => mounted,
      options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require => [ File["chroot_opt_osg_app"] ],
   }

   file { "chroot_opt_osg_data":
      path    => "${chroot::params::chroot_root}/opt/osg/data",
#      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => [File["chroot_opt_osg"]],
   }  

   # See above comment for why this is not a bind mount      
   mount { "chroot_mount_opt_osg_data":
      name    => "${chroot::params::chroot_root}/opt/osg/data",
      device  => "hcc-gridnfs:/osg/data",
      fstype  => "nfs4",
      ensure  => mounted,
      options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require  => [File["chroot_opt_osg_data"]],
   }  

## Home
## Home is managed by autofs, so no bind mount.
##
   file { "chroot_home":
      path    => "${chroot::params::chroot_root}/home",
      mode    => "0644", owner => "root", group => "root",
      ensure  => directory,
      require => Exec["chroot_initial_cmd"],
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
      seluser => "system_u",
      seltype => "sssd_var_lib_t",
      ensure  => directory,
      require => File["chroot_sss"],
   }

   mount { "chroot_mount_sss_nss":
      name     => "${chroot::params::chroot_root}/var/lib/sss/pipes",
      device   => "/var/lib/sss/pipes",
      ensure   => mounted,
      options  => "bind",
      require  => [Exec["chroot_initial_cmd"], File["chroot_sss_pipes"]],
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
      require  => [Exec["chroot_initial_cmd"], File["chroot_nsswitch"]],
      fstype   => none,
      atboot   => true,
      remounts => true,
   }

## Customize lcmaps.db
##
   file { "chroot_lcmaps.db":
      name    => "${chroot::params::chroot_root}/etc/lcmaps.db",
      require => Exec["chroot_initial_cmd"],
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
      require => Exec["chroot_initial_cmd"],
      source  => "puppet:///modules/condor/condor_nfslite_job_wrapper.sh",
   }  
   
## Finally, the chroot-tool invocation
## 
   package { "chroot_tool":
		name    => "chroot-tool",
		ensure  => present,
   }

   file { "chroot_tool_cfg":
      path     => "/etc/chroot-tool/tool.cfg",
      mode     => "0644", owner => "root", group => "root",
      ensure   => file,
      content  => template("chroot/tool.cfg.erb"),
      require  => Package["chroot_tool"],
   }

   file { "chroot_tool_yum_conf":
      path     => "/etc/chroot-tool/yum.conf",
      mode     => "0644", owner => "root", group => "root",
      ensure   => file,
      content  => template("chroot/yum.conf.erb"),
      require  => Package["chroot_tool"],
   }

   exec { "chroot_initial_cmd":
      name     => "test -d ${chroot::params::chroot_root} ||  chroot-tool create && chroot-tool install acl attr authconfig bc bind-utils bzip2 cyrus-sasl-plain lsof libcgroup quota rhel-instnum cpuspeed dos2unix m2crypto sssd nc prctl redhat-lsb setarch time tree unix2dos unzip wget which zip zlib && chroot-tool secure",
      require  => [File["chroot_tool_cfg"], File["chroot_tool_yum_conf"]],
      provider => "shell",
      cwd      => "/",
      logoutput => "on_failure",
   }

   exec { "chroot_grid_cmd":
      name      => "test -f ${chroot::params::chroot_root}/usr/sbin/glexec || chroot-tool install osg-wn-client HEP_OSlibs_SL5 glexec lcmaps-plugins-condor-update lcmaps-plugins-process-tracking lcmaps-plugins-mount-under-scratch",
      require   => [Exec["chroot_initial_cmd"]],
      provider  => "shell",
      cwd       => "/",
      logoutput => "on_failure",
   }

}

