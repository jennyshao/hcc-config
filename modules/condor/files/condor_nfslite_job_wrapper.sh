#!/bin/sh

##############################################################################
##############################################################################
#
#       DO NOT EDIT - file is being maintained by puppet
#
##############################################################################
##############################################################################


# fix for new osg-wn-client-glexec RPM installs, CEs still point at old location
if [ -f /usr/sbin/glexec ]
   then export OSG_GLEXEC_LOCATION="/usr/sbin/glexec"
fi


if [ -n "$MY_INITIAL_DIR" ]
then
    eval cd $MY_INITIAL_DIR
fi

export OSG_WN_TMP=$_CONDOR_SCRATCH_DIR
export PATH=/bin:/usr/bin:$PATH
exec "$@"
