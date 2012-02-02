#
# Class: osg-ca-certs
#
# simple module for osg-ca-certs RPM distribution
# keeps it up to date and requires fetch-crl to ensure proper CRL updating
#
class osg-ca-certs {

	package { osg-ca-certs: name => "osg-ca-certs", ensure => latest }
	package { cilogon-ca-certs: name => "cilogon-ca-certs", ensure => latest }

	include fetch-crl
}
