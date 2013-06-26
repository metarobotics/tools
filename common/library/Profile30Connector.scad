// project		: mT-101
// parts 		: profile (width 30mm) connector
// printable 	: yes

// author 		: vincent
// date   		: 6.20.2013

// www.metarobotics.com
// It is licensed under the Creative Commons - GNU GPL license.

//simple usage
//profile30(length=100,female=false);

include <Profile30.scad>

module profile30_connector(length=20,isPrintable=true) {
	$fa = 1;
	$fn = 40;

	union()
	{
		for( i = [0:3] )
		{
			translate([i * 13,0,0])
			profile30_inner_connector_rounded();
		}
	}
}

profile30_connector(length=20);