/*
    This mimics a wooden dowel pin used for joinery. The advantage is you can control 
    the dimensions. The disadvantage is that the wood glue won't penetrate the 
    plastic as it would with wood.
    
    Author: Alex Kazim
*/

/* [Main] */
// overall length including the caps
pin_length = 18;

// diameter excluding the ribs
pin_diameter = 6; 

// height of each end-cap
cap_h = 2;          // [0:5]


/* [Misc] */
// number of ribs around the core
num_ribs = 12;          // [0:30]

// radius of each rib
rib_radius = 0.25;

// rendering quality
$fn = 50;

/* [Hidden] */

// calcs
cap_r1 = pin_diameter/2 - 0.8;  // 20% drop in diameter for the end-cap
cap_r2 = pin_diameter/2;

dowel_l = pin_length - 2*cap_h;

union() {
    // cap
    cylinder(cap_h,cap_r1,cap_r2,center=false);
    
    // body
    translate([0,0,cap_h]) {
        cylinder(dowel_l,r=pin_diameter/2);
    }
    
    // cap
    translate([0,0,pin_length - cap_h]) {
        cylinder(cap_h,cap_r2,cap_r1,center=false);
    }
    
    // ribs
    if (num_ribs > 0) {
        for (i = [0:num_ribs - 1]) {
            translate([sin(360*i/num_ribs)*(pin_diameter/2), cos(360*i/num_ribs)*(pin_diameter/2),cap_h]) {
                color([1,0,0]) cylinder(h=dowel_l,r=rib_radius);
            }
        }
    }
}
