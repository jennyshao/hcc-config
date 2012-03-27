### red gridftp / xrootd servers

node 'red-gridftp11.unl.edu' inherits red-public {
	include general

#	$yum_extrarepo = [ 'nebraska', 'osg' ]
#	include yum

	include ganglia
	include gridftp-hdfs
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
	include hostcert
	include gridftp-hdfs
	include xrootd

}

