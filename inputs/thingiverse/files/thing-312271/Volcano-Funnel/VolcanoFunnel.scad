r1 = 26;
r2 = 16;
r3 = 11;
h1 = 10;
h2 = 10;
extruder_thickness = .4;
thickness = 2*extruder_thickness;
minor_h_offset = 0.1;
$fn=200;

difference()
{
	cylinder(r1=r1, r2=r2, h=h1);
	translate([0, 0, -minor_h_offset]) 
		cylinder(r1=r1-thickness, r2=r2-thickness-.15, h=h1+2*minor_h_offset);
}

translate([0, 0, h1]) difference()
{
	cylinder(r1=r2, r2=r3, h=h2);
	translate([0, 0, -minor_h_offset])
		cylinder(r1=r2-thickness, r2=r3-thickness, h=h2+2*minor_h_offset);
}
	