class osg-ce::install {

	package { $osg-ce::params::ce_package_name:
		ensure => present,
	}

}
