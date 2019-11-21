only_one_piece = "YES";  //  [YES,NO]
same_side = "YES";  //  [YES,NO]

piece_side_length = 25;
// for n x n multiplication puzzle
n = 9; // [1:9]
spacing = 0.5;

/* [IF_ONLY_ONE_PIECE_ENABLED] */

number_for_one_piece = 4; 
flat_sides = "NONE"; // [NONE, TOP_RIGHT, BOTTOM_RIGHT, TOP_LEFT, BOTTOM_LEFT, TOP_SIDES, BOTTOM_SIDES, RIGHT_SIDES, LEFT_SIDES]

// Create a puzzle piece.
//
// Parameters: 
//     side_length - the length of the piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
//     same_side - whether the piece has the same side.
module puzzle_piece(side_length, spacing, same_side = true) {
	$fn = 48;

	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;

	difference() {
		square(side_length - spacing);
		
		// left
		translate([half_circle_radius - spacing, side_length_div_4 , 0]) 
			circle(circle_radius);
		translate([half_circle_radius - spacing, side_length_div_4 * 3, 0]) 
			circle(circle_radius);
			
		// top
		if(same_side) {
			translate([side_length_div_4, side_length - half_circle_radius, 0]) 
				circle(circle_radius);
		
			translate([side_length_div_4 * 3, side_length - half_circle_radius, 0]) 
				circle(circle_radius);		
		} else {
			translate([side_length_div_4 * 2, side_length - half_circle_radius, 0]) 
				circle(circle_radius * 1.5);
		}
	}

	// right
	translate([side_length + half_circle_radius - spacing, side_length_div_4, 0]) 
		circle(bulge_circle_radius);
	translate([side_length + half_circle_radius - spacing, side_length_div_4 * 3, 0]) 
		circle(bulge_circle_radius);

	// bottom
	if(same_side) {
		translate([side_length_div_4, -half_circle_radius, 0]) 
			circle(bulge_circle_radius);
		translate([side_length_div_4 * 3, -half_circle_radius, 0]) 
			circle(bulge_circle_radius);
	} else {
		translate([side_length_div_4 * 2, -half_circle_radius, 0]) 
			circle(bulge_circle_radius * 1.5);	
	}
}

// Create a puzzle piece with a text.
//
// Parameters: 
//     side_length - the length of the piece.
//     text - a text shown on the piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
//     same_side - whether the piece has the same side.
module puzzle_piece_with_text(side_length, text, spacing, same_side = true) {
    half_side_length = side_length / 2;
	
    difference() {
		puzzle_piece(side_length, spacing, same_side);
		translate([half_side_length, half_side_length, 0]) 
			rotate(-45) 
			     text(text, size = side_length / 3, 
					 halign = "center", valign = "center");
	}
}

// Create a multiplication_puzzle.
//
// Parameters: 
//     xs - the amount of pieces in x direction.
//     ys - the amount of pieces in y direction.
//     piece_side_length - the length of a piece.
//     spacing - a small space between pieces to avoid overlaping while printing.
//     same_side - whether the piece has the same side.
module multiplication_puzzle(xs, ys, piece_side_length, spacing, same_side = true) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
	
	intersection() {
		union() for(x = [0 : xs - 1]) {
			for(y = [0 : ys - 1]) {
			    r = (x + 1) * (y + 1);
				linear_extrude(r) union() {
					translate([piece_side_length * x, piece_side_length * y, 0]) 
						puzzle_piece_with_text(piece_side_length, str(r), spacing, same_side);
						
					if(x == 0) {
						translate([half_circle_radius, side_length_div_4 + piece_side_length * y, 0]) 
							circle(circle_radius);
						translate([half_circle_radius, side_length_div_4 * 3 + piece_side_length * y, 0]) 
							circle(circle_radius);			
					}
					if(y == ys - 1) {
					    if(same_side) {
							translate([side_length_div_4 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
								circle(circle_radius);
							translate([side_length_div_4 * 3 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) 
								circle(circle_radius);	
						} else {
							translate([side_length_div_4 * 2 + piece_side_length * x, piece_side_length * (y + 1) - half_circle_radius, 0]) circle(circle_radius * 1.5);						
						}
					}
				}
                linear_extrude(r - 0.6) 
					translate([piece_side_length * x, piece_side_length * y, 0]) 
					    puzzle_piece(piece_side_length, spacing, same_side);
			}
		}
		
		linear_extrude(81) square([piece_side_length * xs - spacing, piece_side_length * ys - spacing]);
	}
}


module only_one_piece(n, piece_side_length, number_for_one_piece, spacing, same_side = true, flat_sides = "NONE") {
    $fn = 48;
    circle_radius = piece_side_length / 10;
    half_circle_radius = circle_radius / 2;
    side_length_div_4 = piece_side_length / 4;    
    
    linear_extrude(number_for_one_piece) union() {

        if(flat_sides == "NONE") {
            puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));
        } else if(flat_sides == "BOTTOM_RIGHT") {
            intersection() {
                puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES")); 
                
                square([piece_side_length * 2, piece_side_length - spacing]);
            }
        } else if(flat_sides == "BOTTOM_LEFT") {
            intersection() {
                union() {
                    puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));   
        

                    translate([half_circle_radius - spacing, side_length_div_4, 0]) 
                        circle(circle_radius);
                    translate([half_circle_radius - spacing, side_length_div_4 * 3, 0]) 
                        circle(circle_radius);
                }                    

                 translate([0, -side_length_div_4, 0]) square([piece_side_length * 2, piece_side_length * 2]);
            }             
        } else if(flat_sides == "TOP_RIGHT") {
            intersection() {
                puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));   
                 translate([0, -side_length_div_4, 0]) square([piece_side_length - spacing, piece_side_length * 2]);
            }
        } else if(flat_sides == "TOP_LEFT") {
            intersection() {
                 union() {
                     puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));   
                     
                    translate([side_length_div_4, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
                        
                    translate([side_length_div_4 * 3, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
                }
                translate([0, -piece_side_length - spacing, 0]) square([piece_side_length * 2, piece_side_length * 2]);
            }
        } else if(flat_sides == "BOTTOM_SIDES") {
             intersection() {
                union() {
                    puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));  
                    
                    translate([half_circle_radius - spacing, side_length_div_4, 0]) 
                        circle(circle_radius);
                    translate([half_circle_radius - spacing, side_length_div_4 * 3, 0]) 
                        circle(circle_radius);
                }
                square([piece_side_length * 2, piece_side_length * 2]);
            }
        } else if(flat_sides == "TOP_SIDES") {
            intersection() {
                union() {
                    puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));  
                    translate([side_length_div_4, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
                        
                    translate([side_length_div_4 * 3, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
               }
               translate([0, -piece_side_length - spacing, 0]) 
                   square([piece_side_length - spacing, piece_side_length * 2]);
           }            
        } else if(flat_sides == "RIGHT_SIDES") {
            intersection() {
               puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));     
               square([piece_side_length - spacing, piece_side_length]);
            }                   
        } else if(flat_sides == "LEFT_SIDES") {
            intersection() {
                union() {
                    puzzle_piece_with_text(piece_side_length, str(number_for_one_piece), spacing, same_side = (same_side == "YES"));  
                    
                    translate([side_length_div_4, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
                    translate([side_length_div_4 * 3, piece_side_length -half_circle_radius, 0]) 
                        circle(circle_radius);
                        
                    translate([half_circle_radius - spacing, side_length_div_4, 0]) 
                        circle(circle_radius);
                    translate([half_circle_radius - spacing, side_length_div_4 * 3, 0]) 
                        circle(circle_radius);                        
               }    
               translate([0, -piece_side_length - spacing, 0]) square([piece_side_length * 2, piece_side_length * 2]);
            }                   
        }
        
    }    
    
    half_side_length = piece_side_length / 2;
    linear_extrude(number_for_one_piece - 0.6) difference() {
		translate([half_side_length, half_side_length, 0]) 
			rotate(-45) 
			     text(str(number_for_one_piece), size = piece_side_length / 3, 
					 halign = "center", valign = "center");
	}
}

if(only_one_piece == "YES") {
    only_one_piece(n, piece_side_length, number_for_one_piece, spacing, same_side, flat_sides);
}
else {
    multiplication_puzzle(n, n, piece_side_length, spacing, same_side = (same_side == "YES"));
}