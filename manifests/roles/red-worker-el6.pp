class role_red-worker-el6 {

	$isCondorWorker = true

	$gangliaClusterName = 'red-worker'
	$gangliaTCPAcceptChannel = '8651'
	$gangliaUDPSendChannel = [ 'red-mon.unl.edu', '8651' ]
	$gangliaUDPRecvChannel = '8651'

	include condor
	include ganglia
	include fetch-crl
   include osg-wn-client
   include glexec
   include cvmfs
   include osg-ca-certs
   include hadoop

## These are not yet working
#  include pakiti
#	include cgroups

}
