class osg-ce::service {

	$require = Class["osg-ce::config"]

	service { $osg-ce::params::ce_service_name:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Class["osg-ce::config"],
	}

}
