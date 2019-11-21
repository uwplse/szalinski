piece_side_length = 25;
piece_height = 2;
xs = 4;
ys = 6;
spacing = 0.4;

// Create a puzzle piece.
//
// Parameters: 
//     side_length - the length of the piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
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

// Create a puzzle.
//
// Parameters: 
//     xs - the amount of pieces in x direction.
//     ys - the amount of pieces in y direction.
//     piece_side_length - the length of a piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
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
					translate([half_circle_radius, side_length_div_4 + piece_side_length * y, 0]) 
						circle(circle_radius);
					translate([half_circle_radius, side_length_div_4 * 3 + piece_side_length * y, 0]) 
						circle(circle_radius);			
				}
				if(y == ys - 1) {
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

linear_extrude(piece_height) 
    puzzle(xs, ys, piece_side_length, spacing);