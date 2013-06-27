//non-printable
//parts::Linear shaft support
//http://www.ebay.com/itm/4pcs-SK10-SH10A-Linear-Rail-Shaft-Support-XYZ-Table-CNC-/290562135602?pt=LH_DefaultDomain_15&hash=item43a6da5632
shaft_support_width=42;
shaft_support_height=32.8;
shaft_support_depth=14;
shaft_support_base_height=6;
shaft_support_center_width=18;
shaft_support_hole_width=5;
shaft_support_hole_height=20;

//clamping bolt:M4
clamping_depth=6;
clamping_bolt_width=4;

module shaftsupport()
{
	pos_x = (shaft_support_width-shaft_support_center_width)/2;

	color("DarkRed")
	difference()
	{
		translate([-shaft_support_width/2,0,0])
		{
			rotate([90,0,0])
			linear_extrude(height=shaft_support_depth)
			difference()
			{
				union()
				{
					square([shaft_support_width,shaft_support_base_height]);

					translate([pos_x,0,0])
					square([shaft_support_center_width,shaft_support_height]);
				}

				//shaft hole
				translate([shaft_support_width/2,shaft_support_hole_height,0])
				circle(shaft_support_hole_width);
			}
		}
	}

	//clamping bolts
	translate([-shaft_support_width/2+5,-shaft_support_depth/2,-0.1])
	boltHole();

	translate([shaft_support_width/2-5,-shaft_support_depth/2,-0.1])
	boltHole();
}

module boltHole()
{
	cylinder(h=clamping_depth+0.2,r=clamping_bolt_width/2);
}