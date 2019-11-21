holder_inner_radius = 35;
hole_radius = 8;
holes = 16;
height = 5;
thickness = 1;

module colour_pen_holder(holder_inner_radius, hole_radius, holes, height, thickness) {
	$fn = 48;
	step = 360 / holes;

	linear_extrude(height) difference() {
		circle(holder_inner_radius + thickness * 2 + hole_radius * 2);
		circle(holder_inner_radius);
		for(a = [0:step:360 - step]) {
			rotate(a) 
                translate([hole_radius + holder_inner_radius + thickness, 0, 0]) 
                    circle(hole_radius);
		}
	}
    
	linear_extrude(thickness) 
		circle(holder_inner_radius + thickness * 2 + hole_radius * 2);
}

colour_pen_holder(holder_inner_radius, hole_radius, holes, height, thickness);