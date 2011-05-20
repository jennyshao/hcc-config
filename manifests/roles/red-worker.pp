class role_red-worker {

	$isCondorWorker = true

	include condor
	include fetch-crl
   include wn-glexec

}
