class role_red-worker-el6 {

	$isCondorWorker = true
	$condorCustom09 = "el6"
   $mountsHDFS = true

	$gangliaClusterName = 'red-worker'
	$gangliaTCPAcceptChannel = '8651'
	$gangliaUDPSendChannel = [ 'red-mon.unl.edu', '8651' ]
	$gangliaUDPRecvChannel = '8651'

	include condor
	include ganglia
	include fetch-crl
   include osg-wn-client
   include glexec
   include cvmfs
	include chroot
   include osg-ca-certs
   include hadoop
   include cgroups
   include nrpe
   include sudo
   include updatedb
	include selinuxmodules

   # must hard mount OSGAPP and OSGDATA to make RSV probes happy
   # automounting will not show correct permissions
   file { "/opt/osg": ensure => directory }
   file { "/opt/osg/app": ensure => directory }
   mount { "mount_osg_app":
      name    => "/opt/osg/app",
      device  => "hcc-gridnfs:/export/osg/app",
      fstype  => "nfs",
      ensure  => mounted,
      options => "nfsvers=3,rw,noatime,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require => [ File["/opt/osg"], File["/opt/osg/app"], ],
   }
   
   file { "/opt/osg/data": ensure => directory }
   mount { "mount_osg_data":
      name    => "/opt/osg/data",
      device  => "hcc-gridnfs:/export/osg/data",
      fstype  => "nfs",
      ensure  => mounted,
      options => "nfsvers=3,rw,noatime,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require => [ File["/opt/osg"], File["/opt/osg/data"], ],
   }

	mount { "/home":
		device  => "t3-nfs:/export/home",
		fstype  => "nfs",
		ensure  => mounted,
		options => "nfsvers=3,rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}


	# disable transparent huge pages for now, kernel bug of some kind
	exec { "disable_thp":
		command => 'echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled',
		unless => 'grep "\[never\]" /sys/kernel/mm/redhat_transparent_hugepage/enabled',
	}

}
