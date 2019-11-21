wall_thickness=6.5;
base_thickness=2.0;
bb_depth=20;
bb_width=56.5;
bb_height=89.5;
bb_curve_corner=10;

bb_lid_thickness=2;
bb_lid_depth=2.5;
bb_lid_shrink=.5;

corner_size=12;

// Battery holder
bat_width=32;
bat_height=64;
bat_depth=8;
bat_wall=5.0;
bat_ceil=2.0;

module RoundedBB(extra_width,extra_height,depth,curve=bb_curve_corner,bevel=0) {
	minkowski() {
		cube([bb_width-curve+extra_width,bb_height-curve+extra_height,depth-bevel],center=true);
		cylinder(r1=curve/2.5,r2=curve/2, h=.0001+bevel, $fn=32, center=true);
	}
}

module BeagleLid(curve=bb_curve_corner) {
	difference() {
		union() {
			RoundedBB(wall_thickness, wall_thickness, bb_lid_thickness, curve, bb_lid_thickness*3/4);
			translate([0,0,bb_lid_thickness/2+bb_lid_depth/2]) {
				difference() {
					rotate( [180,0,0] )
					RoundedBB(-bb_lid_shrink, -bb_lid_shrink, bb_lid_depth, curve-2,bb_lid_depth*1/2);
					*RoundedBB(-bb_lid_shrink-5, -bb_lid_shrink-5, bb_lid_depth, curve-2);
					cube([bb_width-1.5*corner_size,bb_height,bb_lid_depth*5],center=true);
					cube([bb_width,bb_height-1.5*corner_size,bb_lid_depth*5],center=true);
				}
			}
/*
			translate([0,-(bb_height-bat_height)/2+2,bb_lid_thickness/2+bat_depth/2+bat_ceil/2]) {
				cube([bat_width+bat_wall,bat_height+bat_wall,bat_depth+bat_ceil], center=true);
			}
*/
		}
/*
		// Carve out the space in the battery holder
		translate([0,-(bb_height-bat_height)/2+2,0]) {
			cube([bat_width,bat_height,bb_lid_thickness+bat_depth*2], center=true);
		}

		// Take slices out of the battery holder
		translate([0,-(bb_height-bat_height)/2+2,bb_lid_thickness/2+bat_depth/2+bat_ceil/2]) {
			cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);

			translate([0,-25,0])
				cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);

			translate([0,25,0])
				cube([bat_width+bat_wall,20,bat_depth+bat_ceil], center=true);
		}
*/
	}
}

BeagleLid();
