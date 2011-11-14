class osg-ce::service {

	$require = Class["osg-ce::config"]

	service { $osg-ce::params::ce_service_name:
		ensure => stopped,
		hasstatus => true,
		hasrestart => true,
		enable => false,
		require => Class["osg-ce::config"],
	}

}
