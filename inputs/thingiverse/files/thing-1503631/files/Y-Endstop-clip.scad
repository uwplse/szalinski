// This par is for parameters
//Parametric input values

 // Part tickness
part_thickness = 2.3;  // [2.0:5.0]

// Distance in between lower and upper Y bars ?
y_bars_gap =24.8;   //[15.0:30.0]

//Size of sliding rods 8, 10 , 12mm?
diam_8mm = 8; // [8,10,12]

// size of the endstop sensor ?
endstop_wt = 20; // [15:25]
endstop_ht = 10;  // [10:25]
endstop_dt =  7; // [5:10]

//-- End tunables--------------------------------------------------------------------------------------------------------------------------------------------
/* [Hidden] */
//Resolution
$fn = 24;

radius_3mm = 1.7;
radius_4mm = 2.2;
radius_8mm = diam_8mm / 2;

// stats about your i3
rod_frame_gap = 25;
frame_thickness = 6.8;

// size of the endstop
endstop_w = endstop_wt + 0.2;
endstop_h = endstop_ht + 0.2;
endstop_d = endstop_dt + 0.2 + 0.2;
// useful shorthand
pt2 = part_thickness / 2;

//End of parameters

//Commons

clip_h = endstop_h + part_thickness;
holder_d = endstop_d + part_thickness * 2;
holder_w = endstop_w + part_thickness * 2;

module endstop_holder() {
	difference() {
		translate([-holder_d / 2, radius_8mm, 0])
			cube([holder_d, holder_w, clip_h]);

		translate([-holder_d / 2, radius_8mm, 0]) {
			// cutout endstop hole
			translate([part_thickness, part_thickness, part_thickness + 1]) cube([endstop_d, endstop_w, endstop_h + 2]);

			// cutout endstop wire hole
			translate([part_thickness + 1, part_thickness, -0.5]) cube([endstop_d - 2, endstop_w, part_thickness + 2]);
		}
		// cutout the rod
		cylinder(r=radius_8mm, h=clip_h + 1);
	}
}

module screw(r=radius_3mm, length=10, cap=2, hex=false) {
	cylinder(r=r, h=length);
	translate([0, 0, length])
		difference() {
			cylinder(r1=r+1, r2=r + 0.8, h=cap);
			translate([0, 0, cap]) {
				if (hex) {
					cylinder(r=r, h=2, $fn=6, center=true);
				}
				else {
					rotate([0, 0, 45])
						cube([r * 2, r / 4, 2], center=true);
					rotate([0, 0, 135])
						cube([r * 2, r / 4, 2], center=true);
				}
			}
		}
}

// End of commons ----------------------------------------------------------------

// The piece itself Y-End-stop-clip_h


y_bar_dist = y_bars_gap + radius_8mm * 2;

module y_carriage_rods() {
	color([0.9,0.9,0.9])
		rotate([0,0,0]) {
			#cylinder(r=radius_8mm, h=100, center=true);
			#translate([0,y_bar_dist,0]) cylinder(r=radius_8mm, h=100, center=true);
		}
}

module rod_clip() {
	clip_r = radius_8mm + part_thickness;
	clip_h = endstop_h + part_thickness;
	difference() {
		cylinder(r=clip_r, h=clip_h);
		translate([0,0,clip_h/2]) cylinder(r=radius_8mm, h=clip_h + 1, center=true);
		translate([radius_8mm + 1, 3, clip_h / 2]) cube([4, 8, clip_h+1], center=true);
		translate([0,radius_8mm,clip_h / 2]) cube([diam_8mm,diam_8mm,clip_h+1], center=true);
	}
}

module i3_y_endstop() {
	union() {

		rod_clip();
		translate([0,y_bar_dist,clip_h])
			rotate([180,0,0])
				rod_clip();

		translate([-radius_8mm - pt2, y_bar_dist / 2, clip_h / 2])
			cube([part_thickness, y_bar_dist, clip_h], center=true);

		translate([-holder_d / 2 - radius_8mm,part_thickness+y_bars_gap-14,0])
			endstop_holder();

	} // union
}

//y_carriage_rods();

i3_y_endstop();
