### red gridftp / xrootd servers

node /^red-test\.unl\.edu$/ inherits red-public {

	$role = "red-gridftp"

	include general
	include users
	include pam
	include openssh
	include sudo
	include nrpe
	include ganglia
	include ganglia::diskstat
	include hostcert
	include hadoop
	include gridftp-hdfs
	include xrootd

}

node /^red-gridftp\d+\.unl\.edu$/ inherits red-public {

#	$role = "red-gridftp"

	include general
	include users
	include autofs
	include pam
	include openssh
	include sudo
	include nrpe
	include ganglia
	include ganglia::diskstat
	include hostcert
	include gridftp-hdfs
	include xrootd

}

node "red-fdt.unl.edu" inherits red-public {

   include general
   include users
   include autofs
   include pam
   include openssh
   include sudo
   include nrpe
   include ganglia
   include ganglia::diskstat
   include hostcert
   include gridftp-hdfs
   include xrootd

}

