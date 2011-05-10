class role_red-gatekeeper {

	include condor
	include fetch-crl
	include ganglia::diskstat
	include osg-ce

}
