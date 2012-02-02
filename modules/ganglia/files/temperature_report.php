<?php

/* Pass in by reference! */
function graph_temperature_report( &$rrdtool_graph ) 
{

	global $context, $hostname, $graph_var, $range, $rrd_dir, $size, $strip_domainname ;

	if ($strip_domainname) {
		$hostname = strip_domainname($hostname) ;
	}

	$title = 'Temperatures' ;
	$rrdtool_graph['title'] = $title ;
	$rrdtool_graph['vertical-label'] = 'Celsius' ;
	$rrdtool_graph['height'] += ($size == 'medium') ? 28 : 0 ;
	$rrdtool_graph['extras'] = '--rigid' ;

//    $rrdtool_graph['extras'] = ($conf['graphreport_stats'] == true) ? ' --font LEGEND:7' : '';
//    $rrdtool_graph['extras']  .= " --rigid";


	$series = "DEF:'ambient_temp'='${rrd_dir}/ambient_temp.rrd':'sum':AVERAGE "
				."DEF:'planar_temp'='${rrd_dir}/planar_temp.rrd':'sum':AVERAGE "
				."LINE1:'0'#00000066:'' "
				."AREA:'ambient_temp'#0055ff:'Ambient' "
				."VDEF:ambient_last=ambient_temp,LAST "
				."VDEF:ambient_min=ambient_temp,MINIMUM "
				."VDEF:ambient_max=ambient_temp,MAXIMUM "
				."VDEF:ambient_avg=ambient_temp,AVERAGE "
				."GPRINT:'ambient_last':'${space1}Now\:%6.1lf%s' "
				."GPRINT:'ambient_min':'${space1}Min\:%6.1lf%s${eol1}' "
				."GPRINT:'ambient_max':'${space2}Max\:%6.1lf%s' "
				."GPRINT:'ambient_avg':'${space1}Avg\:%6.1lf%s\\l' "

				."AREA:'planar_temp'#ff000055:'Planar    ' "
				."VDEF:planar_last=planar_temp,LAST "
				."VDEF:planar_min=planar_temp,MINIMUM "
				."VDEF:planar_max=planar_temp,MAXIMUM "
				."VDEF:planar_avg=planar_temp,AVERAGE "
				."GPRINT:'planar_last':'${space1}Now\:%6.1lf%s' "
				."GPRINT:'planar_min':'${space1}Min\:%6.1lf%s${eol1}' "
				."GPRINT:'planar_max':'${space2}Max\:%6.1lf%s' "
				."GPRINT:'planar_avg':'${space1}Avg\:%6.1lf%s\\l' "
	;

//				."VDEF:ambientmax=ambient_temp,MAXIMUM "
//				."COMMENT:'Maximum   ' "
//				."GPRINT:ambientmax:'%6.2lf' "
//	;


	$rrdtool_graph[ 'series' ] = $series ;
	return $rrdtool_graph;

}

?>
