 // einfacher Zahnputzbecher - simple toothbrush cup
 // toothbrush-cup_v2.scad
 // djgan 2019-01-18

// Fineness: Higher = smoother
$fn = 100;

// Mug outer in mm
mug_radius = 26; 
mug_height = 60;

// Rounding of the bottom, radius in mm.
mug_rnd_bottom = 8;

// Width of the wall  in mm.
mug_wall = 2;

// Rounding calculation
calc_round = min(mug_rnd_bottom, mug_radius/10); 

// Calculation of the height with roundings
calc_height = mug_height - calc_round - mug_wall * 0.5; // mug height adjusted 

// Functions make a simple tooth mug
module mug_simple(h1,r1,rc) {
 cylinder(h1,r1,r1); rotate_extrude (convexity = 10) translate ([r1-rc,0,-rc/2]) circle (r=rc); translate ([0,0,-rc]) cylinder(rc,r1-rc,r1-rc);
}  
// Round off upper edge
translate ([0,0,calc_height]) rotate_extrude (convexity=10) translate([mug_radius-mug_wall/2,0,0]) circle (r=mug_wall/2);

// Apply the "difference ()" function
difference () {mug_simple(calc_height,mug_radius,calc_round); translate ([0,0,mug_wall]) mug_simple(calc_height+0.1,mug_radius-mug_wall,calc_round);
    }     
