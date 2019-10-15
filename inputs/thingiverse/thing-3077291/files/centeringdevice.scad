/*[Center]*/
// Outer diameter 
diameter = 110;

// Thickness of bow
bow_thickness=4;

// Each bows width
bow_width=15;

// Number of bows
number_bows=5;

// Innerdiameter
Innerdiameter=38.5; 
// Thickness of inner shell
thickness_inner= 8; // [1:40]

// Extra lenght inner shell
extra_length = 0; // [0:40]

height = diameter + extra_length;

//Roundness. High number give rounder circles. Use a lower value if you get timeout.
fn=16; // [1:40]
$fn = fn;
center();
module center() {
difference(){
    union() {
        difference(){
            difference(){
                sphere(r=diameter/2, center=true);
                sphere(r=diameter/2-bow_thickness/2, center=true);
            }
            sectors();
        }
        cylinder(r=Innerdiameter/2+thickness_inner/2, h=height, center=true);
        }
        cylinder(r=Innerdiameter/2, h=height, center=true); 
}
}

module sectors() {
    union(){
        steg=(360-number_bows*bow_width)/number_bows;
        for(angle = [0 : steg+bow_width : 360]) {
            translate([0,0,-height/2]) sector(height, diameter, angle, angle+steg-bow_width);
        }
    }
}


module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
} 