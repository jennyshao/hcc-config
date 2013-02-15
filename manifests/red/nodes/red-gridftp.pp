### red gridftp / xrootd servers

node /^red-gridftp\d+\.unl\.edu$/ inherits red-public {

	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	$role = "red-gridftp"
	include general
	include nrpe

}

