
node 'red-dev-sl5.unl.edu' inherits red-public {
	$sshExtraAdmins = [ 'bbockelm' ]
	$sudoExtraAdmins = [ 'bbockelm' ]
	include general
	mount { "/home":
		device  => "t3-nfs.red.hcc.unl.edu:/home",
		fstype  => "nfs4",
		ensure  => mounted,
		options => "rw,noatime,hard,intr,rsize=32768,wsize=32768",
		atboot  => true,
	}
}

node 'red-dev-sl6.red.hcc.unl.edu' inherits red-private {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]

	include general

}

