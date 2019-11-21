filename1 = ""; // [image_surface:100x100]
filename2 = ""; // [image_surface:100x100]
radius = 20;
thickness = 4;
spacing = 0.6;

module position_around_sphere(radius, step_angle, semi_circles) {   
	for(i = [0 : step_angle : 180 * semi_circles * 2]) {
		rotate([0, 0, i])
			 rotate([0, -90 + i / (semi_circles * 2), 0])
				 translate([radius, 0, 0])
					rotate([90, 0, 90]) 
						 children();
	}
}

module spinning_ornament(radius, filename1, filename2, thickness, spacing) {  
    $fn = 48;
	
	module image_in_circle(filename) {
		translate([0, 0, thickness / 4]) 
		    scale([radius / 50 * cos(45), radius / 50 * cos(45), 1]) 
			    translate([0, 0, -0.1]) intersection() {
			        translate([0, 0, 0.1]) linear_extrude(thickness / 4) circle(50);
			        translate([-50, -50, 0]) surface(filename);
		        }
    }
	
	// ball
    difference() {
		for(az = [0 : 45 : 315]) { 
		    rotate(az)
		        position_around_sphere(radius, 0.5, 0.5)  
				    cube([thickness, thickness / 20, thickness], center = true);
		}
		translate([0, 0, -radius * 2]) linear_extrude(radius * 4) 
			circle(thickness * 1.1);
	}
	
	// spinning circle
	pole_radius1 = thickness * 1.1- spacing;
	pole_radius2 = thickness * 0.5;
	pole_height = thickness * 1.8;
	
	translate([0, 0, -radius + thickness / 2]) 
	    cylinder(r1 = pole_radius1, r2 = pole_radius2, h = pole_height, center = true);
	translate([0, 0, radius + thickness / 2]) 
	    mirror([0, 0, 1]) cylinder(r1 = pole_radius1, r2 = pole_radius2, h = pole_height);
		
	rotate([90, 0, 0]) union() {
	    image_in_circle(filename1);
		rotate([0, 180, 0]) image_in_circle(filename2);
		
	    linear_extrude(thickness / 2, center = true) 
	        circle(radius - thickness);
	}

	// ring
    translate([0, 0, radius + thickness]) rotate([90, 0, 0]) 
	    linear_extrude(thickness / 2, center = true) difference() {
	        circle(pole_radius1);
	        circle(pole_radius1 - thickness / 2);
	    }
}


spinning_ornament(radius, filename1, filename2, thickness, spacing);



