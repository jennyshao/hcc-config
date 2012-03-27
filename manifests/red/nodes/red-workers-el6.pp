node 'node000.red.hcc.unl.edu' inherits red-private {
   $condorCustom09 = "el6"
   $role = "red-worker-el6"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]

	include general
	include yum
}

node /^node10[3456789]$/ inherits red-private {
	$isHDFSDatanode = true
#	$condorCustom09 = "r710"
   $role = "red-worker-el6"
	include general
}

node /^red-d1[5,6]n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = true
   $condorCustom09 = "el6"
   $role = "red-worker-el6"
}



node /^red-d18n[7-9].red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = false
   $condorCustom09 = "el6"
   $role = "red-worker-el6"
}

node /^red-d18n[12][0-9].red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = false
   $condorCustom09 = "el6"
   $role = "red-worker-el6"
}

node /^red-d18n3[0-6].red\.hcc\.unl\.edu$/ inherits red-private {
	$isHDFSDatanode = false
   $condorCustom09 = "el6"
   $role = "red-worker-el6"
}
