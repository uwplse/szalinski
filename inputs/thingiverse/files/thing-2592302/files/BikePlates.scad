// Customizable classic bike License plate generator
//
// Makes vintage style licence plates with your name on it for
// your bicycle. The style is like the ones you find in gift shops 
// at various tourist traps. My sister was always sad that she 
// could never find one with her name. This thing is for you
// Monica! If your name is too long try adjusting the letter
// spacing, then the letter size.
//
// Of course, you are not limited to your actual name and state,
// Have fun with that!
//
// The font I used is available here:
//      http://www.fontspace.com/dave-hansen/license-plate
// You might want to download the .scad file and run it locally
// if thingiverse doesn't have that one available

// Your Name
name = "Bobby";

// Your State
state = "FLORIDA";

// Optional Bottom Text
bottom = "SUNSHINE STATE";

// Letter Spacing
spacing = 1; // [.8:.1:1.3]

// Letter Size
lsize = .7; // [.5:.1:1.0]

/* [Hidden] */
font_ = "License Plate";
size = [5.8,3.5] * 25;
c_rad = 6;


BikePlate(name, state, bottom, spacing, lsize, font_);


module BikePlate(name, state, bottom, spacing, lsize, font_) {
    color("white")  {
        linear_extrude(height = 2)
            difference () {
                offset (r=c_rad) square (size - [2,2]*c_rad, center=true);
                translate(size*.5+[-20,-10]) mounting_hole(2,3);
                mirror() translate(size*.5+[-20,-10]) mounting_hole(2,3);
            }
    }


    color("ForestGreen") linear_extrude(height = 4) {
        difference ()   {
            offset (r=c_rad-2) square (size - [2,2]*c_rad, center=true);
            offset (r=c_rad-4) square (size - [2,2]*c_rad, center=true);
        }
        text(name, spacing = spacing, font = font_, size=.5*size[1]*lsize, valign="center", halign="center");
        translate ([0, size[1]/2 - 12]) text(state, font = font_, 10, valign="center", halign="center");
        translate ([0,-size[1]/2 + 12]) text(bottom, font = font_, 10, valign="center", halign="center");
    }
}


module mounting_hole (width, radius) 
{
    hull () {
        translate([ width/2 + radius, 0]) circle(radius);
        translate([-width/2 - radius, 0]) circle(radius);
    }
}
