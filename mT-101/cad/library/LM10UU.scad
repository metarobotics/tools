//linear ball bearing
//LM10UU
//http://www.ebay.com/itm/10pcs-LM10UU-10mm-Linear-Ball-Bearing-Bush-Bushing-/300629832385?pt=BI_Heavy_Equipment_Parts&hash=item45feef32c1

LM10UU_length = 29;

module LM10UU()
{
	outer_diameter=9.5;
	inscribed_circle=5;

	translate([0,LM10UU_length/2,0])
	rotate([90,0,0])
	linear_extrude(height=LM10UU_length)
	difference()
	{
		circle(outer_diameter,center=true);
		circle(inscribed_circle,center=true);
	}
}