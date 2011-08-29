### red infrastructure nodes (single nodes, groups go in their own .pp file)

node 'red-condor.unl.edu' inherits red-public {
	$isCondorCollector = true
	$role = "red-collector"
	include general
	include ganglia
}

