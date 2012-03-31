
node /^node11[4-9]$/ inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}
node /^node1[234567][0-9]$/ inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}
node node170 inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}



node /^node18[0-3]$/ inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}

node /^red-d18n[1-6]$/ inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}
node /^red-d8n[12345]$/ inherits red-private {
$role = "red-worker-el6"
   $condorCustom09 = "el6"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
   $isHDFSDatanode = true
   include general
   include cvmfs
   include chroot
   include osg-wn-client
}


node 'node189' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node190' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node191' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node192' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node193' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node194' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node195' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node196' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node197' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node198' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node199' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}

node 'node200' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r410"
	include general
}


node 'node230' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node231' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node232' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node233' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node234' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node235' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node236' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node237' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node238' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node239' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node240' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node241' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node242' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node243' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node244' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node245' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node246' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node247' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node248' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node249' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	include general
}

node 'node250' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}

node 'node251' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}

node 'node252' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}

node 'node253' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	$condorCustom09 = "r710"
	include general
}

node 'node254' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$condorCustom09 = "r710"
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}


node /^red-d8n[6-9].red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
} 

node /^red-d8n[12][0-9].red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
} 
node /^red-d9n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}

node /^red-d11n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	$yum_extrarepo = [ 'epel', 'nebraska', 'osg' ]
	include general
}
