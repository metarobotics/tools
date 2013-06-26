default_rail_length=537;

module rail(length=537)
{
	width = 15;
	height = 15;

	array=[[0,0],[width,0],[width,4],[width-2,6],[width-2,11],[width,13],[width,15],[0,height],[0,height-2],[2,height-4],[2,height-9],[0,height-11]];

	echo(array);

	//translate([50,50,60])
	rotate([90,0,90])
	linear_extrude(height=length)
	polygon(points=array);
}

module runner_block()
{
	translate([20,-9,7.7])
		cube([58.2,34,16.30]);

	translate([440,-9,7.7])
		cube([58.2,34,16.30]);
}

module lmguide_r1622()
{
	color("Magenta")
	rail();

	color("Indigo")
	runner_block();
}

//lmguide_r1622();