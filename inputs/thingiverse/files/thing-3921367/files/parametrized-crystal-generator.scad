/*
Random crystal generator for Thingiverse Customizer
by Fernando Jerez 2016

Ugraded by Teevax 01-2017

Refactored and fully parametrized by Kraplax 2019-10

*/

/* [Crystals' Base] */
// The width of the base to grow crystals on
base_radius = 10; // [8:0.5:20]

// Number of facets of base to grow crystals on
base_sides = 10; // [5:1:50]

/* [Crystals] */
// Whether to generate crystals of same sides count or randomize
randomize_crystal_sides = false; // [false: Same, true: Random]

// How many sides/facets for crystals (if randomized, used as max facets, 3 being as minimum random value)
crystal_sides = 6; // [3:1:10]

// How many crystals to grow
crystals_count = 50; // [10:1:50]

// Cofficient to modify crystal radius at it's base
base_radius_percents = 100; // [1:1:200]

// Cofficient to modify crystal's body radius
body_radius_percents = 100; // [1:1:200]

// Cofficient to modify crystal's tip radius
tip_radius_percents = 100; // [1:1:200]

// Cofficient to modify crystal's tip length
tip_length_percents = 100; // [1:1:200]

/* [Hidden] */
base_radius_coefficient = base_radius_percents / 100;
body_radius_coefficient = body_radius_percents / 100;
tip_radius_coefficient = tip_radius_percents / 100;
tip_length_coefficient = tip_length_percents / 100;

crystalrock();

module crystalrock(){
    union(){
        semisphere(base_radius,$fn=base_sides);
        for(i=[1:crystals_count]){
            maxAngleX = 70;
            maxAngleY = 50;
            g1 = rands(-maxAngleX, maxAngleX, 1)[0];
            g2 = rands(-maxAngleY, maxAngleY, 1)[0];
            
            sidesCount = crystal_sides;
            if (randomize_crystal_sides) {
                sidesCount = rands(3, crystal_sides);
            }
            bottomRadius = rands(1, 3, 1)[0] * base_radius_coefficient;
            widestRadius = rands(1.1, 1.6, 1)[0] * bottomRadius * body_radius_coefficient;
            tipRadius = rands(0, 0.5, 1)[0] * widestRadius * tip_radius_coefficient;
            baseLength = bottomRadius
                * rands(1, 2, 1)[0]
                * 5
                * (0.5 + pow((abs(cos(g1) * cos(g2))), 4));
            tipLength = rands(0.05, 0.3, 1)[0] * baseLength * tip_length_coefficient;

            translate([0, 0, bottomRadius])
            rotate([g1, g2, 0])
            crystal(sidesCount, bottomRadius, widestRadius, tipRadius, baseLength, tipLength);
        }
    }
}

module crystal(sidesCount, bottomRadius, widestRadius, tipRadius, baseLength, tipLength) {
    cylinder(r1=bottomRadius, r2=widestRadius, h=baseLength, $fn=sidesCount);
    translate([0, 0, baseLength])
    cylinder(r1=widestRadius, r2=tipRadius, h=tipLength, $fn=sidesCount);
    
}

module semisphere(r) {
    difference(){
        sphere(r); 
        translate([0,0,-r]) cube([2*r, 2*r, 2*r], center = true);
    }
}

