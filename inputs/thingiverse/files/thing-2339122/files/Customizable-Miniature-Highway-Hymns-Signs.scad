// Customizable Miniature Highway Hymns Signs
// by RiverRatDC 2017
//
// Remix of http://www.thingiverse.com/thing:2289808
// by RiverRatDC 2017
//
// "Customizable Miniature Highway Hymns Signs" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//

// Select the part you'd like to print:
part="Preview"; //[Preview, Signs, Tall Signpost, Short Signpost]

/* [Sign 1 Text] */

//Sign 1 Text
line1 = "HIGHWAY HYMNS";
//Sign 1 Text Size
line1_text_size = 6.5; //[4,4.5,5,5.5,6,6.5]

/* [Sign 2 Text] */

//Sign 2 Line 1 Text
2line1 = "55 |";
//Sign 2 Line 1 Text Size
2line1_text_size = 9; //[7,8,9]
//Sign 2 Line 2 Text
2line2 = "'GOD WILL TAKE";
//Sign 2 Line 2 Text Size
2line2_text_size = 5; //[4,4.5,5,5.5,6,6.5]
//Sign 2 Line 3 Text
2line3 = "CARE OF YOU'";
//Sign 2 Line 3 Text Size
2line3_text_size = 5; //[4,4.5,5,5.5,6,6.5]

/* [Sign 3 Text] */

//Sign 3 Line 1 Text
3line1 = "75 |";
//Sign 3 Line 1 Text Size
3line1_text_size = 9; //[7,8,9]
//Sign 3 Line 2 Text
3line2 = "'NEARER MY GOD";
//Sign 3 Line 2 Text Size
3line2_text_size = 4.5; //[4,4.5,5,5.5,6,6.5]
//Sign 3 Line 3 Text
3line3 = "TO THEE'";
//Sign 3 Line 3 Text Size
3line3_text_size = 5; //[4,4.5,5,5.5,6,6.5]

/* [Sign 4 Text] */

//Sign 4 Line 1 Text
4line1 = "85 |";
//Sign 4 Line 1 Text Size
4line1_text_size = 9; //[7,8,9]
//Sign 4 Line 2 Text
4line2 = "'THIS WORLD IS";
//Sign 4 Line 2 Text Size
4line2_text_size = 5; //[4,4.5,5,5.5,6,6.5]
//Sign 4 Line 3 Text
4line3 = "NOT MY HOME'";
//Sign 4 Line 3 Text Size
4line3_text_size = 5; //[4,4.5,5,5.5,6,6.5]

/* [Sign 5 Text] */

//Sign 5 Line 1 Text
5line1 = "95 |";
//Sign 5 Line 1 Text Size
5line1_text_size = 9; //[7,8,9]
//Sign 5 Line 2 Text
5line2 = "'LORD, I'M";
//Sign 5 Line 2 Text Size
5line2_text_size = 5; //[4,4.5,5,5.5,6,6.5]
//Sign 5 Line 3 Text
5line3 = "COMING HOME'";
//Sign 5 Line 3 Text Size
5line3_text_size = 5; //[4,4.5,5,5.5,6,6.5]

/* [Sign 6 Text] */

//Sign 6 Line 1 Text
6line1 = "100|";
//Sign 6 Line 1 Text Size
6line1_text_size = 8; //[7,7.5,8,8.5,9]
//Sign 6 Line 2 Text
6line2 = "'PRECIOUS";
//Sign 6 Line 2 Text Size
6line2_text_size = 5; //[4,4.5,5,5.5,6,6.5]
//Sign 6 Line 3 Text
6line3 = "MEMORIES'";
//Sign 6 Line 3 Text Size
6line3_text_size = 5; //[4,4.5,5,5.5,6,6.5]

/* [Hidden] */

// preview[view:south, tilt:top]

print_part();

  /////////////
 // Modules //
/////////////

module print_part() {
    if (part == "Preview") {
		one_piece();
    } else if (part == "Signs") {
		signs();
    } else if (part == "Tall Signpost") {
		tall_signpost();    
	} else if (part == "Short Signpost") {
		short_signpost();    
	} 
}
module one_piece(){
    color("black") Sign();
	color("black") translate([0,-28.0,0]) Sign();
	color("black") translate([0,-28.0*2,0]) Sign();
	color("black") translate([0,-28.0*3,0]) Sign();
	color("black") translate([0,-28.0*4,0]) Sign();
    color("black") translate([0,-28.0*5,0]) Sign();
	color("white") signpost();    
	color("white") translate([0,0,1]) SignWords1(line1);
	color("white") translate([0,-28.0,1]) SignWords2(2line1,2line2,2line3);
	color("white") translate([0,-28.0*2,1]) SignWords3(3line1,3line2,3line3);
	color("white") translate([0,-28.0*3,1]) SignWords4(4line1,4line2,4line3);
	color("white") translate([0,-28.0*4,1]) SignWords5(5line1,5line2,5line3);
	color("white") translate([0,-28.0*5,1]) SignWords6(6line1,6line2,6line3);	
}
module signs(){
	color("black") Sign();
	color("black") translate([0,-28.0,0]) Sign();
	color("black") translate([0,-28.0*2,0]) Sign();
	color("black") translate([0,-28.0*3,0]) Sign();
	color("black") translate([0,-28.0*4,0]) Sign();
    color("black") translate([0,-28.0*5,0]) Sign();
	color("white") translate([0,0,1]) SignWords1(line1);
	color("white") translate([0,-28.0,1]) SignWords2(2line1,2line2,2line3);
	color("white") translate([0,-28.0*2,1]) SignWords3(3line1,3line2,3line3);
	color("white") translate([0,-28.0*3,1]) SignWords4(4line1,4line2,4line3);
	color("white") translate([0,-28.0*4,1]) SignWords5(5line1,5line2,5line3);
	color("white") translate([0,-28.0*5,1]) SignWords6(6line1,6line2,6line3);
}
module signpost(){
	translate([-20,-75,-.76]) cube([3, 175, 2], center=true);
	translate([20,-75,-.76]) cube([3, 175, 2], center=true);
	translate([0,-161,6.25]) cube([65, 3, 16], center=true);
}
module tall_signpost(){
	translate([-20,-75,0]) cube([3, 175, 3], center=true);
	translate([20,-75,0]) cube([3, 175, 3], center=true);
	translate([0,-161,6.25]) cube([65, 3, 15.5], center=true);
}
module short_signpost(){
	translate([-20,-72,0]) cube([3, 50, 3], center=true);
	translate([20,-72,0]) cube([3, 50, 3], center=true);
	translate([0,-98,6.25]) cube([65, 3, 15.5], center=true);
}
module Sign(){
    difference(){
		color("black") cube([65, 25, 3.5], center=true);
        translate([-20,0,-1]) cube([3, 28, 2], center=true);
	    translate([20,0,-1]) cube([3, 28, 2], center=true);
    }
}
module SignWords1(sign_text){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([0,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text, size=line1_text_size, font="Oswald-Regular", halign="center", valign="center"); 
		} 
	}	
}
module SignWords2(sign_text1,sign_text2,sign_text3){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([-21,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text1, size=2line1_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text2, size=2line2_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,-4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text3, size=2line3_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
}
module SignWords3(sign_text1,sign_text2,sign_text3){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([-21,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text1, size=3line1_text_size, font="Oswald-Regular", halign="center", valign="center"); 
		} 
	}
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text2, size=3line2_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,-4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text3, size=3line3_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }	
}
module SignWords4(sign_text1,sign_text2,sign_text3){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([-21,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text1, size=4line1_text_size, font="Oswald-Regular", halign="center", valign="center"); 
		} 
	}
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text2, size=4line2_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,-4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text3, size=4line3_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }	
}
module SignWords5(sign_text1,sign_text2,sign_text3){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([-21,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text1, size=5line1_text_size, font="Oswald-Regular", halign="center", valign="center"); 
		} 
	}
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text2, size=5line2_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,-4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text3, size=5line3_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }	
}
module SignWords6(sign_text1,sign_text2,sign_text3){
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([-21,0,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text1, size=6line1_text_size, font="Oswald-Regular", halign="center", valign="center"); 
		} 
	}
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text2, size=6line2_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }
	intersection(){ 
		color("black") cube([65, 25, 3.5], center=true);
		translate([9.5,-4,3]) linear_extrude(height=5, center=true, convexity=10, twist=0) {
		text(sign_text3, size=6line3_text_size, font="Oswald-Regular", halign="center", valign="center");
        }		
    }	
}
