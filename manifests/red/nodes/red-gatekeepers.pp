### red gatekeepers

node 'red-gw1.unl.edu' inherits red-public {
	$ntp_server_local = true
	$role = "red-gatekeeper"
	include general
	include autofs
	include ganglia
}

node 'red-gw2.unl.edu' inherits red-public {
	$ntp_server_local = true
	$role = "red-gatekeeper"
	include general
	include autofs
	include ganglia
}
