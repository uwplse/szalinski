//Customizable Double Sided Token

/*Token Variables*/
token_width = 30;
token_rim_size = 4;
token_thickness = 4;

// A global overlap variable (to prevent printing glitches)
o = .1;

perfect_circle_factor = 200;

/*Text Varibles*/
sidea_font = "Impact";
sidea_letter_size = 8;
sidea_letter_height = 1;
sidea_letter_line_space = 2;
sidea_letter_text_line1 = "Good";
sidea_letter_text_line2 = "Day";
sidea_text_posy = -5;
sidea_text_posx = 0;

/*Text Varibles*/
sideb_font = "Impact";
sideb_letter_size = 8;
sideb_letter_height = 1;
sideb_letter_line_space = 1;
sideb_letter_text_line1 = "Bad";
sideb_letter_text_line2 = "Luck";
sideb_text_posy = -5;
sideb_text_posx = 0;


module multiLine(letter_size,letter_line_space){
  union(){
    for (i = [0 : $children-1])
      translate([0 , -i * (letter_size+letter_line_space), 0 ]) children(i);
  }
}

module drawtext_sidea() {

    color([.557,0.443,0,1])
        linear_extrude(height = sidea_letter_height){
            rotate([0,0,90]) translate([0,0,5]) 
            
            multiLine(sidea_letter_size, sidea_letter_line_space) {
                text(sidea_letter_text_line1, font=sidea_font, valign="center", halign="center", size=sidea_letter_size);
                text(sidea_letter_text_line2, font=sidea_font, valign="center", halign="center", size=sidea_letter_size);
            }
        }
}

module drawtext_sideb() {

    color([.557,0.443,0,1])
        linear_extrude(height = sideb_letter_height){
            rotate([0,0,90]) translate([0,0,5]) 
            
            multiLine(sideb_letter_size, sideb_letter_line_space) {
                text(sideb_letter_text_line1, font=sideb_font, valign="center", halign="center", size=sideb_letter_size);
                text(sideb_letter_text_line2, font=sideb_font, valign="center", halign="center", size=sideb_letter_size);
            }
        }
}

difference() {
     cylinder(h=token_thickness, d=token_width, $fn = perfect_circle_factor);

    
    translate([sidea_text_posy,sidea_text_posx,(token_thickness-sidea_letter_height+o)]) drawtext_sidea();
    
    translate([-sideb_text_posy,sideb_text_posx,sideb_letter_height-o]) rotate(a=180, v=[0,1,0]) drawtext_sideb();

}