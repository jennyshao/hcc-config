
import "modules"
import "nodes"

filebucket { main: server => 'red-man.unl.edu', path => "/var/lib/puppet/bucket" }

File { backup => main }
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }


# site wide variables
$snmpLocation = 'Schorr 02'
$snmpContactName = 'Garhan Attebury'
$snmpContactEmail = 'attebury@cse.unl.edu'
$snmpSources = ['red-mon.unl.edu', '172.16.200.3']

$my_project = "red"
$debug = "yes"
$ntp_server = 'pool.ntp.org'
