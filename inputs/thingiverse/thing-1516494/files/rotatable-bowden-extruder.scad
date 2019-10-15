// Customizable Rotable Bowden Extruder 
// preview[view:south, tilt:top];

// Which one would you like to see?
part = "both"; // [top:Motor Base,bottom:Bearing Base,both:Motor and Bearing Base]



/* [Motor Base] */

//Motor base width 
motor_base_size_x = 60;

//Motor base length 
motor_base_size_y = 30;

//Motor base height 
motor_base_size_z = 2.5;

//
bearing_top_central_hole_diameter =  12;

//
bearing_top_screw_head_diameter = 4.5;

//
bearing_top_screw_hole_diameter = 3.4;

//
bearing_top_screw_height = 4.5;

//distant between bearing top screw hole and the central
bearing_top_screw_hole_position = 9.2;

//motor width
motor_width = 42;

//
motor_holder_diameter = 4;


/* [Bearing Base] */

//Hard Disk bearing base width (mm)
bearing_base_size_x = 50;

//Hard Disk bearing base length 
bearing_base_size_y = 50;

//Hard Disk bearing base height 
bearing_base_size_z = 2.5;

//Central hole diameter    
base_central_hole_diameter = 4.95;

//Base screw diameter 
base_screw_diameter = 4;

//The distant between the screw and the central
base_screw_position = 20;



/* [Hidden] */
bearing_top_screw_head_hole_height = motor_base_size_z -bearing_top_screw_height/2;



module rounded(size, r) {
    //2 cube + 4 cylinder
    union() {
        translate([r, 0, 0]) cube([size[0]-2*r, size[1], size[2]]);
        translate([0, r, 0]) cube([size[0], size[1]-2*r, size[2]]);
        translate([r, r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, r, 0]) cylinder(h=size[2], r=r);
        translate([r, size[1]-r, 0]) cylinder(h=size[2], r=r);
        translate([size[0]-r, size[1]-r, 0]) cylinder(h=size[2], r=r);
    }
}

//bearing base
module bearingBase() {
    difference() {
        union() {
            //bearing base
            rounded([bearing_base_size_x, bearing_base_size_y, bearing_base_size_z], 3);
            //bearing central
            translate ([bearing_base_size_x/2,bearing_base_size_y/2,0]) {
                cylinder(h=(bearing_base_size_z+2.5), d=(base_central_hole_diameter+6),center=false, $fn=36);
            }
        }
        //bearing central hole
        translate ([bearing_base_size_x/2,bearing_base_size_y/2,-0.2]) {
            cylinder(h=bearing_base_size_z+2.5+1, d=base_central_hole_diameter, center=false, $fn=36);
        }
    
        //screw hole up
        translate ([bearing_base_size_x/2,bearing_base_size_y/2+base_screw_position,-0.2]) {
            cylinder(h=bearing_base_size_z+1, d=base_screw_diameter, center=false, $fn=36);
        }
    
        //screw hole down
        translate ([bearing_base_size_x/2,bearing_base_size_y/2-base_screw_position,-0.2]) {
            cylinder(h=bearing_base_size_z+1, d=base_screw_diameter, center=false, $fn=36);
        }

        //screw hole right
        translate ([bearing_base_size_x/2+base_screw_position,bearing_base_size_y/2, -0.2]) {
            cylinder(h=bearing_base_size_z+1, d=base_screw_diameter, center=false, $fn=36);
        }
    
        //screw hole left
        translate ([bearing_base_size_x/2-base_screw_position,bearing_base_size_y/2, -0.2]) {
            cylinder(h=bearing_base_size_z+10+1, d=base_screw_diameter, center=false, $fn=36);
        }
    }
}


//motor base
module motorBase () {
    difference() {
        //base
        rounded([motor_base_size_x, motor_base_size_y, motor_base_size_z], 3);
        //bearing top central hole 
        translate ([motor_base_size_x/2,motor_base_size_y/2,-0.2]) {
            cylinder(h=motor_base_size_z+1, d=bearing_top_central_hole_diameter,center=false, $fn=36);
        }
        
        //bearing screw hole (right)
        translate ([motor_base_size_x/2+bearing_top_screw_hole_position,motor_base_size_y/2,-0.2]) {
            union () {
                cylinder(h=motor_base_size_z+1, d=bearing_top_screw_hole_diameter,center=false, $fn=36);
                translate ([0,0,bearing_top_screw_height/2]) {
                    cylinder(h=bearing_top_screw_head_hole_height+1, d=bearing_top_screw_head_diameter,center=false, $fn=36);
                }
            }
        }
        //bearing screw hole (left)
        translate ([motor_base_size_x/2-bearing_top_screw_hole_position,motor_base_size_y/2,-0.2]) {
            union () {
                cylinder(h=motor_base_size_z+1, d=bearing_top_screw_hole_diameter,center=false, $fn=36);
                translate ([0,0,bearing_top_screw_height/2]) {
                    cylinder(h=bearing_top_screw_head_hole_height+1, d=bearing_top_screw_head_diameter,center=false, $fn=36);
                }
            }
        }
        
        //motor holder hole (right)
        translate ([motor_base_size_x/2+motor_width/2+motor_holder_diameter/2,motor_base_size_y/2,-0.2]) {
        cylinder(h=motor_base_size_z+1, d=motor_holder_diameter,center=false, $fn=36);
        }
        //motor holder hole (left)
        translate ([motor_base_size_x/2-motor_width/2-motor_holder_diameter/2,motor_base_size_y/2,-0.2]) {
        cylinder(h=motor_base_size_z+1, d=motor_holder_diameter,center=false, $fn=36);
        }
    }

}

module both() {
    bearingBase();
    translate ([0,bearing_base_size_y+5, 0]) {
        motorBase();
    }
}

module print_part() {
	if (part == "top") {
		motorBase();
	} else if (part == "bottom") {
		bearingBase();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

print_part();

