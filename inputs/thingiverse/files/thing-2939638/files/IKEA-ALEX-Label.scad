// preview[view:south, tilt:top]

/* [General Settings] */

label_text = "Custom Text";
//Cut/Extrude distance (mm). A negative value creates inset text, a positive value creates extruded text.
extrude_distance = 2; // [-1.8:0.1:4.1]

// Does not apply to text that is cut all the way through the label, which is hardcoded to use a stencil font (Allerta Stencil). When set to Braille, the "#" symbol can be used for the dots-3456 number indicator. 
font_type = 5; //[6:Braille, 5:Allerta (Sans Serif), 4:Roboto (Sans Serif), 3:Delius (Handwriting), 2:Courgette (Handwriting), 1:Comfortaa (Display), 0:Righteous (Display)] 

font_size = 13; //[8:0.5:15]

/* [Braille Settings] */
//Dot radius and height (mm). The rest of the Braille parameters are set according to the Marburg Medium Braille font standard
dot_radius = 0.8; // [0.5:0.1:1]
//Extra offset from left (mm).
braille_x_offset = 0;
//Extra offset from top (mm).
braille_y_offset = 0;


/* [Adjustments] */
//Adjust these parameters if the label has trouble fitting in the groove of the 3D printed handle. (All mm)
label_thickness = 1.8; // [1.4:0.1:1.8]
label_width = 154.5;
label_height = 21.6;
chamfer_size = 2;


/* [Hidden] */
$fn = 10;
//More braille settings
spacing = 2.5;
distance = 3.5 + spacing;
char_count = len(label_text);

//Sans Serif fonts

module text_cut_through(input_text) { //Converts text for cutting all the way through label (uses Allerta stencil font)
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Allerta Stencil:style=Regular", halign = "center", valign = "center");
	}
}

module text_cutter_allerta(input_text) { //Converts text (Allerta font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Allerta:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_allerta(input_text) { //Converts text (Allerta font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Allerta:style=Regular", halign = "center", valign = "center");
	}
}

module text_cutter_roboto(input_text) { //Converts text (Roboto font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Roboto:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_roboto(input_text) { //Converts text (Roboto font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Roboto:style=Regular", halign = "center", valign = "center");
	}
}

//Handwriting fonts

module text_cutter_delius(input_text) { //Converts text (Delius font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Delius:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_delius(input_text) { //Converts text (Delius font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Delius:style=Regular", halign = "center", valign = "center");
	}
}

module text_cutter_courgette(input_text) { //Converts text (Courgette font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Courgette:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_courgette(input_text) { //Converts text (Courgette font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Courgette:style=Regular", halign = "center", valign = "center");
	}
}

//Display fonts

module text_cutter_comfortaa(input_text) { //Converts text (Comfortaa font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Comfortaa:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_comfortaa(input_text) { //Converts text (Comfortaa font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Comfortaa:style=Regular", halign = "center", valign = "center");
	}
}

module text_cutter_righteous(input_text) { //Converts text (Righteous font) from 2D to 3D for cutting
	linear_extrude(height = (-extrude_distance)+0.02) {
		text(label_text, size = font_size, font = "Righteous:style=Regular", halign = "center", valign = "center");
	}
}

module text_extruder_righteous(input_text) { //Converts text (Righteous font) from 2D to 3D for extrusion
	linear_extrude(height = extrude_distance) {
		text(label_text, size = font_size, font = "Righteous:style=Regular", halign = "center", valign = "center");
	}
}


/*
Braille Module
http://creativecommons.org/licenses/by/3.0/
*/

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
					sphere(dot_radius, center = true);
				}
			}
		}
	}
}

module braille_char(char) {
	if (char == "A" || char == "a") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "B" || char == "b") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "C" || char == "c") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "D" || char == "d") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "E" || char == "e") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "F" || char == "f") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "G" || char == "g") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "H" || char == "h") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "I" || char == "i") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else if (char == "J" || char == "j") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "K" || char == "k") {
		letter([
			1,0,
			0,0,
			1,0
		]);
	} else if (char == "L" || char == "l") {
		letter([
			1,0,
			1,0,
			1,0
		]);
	} else if (char == "M" || char == "m") {
		letter([
			1,1,
			0,0,
			1,0
		]);
	} else if (char == "N" || char == "n") {
		letter([
			1,1,
			0,1,
			1,0
		]);
	} else if (char == "O" || char == "o") {
		letter([
			1,0,
			0,1,
			1,0
		]);
	} else if (char == "P" || char == "p") {
		letter([
			1,1,
			1,0,
			1,0
		]);
	} else if (char == "Q" || char == "q") {
		letter([
			1,1,
			1,1,
			1,0
		]);
	} else if (char == "R" || char == "r") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "S" || char == "s") {
		letter([
			0,1,
			1,0,
			1,0
		]);
	} else if (char == "T" || char == "t") {
		letter([
			0,1,
			1,1,
			1,0
		]);
	} else if (char == "U" || char == "u") {
		letter([
			1,0,
			0,0,
			1,1
		]);
	} else if (char == "V" || char == "v") {
		letter([
			1,0,
			1,1,
			1,0
		]);
	} else if (char == "W" || char == "w") {
		letter([
			0,1,
			1,1,
			0,1
		]);
	} else if (char == "X" || char == "x") {
		letter([
			1,1,
			0,0,
			1,1
		]);
	} else if (char == "Y" || char == "y") {
		letter([
			1,1,
			0,1,
			1,1
		]);
	} else if (char == "Z" || char == "z") {
		letter([
			1,0,
			0,1,
			1,1
		]);
	} else if (char == " ") {
		letter([
			0,0,
			0,0,
			0,0
		]);
	} else if (char == "#") {
		letter([
			0,1,
			0,1,
			1,1
		]);        
	} else if (char == "0") {
		letter([
			0,1,
			1,1,
			0,0
		]);
	} else if (char == "1") {
		letter([
			1,0,
			0,0,
			0,0
		]);
	} else if (char == "2") {
		letter([
			1,0,
			1,0,
			0,0
		]);
	} else if (char == "3") {
		letter([
			1,1,
			0,0,
			0,0
		]);
	} else if (char == "4") {
		letter([
			1,1,
			0,1,
			0,0
		]);
	} else if (char == "5") {
		letter([
			1,0,
			0,1,
			0,0
		]);
	} else if (char == "6") {
		letter([
			1,1,
			1,0,
			0,0
		]);
	} else if (char == "7") {
		letter([
			1,1,
			1,1,
			0,0
		]);
	} else if (char == "8") {
		letter([
			1,0,
			1,1,
			0,0
		]);
	} else if (char == "9") {
		letter([
			0,1,
			1,0,
			0,0
		]);
	} else {
		echo("Invalid Character: ", char);
	}

}

module braille_str(label_text, char_count) {
	union() {
		for (count = [0:char_count-1]) {
			translate(v = [0, count * distance, 0]) {
				braille_char(label_text[count]);
			}
		}
	}
}

module chamfers(w, h, t, ch_s){ //generates chamfers for label (takes label width, height, thickness and chamfer size as parameters)
    union() {
            translate([-w/2, -h/2, t/2]) rotate([0,0,45]) cube([ch_s,ch_s,t+1], true);
            translate([w/2, -h/2, t/2]) rotate([0,0,45]) cube([ch_s,ch_s,t+1], true);
            translate([-w/2, h/2, t/2]) rotate([0,0,45]) cube([ch_s,ch_s,t+1], true);
            translate([w/2, h/2, t/2]) rotate([0,0,45]) cube([ch_s,ch_s,t+1], true);
    }
}


if(font_type == 6){ //Extrude Braille
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([(-(label_width/2)+12+braille_x_offset),((label_height/2)-braille_y_offset),label_thickness]) rotate([0,0,-90]) braille_str(label_text, char_count);
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}

else if(extrude_distance < 0 && (abs(extrude_distance) >= label_thickness)){ //Cut Allerta Stencil font text through label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cut_through(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
        }
    }
}

else if(extrude_distance < 0 && font_type == 5){ //Cut Allerta font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_allerta(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance < 0 && font_type == 4){ //Cut Roboto font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_roboto(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance < 0 && font_type == 3){ //Cut Delius font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_delius(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance < 0 && font_type == 2){ //Cut Courgette font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_courgette(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance < 0 && font_type == 1){ //Cut Comfortaa font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_comfortaa(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance < 0 && font_type == 0){ //Cut Righteous font text into label
    
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        union() {
            translate([0, 1, (label_thickness+extrude_distance-0.01)]) text_cutter_righteous(label_text) ;
            chamfers(label_width, label_height, label_thickness, chamfer_size);
       }
    }
}

else if(extrude_distance == 0) {//If text is enabled and set to 0 height, create blank label
    difference() {
        translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }    
}

else if(extrude_distance > 0 && font_type == 5){ //Extrude Allerta font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_allerta(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}

else if(extrude_distance > 0 && font_type == 4){ //Extrude Roboto font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_roboto(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}


else if(extrude_distance > 0 && font_type == 3){ //Extrude Delius font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_delius(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}

else if(extrude_distance > 0 && font_type == 2){ //Extrude Courgette font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_courgette(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}

else if(extrude_distance > 0 && font_type == 1){ //Extrude Comfortaa font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_comfortaa(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}

else if(extrude_distance > 0 && font_type == 0){ //Extrude Righteous font text

    
    difference() {
        union() {
            translate([0,0,label_thickness/2]) cube([label_width, label_height, label_thickness], true);
            translate([0, 1, label_thickness]) text_extruder_righteous(label_text) ;     
        }
        
        chamfers(label_width, label_height, label_thickness, chamfer_size);
    }
}