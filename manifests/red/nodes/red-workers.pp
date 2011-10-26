
# nodes 000-060 have no HDFS (thpc nodes)
node /^node0[0-5][0-9]$|^node060$/ inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}


node /demo\d\d\d/ inherits red-private {
	$sshExtraAdmins = [ 'acaprez', 'aguru', 'jwang' ]
	$sudoExtraAdmins = [ 'acaprez', 'aguru', 'tharvill', 'jthiltge', 'jsamuels', 'jwang' ]
	$role = "red-worker57"
	include general

	# mount sh-util for benchmarking
   file { "/util": ensure => directory }
   mount { "/util":
      device  => "sh-util:/mnt/util/PF",
      fstype  => "nfs",
      ensure  => mounted,
      options => "rw,noatime,tcp,nolock,hard,intr,rsize=32768,wsize=32768",
      atboot  => true,
      require => File["/util"],
   }
}

##############################################################################

node /node\d\d\d/ inherits red-private {
	$role = "red-worker57"
	include general
}

node 'node001' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node002' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node003' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node004' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node005' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node006' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node007' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node008' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node009' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node010' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node011' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node012' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node013' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node014' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node015' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node016' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node017' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node018' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node019' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node020' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node021' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node022' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node023' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node024' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node025' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node026' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node027' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node028' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node029' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node030' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}

node 'node031' inherits red-private {
	$role = "red-worker57"
	$condorCustom09 = "thpc"
	include general
}




node 'node103' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node104' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node105' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node106' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node107' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node108' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node109' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node110' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}


node 'node114' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node115' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node116' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node117' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node118' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node119' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node120' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node121' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node122' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node123' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node124' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node125' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node126' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node127' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node128' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node129' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node130' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node131' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node132' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node133' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node134' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node135' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node136' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node137' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node138' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node139' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}


node 'node183' inherits red-private {
	$role = "red-worker"

	# for Anthony Tiradani vm testing with Ashu
	$sshExtraAdmins = 'tiradani'
	$sudoExtraAdmins = 'tiradani'

	include general
	include sudo
	include nrpe
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

node 'node201' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node202' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node203' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node204' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node205' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node206' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node207' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node208' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node209' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node210' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node211' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node212' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node213' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node214' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node215' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node216' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node217' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node218' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node219' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node220' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node221' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node222' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node223' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node224' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node225' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node226' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node227' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node228' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node229' inherits red-private {
	$role = "red-worker"
	include general
}

node 'node230' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node231' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node232' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node233' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node234' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node235' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node236' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node237' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node238' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node239' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node240' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node241' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node242' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node243' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node244' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node245' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node246' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node247' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node248' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node249' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node250' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node251' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node252' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node253' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node 'node254' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}


node /^node1[4,5,6,7]\d\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}
node 'node180.red.hcc.unl.edu' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}
node 'node181.red.hcc.unl.edu' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}
node 'node182.red.hcc.unl.edu' inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node /^red-d8n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
} 

node /^red-d9n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}

node /^red-d11n\d+\.red\.hcc\.unl\.edu$/ inherits red-private {
	$role = "red-worker57"
	$isHDFSDatanode = true
	include general
}


