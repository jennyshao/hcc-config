# main entry point for puppet
# default location is /etc/puppet/manifests/site.pp

# example42 imports common module here (we don't use it yet)
# import "common"


# we define nodes based off the exampe42 medium example
# we define ZONES (network based approach for now, like red-public and red-private)
# we then define NODES that inherit a zone
# each node can include a ROLE
import "red/site.pp"


# baseline classes include modules that can be applied to all nodes
import "baselines/*.pp"


# roles are classes that include other classes and resources for a specific purpose
# roles are included from the "general" baseline if $role is defined
import "roles/*.pp"


# general settings for the standard types
Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }
