
node basenode {
	include sudo
	include ntp
}

node red-worker inherits basenode {
	include condor
}

node 'node001' inherits basenode {
	include condor
}

node 'node002' inherits red-worker {
}
