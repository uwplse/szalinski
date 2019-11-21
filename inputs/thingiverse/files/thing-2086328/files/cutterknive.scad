length = 122;
height = 27;
width = 10;

blade_width = 1.5;
blade_height = 19;
blade_margin = 10;

num_holes = 12;
hole_margin = 8;
hole_height = height/2;
hole_radius = 2.2;
pin_radius = 2;

text_pos_x = 5;
text_pos_y = 5;
text_size = 5;
text_content = "DiddyDevelopment";
text_depth = 1;

rotate([90]) 
difference() {
roundedcube([length,height,width],false,3,"all");

union() {
translate([blade_margin,(height-blade_height)/2,(width-blade_width)/2]) cube([500,blade_height,blade_width]);
for(i=[0:num_holes-1]) translate([blade_margin+hole_margin+i*hole_margin,hole_height,0]) cylinder(200,hole_radius,hole_radius,center=true);
    
translate([text_pos_x,text_pos_y,width-text_depth]) linear_extrude(text_depth) text(text_content,size = text_size);

}

}



translate([width,width/2,0]) cylinder(width,pin_radius,pin_radius,center=false);




// Higher definition curves
$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

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
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}