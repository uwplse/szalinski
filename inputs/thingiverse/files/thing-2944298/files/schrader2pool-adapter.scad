//
// Compressor (Schrader) to inflatable pool adapter
// by Klaus Moser (aka Assin)
//

/* [Settings] */

// Car tube compressor coupling length
coupler_height = 10;

// Car tube compressor coupling diameter
coupler_outer_diameter = 8.2;

// Ripple height
coupler_ripple_height = 1;

// Height of the middle cone
middle_part_height = 5;

// Large diameter of the outlet
outlet_large_diameter = 21;

// Small diameter of the outlet
outlet_small_diameter = 15;

// Heigh of the outlet
outlet_height = 15;

/* [Misc] */

// Wall thickness
wall_width = 2;

// Resolution
$fn=96;

// Avoid artifacts
clearance = 0.001;


// Calulated values
/////////////////////

/* [hidden] */

// Feedthrough hole
hole_diameter = coupler_outer_diameter-2*wall_width;


// Build
/////////
translate([0,0,middle_part_height+outlet_height]) {
    compressedAirCoupler();
}
translate([0,0,outlet_height]) {
    middle_part();
}
outlet_part();


// Modules
////////////

module compressedAirCoupler() {
    difference() {
        // Coupler
        for (h=[0:coupler_ripple_height:coupler_height-1]) {
            translate([0,0,h]) {
                cylinder(
                    d1=coupler_outer_diameter,
                    d2=coupler_outer_diameter-.3,
                    h=coupler_ripple_height
                );
            }
        }
        translate([0,0,-clearance]) {
            cylinder(
                d=hole_diameter,
                h=coupler_height+2*clearance
            );
        }
    }
}

module middle_part() {
    difference() {
        cylinder(
            d1=outlet_large_diameter,
            d2=coupler_outer_diameter,
            h=middle_part_height
        );
        translate([0,0,-clearance]) {
            cylinder(
                d=hole_diameter,
                h=middle_part_height+2*clearance
            );
        }
    }
}

module outlet_part() {
    difference() {
        cylinder(
            d1=outlet_small_diameter,
            d2=outlet_large_diameter,
            h=outlet_height
        );
        translate([0,0,-clearance]) {
            cylinder(
                d1=outlet_small_diameter-2*wall_width,
                d2=hole_diameter,
                h=outlet_height+2*clearance
            );
        }
    }
}
