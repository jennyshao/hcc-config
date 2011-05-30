### red gridftp / xrootd servers

node 'red-gridftp12.unl.edu' inherits red-public {
	$role = "red-gridftp"

	include general
	include ganglia
	include ssh
}
