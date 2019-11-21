// png: 100x100 pixels
filename = "";  // [image_surface:100x100]
width = 100;
x_blocks = 3; 
spacing = 0.4;
        
// Puzzle
module puzzle_piece(side_length, spacing) {
	$fn = 48;
	
	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;

	difference() {
		square(side_length - spacing);
		
		// left
		translate([half_circle_radius, side_length_div_4, 0]) 
			circle(circle_radius);
		translate([half_circle_radius, side_length_div_4 * 3, 0]) 
			circle(circle_radius);
			
		// top
		translate([side_length_div_4, side_length - half_circle_radius, 0]) 
			circle(circle_radius);
		translate([side_length_div_4 * 3, side_length - half_circle_radius, 0]) 
			circle(circle_radius);		
	}

	// right
	translate([side_length + half_circle_radius, side_length_div_4, 0]) 
		circle(bulge_circle_radius);
	translate([side_length + half_circle_radius, side_length_div_4 * 3, 0]) 
		circle(bulge_circle_radius);

	// bottom
	translate([side_length_div_4, -half_circle_radius, 0]) 
		circle(bulge_circle_radius);
	translate([side_length_div_4 * 3, -half_circle_radius, 0]) 
		circle(bulge_circle_radius);
}

module puzzle(xs, ys, piece_side_length, spacing) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
	
	intersection() {
		union() for(x = [0 : xs - 1]) {
			for(y = [0 : ys - 1]) {
				translate([piece_side_length * x, piece_side_length * y, 0]) 
					puzzle_piece(piece_side_length, spacing);
					
				if(x == 0) {
					// left
					translate([half_circle_radius, side_length_div_4 + piece_side_length * y, 0]) 
						circle(circle_radius);
					translate([half_circle_radius, side_length_div_4 * 3 + piece_side_length * y, 0]) 
						circle(circle_radius);			
				}
				if(y == ys - 1) {
					// top
					translate([side_length_div_4 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
						circle(circle_radius);
					translate([side_length_div_4 * 3 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
						circle(circle_radius);	
				}
			}
		}
		
		square([piece_side_length * xs - spacing, piece_side_length * ys - spacing]);
	}
} 

module image_to_surface(filename, width) {
    $fn = 48;
    origin_width = 100;
	half_origin_width = 50;
	scale_factor = width / origin_width;

	scale([scale_factor, scale_factor, 1])  union() {
		color("white") intersection() {			   
		   linear_extrude(4) square(origin_width); 
		   scale([1, 1, 10]) surface(file = filename);
		} 
		
		color("black") linear_extrude(2) square(origin_width);  
	}
}    

module image_to_puzzle(filename, width, x_blocks, spacing) {       
	piece_side_length = width / x_blocks;
	y_blocks = x_blocks;

	intersection() {
		image_to_surface(filename, width);
		linear_extrude(15)
			 puzzle(x_blocks, y_blocks, piece_side_length, spacing);    		 
	}	
}
 
image_to_puzzle(filename, width, x_blocks, spacing);

