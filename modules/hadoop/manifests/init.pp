#
# Class: hadoop
#

class hadoop {

	# everything should have hadoop + hadoop-libhdfs
	# as an absolute minimum

	package { "hadoop":
		name   => "hadoop-0.20",
		ensure => present,
	}

	package { "hadoop-libhdfs":
		name   => "hadoop-0.20-libhdfs",
		ensure => present,
	}


	# ensure /hadoop-data* directories are owned by hdfs:hadoop
	# should only do this once, but every time won't hurt
	exec { "chown hdfs:hadoop /hadoop-data*":
		path => "/usr/bin:/usr/sbin:/bin",
		onlyif => [ "test `ls -ld /hadoop-data1 | awk '{print \$3}'` != hdfs" ],
	}

	# log location owned by hadoop group and group writable
	# this should happen automatically with the newer hadoop RPMs
#	file { "/var/log/hadoop-0.20":
#		ensure => directory,
#		owner => "root", group => "hadoop", mode => 0775,
#		require => Package["hadoop"],
#	}


	# we keep our configs on a dedicated conf.red directory
	# start by cleaning and copying default configs
	file { "/etc/hadoop-0.20/conf.red":
		ensure  => directory,
		owner   => "root", group => "root", mode => 0644,
#		recurse => true,
#		purge   => true,
#		force   => true,
		source  => "puppet:///modules/hadoop/defaults",
		require => Package["hadoop"],
	}

	# now apply our custom configs
	file { "/etc/hadoop-0.20/conf.red/hdfs-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hdfs-site.xml.erb"),
		require => Package["hadoop"],
	}

	file { "/etc/hadoop-0.20/conf.red/core-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/core-site.xml.erb"),
		require => Package["hadoop"],
	}

	file { "/etc/hadoop-0.20/conf.red/hadoop-metrics.properties":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hadoop-metrics.properties.erb"),
		require => Package["hadoop"],
	}

	file { "/etc/hadoop-0.20/conf.red/hadoop-env.sh":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hadoop-env.sh.erb"),
		require => Package["hadoop"],
	}

	file { "/etc/hadoop-0.20/conf.red/log4j.properties":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/log4j.properties.erb"),
		require => Package["hadoop"],
	}

	file { "/etc/hadoop-0.20/conf.red/mapred-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/mapred-site.xml.erb"),
		require => Package["hadoop"],
	}

	file {"/etc/hadoop-0.20/conf.red/rack_mapfile.txt":
		owner 	=> "root", group => "root", mode => 0644,
		source	=> "puppet:///modules/hadoop/rack_mapfile.txt",
		require => Package["hadoop"],
	}
	
	file {"/etc/hadoop-0.20/conf.red/rackmap.pl":
      owner    => "hdfs", group => "root", mode => 0744,
      source   => "puppet:///modules/hadoop/rackmap.pl",
      require => Package["hadoop"],
   }
	# ALTERNATIVES maintenance
	# we use the alternatives system to keep our hadoop configs in a dedicated
	# location called conf.red (as opposed to conf.osg from the -osg RPMs)

	# check if alternatives currently points at our configs and fix if not
	exec { "run_hadoop_conf_alt_install":
		path => "/usr/bin:/usr/sbin:/bin",
		command => "/usr/sbin/alternatives --install /etc/hadoop-0.20/conf hadoop-0.20-conf /etc/hadoop-0.20/conf.red 50", 
		unless  => "/usr/bin/test `/bin/ls -l /etc/alternatives/hadoop-0.20-conf | /bin/awk '{print \$11}'` = /etc/hadoop-0.20/conf.red",
		logoutput => true,
		require => Package["hadoop"],
	}
	exec { "run_hadoop_conf_alt_link":
		path    => "/usr/bin:/usr/sbin:/bin",
		command => "/usr/sbin/alternatives --auto hadoop-0.20-conf",
		unless  => "/usr/bin/test `/bin/ls -l /etc/alternatives/hadoop-0.20-conf | /bin/awk '{print \$11}'` = /etc/hadoop-0.20/conf.red",
		logoutput => true,
		require => Package["hadoop"],
	}



	# NOTE: Temporary fix for /usr/bin/hadoop-fuse-dfs to correctly follow symlinks
	file { "/usr/bin/hadoop-fuse-dfs":
		owner   => "root", group => "root", mode => 0755,
		source  => "puppet:///modules/hadoop/hadoop-fuse-dfs",
		require => Package["hadoop"],
	}



	# mountsHDFS specifies whether this node needs to mount hdfs via fuse
	# if so, hadoop-fuse (which can be used without -osg) is needed
	# just require -osg special sauce for now
	# TODO: need to figure out best way to organize the -osg special sauce
	if $mountsHDFS {

		package { "hadoop-fuse":
			name   => "hadoop-0.20-fuse",
			ensure => present,
			require => Package["hadoop"],
		}

      # EL6 nodes have SELinux on by default; install sub-package
      if $lsbmajdistrelease == "6" {

         package { "hadoop-fuse-selinux":
            name    => "hadoop-0.20-fuse-selinux",
            ensure  => present,
            require => Package["hadoop-fuse"],
         }

      }

		# hadoop mountpoint
		file { "/mnt/hadoop": ensure => directory }
		mount { "mount_hadoop":
         name    => "/mnt/hadoop",
			device  => "hdfs",
			fstype  => "fuse",
			ensure  => mounted,
			options => "server=hadoop-name,port=9000,rdbuffer=32768,allow_other",
			atboot  => true,
			remounts => false,
			require => [ File["/mnt/hadoop"], File["/etc/hadoop-0.20/conf.red/hdfs-site.xml"], File["/usr/bin/hadoop-fuse-dfs"], ],
		}

		require hadoop::osg
	} # mountsHDFS


	# isHDFSDatanode
	if $isHDFSDatanode {
		package { "hadoop-datanode":
			name   => "hadoop-0.20-datanode",
			ensure => present,
			require => Package["hadoop"],
		}
	} # isHDFSDatanode

}

