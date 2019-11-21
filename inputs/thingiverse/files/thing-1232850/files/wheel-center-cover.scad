/*
Wheel Center Cover
http://www.thingiverse.com/thing:1232850/

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: http://paul-houghton.com/

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode
*/


/* [Wheel Center Cover Options] */


// Radius of the cap (outside dimension)
Cap_Radius = 27.25;
// Height of the cap (how far it sticks out from the wheel surface)
Cap_Height = 7;
// Radius of the riser between the cap and the wheel grips
Throat_Radius = 25.55;
// Height of the wheel grips
Grip_Height = 17.2;

// Difference between inside and outside radius of the throat and wheel grips
Thickness = 6;
center_radius = Cap_Radius - Thickness;
// Height between the cap and the grips
notch_offset = 3.5;
notch_height = Grip_Height - notch_offset - Cap_Height; // from notch radially outward
// Height of corner rounding
Notch_Bevel_Height = 1.6;
// Width of space between wheel grips
Cut_Width = 22;
// Number of facets to approximate a circle
$fn=64;



difference() {
	union() {
		color("red") cap();
        color("green") throat();
		color("blue") notch();
	}
	union() {
        center_cutout();
		cut(0);
		cut(90);
		cut(180);
		cut(270);
	}
}

module cap() {
    cylinder(r=Cap_Radius, h=Cap_Height);
}

module throat() {
    cylinder(r=Throat_Radius, h=Grip_Height);    
}

module center_cutout() {
    translate([0, 0, Cap_Height]) cylinder(r=center_radius, h=Grip_Height);    
}

module notch() {
    translate([0, 0, Cap_Height + notch_offset]) hull() {
        cylinder(r=Throat_Radius, h=notch_height);
        translate([0, 0, Notch_Bevel_Height]) cylinder(r=Cap_Radius, h=notch_height - 2*Notch_Bevel_Height);
    }
}

module cut(angle) {
	rotate([0, 0, angle]) {
        translate([-Cut_Width/2, 0, Cap_Height + notch_offset]) 
            cube([Cut_Width, 100, 100]);
	}
}

