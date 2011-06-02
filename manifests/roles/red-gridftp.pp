class role_red-gridftp {

	include fetch-crl
	include ganglia::diskstat
	include hadoop
	include gridftp-hdfs
	include xrootd
#	include tester

}
