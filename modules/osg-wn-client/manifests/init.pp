#
# Class: osg-wn-client
#

class osg-wn-client {

	package { osg-wn-client: name => "osg-wn-client", ensure => installed }


	###########################################################################
	# the following hacks can be nuked once glideinwms doesn't rely on them
	###########################################################################
	# red CEs still point at /opt/osgwn1.2.15 in config.ini, so fake a symlink
	# to the new /etc/osg/wn-client location
	file { '/opt/osgwn1.2.15':
		ensure => link,
		target => '/etc/osg/wn-client',
	}

	# make dir tree for /opt/osgwn1.2.15/globus/etc/globus-user-env.sh to live in
	file { '/opt/osgwn1.2.15/globus':
		ensure => directory,
		require => File['/opt/osgwn1.2.15'],
	}

	file { '/opt/osgwn1.2.15/globus/etc':
		ensure => directory,
		require => File['/opt/osgwn1.2.15/globus'],
	}

	file { '/opt/osgwn1.2.15/globus/etc/globus-user-env.sh':
		ensure => present,
		content => "",
		require => File['/opt/osgwn1.2.15/globus/etc'],
	}

	file { '/opt/osgwn1.2.15/globus/bin':
		ensure => directory,
		require => File['/opt/osgwn1.2.15/globus'],
	}

	# /opt/osg/osg-1.2/globus/bin/myproxy-get-delegation
	file { '/opt/osg/osg-1.2':
		ensure => directory,
	}
	file { '/opt/osg/osg-1.2/globus':
		ensure => directory,
		require => File['/opt/osg/osg-1.2'],
	}
	file { '/opt/osg/osg-1.2/globus/bin':,
		ensure => directory,
		require => File['/opt/osg/osg-1.2/globus'],
	}
	file { '/opt/osg/osg-1.2/globus/bin/myproxy-get-delegation':
		ensure => link,
		target => '/usr/bin/myproxy-get-delegation',
		require => File['/opt/osg/osg-1.2/globus/bin'],
	}

}
