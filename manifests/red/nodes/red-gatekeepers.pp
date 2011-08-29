### red gatekeepers

node 'red.unl.edu' inherits red-public {
	$ntp_server_local = true
	$isCondorSubmitter = true
	$role = "red-gatekeeper"
	include general
	include autofs
	include ganglia
	include mcollective
	include hadoop
}

node 'red-gw1.unl.edu' inherits red-public {
	$ntp_server_local = true
	$isCondorSubmitter = true
	$role = "red-gatekeeper"
	include general
	include autofs
	include ganglia
}

node 'red-gw2.unl.edu' inherits red-public {
	$ntp_server_local = true
	$isCondorSubmitter = true
	$role = "red-gatekeeper"
	include general
	include autofs
	include ganglia
}
