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


	# we keep our configs on a dedicated conf.red directory
	# start by cleaning and copying default configs
	file { "/etc/hadoop-0.20/conf.red":
		ensure  => directory,
		owner   => "root", group => "root", mode => 0644,
		recurse => true,
		purge   => true,
		force   => true,
		source  => "puppet://red-man.unl.edu/hadoop/defaults",
	}

	# now apply our custom configs
	file { "/etc/hadoop-0.20/conf.red/hdfs-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hdfs-site.xml.erb"),
	}

	file { "/etc/hadoop-0.20/conf.red/core-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/core-site.xml.erb"),
	}

	file { "/etc/hadoop-0.20/conf.red/hadoop-metrics.properties":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hadoop-metrics.properties.erb"),
	}

	file { "/etc/hadoop-0.20/conf.red/hadoop-env.sh":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/hadoop-env.sh.erb"),
	}

	file { "/etc/hadoop-0.20/conf.red/log4j.properties":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/log4j.properties.erb"),
	}

	file { "/etc/hadoop-0.20/conf.red/mapred-site.xml":
		owner   => "root", group => "root", mode => 0644,
		content => template("hadoop/mapred-site.xml.erb"),
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
	}
	exec { "run_hadoop_conf_alt_link":
		path    => "/usr/bin:/usr/sbin:/bin",
		command => "/usr/sbin/alternatives --auto hadoop-0.20-conf",
		unless  => "/usr/bin/test `/bin/ls -l /etc/alternatives/hadoop-0.20-conf | /bin/awk '{print \$11}'` = /etc/hadoop-0.20/conf.red",
		logoutput => true,
	}



	# mountsHDFS specifies whether this node needs to mount hdfs via fuse
	# if so, hadoop-fuse (which can be used without -osg) is needed
	# just require -osg special sauce for now
	# TODO: need to figure out best way to organize the -osg special sauce
	if $mountsHDFS {

		package { "hadoop-fuse":
			name   => "hadoop-0.20-fuse",
			ensure => present,
		}

		require hadoop::osg
	} # mountsHDFS


	# isHDFSDatanode
	if $isHDFSDatanode {
		package { "hadoop-datanode":
			name   => "hadoop-0.20-datanode",
			ensure => present,
		}
	} # isHDFSDatanode

}

