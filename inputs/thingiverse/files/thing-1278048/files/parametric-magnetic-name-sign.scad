/*
Parametric Magnetic Name Sign
http://www.thingiverse.com/thing:1278048/

By Paul Houghton
Twitter: @mobile_rat
Email: paulirotta@gmail.com
Blog: http://paul-houghton.com/

Creative Commons Attribution ShareAlike License
https://creativecommons.org/licenses/by-sa/4.0/legalcode
*/


/* [Parametric Magnetic Name Sign options] */

// Sign text
text="Liva";

// Sign length
sign_length=32;

// Text X offset
text_x=3;

// Text Y offset
text_y=3;

// Sign width
sign_width=17;

// Sign thickness
sign_thickness=2; // +2*rounding as with other dimensions

// Radius of corner rounding
radius=3;

// Radius of magnet
magnet_radius=5.2;

// Thickness of magnet
magnet_thickness=5.15;

// Number of facets for approximating a sphere
$fn=10; // #sides to a circle. Try big and small numbers

sign(line1=text);

module sign(line1="Line1") {        
    difference() {
        translate([0,0,-radius]) minkowski() {
            cube([sign_length,sign_width,sign_thickness]);
            sphere(r=radius);
        }

        union() {
            translate([text_x,text_y,0]) linear_extrude(height=3) text(line1);
            magnet_hole();
        }
    }
 }

module magnet_hole() {
    translate([-radius+(sign_length + 2*radius)/2,-radius+(sign_width+2*radius)/2,-sign_thickness-radius-.9])
        cylinder($fn=256, r=magnet_radius, h=magnet_thickness);
}