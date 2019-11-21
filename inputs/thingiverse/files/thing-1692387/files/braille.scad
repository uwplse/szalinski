/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/


// mm sizes from http://dots.physics.orst.edu/gs_layout.html
dot_height = 0.8;
dot_offset= -0.3;
spacing = 2.4;
distance = 6.2;

plate_height = 15;
plate_thickness = 2;
plate_corner = 4;

support_disc = true;
support_disc_r = 15;
support_h = 0.3; //ensure only single layer

//The text (ONLY CAPS)
chars = ["M","A","C","H","U"," ","P","I","C","C","H","U"];
char_count = 12;

$fn = 20;

/////////////////////////////////////////////////////////////////

module letter(bitmap) {
	row_size = 2;
	col_size = 3;
	bitmap_size = row_size * col_size;
	
	function loc_x(loc) = (floor(loc / row_size) * spacing) + spacing;
	function loc_y(loc) = loc % row_size * spacing  + (distance-spacing)/2;

	for (loc = [0:bitmap_size - 1]) {
		if (bitmap[loc] != 0) {
			union() {
				translate(v = [loc_x(loc)+(plate_height-10)/2, loc_y(loc), dot_offset ]) {
					sphere(r = (dot_height-dot_offset)*bitmap[loc], center = true);
				}
			}
		}
	}
}


module braille_char(char) {
	if (char == "A") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "B") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "C") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "D") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "E") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "F") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "G") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "H") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "I") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "J") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "K") {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if (char == "L") {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if (char == "M") {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if (char == "N") {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if (char == "O") {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if (char == "P") {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if (char == "Q") {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if (char == "R") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "S") {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if (char == "T") {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if (char == "U") {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if (char == "V") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "W") {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if (char == "X") {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if (char == "Y") {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if (char == "Z") {
		letter([
			1,0,
			0,1,
			1,1
		]);
	} else {
		echo("Invalid Character: ", char);
	}

}

module braille_str(chars, char_count) {
	echo(str("Total Width: ", distance * char_count, "mm"));
	union() {
		for (count = [0:char_count-1]) {
			translate(v = [0, count * distance, plate_thickness]) {
				braille_char(chars[count]);
			}
		}
		translate(v = [0, -distance/2, 0]) {
			//color([0,0,1]) {
			//	cube(size = [plate_height, distance * (char_count+1), plate_thickness]);
			//}
            color([0,0,1]){
                linear_extrude(height = 2, center = false, convexity = 10, twist = 0){
                polygon(points=[[0,plate_corner],[0,distance * (char_count+1)],[plate_height,distance * (char_count+1)],[plate_height,0],[plate_corner,0]]);
                }
            }
		}
	}
}








union()
{
	rotate([0,90,0]) braille_str(chars, char_count);
	// uncomment next line to have a small "foot" added for better adhesion to the print platform or raft
    if (support_disc == true){
	translate([0,(distance * (char_count+1)),-plate_height]) cylinder(h=support_h,r=support_disc_r,center = false );
    translate([0,-5,-plate_height]) cylinder(h=support_h,r=support_disc_r,center = false );
    }
}