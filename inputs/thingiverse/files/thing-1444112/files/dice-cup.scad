
// Inspired by model from WaveSupportApparatus
// http://www.thingiverse.com/thing:1443491
// Default settings create same cup as that one.


//
// preview[view:north east, tilt:top diagonal]

// Diameter at Base
cup_base_dia = 50;
// Diameter at Top
cup_top_dia = 40;
// Height of Cup
cup_height = 82;
// Twist at top
rotation = 23;
// Wall thickness
wall = 2;
// Roundness of corners
wall_roundness = 10;
/* [Visualize] */
// Show Cutaway
cutaway="no"; // [yes,no]

/* [Hidden] */
slices = 80;
Delta = 0.1;
cyl_res = 80;

// if you have orig reference
// color("cyan")
// translate([0,0,0])
	// import("dice_cup.stl");

module soft_pentagon(dia, round=roundness) {
	minkowski() {
		circle(d=dia, center=true, $fn=5);
		circle(d=round, center=true, $fn=cyl_res);
	}
}

module cup_solid(height, base_dia, top_dia, rotation, roundness=wall_roundness) {
	scale_factor = top_dia*1.0/base_dia;
	linear_extrude(height=height, twist=rotation, scale=scale_factor,convexity=4, slices=slices)
		soft_pentagon(base_dia, roundness);
}


module dicecup() {
	difference() {
		// outer cup
		cup_solid(cup_height, cup_base_dia, cup_top_dia, rotation);
		// inner cup
		translate([0,0,wall])
			cup_solid(cup_height, cup_base_dia-wall*2, cup_top_dia-wall*2, rotation);
	}
}

// color("red")
difference() {
	dicecup();
	if (cutaway=="yes")
		translate([0,0,-Delta])
		cube(size=cup_height+Delta*2);
}