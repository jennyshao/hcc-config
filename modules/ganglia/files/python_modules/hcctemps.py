#!/usr/bin/env python

import logging
import subprocess
import re

Tcase = 0
descriptors = []
sensor_map = {}

LOGFILE = '/var/log/gmond-temps.log'
logging.basicConfig(level = logging.INFO, format = "%(asctime)s %(levelname)s - %(message)s", filename=LOGFILE, filemode='a')
logging.info('==============================================================================')
logging.info('HCC Ganglia Temps: starting up')
logging.info('==============================================================================')



def get_reading(sensor_id):
	global Tcase
	""" return value from specified sensor id """
	logging.debug( 'gathering sensor_id = %d' % sensor_id )

	cmd = "sudo /usr/sbin/ipmi-sensors --comma-separated-output --no-header-output --workaround-flags=ignorescanningdisabled --record-ids=%d" % sensor_id
	logging.debug( 'running command: %s' % cmd )

	p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	out, err = p.communicate()
	logging.debug( 'result:\n' + out )

	if p.returncode:
		logging.warning( 'failed to run: %s' % cmd )
		return p.returncode

	reading = int(float(out.split(',')[3]))

	if reading < 0:
		logging.debug( 'reading was negative, offsetting by Tcase' )
		reading = reading + Tcase

	logging.debug( 'returning sensor value = %d' % reading )
	return reading



def get_metrics(name):
	""" return metric for a sensor name """
	global sensor_map
	logging.debug( 'callback for %s' % name )
	logging.debug( 'getting reading for %s' % sensor_map[name] )
	return get_reading(int(sensor_map[name]))



def metric_init(params):

	global descriptors
	global sensor_map
	global Tcase

	logging.debug( 'initalizing' )
	logging.debug( 'received the following params: %s' % params )

	""" loop over our supplied params to get initial value and units """
	for sensor in params.keys():


		if sensor == 'tcase':
			Tcase = int(params[sensor])
			continue

		logging.debug( '  doing sensor %s' % str(params[sensor]) )
		logging.debug( '    adding map for %s to %s' % (sensor, str(params[sensor])) )
		sensor_map[sensor] = str(params[sensor])
		logging.debug( '    v sensor_map = %s' % sensor_map )

		cmd = "sudo /usr/sbin/ipmi-sensors --comma-separated-output --no-header-output --workaround-flags=ignorescanningdisabled --record-ids=%s" % params[sensor]
		logging.debug( 'running command: %s' % cmd )

		p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		out, err = p.communicate()
		logging.debug( 'result:\n' + out )

		if p.returncode:
			logging.warning( 'failed to run: %s' % cmd )
			return p.returncode

		line = out.split(',')
		sensor_name = sensor
		sensor_type = line[2].lower()
		sensor_unit = line[4]
		logging.debug( 'generating descriptor: <%s> <%s> <%s>' % (sensor_name, sensor_unit, sensor_type ) )

		d = {
		      'name': sensor_name,
				'call_back': get_metrics,
				'time_max': 60,
				'value_type': 'uint',
				'units': sensor_unit,
				'slope': 'both',
				'format': '%u',
				'description': sensor_name,
				'groups': sensor_type,
		}

		logging.debug( 'DESCRIPTOR = %s' % d )
		descriptors.append( d )

	return descriptors


def metric_cleanup():
	pass


if __name__ == '__main__':
	params = { 'cpu1_temp': 1,
	           'cpu2_temp': 2,
	           'temp_ambient': 5,
	           'temp_planar': 6, }
	metric_init(params)

	for d in descriptors:
		v = d['call_back'](d['name'])
		print 'value for %s is %u' % (d['name'], v)

