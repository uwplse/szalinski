height = 50; 
spacing = 0.5;

// create a pentagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module pentagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(36);
	s = (r - spacing / 2) / r;

    color("black") 
	    rotate(18) 		     
		     linear_extrude(length, scale = 1.42215)
		        scale([s, s, s])
			        circle(0.5 * length / sin(36), $fn = 5);
}

// create a hexagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module hexagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(30);
	s = (r - spacing / 2) / r;

    color("white") 
	     linear_extrude(length - length * 0.02125, scale = 1.42215) 
		    scale([s, s, s])			
		        circle(0.5 * length / sin(30), $fn = 6);
}

// a placeholder pentagon, one pentagon and two hexagons.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module pentagon_based_sub_comp(length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * length / sin(36);
	
	a = 37.325;
	
	offset_y = 0.5 * length * tan(54) + pentagon_circle_r * cos(a);
	offset_z = 0.5 * length * tan(60) * sin(a);
	
	translate([0, -offset_y, -offset_z]) 
	    rotate([a, 0, 0]) 
		    hexagon_based_sub_comp(length, spacing);
}


// two hexagons and one pentagon.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module hexagon_based_sub_comp(length, spacing = 0.5) {
    hexagon(length, spacing);
	
	length_center_to_side = 0.5 * length * tan(54);
	
    a = -37.325;
	
	offset_y = 0.5 * length * (tan(54) * cos(a) + tan(60));
	offset_z = length_center_to_side * sin(a);
	
	rotate(120) translate([0, offset_y, offset_z]) 
	    rotate([a, 0, 0]) 
	        pentagon_hexagon(length, spacing);
			
}

// a pentagon and a hexagon.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module pentagon_hexagon(length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * length / sin(36);
	
	pentagon(length, spacing);
	
	a = 37.325;
	
	offset_y = 0.5 * length * tan(54) + pentagon_circle_r * cos(a);
	offset_z = 0.5 * length * tan(60) * sin(a);
	
	rotate(144) translate([0, -offset_y, -offset_z]) 
	    rotate([a, 0, 0]) 
		    hexagon(length, spacing);
}

// a half of soccer polyhedron.
// Parameters:
//     line_length : the side length of pentagons and hexagons
//     spacing : the gap between the pentagon and hexagon
module half_soccer_polyhedron(line_length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * line_length / sin(36);
	offset_y = pentagon_circle_r * cos(36);

	pentagon(line_length, spacing);
	
	for(i = [0:4]) {
		rotate(72 * i) 
		    pentagon_based_sub_comp(line_length, spacing);
	}
}

// a soccer polyhedron.
// Parameters:
//     line_length : the side length of pentagons and hexagons
//     spacing : the gap between the pentagon and hexagon
//     center : center it or not
module soccer_polyhedron(height, spacing = 0.5, center = true) {
    line_length = height / 6.65;
	
	offset_for_center = center ? height / 2: 0;
	
	translate([0, 0, -offset_for_center]) union() {
		translate([0, 0, -line_length + line_length * 6.64875]) 
		    half_soccer_polyhedron(line_length, spacing);
			
		rotate(36) mirror([0, 0, 1]) translate([0, 0, -line_length]) 
		    half_soccer_polyhedron(line_length, spacing);
	}
}

soccer_polyhedron(height, spacing); 
