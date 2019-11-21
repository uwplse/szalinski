//design and code by emanresu (http://www.thingiverse.com/Emanresu)
//customizable servo mount for mounting hobby servos to an optics breadboard


  ////////////////
 // Parameters //
////////////////

/* [Global] */

/* [Servo Mount] */

//mounting hole type
mount_hole = "slot"; //[hole, slot]
//distance between servo mounting holes (mm)
screw_space = 28.3;
//mounting screw diameter (mm)
mount_screw_diameter = 2.1;
//how far the servo spline is from being centered between the mounting screws (mm)
shaft_offset = 3.6;
//desired height of servo spline (mm) assuming it is centered at the same height as the mounting screws
shaft_height = 25;
//thickness around mounting holes on posts (mm) set to < distance between edge of mounting holes and servo body
post_thick = 1.5;
//mounting post width
post_width = 5;

/* [Mount Base] */

//what grid are your breadboard holes spaced on? (mm)
breadboard_grid = 25.4;
//diameter of clearance hole for the type of screws your breadboard uses (mm)
breadboard_hole_diameter = 6.75;
//how many holes do you want the mounting slots to cover?
holes_x = 2;
//how many holes (inclusive) do you want the mounting slots to be spaced apart?
holes_y =3;
//how thick do you want the base? (mm)
base_thick = 2;
//how much clearance around the outside of the mounting slots do you want? (mm)
base_clearance = 5;

/* [Hidden] */

//Set openSCAD resolution
$fa=1;
$fs=0.5;

mount_screw_radius = mount_screw_diameter/2;
breadboard_hole_radius = breadboard_hole_diameter/2;


  /////////////
 // Modules //
/////////////

module mounting_holes() {
	// generates the mounting slots for bolting to the breadboard
	for (i=[0:holes_x-1:holes_x-1]) {
		for (t=[0:holes_y-1:holes_y-1]) {
			translate([i*breadboard_grid, t*breadboard_grid, 0]) {
				cylinder(r=breadboard_hole_radius, h=base_thick+1, center=false);
			}
		}	
	}
	for (j=[0:holes_y-1:holes_y-1]) {
		translate([0, j*breadboard_grid-breadboard_hole_diameter/2, 0]) {
			cube(size=[(holes_x-1)*breadboard_grid, breadboard_hole_diameter, base_thick+1], center=false);
		}
	}		
}

module mounting_plate() {
	// body...
	difference() {
		cube(size=[(holes_x-1)*breadboard_grid+2*base_clearance+breadboard_hole_diameter,
		    (holes_y-1)*breadboard_grid+2*base_clearance+breadboard_hole_diameter, base_thick], center=false);
		translate([base_clearance+breadboard_hole_radius, base_clearance+breadboard_hole_radius, -0.5]) {
			mounting_holes();
		}
	}	
}

module mount_post() {
	// body...
	if (mount_hole == "hole") {
		difference() {
			cube(size=[post_width, mount_screw_diameter+2*post_thick, shaft_height-base_thick+mount_screw_radius+post_thick], center=true);
			translate([0, 0, (shaft_height-base_thick+mount_screw_radius+post_thick)/2-(mount_screw_radius+post_thick)]) {
				rotate([0, 90, 0]) {
					cylinder(r=mount_screw_radius, h=post_width+1, center=true);
				}	
			}
		}	
	}
	if (mount_hole == "slot") {
		difference() {
			cube(size=[post_width, mount_screw_diameter+2*post_thick, shaft_height-base_thick+mount_screw_radius+post_thick], center=true);
			cube(size=[post_width+1, mount_screw_diameter, shaft_height-base_thick-mount_screw_radius-post_thick], center=true);
			translate([0, 0, (shaft_height-base_thick-mount_screw_radius-post_thick)/2]) {
				rotate([0, 90, 0]) {
					cylinder(r=mount_screw_radius, h=post_width+1, center=true);
				}	
			}
			translate([0, 0, -(shaft_height-base_thick-mount_screw_radius-post_thick)/2]) {
				rotate([0, 90, 0]) {
					cylinder(r=mount_screw_radius, h=post_width+1, center=true);
				}	
			}
		}
	}
}

module servo_mount() {
	// body...
	union() {
		translate([0, screw_space/2, (shaft_height-base_thick+mount_screw_radius+post_thick)/2+base_thick]) {
			mount_post();
		}
		translate([0, -screw_space/2, (shaft_height-base_thick+mount_screw_radius+post_thick)/2+base_thick]) {
			mount_post();
		}
		translate([0, 0, base_thick/2]) {
			cube(size=[post_width, screw_space+mount_screw_diameter+2*post_thick, base_thick], center=true);	
		}
	}
}

module bb_servo_mount() {
	// body...
	union() {
		translate([-post_width/2, ((holes_y-1)*breadboard_grid+2*base_clearance+breadboard_hole_diameter)/2 + shaft_offset, 0]) {
			servo_mount();
		}
		mounting_plate();
	}	
}


  //////////////////
 // Control Code //
//////////////////

bb_servo_mount();
