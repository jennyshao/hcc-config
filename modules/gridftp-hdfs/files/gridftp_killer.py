#!/usr/bin/python

import os
import re
import sys
import time
import signal

status_re = re.compile('([\w]+):\s+(.*)')

def process_age(pid):
    try:
        s = os.stat('/proc/%s' % str(pid))
    except:
        raise Exception("Process is not alive.")
    born = s.st_ctime
    age = time.time() - born
    return age

def list_processes():
    all_procs = []
    for name in os.listdir('/proc'):
        try:
            if not os.path.isdir(os.path.join('/proc', name)):
                continue
            all_procs.append(int(name))
        except ValueError:
            continue
        except OSError:
            continue
    return all_procs

def find_gridftp(age=6*3600):
    xinetd_proc = None
    gridftp_procs = []
    parent_proc = {}
    all_procs = list_processes()
    print "Finding gridftp servers at least %.2f minutes old." % (age/60.0)
    for proc in all_procs:
        try:
            fd = open(os.path.join('/proc', str(proc), 'status'))
            for line in fd:
                m = status_re.match(line.strip())
                if not m:
                    continue
                key, val = m.groups()
                if key == 'Name':
                    if val.find('globus-gridftp-') >= 0:
                        gridftp_procs.append(proc)
                    elif val == 'xinetd':
                        xinetd_proc = proc
                    else:
                        break
                elif key == 'PPid':
                    try:
                        parent_proc[proc] = int(val)
                    except:
                        continue
        except OSError:
            continue
    if xinetd_proc == None:
        return []
    interesting_procs = []
    for proc in gridftp_procs:
#        if parent_proc.get(proc, -1) == xinetd_proc:
#            print "continuing, xinetd=",xinetd_proc
#            continue
        if process_age(proc) >= age:
            print "interesting=",proc
            interesting_procs.append(proc)
    return interesting_procs

def kill_procs(interesting_procs):
    for proc in interesting_procs:
        try:
            os.kill(proc, signal.SIGKILL)
        except Exception, e:
            print e
            continue

def main():
    age = None
    try:
        age = int(eval(sys.argv[1], {}, {}))
    except IndexError:
        pass
    except ValueError:
        pass
    if age:
        procs = find_gridftp(age)
    else:
        procs = find_gridftp()
    print "GridFTP servers to kill:\n" + "\n".join([str(i) for i in procs])
    kill_procs(procs)

if __name__ == '__main__':
    main()
