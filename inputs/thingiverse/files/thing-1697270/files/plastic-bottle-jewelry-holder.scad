bottle_bottom_radius = 30;
thickness = 1.5;
height = 50;

module frame(thickness) {
    difference() {
        children();
        offset(r = -thickness) children();
    }
}

module plastic_bottle_jewelry_holder(bottle_bottom_radius, height, thickness) {
    $fn = 64;
	
	ring_outer_r = bottle_bottom_radius + 2 * thickness;
	
    gravity_center_to_apex = ring_outer_r / cos(30);
	
	for(i = [0:120:240]) {
		rotate(i) 
		    translate([gravity_center_to_apex, 0, 0]) 
				linear_extrude(thickness, scale = 0.95) 
						frame(thickness)
  						    circle(ring_outer_r);
	}

	linear_extrude(height, twist = 45, scale = 0.5) difference() {
		circle(gravity_center_to_apex, $fn = 3);
		for(i = [0:120:240]) {		
			rotate(i) 
			    translate([gravity_center_to_apex, 0, 0])
                    circle(ring_outer_r - thickness / 2);
		}
	}

	translate([0, 0, height]) difference() {
		sphere(ring_outer_r / 1.5);
		linear_extrude(ring_outer_r) 
			square([ring_outer_r * 2, ring_outer_r * 2], center = true);
	}
}

plastic_bottle_jewelry_holder(bottle_bottom_radius, height, thickness);
