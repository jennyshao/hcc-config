class role_red-worker {

	$isCondorWorker = true

	include condor
#	include cgroups
	include fetch-crl
   include wn-glexec

}
