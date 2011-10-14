### red bestman servers

node 'red-srm1.unl.edu' inherits red-public {

	$role = "red-srm"

   $mountsHDFS = "True"

   include general
   include sudo
   include nrpe
   include autofs
   include ganglia
   include users
   include pam
   include openssh
   include hadoop
   include bestman
   include osg-ca-certs
   include hostcert


}

node 'red-srm2.unl.edu' inherits red-public {

	$role = "red-srm"

	$mountsHDFS = "True"

	include general
	include sudo
	include nrpe
	include autofs
	include ganglia
	include users
	include pam
	include openssh
	include hadoop
	include bestman
	include osg-ca-certs
	include hostcert

}

