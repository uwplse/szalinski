chars = "3DP";
font_name = "Arial Black";
innermost_ring_radius = 6;
ring_thickness = 6;
ring_height = 6; 
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

module text_gyro(chars, font_name, innermost_ring_radius, ring_thickness, ring_height, spacing) {
	gyro_rings = len(chars);
	half_h = ring_height / 2;
	each_ch_offset = ring_thickness + spacing;

	gyro(
	    innermost_ring_radius, 
		gyro_rings, 
		ring_thickness, 
		ring_height, 
	    spacing
	);

	for(i = [0:gyro_rings - 1]) {
		r = innermost_ring_radius - ring_thickness / 2 + each_ch_offset * i;
		step = 360 / ceil(6.28318 * r / ring_thickness);

		for(a = [0:step:360]) {
			rotate(a) translate([0, innermost_ring_radius + each_ch_offset * i, half_h]) 
				linear_extrude(0.6) 
					text(
					    chars[gyro_rings - i - 1], 
						size = ring_thickness * 0.8, 
						halign = "center", valign = "center", 
						font = font_name
					);
		}
	}

	translate([0, innermost_ring_radius + each_ch_offset * gyro_rings - half_h, 0]) rotate([0, 90, 0]) 
	    linear_extrude(ring_height * 0.4, center = true) difference() {
		    circle(half_h, $fn = 24);
		    offset(r = -half_h * 0.5) circle(half_h, $fn = 24);
	}
}

text_gyro(chars, font_name, innermost_ring_radius, ring_thickness, ring_height, spacing);
