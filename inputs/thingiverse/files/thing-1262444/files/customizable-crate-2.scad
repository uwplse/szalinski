// Customizable Crate
// by Kevin McCormack

// The length of the inside of the box in mm
inside_length = 50; //[10:1:300]
// The width of the inside of the box in mm
inside_width = 50; //[10:1:300]
// Height of the box in mm
height = 50; //[10:1:300]

// Thickness of the walls in mm
wall_thickness = 1; //[1:0.1:4]

// Diameter of crate holes
hole_d = 5; //[2:1:20]

outside_length = inside_length + (wall_thickness * 2);
outside_width = inside_width + (wall_thickness * 2);

num_x_holes =  floor(inside_length/(hole_d+2));
x_offset = inside_length/num_x_holes;
x_start = (x_offset * num_x_holes / (-2)) + (hole_d/2) + 1;
x_end = x_offset * num_x_holes / 2;

num_y_holes =  floor(inside_width/(hole_d+2));
y_offset = inside_width/num_y_holes;
//y_start = num_y_holes/(-2) * (hole_d+1);
//y_end = num_y_holes/2 * (hole_d+1);
y_start = (y_offset * num_y_holes / (-2)) + (hole_d/2) + 1;
y_end = y_offset * num_y_holes / 2;

num_z_holes =  floor(height/(hole_d+1));
z_start = height/num_z_holes;
z_offset = height/num_z_holes + 1;
z_end = height - hole_d/2 - 1;

module boxBase() {
    difference() {
        translate([0,0,height/2]) 
        cube([outside_length,outside_width,height],center=true);
        
        translate([0,0,((height/2) + wall_thickness)]) 
        cube([inside_length,inside_width,height],center=true);
        
    }
}

module bottomCuttout() {
    for (y=[y_start:y_offset:y_end]) {
        for (x=[x_start:x_offset:x_end]) {
            translate([x,y,0]) 
            cylinder(h=wall_thickness*3, d=hole_d, center=true);
        }
    }    
}

module xCuttout() {
    for (z=[z_start:z_offset:z_end]) {
        for (y=[y_start:y_offset:y_end]) {
            translate([0,y,z]) rotate([0,90,0]) 
            cylinder(h=outside_length+5, d=hole_d, center=true);
        }
    }
}

module yCuttout() {
    for (z=[z_start:z_offset:z_end]) {
        for (x=[x_start:x_offset:x_end]) {
            translate([x,0,z]) rotate([90,0,0]) 
            cylinder(h=outside_width+5, d=hole_d ,center=true);
        }
    }
}


difference() {
    boxBase();
    yCuttout();
    bottomCuttout();
    xCuttout();
}