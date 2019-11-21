
// Total diameter
total_d = 60;

// Number of wings
wing_count = 3; //[1:16]

// Wing diameter on the outside
wing_thick_d = 8;

// Wing diameter on the inside
wing_thin_d = 5;

// Wing height (on the outside)
wing_h = 7;

// Nut diameter (from corner to corner). eg. 14.6 for a M8 or 8 for a M4. Zero to disable.
nut_d = 14.6;

// Hex nut vs. just a cylindrical hole
hex_nut = 1; //[1:Hexagonal,0:Cylindrical]

// Nut thickness or lower for the nut to protrude, eg. 6.6 for M8 or 3.1 for M4.
nut_th = 6.6;

// Thread diameter, eg. 8 for M8 or 4 for M4
thread_d = 8;

// Thickness below the central nut (core thickness is the nut thickness added to this)
nut_shoulder_z = 2;

// Thickness around the central nut
nut_shoulder_x= 2.8;

// Overall roundness ratio (100 produces fully rounded wings)
roundness_ratio = 30; // [1:99]

roundness= roundness_ratio * min(wing_h, nut_th + nut_shoulder_z) / 100;

$fs=0.3+0;
tol= 0.05+0;

module torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}

module rcyl(r,h, zcenter=false, rnd=1)
{
	translate([0,0,zcenter ? -h/2 : 0])
	hull()
	{
		translate([0,0,0]) torus(r=r, rnd=rnd);
		translate([0,0,h-rnd]) torus(r=r, rnd=rnd);
	}
}

module one_wing()
{
	hull()
	{
		translate([total_d/2 - wing_thick_d/2, 0, 0])
			rcyl(r= wing_thick_d/2, h= wing_h, rnd= roundness);
		translate([nut_d/2+nut_shoulder_x-roundness, 0, 0])
			rcyl(r= wing_thin_d/2, h= nut_shoulder_z+nut_th, rnd= roundness);
	}
}

difference()
{
	for(rot=[0:360/wing_count:359])
	{
		rotate([0,0,rot])
			one_wing();
		rcyl(r= nut_d/2+nut_shoulder_x, h= nut_shoulder_z+nut_th, rnd= roundness);
	}
	
	translate([0,0,nut_shoulder_z - tol])
		cylinder(r=nut_d/2, h=nut_th+nut_shoulder_z+2*tol, $fn=(hex_nut?6:60));

	translate([0,0,-tol])
		cylinder(r=thread_d/2, h=nut_th+nut_shoulder_z+2*tol);
}