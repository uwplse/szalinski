// OB-2020 T-Slot Cable Holder
// v1, 26/3/2019
// by inks007
// Modified for 2020 profile by frol, 2019-04-05
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (CC BY-NC-SA 4.0)

// Cable holder length
holder_ln = 15;
// Cable holder inner diameter (range = 5-36)
holder_id = 9; // [5:36]
// Cable holder thickness (range = 2-4)
holder_th = 1.5; // [0.5:0.25:4]
// Loosen fit (range = 0-0.3)
loosen = 0.1; // [0:0.05:0.31]

/* [Profile Sizes] */

profile_slot_width=6.2;
profile_slot_depth=6.1;
profile_cage_width=11;
profile_cage_corner_cut=2.55;
profile_wall_thickness=1.9;

/* [Hidden] */

holder_hln = holder_ln/2;
holder_ir = holder_id/2;
holder_od = holder_id+holder_th*2;
holder_or = holder_ir+holder_th;
holder_os = sqrt(pow(holder_ir+holder_th,2)-pow(profile_slot_width/2,2))-holder_ir;
cut_os = 0.6*holder_ir;
cut_points = [[0,0],[0,cut_os-1],[1,cut_os],[holder_hln+0.1,cut_os]];

rotate([-90,90,0]) holder();

module holder() {
	difference() {
		rotate([0,-90,0]) linear_extrude(holder_ln,convexity=3,center=true) difference() {
			union() {
				offset(delta=-loosen) flange_profile();
				intersection() {
					translate([holder_ir+holder_os,0]) circle(d=holder_od,$fn=90);
					translate([holder_id+holder_os,0]) square(holder_od+2,center=true);
				}
				translate([holder_ir/2+holder_os/2,0]) square([holder_ir+holder_os,holder_od],center=true);
			}
			translate([holder_ir+holder_os,0]) circle(d=holder_id,$fn=90);
		}
		// Base cut
		translate([0,0,-10]) linear_extrude(10.1+holder_os+holder_ir,convexity=2) square([holder_ln+2,0.01],center=true);
		// Z cut
		rotate_duplicate([0,0,1]) translate([0,0,holder_os+holder_ir]) linear_extrude(holder_or+1,convexity=2) for (p=[0:1:len(cut_points)-2]) hull() {
			translate(cut_points[p]) circle(r=0.01,$fn=8);
			translate(cut_points[p+1]) circle(r=0.01,$fn=8);
		}
		// Screwdriver slot
		translate([0,0,holder_os+holder_ir+holder_or/2+0.5]) cube([0.5,cut_os*2-3,holder_or+1],center=true);
		// Slide on chamfers
		rotate_duplicate([0,0,1]) translate([holder_hln,cut_os,holder_os+holder_ir]) cylinder(r=1,h=holder_or+1,$fn=4);
		rotate_duplicate([0,0,1]) translate([holder_hln,0,-10]) cylinder(r=2,h=10.1+holder_os+holder_ir,$fn=4);
//		rotate_duplicate([0,0,1]) translate([holder_hln,0,-10]) linear_extrude(10.1+holder_os+holder_ir,convexity=2) polygon([[1,2],[0,2],[-2,0],[-1,0],[0,-1],[1,-1]]);
		// Remove half
		translate([0,(holder_id+holder_th)/2+1,-10]) linear_extrude(10.1+holder_os+holder_ir,convexity=2) square([holder_ln+2,holder_id+holder_th+2],center=true);
		translate([0,0,holder_os+holder_ir]) linear_extrude(holder_or+1,convexity=2) for (p=[0:1:len(cut_points)-2]) hull() {
			translate(cut_points[p]) rotate(90) square(holder_id+holder_th);
			translate(cut_points[p+1]) rotate(90) square(holder_id+holder_th);
		}
		rotate(180) translate([0,0,holder_os+holder_ir]) linear_extrude(holder_or+1,convexity=2) for (p=[0:1:len(cut_points)-2]) hull() {
			translate(cut_points[p]) rotate(-90) square(holder_id+holder_th);
			translate(cut_points[p+1]) rotate(-90) square(holder_id+holder_th);
		}
	}
}

// OB-2020 slot profile
module flange_profile() {
    sw=profile_slot_width/2;
    sd=profile_slot_depth;
    st=profile_wall_thickness;
    cw=profile_cage_width/2;
    cc=profile_cage_corner_cut;
    rotate(-90)
        polygon([
            [-sw,1],
            [-sw,-st],
            [-cw,-st],
            [-cw,-sd+cc],
            [-cw+cc,-sd],
            [cw-cc,-sd],
            [cw,-sd+cc],
            [cw,-st],
            [sw,-st],
            [sw,1]
        ]);
}

module mirror_duplicate(axis) {
	x = axis[0] ? [0,1] : [0];
	y = axis[1] ? [0,1] : [0];
	z = axis[2] ? [0,1] : [0];
	for (a=x) mirror([a,0,0]) for (b=y) mirror([0,b,0]) for (c=z) mirror([0,0,c]) children();
}

module rotate_duplicate(v,n=2) {
	step = 360/n;
	for (a=[0:step:359]) rotate(a=a,v=v) children();
}