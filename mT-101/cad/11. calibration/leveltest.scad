// project		: mT-101
// used for calibration

// author 		: vincent
// date   		: 6.20.2013

// www.metarobotics.com
// It is licensed under the Creative Commons - GNU GPL license.

//printing specification
//this is for makerbot replicator 2
flate_x = 285;
flate_y = 153;

//test argument
test_height = 0.2;	// single layer
line_width = 0.2;	// single line

module leveltest()
{
	//outer square test
	//printing offset
	x_offset = 35;
	y_offset = 23;

	x1 = flate_x-x_offset;
	y1 = flate_y-y_offset;

	difference()
	{
		cube([x1,y1,test_height]);

		translate([line_width,line_width,-0.1])
		cube([x1-line_width*2,y1-line_width*2,test_height + 0.2]);
	}

	//inner square test
	inner_factor = 0.25;
	x2 = x1*inner_factor;
	y2 = y1*inner_factor;

	translate([x1/2-x2/2,y1/2-y2/2,-0.01])
	difference()
	{
		cube([x2,y2,test_height]);

		translate([line_width,line_width,-0.1])
		cube([x2-line_width*2,y2-line_width*2,test_height + 0.2]);
	}
}

leveltest();