class osg-ce::config {

	$require = Class["osg-ce::install"]

	file { "extattr_table.txt":
		ensure  => present,
		path    => "/etc/osg/extattr_table.txt",
		owner   => "root", group => "root", mode => '0644',
		source  => "puppet:///modules/osg-ce/extattr_table.txt",
	}

	file { "uid_table.txt":
		ensure  => present,
		path    => "/etc/osg/uid_table.txt",
		owner   => "root", group => "root", mode => '0644',
		source  => "puppet:///modules/osg-ce/uid_table.txt",
	}

	file { "condor.pm":
		ensure  => present,
		path    => "/usr/lib/perl5/vendor_perl/5.8.8/Globus/GRAM/JobManager/condor.pm",
		owner   => "root", group => "root", mode => '0644',
		source  => "puppet:///modules/osg-ce/condor.pm",
	}


	### /etc/osg/config.d/ settings ###
	file { "01-squid.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/01-squid.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/01-squid.ini.erb"),
	}

	file { "10-misc.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/10-misc.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/10-misc.ini.erb"),
	}

	file { "10-storage.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/10-storage.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/10-storage.ini.erb"),
	}

	file { "15-managedfork.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/15-managedfork.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/15-managedfork.ini.erb"),
	}

	file { "20-condor.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/20-condor.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/20-condor.ini.erb"),
	}

	file { "30-cemon.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-cemon.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/30-cemon.ini.erb"),
	}

	file { "30-gip.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-gip.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/30-gip.ini.erb"),
	}

	file { "30-gratia.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/30-gratia.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/30-gratia.ini.erb"),
	}

	file { "40-localsettings.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/40-localsettings.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/40-localsettings.ini.erb"),
	}

	file { "40-siteinfo.ini":
		ensure  => present,
		path    => "/etc/osg/config.d/40-siteinfo.ini",
		owner   => "root", group => "root", mode => '0644',
		content => template("osg-ce/config.d/40-siteinfo.ini.erb"),
	}

}
