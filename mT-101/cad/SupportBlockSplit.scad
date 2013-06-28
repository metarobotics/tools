include <SupportBlock2.scad>

module splits()
{
	difference()
	{
		SupportBlock(isPrintable=false);
		translate([-0.1,-0.1,-0.1])
		cube([profile_width+0.1,support_block_y+0.2,support_block_z+0.2]);
	}

	translate([-30,0,0])
	{
		intersection()
		{
			splitBearingHolder();
			cube([profile_width+0.1,support_block_y/2,support_block_z+0.2]);
		}

		translate([0,10,0])
		intersection()
		{
			splitBearingHolder();
			translate([0,support_block_y/2,0])
			cube([profile_width+0.1,support_block_y/2,support_block_z+0.2]);
		}
	}
}

module splitBearingHolder()
{
	intersection()
	{
		SupportBlock(isPrintable=true);
		translate([-0.1,-0.1,-0.1])
		cube([profile_width+0.1,support_block_y+0.2,support_block_z+0.2]);
	}
}

splits();
