### red bestman servers

node 'red-srm2.unl.edu' inherits red-public {

	$role = "red-srm"

	$mountsHDFS = "True"

	include general
	include ganglia
	include users
	include pam
	include openssh
	include hadoop

}

