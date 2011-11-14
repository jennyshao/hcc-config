#
# Class: osg-ce
#
class osg-ce {

	include osg-ce::params, osg-ce::install, osg-ce::config, osg-ce::service

	# must hard mount OSGAPP and OSGDATA to make RSV probes happy
	# automounting will not show correct permissions
	file { "/opt/osg": ensure => directory }
	file { "/opt/osg/app": ensure => directory, require => File["/opt/osg"], }
	mount { "/opt/osg/app":
		device  => "nfs04:/mnt/raid/opt/osg/app",
		fstype  => "nfs",
		ensure  => mounted,
		options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/app"],
	}

	file { "/opt/osg/data": ensure => directory, require => File["/opt/osg"], }
	mount { "/opt/osg/data":
		device  => "nfs04:/mnt/raid/opt/data",
		fstype  => "nfs",
		ensure  => mounted,
		options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/data"],
	}

}
