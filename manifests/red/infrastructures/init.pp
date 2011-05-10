# infrastructure template for red
# similar approach to example42 medium with (basenode -> zones -> node)

# baseline node is used to define general variables
# which can be overriden by nodes that inherit basenode

node basenode {

	# $my_project is used to autoload custom $project.pp classes in modules
	$my_project = "red"

	# $my_project_onmodule allows you to keep custom project classes in
	# an autonomous module (like /module/<project>/...)
	# $my_project_onmodule = true

	# activate module debugging
	$debug = "yes"

	# site wide variables
	$domain = "unl.edu"
	$dns_servers = [ '129.93.5.53', '129.93.5.69', '129.93.6.143', '129.93.6.189' ]

	$snmpLocation = 'Schorr 02'
	$snmpContactName = 'Garhan Attebury'
	$snmpContactEmail = 'attebury@cse.unl.edu'
	$snmpSources = [ 'red-mon.unl.edu', '172.16.200.3' ]

	# this lists all our CEs - used for config.ini generation
	$osgCEList = [ 'red.unl.edu', 'red-gw1.unl.edu', 'red-gw2.unl.edu' ]

	$gangliaClusterName = 'red-infrastructure'
	$gangliaClusterOwner = 'Holland Computing Center'
	$gangliaClusterLatLong = 'N40.812957 W96.702991'
	$gangliaClusterUrl = 'http://hcc.unl.edu/'
	$gangliaHostLocation = 'Schorr 02'
	$gangliaTCPAcceptChannel = '8650'  # port
	$gangliaUDPSendChannel = [ 'red-mon.unl.edu', '8650' ]  # host, port
	$gangliaUDPRecvChannel = '8650'  # port
	$gangliaMulticast = false  # use multicast if true
	$gangliaMulticastJoin = [ '239.2.11.71', '8650' ]  # multicast address, port

	$ntpServersPublic = [ '0.us.pool.ntp.org', '1.us.pool.ntp.org', '2.us.pool.ntp.org', '3.us.pool.ntp.org' ]
	$ntpServersLocal = [ 'red.unl.edu', 'gpn-husker.unl.edu', 't3.unl.edu' ]
	$timezone = "America/Chicago"

}


node red-private inherits basenode {
	$zone = "red-private"
}

node red-public inherits basenode {
	$zone = "red-public"
}

