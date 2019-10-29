// Customizable Bobbin Maker by Elliot Boney

// preview[view:south, tilt:top]

/* [Global] */
// Preview the bobbin split into two pieces.
split_preview = true; //[true,false]

/* [Bobbin] */
// Outer Diameter of the Bobbin in mm
bobbin_diameter = 21.85;

// Height of the Bobbin in mm
bobbin_height = 7.5;

// Hole Diameter in mm
bobbin_hole_diameter = 6;

// Wall Width in mm. Adjust this to match your nozzle print width.
wall_width = .96;

/* [Tweaks] */
// Tolerance for pieces to fit together on the inside. Increase this number if you print and your pieces won't fit together.
tolerance = 0.1;

// Tolerance in case the bobbin ends up too tall. Increase this number to shorten the bobbin.
height_tolerance = 0.1;



/* [Hidden] */
$fn = 50;
eps1 = 0 + 00.01;
eps2 = 2 * eps1;

if (split_preview == true) {
translate([bobbin_diameter+bobbin_diameter*.1,0,bobbin_height-wall_width])
rotate([0,180,0])
    top();
} else {
    top();
}



bottom();


module bottom() {
    difference() {
        union() {
            disc(bobbin_diameter,wall_width, bobbin_height);
            center(bobbin_hole_diameter,wall_width, bobbin_height-height_tolerance);
        }
        cutout(bobbin_hole_diameter,wall_width, bobbin_height);
    }
}

module top() {
    difference() {
        translate([0,0,bobbin_height-wall_width])
            union() {
                difference() {
                    disc(bobbin_diameter,wall_width, bobbin_height);
                        translate([bobbin_hole_diameter-wall_width,0,-bobbin_height])
                          cylinder(d=1.5,h=bobbin_height*2);
                }
                translate([0,0,-(bobbin_height-wall_width*2)/2+eps2*2])
                    cylinder(d=bobbin_hole_diameter+4*wall_width+tolerance, h=bobbin_height-height_tolerance-wall_width, center=true);
            }
         translate([0,0,(bobbin_height-wall_width)/2-eps1])
             cylinder(d=bobbin_hole_diameter+2*wall_width+tolerance, h=bobbin_height+eps2*2, center=true);
    }
}



module disc (dia, wall, ht) {
    echo (dia, wall);
    cylinder(d=dia, h=wall, center=true);

}
    

module center(innerd,wall,ht) {
    translate([0,0,(ht-wall)/2])
        cylinder(d=innerd+2*wall, h=ht, center=true);
}
    
module cutout(innerd,wall,ht) {
    translate([0,0,(ht-wall)/2-eps1])
        cylinder(d=innerd, h=ht+2*wall+eps2, center=true);
}