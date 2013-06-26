// project		: mT-101
// printable 	: yes

// assembles parts
// profile30 height=10 * 6 * 4;
// profile_L_bracket=15;

// author 		: vincent
// date   		: 6.20.2013

// www.metarobotics.com
// It is licensed under the Creative Commons - GNU GPL license.

include <../library/Profile30.scad>

//factors
profile_length=100;
apart_factor = 0.01;

bottom_length_x = 600;
bottom_length_y = 600;
bottom_length_z = 600;

module zaxes(apart=false)
{
	union()
	{
		translate([-profile30_width/2,profile30_width/2,profile_length/2])
		bottom_z_profiles(apart);

		translate([-profile30_width/2,profile30_width*1.5+bottom_length_y,profile_length/2])
		bottom_z_profiles(apart);

		translate([profile30_width/2+bottom_length_x,profile30_width/2,profile_length/2])
		bottom_z_profiles(apart);

		translate([profile30_width/2+bottom_length_x,profile30_width*1.5+bottom_length_y,profile_length/2])
		bottom_z_profiles(apart);
	}	
}

module bottom_profiles(apart=false)
{
	union()
	{
		translate([profile_length/2,profile30_width/2,profile30_width/2])
		bottom_x_profiles(apart);

		translate([profile_length/2,profile30_width*1.5+bottom_length_y,profile30_width/2])
		bottom_x_profiles(apart);

		translate([-profile30_width/2,profile30_width*2.5,profile30_width/2])
		bottom_y_profiles(apart);

		translate([bottom_length_x+profile30_width/2,profile30_width*2.5,profile30_width/2])
		bottom_y_profiles(apart);
	}
}

module bottom_z_profiles(apart=false)
{
	profile_z_count = bottom_length_z / profile_length;

	distance = (apart==true) ? profile_length + apart_factor : profile_length;
	isFemale = false;

	if(apart==true)
	{
		assign(distance = distance + apart_factor)
		{
			connect_profiles(distance,profile_z_count,isFemale);
		}
	}
	else
	{
		connect_profiles(distance,profile_z_count,isFemale);
	}
}

module bottom_x_profiles(apart=false)
{
	profile_x_count = bottom_length_x / profile_length;

	distance = (apart==true) ? profile_length + apart_factor : profile_length;
	isFemale = false;

	if(apart==true)
	{
		assign(distance = distance + apart_factor)
		{
			connect_profiles(distance,profile_x_count,isFemale,rotatey=90);
		}
	}
	else
	{
		connect_profiles(distance,profile_x_count,isFemale,rotatey=90);
	}
}

module bottom_y_profiles(apart=false)
{
	profile_y_count = bottom_length_y / profile_length;

	distance = (apart==true) ? profile_length + apart_factor : profile_length;
	isFemale = false;

	if(apart==true)
	{
		assign(distance = distance + apart_factor)
		{
			connect_profiles(distance,profile_y_count,isFemale,rotatex=90);
		}
	}
	else
	{
		connect_profiles(distance,profile_y_count,isFemale,rotatex=90);
	}
}

module connect_profiles(distance,count,isFemale,rotatex=0,rotatey=0)
{
	rotatez=0;

	for( i = [0:count-1] )
	{
		if( i==count-1 )
		{
			assign(isFemale = true)
			{
				if(rotatey>0)
				{
					translate([distance*i,0,0])
					rotate([rotatex,rotatey,rotatez])
					profile30(length=profile_length,female=isFemale);
				}
				else if(rotatex>0)
				{
					translate([0,distance*i,0])
					rotate([rotatex,rotatey,rotatez])
					profile30(length=profile_length,female=isFemale);
				}
				else
				{
					translate([0,0,distance*i])
					profile30(length=profile_length,female=isFemale);
				}
			}
		}
		else
		{
			if(rotatey>0)
			{
				translate([distance*i,0,0])
				rotate([rotatex,rotatey,rotatez])
				profile30(length=profile_length,female=isFemale);
			}
			else if(rotatex>0)
			{
				translate([0,distance*i,0])
				rotate([rotatex,rotatey,rotatez])
				profile30(length=profile_length,female=isFemale);
			}
			else
			{
				translate([0,0,distance*i])
				profile30(length=profile_length,female=isFemale);
			}
		}
	}
}

module assembleProfile(isPrintable=false,apart=false)
{
	if(isPrintable)
	{

	}
	else
	{
		bottom_profiles(apart=apart);

		translate([0,0,bottom_length_z-profile30_width])
		bottom_profiles(apart=apart);

		zaxes(apart);
	}
}

//simple usage
//assembleProfile(apart=true);