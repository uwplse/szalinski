/* [Box Dimensions] */

edge_style = 1; // [1: Rounded, 0: Sharp]

detail = 5; // [1,2,3,4,5,6,7,8,9,10]
$fs = 11 - detail;

// Width
box_width = 110;

// Depth
box_depth = 100;

// Height
box_height = 50;

// Corner radius
radius = 100;


// Wall Thickness
box_thickness = 1;

// Show Box, Lid or both
toggle_display =  0; // [0:Both, 1:Box, 2:Lid]




/* [Lid] */

// Lid Height
lid_height = 5;

// Lid Tolerance
lid_tolerance = 0.2;



/* [Hidden] */

box_radius = min(box_width/3,box_height/3,box_depth/3, radius);

box_size = [box_width,box_depth,box_height];
lid_size = [box_width, box_depth, lid_height];

if(toggle_display != 2) Box(size=box_size, radius=box_radius, wallWidth=box_thickness);
translate([toggle_display!=2 ? box_width*1.2 : 0,0,0]) if(toggle_display!=1) Lid(size=lid_size, wallWidth=box_thickness, radius=box_radius, tolerance=lid_tolerance);
    

module my_cube(size, radius, center, apply_to){
    if(edge_style){
        roundedcube(size=size,radius=radius,center=center,apply_to=apply_to);
    } else {
        cube(size=size,center=center);
    }
}

module Lid(size=[100,50,5], wallWidth=1, radius=5, tolerance=1){
    dw = (wallWidth+tolerance)*2;
    qw = (wallWidth+tolerance)*4;
    translate([0,0,size[2]/2/2])
    difference(){
        union(){
            resize([size[0],size[1],size[2]*0.5])
            my_cube(size=size, radius=radius, apply_to="z", center=true);
            translate([0,0,size[2]*0.5])
            resize([size[0]-dw,size[1]-dw,size[2]*0.5])
            my_cube(size=size, radius=radius, apply_to="z", center=true);
        }
        translate([0,0,size[2]*0.55])
        resize([size[0]-qw,size[1]-qw,size[2]/2])
        my_cube(size=size, radius=radius, apply_to="z", center=true);
        
    }
}

module Box(size=[100,50,30], wallWidth=1, radius=5){
    dw = wallWidth*2;
    translate([0,0,size[2]/2])
    difference(){
        my_cube(size=size, radius=radius, apply_to="zmin", center=true);
        resize([size[0]-dw,size[1]-dw,size[2]])
        translate([0,0,wallWidth])
            my_cube(size=size, radius=radius, apply_to="zmin", center=true);
    }
    
}



module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							rotate(a = rotate)
							cylinder(h = diameter, r = radius, center = true);
						}
					}
				}
			}
		}
	}
}