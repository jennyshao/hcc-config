class role_red-gatekeeper {

	$isCondorSubmitter = true
	$mountsHDFS = true

	include nrpe
   include ganglia
	include condor
	include osg-ce
	include cvmfs

}
