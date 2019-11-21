// Game Tokens
// Token instantiation

Token("Ω");     // enter your letter or symbol including some unicodes



// Token definition.

module Token(symbol, xpos=0) {
    difference() {
        size = 10;          // size of the Token in mm, default is 10
		symb_size = 0.8;    // scale of the symbol in relation to the token size,
							// should not be higher than 0.9
																		
        x=xpos*size;
        translate([x,0,size/4]) cube([size,size,size/2], center=true);
        translate([x,0,size/6]) {
            // convexity is needed for correct preview
            // since characters can be highly concave
            linear_extrude(height=size/2, convexity=4)
                text(symbol, 
                     size=size*(symb_size),
                     font="Bitstream Vera Sans",	// this font will be used for the symbol
                     halign="center",
                     valign="center");
        }
    }
}
