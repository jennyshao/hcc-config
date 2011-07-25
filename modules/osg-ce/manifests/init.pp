#
# Class: osg-ce
#
# manages osg-ce
#
class osg-ce {

	file { "config.ini":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/osg/etc/config.ini",
		owner   => "root", group => "root", mode => 644,
		content => template("osg-ce/config.ini.erb"),
	}

	file { "gip.conf":
		ensure  => absent,
		path    => "/opt/osg/osg-1.2/gip/etc/gip.conf",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/gip.conf",
	}

	file { "alter-attributes.conf":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/gip/etc/alter-attributes.conf",
		owner   => "root", group => "root", mode => 644,
		content => template("osg-ce/alter-attributes.conf.erb"),
	}

	file { "xinetd-globus-gatekeeper":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/vdt/services/xinetd-globus-gatekeeper",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/xinetd-globus-gatekeeper",
	}

	file { "condor.pm":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/globus/lib/perl/Globus/GRAM/JobManager/condor.pm",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/condor.pm",
	}

	file { "condor_groupacct.pm":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/globus/lib/perl/Globus/GRAM/JobManager/condor_groupacct.pm",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/condor_groupacct.pm",
	}

	file { "ea_table.txt":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/vdt-app-data/ea_table.txt",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/ea_table.txt",
	}

	file { "uid_table.txt":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/vdt-app-data/uid_table.txt",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet://red-man.unl.edu/osg-ce/uid_table.txt",
	}



	# must hard mount OSGAPP and OSGDATA to make RSV probes happy
	# automounting will not show correct permissions
	file { "/opt/osg/app": ensure => directory }
	mount { "/opt/osg/app":
		device  => "nfs04:/mnt/raid/opt/osg/app",
		fstype  => "nfs",
		ensure  => mounted,
		options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/app"],
	}

	file { "/opt/osg/data": ensure => directory }
	mount { "/opt/osg/data":
		device  => "nfs04:/mnt/raid/opt/data",
		fstype  => "nfs",
		ensure  => mounted,
		options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/data"],
	}

}
