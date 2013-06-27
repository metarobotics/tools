include <frame/assembleProfile.scad>
include <library/linearShaft.scad>
include <library/LM10UU.scad>
include <library/ShaftSupport.scad>

width = 600;
y_axis_rail_offset_z = 20;

shaftsupportmodule();

//assembly();

module assembly()
{
	translate([0,30,0])
	guidepanel();

	translate([0,30,600])
	guidepanel();

	assembleProfile(apart=true);
	y_axis_rails();
	x_axis_rails();
}


module x_axis_rails()
{
	thickness=4;

	offset_z = 50;
	offset_y = shaft_support_width;
	sample_pos_y = 100;
	sample_pos_x = 150;

	pos_connector_y = 15;
	pos_connector_z = 0;

	carriage_width=150;
	carriage_height=60;
	carriage_depth=60;

	positions_rails = [ [0,0,0],[0,offset_y,0] ];
	positions_connector = [ [0,pos_connector_y,pos_connector_z],[width-shaft_support_depth,pos_connector_y,pos_connector_z] ];

	translate( [0,sample_pos_y,width] )
	{
		//rail
		translate([width/2,30,offset_z])
		{
			for( i = positions_rails )
			{
				translate(i)
				rotate([90,90,90])
				rod600();	
			}
		}

		//LM10UU linear bearing
		translate([-15,thickness+pos_connector_y,20])
		union()
		{
			translate([0,29,0])
			LM10UU();

			translate([0,carriage_width-shaft_support_height*2,0])
			LM10UU();

			translate([width+30,29,0])
			LM10UU();

			translate([width+30,carriage_width-shaft_support_height*2,0])
			LM10UU();
		}

		//support block
		for( i = positions_connector )
		{
			translate(i)
			carriage_support_block();
		}

		/*
		//carriage
		translate([sample_pos_x,pos_connector_y,pos_connector_z])
		cube([carriage_width,carriage_height,carriage_depth]);
		*/
	}
}

module carriage_support_block()
{
	width=shaft_support_depth;
	height=shaft_support_width*2;
	depth=shaft_support_height;

	thickness=4;

	//todo:add m5 hexa nut hole
	color("MediumVioletRed")
	{
		difference()
		{
			cube([width,height+thickness*2,depth+thickness*2]);

			translate([-0.1,thickness,thickness])
			cube([width+0.2,height,depth]);
		}
	}

	//shaft support
	color("Silver")
	{
		translate([0,shaft_support_width/2 + thickness, shaft_support_height + thickness])
		union()
		{
			translate([0,0,0])
			rotate([0,180,90])
			shaftsupport();

			translate([0,shaft_support_width,0])
			rotate([0,180,90])
			shaftsupport();
		}
	}
}


/*
	Y-Axis rails
	Designed by vincent
	6.25.2012
*/

module y_axis_rails()
{
	//10mm width rails
	positions = [ [0,0,width],[30+width,0,width] ];
	translate([-15,30+width/2,y_axis_rail_offset_z+5])
	{
		//positions = [ [0,0,0],[0,width,0],[0,0,width],[0,width,width] ];
		for( i = positions )
		{
			translate(i)
			rotate([90,90,0])
			rod600();
		}
	}

	//shaft support
	shaftsupportmodules();
}


module rod600()
{
	color("LimeGreen")
	linearShaft(h=600,r=5);
}

module guidepanel()
{
	color("Moccasin")
	cube([600,600,1]);
}

module shaftsupportmodules()
{
	{
		translate([0,30,600])
		rotate([0,90,0])
		shaftsupportmodule();

		translate([630,30,600])
		rotate([0,-90,0])
		shaftsupportmodule();

		translate([0,630-14,600])
		rotate([0,90,0])
		shaftsupportmodule();

		translate([630,630-14,600])
		rotate([0,-90,0])
		shaftsupportmodule();
	}
}

module shaftsupportmodule()
{
	thickness = 4;

	//printable parts
	color("Coral")
	{
		translate([-30,0,0])
		cube([60,30,thickness]);

		//translate([0,0,0])
		//cube([30,60,4]);
	}

	translate([-15,shaft_support_depth,thickness])
	shaftsupport();
}