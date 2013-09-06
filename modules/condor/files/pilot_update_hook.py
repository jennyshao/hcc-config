#!/usr/bin/python

import os
import sys
import time
import errno
import classad

debuglog = False
chirp_verb = "set_job_attr_delayed"

if debuglog:
    debug_fp = open("/tmp/debug_pilot_hook", "w")
else:
    debug_fp = open("/dev/null", "w")
sys.stderr = debug_fp
sys.stdout = debug_fp

launch_time = time.time()

fd = os.popen("condor_config_val LIBEXEC")
libexec = fd.read().strip()
if not fd.close():
    if 'PATH' in os.environ:
        os.environ["PATH"] += ":" + libexec
    else:
        os.environ["PATH"] = libexec

def chirp(name, val, verb=None):
    global chirp_verb
    if verb == None: verb = chirp_verb
    print >> debug_fp, "Invoking condor_chirp %s %s %s" % (verb, name, val)
    pid = os.fork()
    # Use execv directly to avoid quoting issues in os.system and friends
    if not pid:
       try:
           try:
               os.dup2(debug_fp.fileno(), 1)
               os.dup2(debug_fp.fileno(), 2)
               os.execvpe("condor_chirp", ["condor_chirp", str(verb), str(name), str(val)], os.environ)
           except Exception, e:
               print >> debug_fp, str(e)
       finally:
           os._exit(1)

    pid, exit_status = os.waitpid(pid, 0)
    return exit_status

def getAd():
    ad = classad.ClassAd()
    ad["AD_FOUND"] = classad.ExprTree("false")
    ad["AD_FRESH"] = classad.ExprTree("false")
    fp = None
    try:
        fp = open(".pilot.ad")
        st = os.fstat(fp.fileno())
        ad["AD_FOUND"] = classad.ExprTree("true")
        if launch_time - st.st_mtime < 600:
            ad["AD_FRESH"] = classad.ExprTree("true")
        else:
            print "Pilot ad too old"
    except IOError, oe:
        if oe.errno == errno.ENOENT:
            print "No pilot ad available"
        else:
            raise
    if not fp: return ad
    pilot_ad = classad.parseOld(fp)
    for key in pilot_ad:
        if key not in ad:
            ad[key] = pilot_ad.lookup(key)
    return ad

def main():
    ad = getAd()
    global chirp_verb
    for attr in ad.keys():
        val = ad.lookup(attr)
        attr = "PILOT_" + attr
        if chirp(attr, val) and chirp_verb == "set_job_attr_delayed":
            chirp_verb = "set_job_attr"
            retval = chirp(attr, val)
            if retval:
                print "Chirp'ing failed (%d)!" % retval
                return retval

    return 0

if __name__ == "__main__":
    sys.exit(main())

