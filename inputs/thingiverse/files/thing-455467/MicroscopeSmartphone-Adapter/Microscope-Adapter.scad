eyepiece_diameter = 30; 
distance_away = 2.5; 
lens_diameter = 20;
cam_x = 9.28; 
cam_y = 7.35; 
wall_height = 10; 
wall_thickness = 3;
tube_length= 30; 

outer_diameter = eyepiece_diameter+5; 
plate_w = cam_y + outer_diameter/2 + wall_thickness; 
plate_h = cam_x + outer_diameter/2 + wall_thickness; 

rotate([0,180,0]){
difference(){ 
	union(){ 
		translate([cam_y - plate_w + wall_thickness, cam_x - plate_h + wall_thickness, 0]){ 
			cube([plate_w, plate_h, 2.5]); 
		}
		cylinder(tube_length + distance_away, outer_diameter/2, outer_diameter/2);
	}
	translate([0,0,distance_away]){ 
		cylinder(tube_length + distance_away, eyepiece_diameter/2, eyepiece_diameter/2);
	} 
	translate([0,0,-1]){
		cylinder(tube_length + distance_away, lens_diameter/2, lens_diameter/2);
	}
}
translate([-outer_diameter/2,cam_x,-wall_height]){
	cube([plate_w, wall_thickness, wall_height]);
}
translate([cam_y,-outer_diameter/2,-wall_height]){
	cube([wall_thickness, plate_h, wall_height]);
}
}