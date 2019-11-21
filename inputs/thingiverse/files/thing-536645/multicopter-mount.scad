//
//  Mounting brackets for Quanum 680 and other platforms
//  that use twin tubes as equipment mounts
// 
//  by Egil Kvaleberg
//


// platform mounting tube diameter
mount_tube_dia = 10.1;  // leave some space to make fitting easier

// platform mounting tube distance
mount_tube_dist = 110.0;  // center to center (applies to dual)


// tune these:
// example: "dual" / 48 / 65 / 12 / 3
//          "single" / 40 / x / 12 / 3
//          "servo" / x / x / 12 / 3

// type of mount
mount_type = "servo"; // [ dual, single, servo ]
// offset from center line, use 0 for flat bar
mount_offset = 28.0;
// exit angle from mount 		
mount_angle = 65;
// width of clamp		
mount_width = 12;  
// wall thickness		
mount_wall = 3;		   

//servo_flange_width = 28;
//servo_screw = 2.0;
//servo_flange_height = 16; // height to bottom of mount flange

// for servo mount: flange width
servo_flange_width = 35.0;
// for servo mount: screw diameter
servo_screw = 2.5;
// for servo mount: height to bottom of mount flange
servo_flange_height = 20.0; 

// gap of flange
mount_gap = 1.0;
// mount screw diameter
screw = 3.0; // M3 is 3.0 and M2.5 is 2.5	 
// nut, across flats
nut = 5.5;    // M3 is 5.5
// nut height
nut_h = 1.5;    // M3
mount_screw = screw + 0.2;
nut_w = nut + 0.2; 
mount_flange = nut_w+2*nut_h;  // depth of flange

j = 1*0.1;
$fs = 1*0.1;

module nut_cage() {	
	difference ( ) {
		cylinder(r1 = (nut_w/2)/cos(30) + nut_h, r2 = (nut_w/2)/cos(30), h = nut_h);
		translate([0, 0, nut_h/2]) union () {
			cube([nut_w, tan(30)*nut_w, nut_h+j], center=true);
			rotate ([0, 0, 60]) cube([nut_w, tan(30)*nut_w, nut_h+j], center=true);
			rotate ([0, 0, 120])cube([nut_w, tan(30)*nut_w, nut_h+j], center=true);
		}
	}
}

module Mount_Flange_add()
{
	union () {
		cylinder(r = mount_tube_dia/2 + mount_wall, h = mount_width);
		translate([-(2*mount_wall+mount_gap)/2, 0, 0]) cube([2*mount_wall+mount_gap, mount_tube_dia/2+mount_wall+mount_flange, mount_width]);
		translate([-(mount_wall+mount_gap/2), mount_tube_dia/2 + mount_wall + mount_flange*.4, mount_width/2]) rotate([0, -90, 0]) nut_cage(); // screw hole
	}
}

module Mount_Flange_sub()
{
	translate([0, 0, -j]) union () {
		cylinder(r = mount_tube_dia/2, h = mount_width+2*j);
		translate([-mount_gap/2, 0, 0]) cube([mount_gap, mount_tube_dia/2+mount_width, mount_width+2*j]);
		translate([-(2*mount_wall+mount_gap+2*j)/2, mount_tube_dia/2 + mount_wall + mount_flange*.4, mount_width/2]) rotate([0, 90, 0]) cylinder(r = mount_screw/2 + 0.1, h = 2*mount_wall+mount_gap+2*j); // screw hole
	}
}

module Mount_Beam(gap, length)
{		
	translate([-mount_wall/2, gap, 0]) cube([mount_wall, length, mount_width]);
}

module Mount_Dual(offset, angle)
{
	leg = offset/cos(90-angle)-mount_tube_dia/2;
	color([0, 200/255, 0, 0.5])
	difference () {
		union () {
			translate([0, mount_tube_dist/2, 0]) Mount_Flange_add();
			translate([0, -mount_tube_dist/2, 0]) translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_add();

			if (leg > 0) {
				// left part	
				translate([0, -mount_tube_dist/2, 0]) rotate([0, 0, angle]) Mount_Beam(mount_tube_dia/2, leg);
				translate([-offset, offset/tan(angle)-mount_tube_dist/2, 0]) cylinder(r = mount_wall/2, h = mount_width);
				// straight part	
				translate([-offset, -mount_tube_dist/2, 0]) Mount_Beam(offset/tan(angle), mount_tube_dist - 2*offset/tan(angle));

				// right part	
				translate([0, mount_tube_dist/2, 0]) rotate([0, 0, 180-angle]) Mount_Beam(mount_tube_dia/2, leg);
				translate([-offset, -offset/tan(angle)+mount_tube_dist/2, 0]) cylinder(r = mount_wall/2, h = mount_width);
			} else {
				// straight part
				translate([0, -mount_tube_dist/2, 0]) Mount_Beam(offset/tan(angle), mount_tube_dist - 2*offset/tan(angle));
			}
		}
		union () {
			translate([0, mount_tube_dist/2, 0]) Mount_Flange_sub();
			translate([0, -mount_tube_dist/2, 0]) translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_sub();
		}
	}
}

module Mount_single(leg)
{
	color([0, 200/255, 0, 0.5])
	difference () {
		union () {
			 translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_add();

			// straight part
			Mount_Beam(mount_tube_dia/2, leg - mount_tube_dia/2);

		}
		union () {
			translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_sub();
		}
	}
}


module Mount_servo(dist)
{
	module column(dx)
	{
		translate([dx, mount_tube_dia/2, 0]) {
			difference() {
				union() {
					cube([mount_wall, mount_wall+servo_flange_height, mount_width]);
					translate([mount_wall/2, mount_wall+servo_flange_height, mount_width/2]) rotate([90, 0, 0]) cylinder(r = 1.0+servo_screw/2, h = 1.0 + servo_flange_height/2); 
				}
				// hole for servo mounting screw
				translate([mount_wall/2, mount_wall+servo_flange_height+j, mount_width/2]) rotate([90, 0, 0]) cylinder(r = servo_screw/2, h = j+servo_flange_height/2); 
			}
		}
	}

	//color([0, 200/255, 0, 0.5])
	difference () {
		union () {
			 translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_add();

			// servo
			column(-mount_tube_dia/2 - mount_wall);
			column(dist - mount_tube_dia/2 - mount_wall);
			translate([-mount_tube_dia/2 - mount_wall, mount_tube_dia/2, 0]) cube([dist+mount_wall, mount_wall, mount_width]);

		}
		union () {
			translate([0, 0, mount_width]) rotate([180, 0, 0]) Mount_Flange_sub();
		}
	}
}


module view()
{
	if (mount_type == "dual") Mount_Dual(mount_offset, mount_angle);
	else if (mount_type == "single") Mount_single(mount_offset);
	else if (mount_type == "servo") Mount_servo(mount_offset);
	else echo("Unknow mount_type");
}

view();

