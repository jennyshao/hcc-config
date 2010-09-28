
node basenode {
	include sudo
	include ntp
}

node 'node001' inherits basenode {
	include condor
}

node 'node002' inherits basenode {
}
