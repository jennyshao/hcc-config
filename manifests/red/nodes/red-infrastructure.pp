### red infrastructure nodes (single nodes, groups go in their own .pp file)

node 'red-test.unl.edu' inherits red-public {
	$role = "red-srm"
#	include tester
	include general
	include cgroups

}

node 'hcc-mon.unl.edu' inherits red-public {
	include general
}

node 'hcc-ganglia.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'acaprez', ]
	$sudoExtraAdmins = [ 'acaprez', ]
	$yum_extrarepo = [ 'epel', 'nebraska', 'nginx' ]
	include general
	include yum
}

node 'red-net1.unl.edu', 'red-net2.unl.edu' inherits red-private {
	include general
	include ganglia
}

node 'hcc-crabserver.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'belforte', 'letts', 'spadhi', 'crab', ]
	$sudoExtraAdmins = [ 'belforte', 'letts' ]
#	$users_ldap_servers = [ 'hcc-ldap03.unl.edu' ]
	$users_ldap_servers = [ 'red-ldap1.unl.edu', 'red-ldap2.unl.edu' ]

	include general

	mount { "/home":
		device  => "t3-nfs:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}
}

node 'hcc-factoryv3.unl.edu', 'hcc-frontendv3.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'aguru', 'acaprez', 'dweitzel' ]
	$sudoExtraAdmins = [ 'aguru', 'acaprez', 'dweitzel' ]
	include general
   include hostcert
   include osg-ca-certs
   include fetch-crl

	mount { "/home":
		device  => "t3-nfs:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}
}

node 'hcc-uniquant.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'dweitzel' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'dweitzel' ]

	include general

	mount { "/home":
		device  => "t3-nfs:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}
}

node 'red-web.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]
	include general
}

node 'red-dir1.unl.edu', 'red-dir2.unl.edu' inherits red-public {
	include general
	include ganglia
	include lvs
}

node 'red-squid1.unl.edu', 'red-squid2.unl.edu' inherits red-public {
	include general
	include ganglia
	include nrpe
}

node 'hcc-voms.unl.edu' inherits red-public {
	include general
	include ganglia
}

node 'red-condor.unl.edu' inherits red-public {
	$isCondorCollector = true
	$role = "red-collector"
	include general
	include ganglia
}

node 'red-mon.unl.edu' inherits red-public {

	$sshExtraAdmins = [ 'dweitzel', 'aguru', 'acaprez' ]
   $pakitiTag = "T2_US_Nebraska"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]

	include general

   include hostcert
   include osg-ca-certs
   include fetch-crl
   include pakiti
	include nrpe

}

node 'xrootd.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'aguru' ]
	$sudoExtraAdmins = [ 'aguru' ]
	$mountsHDFS = true
	include general
	include xrootd
}

node 'xrootd-itb.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'aguru', 'zzhang' ]
	$sudoExtraAdmins = [ 'aguru', 'zzhang' ]
	$mountsHDFS = true
	include general
}

node 'glidein.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]
	$pakitiTag = "T2_US_Nebraska"
	# general discluded intentionally
	include hosts
}

node 'hcc-gridnfs.red.hcc.unl.edu' inherits red-private {
	include general
}

node 't2.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]

	include general
}

node 't3-nfs.red.hcc.unl.edu' inherits red-private {

	include general
	include nfs::server

	# t3 home storage is mounted on /export so link to allow local logins
	# have to use force to remove /home dir if it exists already
	file { '/home': ensure => link, target => '/export/home', force => true, }

	ssh_authorized_key { "red-dump":
		ensure => "present",
		type => "ssh-dss",
      key => "AAAAB3NzaC1kc3MAAACBAKLkTzJmk4ms4xmZO1CobLWKSKn2mxLPHOI8+YQJeP0DfY9GkB40UAhJleSaFiYl4SVx1VcNhWRawpxT1triUF/6ddDTsQ6itsjjuHKGq87QfMwrnNAaMp3bPf7d3BOz3t4xSugy/YsOMtT50NzTMTFkXV+D/K+S+R/SqSIi4BSTAAAAFQDmjYIT9eSZRvlJ1MXobgyyLauqywAAAIB6V0PfanakhNbNlCMyec5ClASa5Agy/PmByBzho5zPXlLozBD7/5WTLCGIECAkCruQFChtSs7Rzg9AMOhRsxzGq4QXs7JD6Pums7PQi9gZnjSTYyKHAEIp/veOQVKP7MEtxgkumdXIHaeob5L/dclY6Y+1R6nfGqN3NLprxvpUQwAAAIBaQl72b7R96XyHxgoxgfkV+s+8Uwb7zU1pWSylEsCjFKpVcwub+IcUSkpU42XYj2lGqyCGC2jeut3lBOEu29ZAJvrOP67QeZKdaO5ybhJObI+3NNdvMMLkfCxU3HdWjcUz8JoRgRyUJyeLg05q3jQciNvfuuJx2AlF9+pikDRnGg==",
#		options => 'from="red-dump,172.16.200.1"',
		user => "root",
	}
}

node 't3.unl.edu' inherits red-public {
	$sudoExtraAdmins = [ 'acaprez', ]
	$mountsHDFS = true
	$isCondorSubmitter = true
   $ntp_server_local = true
   $yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]

	# ldap override so users can change password
	$users_ldap_servers = [ "hcc-ldap01.unl.edu", "hcc-ldap03.unl.edu" ]

	include general

	include condor
	include hadoop

	include cvmfs

	# OSGAPP and OSGDATA hard mounted to keep users sane
	file { "/opt/osg": ensure => directory }
	file { "/opt/osg/app": ensure => directory, require => File["/opt/osg"], }
	mount { "/opt/osg/app":
		device  => "hcc-gridnfs:/osg/app",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/app"],
	}

	file { "/opt/osg/data": ensure => directory, require => File["/opt/osg"], }
	mount { "/opt/osg/data":
		device  => "hcc-gridnfs:/osg/data",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
		require => File["/opt/osg/data"],
	}

	mount { "/home":
		device  => "t3-nfs:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}
}

node 'red-ldap1.unl.edu', 'red-ldap2.unl.edu' inherits red-public {
	include general
	include nrpe
}

node 'red-fdt.unl.edu' inherits red-public {
	$isFDT = true
	$sshExtraAdmins = [ 'zdenek' ]
   $sudoExtraAdmins = [ 'zdenek' ]
	include general
}

node 'hcc-cache1.unl.edu', 'hcc-cache2.unl.edu' inherits red-public {
	include general
}

node 'hadoop-name.red.hcc.unl.edu' inherits red-private {
	$isHDFSname = true
	include general
	include nrpe
	include hadoop
}

node 'hadoop-tracker.red.hcc.unl.edu' inherits red-private {
	include general
	include nrpe
	include hadoop
}

node 'rcf-gratia.unl.edu' inherits red-public {

	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]

	include general
	include ganglia

	mount { "/home":
		device  => "t3-nfs:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}

}

