class role_red-gatekeeper {

   $pakitiTag = "T2_US_Nebraska"

	include condor
	include fetch-crl
	include pakiti
	include ganglia::diskstat
	include osg-ce

	include sudo
	include nrpe

}
