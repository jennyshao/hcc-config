# Class: fetch-crl::disableboot
#
# This class disables fetch-crl startup at boot time but doesn't check if the service is running
# Useful when the service is started but another applications (such as a Cluster suite)
#
# Usage:
# include fetch-crl::disableboot
#
class fetch-crl::disableboot inherits fetch-crl {
    Service["fetch-crl"] {
        enable => "false",
    }
}
