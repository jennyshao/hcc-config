
node 'pf-grid.unl.edu' inherits red-public {

	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang', 'dweitzel', 'bbockelm' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang', 'dweitzel', 'bbockelm' ]

	include general
	include nrpe
   include ganglia
#	include condor
#	include osg-ce

}


