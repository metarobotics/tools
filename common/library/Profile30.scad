// project		: mT-101
// parts 		: profile (width 30mm)
// printable 	: yes

// author 		: vincent
// date   		: 6.20.2013

// www.metarobotics.com
// It is licensed under the Creative Commons - GNU GPL license.

//simple usage
//profile30(length=100,female=false);

module profile30_inner_slice(width=10.3,width2=6.3,height=10.5,margin_corner=3,marginy=2)
{
	margin2 = (width-width2)/2;
	array1=[[0,height],[0,height-marginy],[margin2,height-marginy],[margin2,height]];
	array2=[[width,height],[width,height-marginy],[width-margin2,height-marginy],[width-margin2,height]];

	difference()
	{
		polygon(points=[[0,0],[width,0],[width,height],[0,height]]);
		polygon(points=[[0,0],[0,margin_corner],[margin_corner,0]]);
		polygon(points=[[width,0],[width,margin_corner],[width-margin_corner,0]]);
		polygon(points=array1);
		polygon(points=array2);
	}
}

module profile_slice30(length=100,width=30,inner_width=20,hole_dia=3,center_dia=5,female=true)
{
	margin1=(width-inner_width)/2;
	margin2=4;
	inner_slice_width=10.3;
	inner_slice_height=10.5;
	socket_length=6;

	translate([-width/2,-width/2,0])
	linear_extrude(height=length,center=true)
	difference()
	{
		square(width,width);
		translate([width/2-inner_slice_width/2,width-inner_slice_height,0]) profile30_inner_slice();
		translate([inner_slice_height,width/2-inner_slice_width/2,0]) rotate([0,0,90]) profile30_inner_slice();
		translate([width-inner_slice_width,inner_slice_height,0]) rotate([0,0,180]) profile30_inner_slice();
		translate([width-inner_slice_height,width/2+inner_slice_width/2,0]) rotate([0,0,270]) profile30_inner_slice();

		//hole
		translate([margin1,margin1]) circle(r=hole_dia);
		translate([margin1,width-margin1]) circle(r=hole_dia);
		translate([width-margin1,margin1]) circle(r=hole_dia);
		translate([width-margin1,width-margin1]) circle(r=hole_dia);
		translate([width/2,width/2]) circle(r=center_dia/2);
	}

	if(female==false)
	{
		//socket
		translate([-width/2,-width/2,length/2])
		difference()
		{
			union()
			{
				linear_extrude(height=2*socket_length,center=true)
				union()
				{
					translate([margin1,margin1]) circle(r=hole_dia);
					translate([margin1,width-margin1]) circle(r=hole_dia);
					translate([width-margin1,margin1]) circle(r=hole_dia);
					translate([width-margin1,width-margin1]) circle(r=hole_dia);
				}

				translate([0,0,socket_length])
				union()
				{
					translate([margin1,margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
					translate([margin1,width-margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
					translate([width-margin1,margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
					translate([width-margin1,width-margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
				}
			}

			translate([0,0,-socket_length-0.01])
			union()
			{
				translate([margin1,margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
				translate([margin1,width-margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
				translate([width-margin1,margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
				translate([width-margin1,width-margin1]) cylinder(h=socket_length/2,r1=hole_dia,r2=hole_dia/2);
			}
		}
	}
}

module profile30(length=100,hole_dia=3,width=30,female=true,isPrintable=true) {
	$fa = 1;
	$fn = 40;
	profile_slice30(length=length,width=width,hole_dia=hole_dia,female=female);
}
