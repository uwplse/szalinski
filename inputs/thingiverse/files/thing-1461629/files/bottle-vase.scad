include <threads.scad>

//	   Customaizable bamboo weave style bottle vase
//		    Steven Veltema
//		    April 2, 2016
//

// must be tall enough to contain bottle and threads
VASE_height = 120; //[50:5:200]
// must be wide enough to contain bottle
VASE_diameter = 60; //[30:5:200]
// taper percentace;
VASE_taper = 0.95; //[0.5:0.05:1.5]

/* [Screw Threads] */
// height of threads
CAP_height = 10; //[5:0.5:15]
// outer diameter of threads (should be wider than bottle threads)
CAP_outer_diameter = 28.4; //[10:0.1:50]
// wall thickness enclosing threads
CAP_wall_thickness = 1.2; //[1:0.1:3]
// bottle thread pitch
CAP_pitch = 3.5; //[1:0.1:5]
// bottle lip thickness
BOTTLE_lip = 2.8; //[1:0.1:5]

/* [Mesh] */
//  multiple of extruder width recommended
MESH_thickness = 2.4; //[1:0.1:5]
MESH_rotation_angle = 30; //[10:5:360]
MESH_offset_angle = 0; //[0:5:360]
MESH_twist_a = 190; //[-720:10:720]
MESH_twist_b = 220; //[-720:10:720]

MESH_top_rotation_angle = MESH_rotation_angle;
MESH_top_offset_angle = MESH_offset_angle;

MESH_twist_one = MESH_twist_a; 
MESH_twist_one_rotation_angle = MESH_rotation_angle;
MESH_twist_one_offset_angle = MESH_offset_angle;
MESH_twist_two = -MESH_twist_a;
MESH_twist_two_rotation_angle = MESH_rotation_angle;
MESH_twist_two_offset_angle = MESH_offset_angle;
MESH_twist_three = MESH_twist_b; 
MESH_twist_three_rotation_angle = MESH_rotation_angle;
MESH_twist_three_offset_angle = MESH_offset_angle;
MESH_twist_four = -MESH_twist_b; 
MESH_twist_four_rotation_angle = MESH_rotation_angle;
MESH_twist_four_offset_angle = MESH_offset_angle;

union() {
$fn=120;

translate([0,0, VASE_height-CAP_height -MESH_thickness]) thread(CAP_outer_diameter,CAP_height,CAP_pitch,CAP_wall_thickness);

    translate([0,0, VASE_height-MESH_thickness])
          difference() {
                    cylinder(MESH_thickness,d=CAP_outer_diameter+MESH_thickness);
                    translate([0,0, -1.0]) cylinder(MESH_thickness*2,d=CAP_outer_diameter-BOTTLE_lip*2.0);
            }

mesh(MESH_thickness,MESH_twist_one_rotation_angle,MESH_twist_one_offset_angle,MESH_twist_one, VASE_taper);
mesh(MESH_thickness,MESH_twist_two_rotation_angle,MESH_twist_two_offset_angle,MESH_twist_two, VASE_taper);
mesh(MESH_thickness,MESH_twist_three_rotation_angle,MESH_twist_three_offset_angle,MESH_twist_three, VASE_taper);
mesh(MESH_thickness,MESH_twist_four_rotation_angle,MESH_twist_four_offset_angle,MESH_twist_four, VASE_taper);

difference() {
    meshtop(MESH_thickness,MESH_top_rotation_angle,MESH_top_offset_angle);
    translate([0,0, VASE_height-CAP_height+2]) cylinder(CAP_height,r=CAP_outer_diameter/2.0+CAP_wall_thickness);
}

difference() {
         translate([0,0, VASE_height-MESH_thickness]) cylinder(MESH_thickness,d=VASE_diameter*VASE_taper+MESH_thickness);
         translate([0,0, VASE_height-MESH_thickness-1]) cylinder(MESH_thickness*2,d=VASE_diameter*VASE_taper-MESH_thickness);
}

difference() {
         cylinder(MESH_thickness,d=VASE_diameter+MESH_thickness);
         translate([0,0,-1]) cylinder(6,d=VASE_diameter-MESH_thickness);
}
}



module meshtop(thickness, step, offset) {
        translate([0,0, VASE_height-thickness/2.0])
       for (rot = [offset:step:360+offset]) {
            rotate([90,0,rot]) 
                linear_extrude(height = VASE_diameter*VASE_taper/2.0, twist = 0, slices = VASE_height) {
                    square([thickness,thickness],true);
                }
         }   
}

module mesh(thickness, step, offset, twist, scale) {
    linear_extrude(height = VASE_height, twist = twist, slices = VASE_height, scale = scale) {
        for (rot = [offset:step:360+offset]) {
            rotate([0,0,rot]) 
            translate([VASE_diameter/2.0,0,0]) 
                square([thickness,thickness],true);
        }   
    translate([VASE_diameter/2.0,0,0]) square([MESH_thickness,MESH_thickness],true);
    }
}

module thread(outer_dia, height, pitch, cap_wall) {
    
    difference() {
        cylinder(height,r=outer_dia/2.0+cap_wall);
        translate([0,0,-height/2.0]) metric_thread(outer_dia, pitch, height*2.0);
    }
}

