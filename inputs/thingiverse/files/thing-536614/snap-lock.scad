//
//  Snap mechanism
//
//  by Egil Kvaleberg
//

// Which part
view = "both"; 	// [demo, both, snap, bracket]

//
//  main parameters, tune as required:
//

// distance between centers of mount holes that seperate
mount_cc_dist = 35.0; 
mount_cc_width = 32.0;

// thickness of main part
thickness = 3.0; 

// mounting screw diameter
screw_dia = 2.5; // BUG: 3.0

screw_head = 2.0*screw_dia;

// tolerance
gap = 0.2; 

screw_land = screw_dia/2; // land outside of screw head

snap_width = mount_cc_width - 2*screw_land - screw_head - 2*thickness;  // width of mechanism proper
mount_width = mount_cc_width + 2*screw_land + screw_head;
mount_height = 2*screw_land + screw_head;
catch_width = snap_width * 0.15; // in addition to snap_width
snap_bar_width = (snap_width - 2.4 * catch_width) / 2; // room to flex
catch_min_width = 0.3 * snap_bar_width; // nicely rounded form
catch_length = (mount_height+mount_cc_dist) / 4;


d = 1*0.1;
$fs = 0.2;

module rounded_bar(r, h) {
	intersection() {
		cylinder(r=r, h=h);
		translate([0,0, h/2])
		cube([2*r * 0.85, 2*r* 0.85, h], center=true);
/*		hull() {
			translate([0, r, h/2 - r]) rotate([90,0,0]) cylinder(r=r, h=2*r);	
			translate([0, r, -(h/2 - r)]) rotate([90,0,0]) cylinder(r=r, h=2*r);		
		}
*/
	}
}

module screw_hole()
{
	sh = screw_head/2 - (screw_dia/2 + gap);	
	cylinder(r=screw_dia/2 + gap, h = d+thickness+d);
	translate([0, 0, d+thickness-sh])
		cylinder(r1=screw_dia/2 + gap, r2 = screw_head/2, h = sh+d);
}

module snap_half() {
	translate([-mount_width/2, 0, 0]) {
		// screw mount
		difference() {
			cube([mount_width/2 + d, mount_height, thickness]);
			translate([screw_land + screw_head/2, screw_land + screw_head/2, -d]) screw_hole();
		}
	}
	translate([-snap_width/2, 0, 0]) {
		// base arm
		cube([snap_bar_width, mount_height+mount_cc_dist+catch_min_width/2+d, thickness]);

		// catch
		translate([-catch_width, mount_height+mount_cc_dist, 0]) {
			hull() {
				cylinder(r=d, h=thickness); 
				translate([catch_width+snap_bar_width-catch_min_width/2, catch_min_width/2, 0]) 
					cylinder(r=catch_min_width/2, h=thickness); 
				// top of "arrow", sloping inwards to allow more bending
				translate([0.85 * (catch_width+snap_bar_width-catch_min_width/2), catch_length-catch_min_width/2, 0]) 
					cylinder(r=catch_min_width/2, h=thickness); 
			}
			//cube([catch_width, catch_length, thickness]);
		}

	}
}

module snap() {
	snap_half();
	mirror([1, 0, 0]) snap_half();	
}

module bracket_half() {

	translate([-mount_width/2, 0, 0]) {
		// screw mount
		difference() {
			cube([2*screw_land+screw_head+thickness, mount_height, thickness]);
			translate([screw_land + screw_head/2, screw_land + screw_head/2, -d]) screw_hole();
		}
		translate([2*screw_land+screw_head, 0, 0]) {
			cube([thickness, mount_height, thickness + gap + thickness]);
			translate([0, 0, gap + thickness]) {
				cube([snap_width/2 + thickness + d, mount_height, thickness]);
			}
		}

	}
}

module bracket() {
	bracket_half();
	mirror([1, 0, 0]) bracket_half();	
}

if (view == "demo") {
	snap();
	color("Red") translate([0, mount_cc_dist-d, 0]) bracket();
}
if (view == "snap") {
	snap();
}
if (view == "bracket") {
	translate([0, -2, 0]) rotate([90, 0, 0])  bracket();
}
if (view == "both") {
	snap();
	translate([0, -2, 0]) rotate([90, 0, 0])  bracket();
}
