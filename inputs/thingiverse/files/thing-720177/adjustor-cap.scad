
use <knurledFinishLib_v2.scad>

hexf2f = 2.5 + 0.1;//hex key face to face

//main hole
bolth = 9.6; //main hole height
boltr = 5.1; //main hole width

outerd = 16; //outer diameter

//retaintion doughnut cutout
doughnuth = 1.75; //doughnut hold height from bottom
doughnutr = 0.4;  //doughnut hole radius

//cylinder slots on grip
slotr = 2;  //Cylinder grips


//maths
hexd = hexf2f/ cos(30);
hexr = hexd/2;
$fn = 30;

module doughnut(r = 0.75) {
	rotate_extrude(convexity = 10, $fn = 30)
		translate([boltr, 0, 0])
		circle(r = r, $fn = 30);
}

module final()
{
	difference() {
		knurl(k_cyl_hg	= bolth + 3,	k_cyl_od	= outerd, knurl_dp=0.75, e_smooth = 1);	
		
		//inner hole
		cylinder(h = bolth, r =boltr);

		//cylinder grips
		for (i = [0:72:360]) {
			rotate([0, 0, i])	
			translate([outerd/2 + slotr - 1, 0, 0])
				cylinder(h = 20, r = slotr);
		}


		//inner doughnut
		translate([0, 0, doughnuth])
		doughnut(doughnutr);

		//o ring lock
		//cylinder(h = doughnuth, r = boltr + 0.15);
	}

	translate([0,0,bolth-5])cylinder(h = 5, r = 2.5 );

}

mirror([0, 0, 1])
difference() {
	final();

	//hex key
	cylinder(h = 20, r = hexr, $fn = 6);
}


