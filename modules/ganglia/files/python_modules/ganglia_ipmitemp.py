#!/usr/bin/python
# Author: Carson Crawford
# Used to make ipmi sensors metrics available to ganglia

##################################################
#						 #
# This can be used for Sun (A and B) nodes only! #
#						 #
##################################################

import os

descriptors = list()

def temp_cpu0(name):

	command = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/CPU_0/ {print $2}'"
	temp0 = os.popen(command).read()
	
	return int(temp0)

def temp_cpu1(name):

	command = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/CPU_1/ {print $2}'"
	temp1 = os.popen(command).read()

	return int(temp1)

def temp_ambient_front(name):

	command = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/Ambient_Temp0/ {print $2}'"
	amb0 = os.popen(command).read()

	return int(amb0)

def temp_ambient_back(name):

	command = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/Ambient_Temp1/ {print $2}'"
	amb1 = os.popen(command).read()

	return int(amb1)

def temp_cpu_avg(name):

	command0 = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/CPU_0/ {print $2}'"
	temp2 = int(os.popen(command0).read())

	command1 = "ipmitool -c sdr type temperature | sed 's/ /_/g' | awk -F, '/CPU_1/ {print $2}'"
	temp3 = int(os.popen(command1).read())
	
	return int((temp2+temp3)/2)

def metric_init(params):
	global descriptors 

	d1 = {'name': 'cpu0_temp',
	      'call_back': temp_cpu0,
	      'time_max': 90,
	      'value_type': 'uint',
	      'units': 'Celcius',
	      'slope': 'both',
	      'format': '%u',
	      'description': 'Temperature of CPU 0',
	      'groups': 'temperature'}

	d2 = {'name': 'cpu1_temp',
	      'call_back': temp_cpu1,
              'time_max': 90,
              'value_type': 'uint',
              'units': 'Celcuis',
              'slope': 'both',
              'format': '%u',
              'description': 'Temperature of CPU 1',
              'groups': 'temperature'}


	d3 = {'name': 'ambient_front',
	      'call_back': temp_ambient_front,
	      'time_max': 90,
              'value_type': 'uint',
              'units': 'Celcuis',
              'slope': 'both',
              'format': '%u',
              'description': 'Ambient temperature at the front of the node',
              'groups': 'temperature'}

	d4 = {'name': 'ambient_back',
	      'call_back': temp_ambient_back,
	      'time_max': 90,
              'value_type': 'uint',
              'units': 'Celcuis',
              'slope': 'both',
              'format': '%u',
              'description': 'Ambient temperature at the rear of the node',
              'groups': 'temperature'}
	

	d5 = {'name': 'cpu_avg',
	      'call_back': temp_cpu_avg,
	      'time_max': 90,
              'value_type': 'uint',
              'units': 'Celcuis',
              'slope': 'both',
              'format': '%u',
              'description': 'Average of CPU1 and CPU0 temperatures',
              'groups': 'temperature'}

	descriptors = [d1,d2,d3,d4,d5]

	return descriptors

def metric_cleanup():
	'''Clean up the metric module.'''
	pass


if __name__ == '__main__':
	metric_init(params)
        for d in descriptors:
             v = d['call_back'](d['name'])
             print 'value for %s is %u' % (d['name'], v)
