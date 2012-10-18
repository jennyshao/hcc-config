### red vm hosts

node /red-vm[1,2,3].red.hcc.unl.edu/ inherits red-private {
	$role = "red-vm"
	include general
}

node /red-vm[6,7,8].red.hcc.unl.edu/ inherits red-private {
	$role = "red-vm"
	include general
}
