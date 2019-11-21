// Zeldathon Recovery Triforce Bas Relief Ring (Customizable)
// by pikafoop (www.pikaworx.com)

/* [Basic Options] */

// : U.S. Ring Size (see Advanced Options to specify diameter in mm)
ring_size = 14; //[4:0.25:16]

/* [Advanced Options] */

// (mm)
ring_height = 9; //[5:0.25:20]

// (mm) : Override ring size and specify inner diameter; 0 means use ring size
ring_diameter = 0;

// (mm) : How thin can we print a base layer on your printer?
thinnest_layer = 0.8; //[0.8:0.1:2]

// (mm) : How much thicker should the thickest part of the ring be?
thickest_feature = 0.5; //[0.5:0.1:2]

// Pattern repitions. Leave a 0 to use the default for selected ring size.
pattern_repititions = 0; 

/* [Hidden] */

// Do we want opposing triforces, or just one set?
opposing_triforces = 1; // [1:Opposing,0:One Set]

// Do we want a solid ring with bas relief triforces, or for the triforces to be "floating"?
bas_relief = 1; // [1:Bas Relief,0:Floating]

resolution = 120;

// if we don't override the ring size, calculate using https://en.wikipedia.org/wiki/Ring_size#Equations
inner_diameter = ring_diameter ? ring_diameter : 11.63 + 0.8128*ring_size;
echo(inner_diameter=inner_diameter);

// PARAMATER ALIASES
ring_base_width = thinnest_layer; //mm
ring_extrusion = thickest_feature; //mm

$fn = resolution;

tri_d = ring_height;

num_tf = pattern_repititions == 0 ? floor(3.14*inner_diameter / tri_d / 2 - 0.5) * 2 : pattern_repititions;

intersection() {
    difference() {
        cylinder( d=inner_diameter + thinnest_layer * 2 + thickest_feature*2, h=ring_height );
        translate([0,0,-1]) cylinder( d=inner_diameter, h=ring_height + 2 );
    }
    for( theta = [0 : 360 / num_tf : 359.9] ) {
        rotate([0,0,theta]) translate([0,0,ring_height/2]) rotate([90,0,0]) triforce( tri_d, inner_diameter/2 + thickest_feature*5 );
        if (opposing_triforces == 1) {
            rotate([0,0,theta+360/num_tf/2]) translate([0,0,ring_height/2]) rotate([180,0,0]) rotate([90,0,0]) triforce( tri_d, inner_diameter/2 + thickest_feature*5 );
        }
    }
}

difference() {
    union() {
        cylinder( d=inner_diameter + thinnest_layer * 2 + thickest_feature * 2, h=ring_height/20 );
        if (bas_relief == 1) {
            cylinder( d=inner_diameter + thinnest_layer * 2, h=ring_height );
        }
        translate([0,0,ring_height/20]) cylinder( d1=inner_diameter + thinnest_layer * 2 + thickest_feature * 2, d2=inner_diameter+thinnest_layer * 2, h=ring_height/10 );
        translate([0,0,17*ring_height/20]) cylinder( d2=inner_diameter + thinnest_layer * 2 + thickest_feature * 2, d1=inner_diameter+thinnest_layer * 2, h=ring_height/10 );
        translate([0,0,19*ring_height/20]) cylinder( d=inner_diameter + thinnest_layer * 2 + thickest_feature * 2, h=ring_height/20 );
    }
    translate([0,0,-1]) cylinder( d=inner_diameter, h=ring_height + 2 );
}

module triforce( d, h ) {
    translate([0, -d/8, 0]) rotate([0,0,-30]) difference() {
        cylinder( d = d, h = h, $fn = 3 );
        rotate([0,0,180]) translate([0,0,-1])
        cylinder( d = d/2.3, h=h+2, $fn = 3);
    }
}