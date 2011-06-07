### red gridftp / xrootd servers

node /^red-gridftp\d+\.unl\.edu$/ inherits red-public {
	$role = "red-gridftp"

	include general
	include ganglia
	include ssh
	include stdlib
	include mcollective
}
