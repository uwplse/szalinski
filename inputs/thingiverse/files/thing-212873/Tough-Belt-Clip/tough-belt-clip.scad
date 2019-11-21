// Tough Belt Clip
// Design by Marius Gheorghescu, December 2013


// how many teeth on each side
teeth = 5;

// width of the belt in mm incl clearance (use 6.25 for typical GT2 belt)
belt_width = 6.5;

// thickness of the belt in mm (use 1.5 for GT2 belt)
belt_thickness = 1.5;

// belt pitch in mm (use 2.0 for GT2 belt)
pitch = 2.0;

// this controls the strength of the bracket 
shell = 1.5;

/* [Hidden] */
cutout_width = 6 + belt_thickness + shell;
len = 2*teeth*pitch + cutout_width;
round_corner_epsilon = 1;
epsilon = 0.01;


module belt()
{
	// reinforcement
	//cube([len, 2, h], center=true);

	for(i=[pitch/4:pitch:len]) {
		translate([i-len/2, 1.25, 0])
			cube([pitch - round_corner_epsilon, belt_thickness + round_corner_epsilon, belt_width], center=true);

	}

}



module clip() {
difference()  {

	union() {
		// general shape of the clip
		linear_extrude(belt_width + 2*shell, center=true) {
			polygon(points=[
				[len/2,0],
				[3,-2.5], 
				[-3,-2.5], 
				[-len/2,0], 
				[-len/2, shell + belt_thickness], 
				[len/2, shell + belt_thickness]
			]);
		}


		
	}

	// left belt turn
	rotate([0,0,-45])
	translate([-3.2/2 - shell - belt_thickness/2,0,0])
		cube([belt_thickness, 20 + 2*shell, belt_width], center=true);

	// right belt turn
	rotate([0,0,45])
//+ belt_thicknes/2 + shell
	translate([3.2/2 + shell + belt_thickness/2,0,0])
		cube([belt_thickness, 20 + 2*shell, belt_width], center=true);

	// cutouts
	translate([len/2 - teeth*pitch, shell + belt_thickness/2, 0])
		cube([pitch + epsilon, belt_thickness + epsilon, belt_width], center=true);

	translate([-len/2 + teeth*pitch, shell + belt_thickness/2, 0])
		cube([pitch + epsilon, belt_thickness + epsilon, belt_width], center=true);


	// m3 hole
	rotate([90,0,0])
		cylinder(r=1.66, h=10 + 2*shell, center=true);

	// hex nut
	translate([0, -3.8, 0])
	rotate([90,90,0])
		cylinder(r=3.35, h=4, center=true, $fn=6);

	// belt teeth
	for(i=[1:1:teeth]) {

		// left side
		color([1,0, 0])
		translate([len/2 + pitch/4 - i*pitch, shell + belt_thickness/2, 0])
			cube([pitch/2, belt_thickness + epsilon, belt_width], center=true);

		// right side 
		color([1,0, 0])
		translate([-len/2 - pitch/4 + i*pitch, shell + belt_thickness/2, 0])
			cube([pitch/2, belt_thickness + epsilon, belt_width], center=true);
	}

}


}


module clip_set()
{
	for(i=[0:10:50]) {
		translate([0,i,0])
			clip();
	}
}

//clip_set();
clip();

