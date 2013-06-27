include <library/LM10UU.scad>
include <library/ShaftSupport.scad>
include <library/Profile30.scad>
include <library/common.scad>

//flags
flag_assembly_complete = true;

SupportBlock(isPrintable=true);
//shaftsupport();

shaft_support_offset=12;
support_thickness=4;
profile_width = 30;

//support_block_x=50;
support_block_x=profile_width+shaft_support_depth;
support_block_y=(shaft_support_width+support_thickness)*2+shaft_support_offset;
support_block_z=shaft_support_height+support_thickness*4+0.3;

module SupportBlock(isPrintable=true)
{
	support_holder(isPrintable);

	if(isPrintable==false)
	{
		linear_bearings();
		translate([support_block_x - shaft_support_depth, shaft_support_width+support_thickness, support_thickness*2])
		supports();

		guide(); // for debugging
	}
}

module support_holder(isPrintable=true)
{
	diameter1=12;
	diameter2=9.5;
	diameter3=5;

	nutOffset=6.5;
	nutPos1 = [profile_width+shaft_support_depth/2,support_thickness+shaft_support_width-nutOffset,shaft_support_height + support_thickness*2 - 0.1];
	nutPos2 = [profile_width+shaft_support_depth/2,support_thickness+shaft_support_width+nutOffset+shaft_support_offset,shaft_support_height + support_thickness*2 - 0.1];

	difference()
	{
		union()
		{
			difference()
			{
				cube([support_block_x,support_block_y,support_block_z]);

				translate([-1,support_thickness,support_thickness])
				cube([support_block_x+2,support_block_y-support_thickness*2 ,support_block_z - support_thickness*2]);
			}

			//translate([profile_width,shaft_support_width+support_thickness-shaft_support_depth/2,shaft_support_height])
			//cube([shaft_support_depth, shaft_support_depth, support_thickness]);

			translate([profile_width,0,support_thickness])
			cube([shaft_support_depth,support_block_y,support_thickness]);

			translate([profile_width,0,support_block_z-support_thickness*2])
			cube([shaft_support_depth,support_block_y,support_thickness]);
		}

		//hole for M6-18
		union()
		{
			translate(nutPos1)
			{
				cylinder(h=support_thickness*2.1 + 0.2,r=3.2);
				hexNut(size="M6");
			}

			translate(nutPos2)
			{
				cylinder(h=support_thickness*2.1 + 0.2,r=3.2);
				hexNut(size="M6");
			}
		}

		//clamping shaft support
		translate([profile_width,support_thickness,-0.1])
		{
			translate([shaft_support_depth/2,5,0])
			union()
			{
				hexNut(size="M5");
				cylinder(h=support_thickness*2 + 0.2,r=2.7);
			}

			translate([shaft_support_depth/2,shaft_support_width-5,0])
			{
				hexNut(size="M5");
				cylinder(h=support_thickness*2 + 0.2,r=2.7);
			}
		}

		translate([profile_width,support_thickness+shaft_support_width+shaft_support_offset,-0.1])
		{
			translate([shaft_support_depth/2,5,0])
			union()
			{
				hexNut(size="M5");
				cylinder(h=support_thickness*2 + 0.2,r=2.7);
			}

			translate([shaft_support_depth/2,shaft_support_width-5,0])
			{
				hexNut(size="M5");
				cylinder(h=support_thickness*2 + 0.2,r=2.7);
			}
		}

		//bearing circuit
		translate([15,support_block_y+1,support_block_z-profile_width/2])
		rotate([90,0,0])
		cylinder(h=support_block_y+2,r=diameter1);
	}

	//color("Maroon",0.6)
	translate([15,support_block_y,support_block_z-profile_width/2])
	rotate([90,0,0])
	difference()
	{
		cylinder(h=support_block_y,r=diameter1);
		translate([0,0,-1])
		cylinder(h=support_block_y+2,r=diameter2);
	}

	if(isPrintable==false)
	{
		if(flag_assembly_complete == true)
		{
			translate(nutPos1)
			M6_nut_module();

			translate(nutPos2)
			M6_nut_module();
		}
		else
		{
			translate(nutPos1)
			M6_nut_module_offset();

			translate(nutPos2)
			M6_nut_module_offset();
		}
	}

}

//bearing circuit
//20.4 = thickness(4) * 2 + washer(1.6) * 4 + bearing(6)
M6_18_height=20;
M6_washer_height=1.6;
bearing_height=6;

module M6_nut_module()
{
	offset_factor = 0;

	color("Magenta")
	{
		translate([0,0,0])
		hexNut(size="M6");
		
		translate([0,0,support_thickness*2])
		washer (size="M6");

		translate([0,0,support_thickness*2+M6_washer_height+offset_factor])
		washer (size="M6");

		translate([0,0,support_thickness*2+M6_washer_height*2+offset_factor*2])
		bearing(size="606ZZ");

		translate([0,0,support_thickness*2+M6_washer_height*2+bearing_height+offset_factor*3])
		washer (size="M6");

		translate([0,0,support_thickness*2+M6_washer_height*3+bearing_height+offset_factor*4])
		washer (size="M6_20");

		translate([0,0,support_thickness*2+M6_washer_height*4+bearing_height+offset_factor*5])
		rotate([0,180,0])
		hexBolt (size="M6", length= M6_18_height, center=false, pos=[0,0,0]);
	}
}

module M6_nut_module_offset()
{
	color("Magenta")
	{
		translate([0,0,-7])
		hexNut(size="M6");
		
		translate([0,0,10])
		washer (size="M6");

		translate([0,0,13])
		washer (size="M6");

		translate([0,0,17])
		bearing(size="606ZZ");

		translate([0,0,27])
		washer (size="M6");

		translate([0,0,30])
		washer (size="M6_20");

		//16.4 = thickness(4) * 2 + washer(1.6) * 4 + bearing(6)
		translate([0,0,54])
		rotate([0,180,0])
		hexBolt (size="M6", length= M6_18_height, center=false, pos=[0,0,0]);
	}
}

module linear_bearings()
{
	offset = 7;

	color("Chocolate")
	translate([15,0,support_block_z-profile_width/2])
	{
		translate([0,support_thickness+LM10UU_length*0.5 + offset,0])
		LM10UU();

		translate([0,support_thickness+LM10UU_length*1.5 + offset*2,0])
		LM10UU();
	}
}

/*support unit

Parts:
	SH10A X 2
	m5-8 bolts X 4
	m5 nuts X 4

*/

module supports()
{
	union()
	{
		translate([0,-shaft_support_width/2,0])
		rotate([0,0,90])
		shaftsupport();

		translate([0,shaft_support_width/2+shaft_support_offset,0])
		rotate([0,0,90])
		shaftsupport();
	}

	color("Magenta")
	{
		translate([shaft_support_depth/2,shaft_support_offset,0])
		union()
		{
			translate([0,5,16])
			rotate([0,180,0])
			hexBolt(size="M5",length=8);

			translate([0,shaft_support_width-5,16])
			rotate([0,180,0])
			hexBolt(size="M5",length=8);

			translate([0,5,-14])
			hexNut(size="M5");

			translate([0,shaft_support_width-5,-14])
			hexNut(size="M5");
		}
	}
}

module guide()
{
	color("LightSeaGreen", 0.1)
	translate([-profile_width-3,0,support_block_z-profile_width])
	cube([30,300,30]);
}