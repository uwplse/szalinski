
/* [Text] */

// The number on the sign
number_text = "4";

// the height of the sign in millimeters
height = 150;

/* [Thickness] */

// Thickness of the backplate in mm.
backplate_thickness = 3;

// How much the text and border is raises from backplate
number_thickness = 3;

/* [Fine tuning] */

// Roundness of corners: 0 = almost square, 100 = a circle
corner_roundness = 25; // [0:100]

// Border thickness as percentage of height
border_thickness = 5; // [0:50]

// This should usually not need to be changed
aspect = 1;

/* [Hidden] */
width = (height + height * 0.53 * (len(str(number_text)) - 1)) * aspect;

$fn=100;

border_roundness = corner_roundness / 100;

number_sign();

module anti_round(r){
    difference(){
        square(2*r,center=false);
        circle(r);
    }
}

module rounded_corner(xpos, ypos, dia, degrees) {
    translate([xpos,ypos]) {
	rotate(degrees) difference() {
	    square(dia);
	     anti_round(dia);
	}
    }
}

module rounded_square(height, width, roundness) {
    difference() {
	scale([width/height,1]) square(height);
	square(roundness);
	translate([width-roundness, 0]) square(roundness);
	translate([0, height-roundness]) square(roundness);
	translate([width-roundness, height-roundness]) square(roundness);
    }
    rounded_corner(roundness, roundness, roundness, 180);
    rounded_corner(roundness, height-roundness, roundness, 90);
    rounded_corner(width-roundness, roundness, roundness, 270);
    rounded_corner(width-roundness, height-roundness, roundness, 0);
}


module rounded_border(height, width, roundness, rwidth) {
    minkowski () {
	difference() {
	    rounded_square(height, width, roundness);
	    translate([1,1]) rounded_square(height-2, width-2, roundness);
	}
	circle(rwidth/2);
    }
}


module number_sign() {
    fudge = 0.1;
    translate([0,0,backplate_thickness-fudge]) {
	linear_extrude(number_thickness + fudge) {
	    rounded_border(height, width, height * border_roundness / 2,
			   height * border_thickness/100);
	    translate([height/5, height/6]) scale(height/14) text(str(number_text));
	}
    }

    linear_extrude(backplate_thickness) {
	minkowski () {
	    rounded_square(height, width, height * border_roundness / 2);
	    circle(height * border_thickness/100/2);
	}
    }
}
