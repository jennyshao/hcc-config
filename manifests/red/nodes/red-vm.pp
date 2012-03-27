### red vm hosts

node /red-vm[1,2].red.hcc.unl.edu/ inherits red-private {
	$yum_extrarepo = [ "nebraska", "epel" ]
	$role = "red-vm"
	include general
}

node /red-vm[6,7,8].red.hcc.unl.edu/ inherits red-private {
	$role = "red-vm"
	include general
}
