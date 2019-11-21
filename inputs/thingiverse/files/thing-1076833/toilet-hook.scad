// preview[view:north east, tilt:top diagonal]
$fs = 2*1;
$fa = 2*1;

//how wide should the part be?
wall_width = 25; //[15:50]

//how thick (strong) should the walls be?
wall_depth = 4; //[4:10]

//how far from the attached surface should the lip be?
hook_depth = 15; //[10:30]

//how high should the lip go?
hook_lip = 15; //[10:30]

//how tall should the attaching part be?
anchor_height = 30; //[30:100]

//diameter of screw hole
screw_diameter = 4; //[4:10]
screw_r = screw_diameter / 2;

//what is the additional width of the widest part of the flange
screw_flange = 0; //[0:5]

sqrt2 = sqrt(2);

cube([hook_depth, wall_depth, wall_width]);
translate([hook_depth, wall_depth-hook_lip, 0])
	cube([wall_depth, hook_lip, wall_width]);
difference() {
	cube([wall_depth, anchor_height, wall_width]);
	
	for(y=[1:2]) {
		translate([-1, wall_depth + (y * (anchor_height - wall_depth) / 3), wall_width / 2])
		rotate([0, 90, 0])
			screw_hole();
	}
}
intersection() {
	cube([hook_depth + wall_depth, hook_depth + wall_depth, wall_depth]);
	rotate([0, 0, 45])
		translate([-sqrt2 * hook_depth / 2, -sqrt2 * hook_depth / 2, 0])
			cube([sqrt2 * (hook_depth + wall_depth), sqrt2 * (hook_depth + wall_depth), wall_depth]);
}

module screw_hole() {
	cylinder(r1=screw_r, r2 = screw_r + screw_flange/2, h=wall_depth + 2);
}
