include <SupportBlock2.scad>

module splits()
{
	difference()
	{
		SupportBlock(isPrintable=true);
		translate([-0.1,-0.1,-0.1])
		cube([profile_width+0.1,support_block_y+0.2,support_block_z+0.2]);
	}

	translate([-10,0,0])
	intersection()
	{
		SupportBlock(isPrintable=true);
		translate([-0.1,-0.1,-0.1])
		cube([profile_width+0.1,support_block_y+0.2,support_block_z+0.2]);
	}
}

splits();
