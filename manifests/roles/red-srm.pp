class role_red-srm {

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
