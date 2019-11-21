// Outer Diameter
    OD = 72.1;
// Inner Diameter
    ID = 57.1;
// Taper's Outer Diameter
    Taper_OD = 77;
// Taper's Inner Diameter
    Taper_InnerD = 64;
// Overall Thickness
    Thickness = 9.5;
// Taper Thickness
    Taper_Thickness = 3;


module WheelSpacer (OD, ID, Taper_OD, Taper_InnerD, Thickness, Taper_Thickness)
{
difference()
{
	union()
	{
		cylinder(h = Thickness, r = OD/2, $fn= 128);
		cylinder(h = Taper_Thickness, r1 = Taper_OD/2, r2= OD/2, $fn = 128);
	}
	translate([0,0,-0.5]) cylinder(h = Thickness+1, r = ID/2, $fn = 128);
	cylinder(h = Taper_Thickness, r1 = Taper_InnerD/2, r2 = ID/2, $fn = 128);
}


}







WheelSpacer(OD, ID, Taper_OD, Taper_InnerD, Thickness, Taper_Thickness);