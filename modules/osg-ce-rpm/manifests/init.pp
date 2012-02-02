#
# Class: osg-ce-rpm
#
# manages osg-ce-rpm
#
class osg-ce-rpm {

	file { "config.ini":
		ensure  => present,
		path    => "/opt/osg/osg-1.2/osg/etc/config.ini",
		owner   => "root", group => "root", mode => 644,
		content => template("osg-ce/config.ini.erb"),
	}

	file { "30-gip.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-gip.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/gip.ini",
	}
	
	file { "01-squid.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/01-squid.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/01-squid.ini",
	}
	

	file { "10-misc.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/10-misc.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/10-misc.ini",
	}
	
	file { "15-managedfork.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/15-managedfork.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/15-managedfork.ini",
	}

	file { "20-condor.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/20-condor.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/20-condor.ini",
	}


	file { "30-cemon.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-cemon.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/30-cemon.ini",
	}

	file { "30-gratia.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-gratia.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/30-gratia.ini",
	}


	file { "40-localsettings.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/40-localsettings.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/40-localsettings.ini",
	}

	file { "40-siteinfo.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/40-siteinfo.ini",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce-rpm/40-siteinfo.ini",
	}


	file { "condor.pm":
		ensure  => present,
		path    => "/usr/lib/perl5/vendor_perl/5.8.8/Globus/GRAM/JobManager/condor.pm",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce/condor.pm",
	}

	file { "condor_groupacct.pm":
		ensure  => present,
		path    => "//usr/lib/perl5/vendor_perl/5.8.8/Globus/GRAM/JobManager/condor_groupacct.pm",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce/condor_groupacct.pm",
	}

	file { "extattr_table.txt":
		ensure  => present,
		path    => "/etc/osg/extattr_table.txt",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce/ea_table.txt",
	}

	file { "uid_table.txt":
		ensure  => present,
		path    => "/etc/osg/uid_table.txt",
		owner   => "root", group => "root", mode => 644,
		source  => "puppet:///modules/osg-ce/uid_table.txt",
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
