### red infrastructure nodes (single nodes, groups go in their own .pp file)

node 'red-condor.unl.edu' inherits red-public {
	$isCondorCollector = true
	$role = "red-collector"
	include general
	include users
	include pam
	include openssh
	include sudo
	include autofs
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
	include nrpe

}

node 'glidein.unl.edu' inherits red-public {
	$pakitiTag = "T2_US_Nebraska"
	# general discluded intentionally
	include hosts
}

node 'red-dev-sl5.red.hcc.unl.edu' inherits red-private {
	include general
}

