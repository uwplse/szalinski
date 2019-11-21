// Shawn Rutledge 2018 https://www.thingiverse.com/ecloud
// GoPro-compatible 3-tab mount taken from https://www.thingiverse.com/thing:909819 by Nicholas Brookins

// width of the powerpack (plus cushioning, plus clearance depending on your printer)
powerpack_width = 45.5;
// height of the powerpack (plus cushioning, plus clearance depending on your printer)
powerpack_thickness = 25;
// how thick should the walls be around the powerpack
wall_thickness = 2;

//height of the mount from one edge of the holder to the center of the gopro bolt hole
gopro_mount_height = 8.5;

//the width of this clamp
clamp_width = 14;
//Style of hole for bolt clearance on top half
clamp_top_hole_style = 2; //[0:None, 1:Round, 2:HexNut]
//Style of hole for bolt clearance on bottom half
clamp_bottom_hole_style = 1;//[0:None, 1:Round, 2:HexNut]

// width of the powerbank bolt clip
powerbank_clamp_width = 10;

//width of the gopro mount
gopro_mount_width = 14.5;
//width of the tab that hangs off the gopro
gopro_mount_tab_width = 9.7;
//with of the middle slot in the gopro tab
gopro_mount_tab_slot_width = 3.1;
//width of the gopro bolt nut
gopro_mount_nut_width= 9.5;
//diameter of the gopro bolt
gopro_mount_bolt_diameter = 5.1;

//auto vars
gopro_nut_flare = 1.5;
gopro_nut_flarewidth = 2.5;
gopro_mount_height_adj = gopro_mount_height + powerpack_thickness / 2 + wall_thickness;
$fn=24;

module nut_holder(mount_width, stickout) {
	translate([-mount_width/2,0, stickout])
	rotate([0,-90,0])
	difference(){
		cylinder(r1=clamp_width/2, r2=gopro_mount_nut_width/2 + gopro_nut_flare, h=gopro_nut_flarewidth);
		translate([0,0,-.01])
		cylinder(d=gopro_mount_nut_width, h=gopro_nut_flarewidth+.02, $fn=6);
	}
}

module gopro_tabs(){
	difference(){
		union(){
			//mount body
			translate([0,0, gopro_mount_height_adj/2])
			cube([gopro_mount_width, clamp_width, gopro_mount_height_adj], center=true);
			//rounded top
			translate([0,0, gopro_mount_height_adj])
			rotate([0,-90,0])
			cylinder(d=clamp_width, h=gopro_mount_width, center=true);

			//nut flare and hole
			nut_holder(gopro_mount_width, gopro_mount_height_adj);
		}
		//GoPro Bolt Hole
		translate([0,0, gopro_mount_height_adj])
		rotate([0,-90,0])
		cylinder(d=gopro_mount_bolt_diameter, h=gopro_mount_width*2, center=true);

		//gopro tab and slot
		translate([0,0,gopro_mount_height_adj ])
		difference(){
			cube([gopro_mount_tab_width, clamp_width+.1, gopro_mount_height_adj*2], center=true);
			cube([gopro_mount_tab_slot_width, clamp_width+.15, gopro_mount_height_adj*2], center=true);
		}
	}
}

module clamp_tabs(){
	clamp_stickout = 4 + powerpack_thickness / 2 + wall_thickness;
	difference() {
		union() {
			//mount body
			translate([0,0, clamp_stickout/2])
			cube([powerbank_clamp_width, clamp_width, clamp_stickout], center=true);
			//rounded top
			translate([0,0, clamp_stickout])
			rotate([0,-90,0])
			cylinder(d=clamp_width, h=powerbank_clamp_width, center=true);

			//nut flare and hole
			nut_holder(powerbank_clamp_width, clamp_stickout);
		}
		//GoPro Bolt Hole
		translate([0,0, clamp_stickout])
		rotate([0,-90,0])
		cylinder(d=gopro_mount_bolt_diameter, h=gopro_mount_width*2, center=true);
	}
}

module lozenge(l, w, h) {
	union() {
		translate([w / -2, 0, h / -2])
			cube([w, l - w, h]);
		translate([0, 0, h / -2])
			cylinder(d=w,h=h);
		translate([0, l - w, h / -2])
			cylinder(d=w,h=h);
	}
}

difference() {
	union() {
		rotate([90, 0, 0]) translate([0, 0, 0]) gopro_tabs();
			lozenge(powerpack_width + wall_thickness * 2, powerpack_thickness + wall_thickness * 2, clamp_width);
		translate([0, powerpack_width - powerpack_thickness, 0]) rotate([-90, 0, 0]) clamp_tabs();
			lozenge(powerpack_width + wall_thickness * 2, powerpack_thickness + wall_thickness * 2, clamp_width);
	};
	lozenge(powerpack_width, powerpack_thickness, clamp_width + 1);
	translate([0, powerpack_width - 2, 0]) cube([3, gopro_mount_height_adj + wall_thickness, gopro_mount_height_adj + wall_thickness] , center=true);
}
