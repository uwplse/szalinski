//Which text would you like to make?
text = "Hello Kitty!"; 
//Plate thickness
plate_thickness = 2;//[1:3]


/* [Hidden] */
radius = 0.25;
spacing = 2.5;
distance = 3.75 + spacing;
plate_height = 10;
$fn = 32;



module letter(bitmap) {
	row_size = 2;
	col_size = 3;
	bitmap_size = row_size * col_size;
	
	function loc_x(loc) = floor(loc / row_size) * spacing + spacing;
	function loc_y(loc) = loc % row_size * spacing  + (distance-spacing)/2;

	for (loc = [0:bitmap_size - 1]) {
		if (bitmap[loc] != 0) {
			union() {
				translate(v = [loc_x(loc), loc_y(loc), 0]) {
					sphere(radius = radius* bitmap[loc], center = true);
				}
			}
		}
	}
}


module braille_char(char) {
	if ((char == "A") || (char == "a")|| (char == "1")) {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if ((char == "B") || (char == "b")|| (char == "2")) {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if ((char == "C") || (char == "c")|| (char == "3")) {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if ((char == "D") || (char == "d")|| (char == "4")) {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if ((char == "E") || (char == "e")|| (char == "5")) {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if ((char == "F") || (char == "f")|| (char == "6")) {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if ((char == "G") || (char == "g")|| (char == "7")) {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if ((char == "H") || (char == "h")|| (char == "8")) {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if ((char == "I") || (char == "i")|| (char == "9")) {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if ((char == "J") || (char == "j")|| (char == "0")) {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if ((char == "K") || (char == "k")) {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if ((char == "L") || (char == "l")) {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if ((char == "M") || (char == "m")) {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if ((char == "N") || (char == "n")) {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if ((char == "O") || (char == "o")) {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if ((char == "P") || (char == "p")) {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if ((char == "Q") || (char == "q")) {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if ((char == "R") || (char == "r")) {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if ((char == "S") || (char == "s")) {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if ((char == "T") || (char == "t")) {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if ((char == "U") || (char == "u")) {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if ((char == "V") || (char == "v")) {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if ((char == "W") || (char == "w")) {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if ((char == "X") || (char == "x")) {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if ((char == "Y") || (char == "y")) {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if ((char == "Z") || (char == "z")) {
		letter([
			1,0,
			0,1,
			1,1
		]);
} else if (char == ",") {
		letter([
			0,0,
			1,0,
			0,0
		]);

} else if (char == ":") {
		letter([
			0,0,
			1,1,
			0,0
		]);

} else if (char == "~") {
		letter([
			0,0,
			0,0,
			0,0
		]);

} else if (char == "\"") {
		letter([
			0,1,
			0,0,
			0,0
		]);

} else if (char == ">") {
		letter([
			0,1,
			0,1,
			0,0
		]);
} else if (char == ".") {
		letter([
			0,0,
			0,0,
			1,0
		]);

} else if (char == ";") {
		letter([
			0,0,
			1,0,
			1,0
		]);

} else if ((char == "+") ||(char == "!")) {
		letter([
			0,0,
			1,1,
			1,0
		]);

} else if ((char == "=") || (char == "(") || (char == ")")) {
		letter([
			0,0,
			1,1,
			1,1
		]);

} else if (char == "*") {
		letter([
			0,0,
			0,1,
			1,0
		]);

} else if (char == "»") {
		letter([
			0,0,
			1,0,
			1,1
		]);

} else if (char == "«") {
		letter([
			0,0,
			0,1,
			1,1
		]);

} else if (char == "-") {
		letter([
			0,0,
			0,0,
			1,1
		]);

} else if (char == "#") {
		letter([
			0,1,
			0,1,
			1,1
		]);

} else if (char == "'") {
		letter([
			0,1,
			0,0,
			0,0
		]);

} else if (char == "?") {
		letter([
			0,0,
			1,0,
			0,1
		]);

} else if (char == "/") {
		letter([
			0,0,
			1,1,
			0,1
		]);


} else if (char == "<") {
		letter([
			0,0,
			0,1,
			0,1
		]);

} else if (char == "$") {
		letter([
			0,1,
			0,0,
			0,1
		]);

}else if (char == "%") {
		letter([
			1,1,
			1,1,
			1,1
		]);

}else if (char == "_") {
		letter([
			0,1,
			0,1,
			0,1
		]);

	} else if (char == " ") {
		letter([
			0,0,
			0,0,
			0,0
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
			color([0,0,1]) {
				cube(size = [plate_height, distance * (char_count+1), plate_thickness]);
			}
		}
	}
}






chars = text;
char_count = len(text);




	rotate([0,90,0]) braille_str(chars, char_count);
	