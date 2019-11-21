height = 30;
piece_set = "black"; // [black, white]
spacing = 0.3;
symbol = "YES"; // [YES, NO]

// create a generalized pentagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module generalized_pentagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(36);
	s = (r - spacing / 2) / r;
	
    color("black") 
	    rotate(18) 		     
		     linear_extrude(length * 4, scale = 2.7135)
		        scale([s, s, s])
			        children(); 
}

// create a generalized hexagon by length.
// Parameters:
//     length : the side length
//     spacing : the gap between a pentagon or a hexagon
module generalized_hexagon(length, spacing = 0.5) {
    r = 0.5 * length / sin(30);
	s = (r - spacing / 2) / r;

    color("white") 
	     linear_extrude((length - length * 0.0245) * 4, scale = 2.7135) 
		    scale([s, s, s])			
		        children();
}

// create a pentagon according the height of the soccer polyhedron
module pentagon_for_soccer_polyhedron(height) {
    line_length = height / 6.65;
    circle(0.5 * line_length / sin(36), $fn = 5);
} 

// ==================================================================

// a generalized pentagon and a generalized hexagon for a puzzle.
// Parameters:
//     length : the side length
//     spacing : the gap between the pentagon and hexagon
module generalized_pentagon_based_sub_for_puzzle(length, spacing = 0.5) {
	pentagon_circle_r = 0.5 * length / sin(36);
	
	generalized_pentagon(length, spacing) children(0); 
	
	a = 37.325;
	
	offset_y = 0.5 * length * tan(54) + pentagon_circle_r * cos(a);
	offset_z = 0.5 * length * tan(60) * sin(a);
	
	for(i = [0:4]) {
		rotate(72 * i) translate([0, -offset_y, -offset_z]) 
			rotate([a, 0, 0]) 
				generalized_hexagon(length, spacing) children(1); 
	}
}

module pentagon_puzzle(radius, shell_thickness, spacing) {
    height = (radius + 2) * 2;
    line_length = height / 6.65;
	

	intersection() {
		translate([0, 0, line_length * 5.64875  -height / 2]) 
			generalized_pentagon_based_sub_for_puzzle(line_length, spacing) {
pentagon_for_soccer_polyhedron(height);
hexagon_for_single_soccer_puzzle_circles_only(height, spacing);
}


		sphere(radius * 2, $fn = 48);
	}
}

// create a hexagon according the height of the soccer polyhedron
module hexagon_for_single_soccer_puzzle(height, spacing) {
    line_length = height / 6.65;
    r = 0.5 * line_length / sin(30);
	
	difference() {
		circle(r, $fn = 6);
		
		for(i = [0:2]) {
			rotate(90 + i * 120)
				translate([r / 1.325, 0, 0]) 
					circle(r / 4.5, $fn = 48);
		}
	}
}


// create circles around a hexagon according the height of the soccer polyhedron
module hexagon_for_single_soccer_puzzle_circles_only(height, spacing) {
    line_length = height / 6.65;
    r = 0.5 * line_length / sin(30);
	s = (r - spacing * 4) / r;	
	
	rotate(90) 
		translate([r / 1.325, 0, 0]) 
			scale([s, s, 1])
				circle(r / 4.5, $fn = 48);
}

module hexagon_puzzle(radius, shell_thickness, spacing) {
    height = (radius + 2) * 2;
    line_length = height / 6.65;
	
	rotate([37.325, 0, 0]) intersection() {
		translate([0, 0, line_length * 5.5836  -height / 2]) 
			generalized_hexagon(height / 6.65, spacing)
				hexagon_for_single_soccer_puzzle(height, spacing);

		sphere(radius * 2, $fn = 48);
	}		
}

// create a pentagon according the height of the soccer polyhedron
module pentagon_for_soccer_puzzle_with_text(height, text) {
	difference() {
		pentagon_for_soccer_polyhedron(height);
		rotate(-18) text(text, font = "MS Gothic", valign = "center", halign = "center", size = height / 7);
	}	
}

module pentagon_puzzle_with_text(radius, text, shell_thickness, spacing) {
    height = (radius + 2) * 2;
    line_length = height / 6.65;
	
	difference() {
		union() {
			intersection() {
				translate([0, 0, line_length * 5.64875  -height / 2]) 
					generalized_pentagon_based_sub_for_puzzle(line_length, spacing) {
		pentagon_for_soccer_puzzle_with_text(height, text);
		hexagon_for_single_soccer_puzzle_circles_only(height, spacing);
	}


				sphere(radius * 2, $fn = 48);
			}
		
			pentagon_puzzle(radius - 1, shell_thickness - 1, spacing);
		}
	    linear_extrude(radius * 0.75) square([radius, radius], center = true);
	}
}

// create a hexagon according the height of the soccer polyhedron
module hexagon_for_single_soccer_puzzle_with_text(height, text, spacing) {
	difference() {
		hexagon_for_single_soccer_puzzle(height, spacing);
		translate([0, -height / 45, 0]) rotate(180) text(text, font = "MS Gothic", valign = "center", halign = "center", size = height / 7);
	}
}

module hexagon_puzzle_with_text(radius, text, shell_thickness, spacing) {
    height = (radius + 2) * 2;
    line_length = height / 6.65;
	
	difference() {
		union() {
			intersection() {
				translate([0, 0, line_length * 5.5836  -height / 2]) 
					generalized_hexagon(height / 6.65, spacing)
						hexagon_for_single_soccer_puzzle_with_text(height, text, spacing);

				sphere(radius * 2, $fn = 48);
			}
		
			rotate([-37.325, 0, 0]) hexagon_puzzle(radius - 1, shell_thickness - 1, spacing);
		}
		linear_extrude(radius * 0.75) square([radius, radius], center = true);
	}
}

module pieces(radius, black_or_white, shell_thickness, spacing) {
    offset = 2 * radius;
	
	ps = symbol == "NO" ? "      " : (black_or_white == "black" ? "♟♜♞♝♚♛" : "♙♖♘♗♔♕");

	for(i = [0:3]) {
	    for(j = [0:1]) {
			translate([offset * i, offset * j, 0])
   			    hexagon_puzzle_with_text(radius, ps[0], shell_thickness, spacing);
		}
	}

	for(i = [0:1]) {
		translate([offset * i, offset * 2, 0]) 
			hexagon_puzzle_with_text(radius, ps[1], shell_thickness, spacing);
	}
	
	for(i = [2:3]) {
		translate([offset * i, offset * 2, 0]) 
		    pentagon_puzzle_with_text(radius, ps[2], shell_thickness, spacing);
	}
 

	for(i = [0:1]) {
		translate([offset * i, offset * 3, 0]) 
		    pentagon_puzzle_with_text(radius, ps[3], shell_thickness, spacing);
	}

	translate([offset * 2, offset * 3, 0])
    	pentagon_puzzle_with_text(radius, ps[4], shell_thickness, spacing);
	
	translate([offset * 3, offset * 3, 0])
    	pentagon_puzzle_with_text(radius, ps[5], shell_thickness, spacing);
	
}

module chess(height, piece_set, shell_thickness, spacing) {
    radius = height / 1.2;
    translate([0, 0, -radius * 0.75]) 
	    pieces(radius, piece_set, shell_thickness, spacing);
}
	
chess(height, piece_set, 0, spacing);






