### red infrastructure nodes (single nodes, groups go in their own .pp file)

node 'red-condor.unl.edu' inherits red-public {
	$isCondorCollector = true
	$role = "red-collector"
	include general
	include ganglia
}

node 'red-mon.unl.edu' inherits red-public {

	$sshExtraAdmins = [ 'dweitzel', 'aguru', 'acaprez' ]
   $pakitiTag = "T2_US_Nebraska"

	include general
   include users
   include pam
   include openssh
   include sudo
	include autofs

   include hostcert
   include osg-ca-certs
   include fetch-crl
   include pakiti

}


node 'red-dev-sl5.red.hcc.unl.edu' inherits red-private {
	include general
}

