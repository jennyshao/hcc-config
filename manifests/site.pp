
import "modules"
import "nodes"

filebucket { main: server => 'red-man.unl.edu', path => "/var/lib/puppet/bucket" }

File { backup => main }
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }

