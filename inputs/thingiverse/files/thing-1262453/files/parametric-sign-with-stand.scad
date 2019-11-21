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


/* [Parametric Sign With Stand options] */
// Sign text top line
text_line_1="3D Print Training";

// Sign text bottom line
text_line_2="10:00 This Friday";

// Length (change to match text)
sign_length=113;

// Tilt from horizontal (90 is straight up)
stand_angle=60;

// Sign corner radius
radius=5;

// Number of facets to approximate a sphere
$fn=10;

rotate([stand_angle,0,0]) {
    sign(line1=text_line_1, line2=text_line_2);
    stand();
}

module sign(line1="Line1", line2="Line2") {        
    difference() {
        translate([-4,-6,-radius]) minkowski() {
            cube([sign_length,35,2]);
            sphere(r=radius);
        }

        union() {
            translate([0,15,0]) linear_extrude(height=3) text(line1);
            linear_extrude(height=3)text(line2);
        }
    }
    stand();
 }

module stand() {
    translate([sign_length/2-radius,-3.2,-10]) rotate([-stand_angle,0,0]) minkowski() {
        cylinder(r=20,h=2);
        sphere(r=5);
    }
}