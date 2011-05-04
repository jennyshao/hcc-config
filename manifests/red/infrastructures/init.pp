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
	$snmpLocation = 'Schorr 02'
	$snmpContactName = 'Garhan Attebury'
	$snmpContactEmail = 'attebury@cse.unl.edu'
	$snmpSources = ['red-mon.unl.edu', '172.16.200.3']

	$ntpServersPublic = [ '0.us.pool.ntp.org', '1.us.pool.ntp.org', '2.us.pool.ntp.org', '3.us.pool.ntp.org' ]
	$ntpServersLocal = [ 'red.unl.edu', 'gpn-husker.unl.edu', 't3.unl.edu' ]

}


node red-private inherits basenode {
	$zone = "red-private"
}

node red-public inherits basenode {
	$zone = "red-public"
}

