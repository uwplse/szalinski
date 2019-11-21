innermost_ring_radius = 5;
gyro_rings = 5;
ring_thickness = 3;
ring_height = 5;
spacing = 0.7;

module gyro_ring(radius, thickness, height, spacing, top = true) {
    $fn = 64;

	
	top_r = height * 0.35355339059327376220042218105242;
	semi_thickness = thickness / 2;
	
	module top() {
		cylinder(r1 = top_r, r2 = 0, h = top_r);
			
		translate([0, 0, -spacing / 2]) 
			linear_extrude(spacing, center = true) 
				circle(top_r);
	}
	
	rotate_extrude() 
	    translate([-radius, 0, 0]) difference() {
		    square([thickness, height], center = true);
		    translate([semi_thickness, 0, 0]) rotate(45) 
			    square([top_r, top_r], center = true);
		
	    }
		
	if(top) {
		translate([radius + semi_thickness, 0, 0]) 
			rotate([0, 90, 0]) top();
		translate([-radius - semi_thickness, 0, 0]) 
			rotate([0, -90, 0]) top();
	}
}

module gyro(innermost_radius, rings, thickness, height, spacing) {
	for(i = [0:rings - 2]) {
		rotate(90 * (i % 2)) 
			gyro_ring(innermost_radius + (spacing + thickness) * i, thickness, height, spacing);
	}
	
	rotate(90 * ((rings - 1) % 2)) 
		gyro_ring(innermost_radius + (spacing + thickness) * (rings - 1), thickness, height, spacing, false);
}

gyro(innermost_ring_radius, gyro_rings, ring_thickness, ring_height, spacing);
