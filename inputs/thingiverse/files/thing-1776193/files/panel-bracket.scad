// Dimensions of the panel. The X dimension will have the fabric straps. I prefer to have them on the larger axis (making them narrower). 
solar_X = 165.5;
solar_Y = 136;

// How wide of a gap to use for the fabric or straps. 
fabric_gap = 4;

// Thickness of the base 
bracket_base_depth = 1.5;

/* [Hidden] */ 

// My panels taper and the outer most edge is slightly smaller. These 
// parameters create a negative model of the panel that is subtracted out.
// You can probably leave these alone. 
solar_Z_max = 3;
// Can probably leave alone
solar_Z_min = 2.3;
// Can probably leave alone
solar_slope_offset = 3;

// Sets how much material is cut out underneath 
bracket_cutout_offset = 15;

// Can probably leave alone
wall_overhang = 10;
// Can probably leave alone
wall_depth = 2;
// Can probably leave alone
side_overhang = 2.5;
// Can probably leave alone
fudge = 0.1;
$fn = 90;

module _bracket_base(bx, by, bz, mink) {
    if(bx < 0 || by < 0 || bz < 0) {
        echo("Solar panel is too small for the specified parameters - try reducing wall overhang");
    }

    echo(bx,by,bz,mink);
        minkowski() {
            cylinder(d=mink, h=bz);
            cube([bx, by, bz]);
        }
}

module _fab_gap(bx, by, bz) {
    hull() {
        translate([-1, fabric_gap, -fudge])
            cylinder(d=fabric_gap, h = solar_Z_max*2 + bracket_base_depth);
        translate([-1, by - fabric_gap, -fudge])
            cylinder(d=fabric_gap, h = solar_Z_max*2 + bracket_base_depth);
    }
}

module fab_gap(bx, by, bz) {
    _fab_gap(bx, by, bz);
    translate([bx + 2, 0])
        _fab_gap(bx, by, bz);
}

module bracket_base() {
    mink = wall_overhang;
    bz = bracket_base_depth/2; // Note, Minkowsky will add to the height, too

    bx = solar_X + mink;
    by = solar_Y - mink + side_overhang*2;

    translate([-(bx - solar_X)/2, -(by - solar_Y)/2]) 
        difference() {
            hull() {
                _bracket_base(bx, by, bz, mink);
                bxx = bx * 0.9;
                byy = by * 0.95;
                bzz = bz + solar_Z_min;
                translate([(bx - bxx)/2, (by - byy)/2, -fudge/2]) 
                    _bracket_base(bxx, byy, bzz, mink);
            }

            bxx = bx - bracket_cutout_offset - wall_overhang;
            byy = by - bracket_cutout_offset;
            translate([(bx - bxx)/2, (by - byy)/2, -fudge]) 
                scale([1,1,1.5])
                    _bracket_base(bxx, byy, bz, mink);

            fab_gap(bx, by, bz);

            //translate([bx/2, -solar_Y/2, bz/2 + 101])
            //    rotate([-90, 0])
            //        cylinder(d = 200, h = solar_Y*2);
        }
}

module panel() {
    hull() {
        cube([solar_X, solar_Y, solar_Z_min]);
        translate([solar_slope_offset, solar_slope_offset])
            cube([solar_X - solar_slope_offset, solar_Y - solar_slope_offset*2, solar_Z_max]);
    }

    // This cube isn't technically panel. Having it keeps the space over the panel clear
    cube([solar_X, solar_Y, solar_Z_max*2 + bracket_base_depth]);
}

module taper() {
    translate([-wall_overhang/2, -solar_Y/2, bracket_base_depth])
        rotate([0, -30, 0])
            cube([solar_X, solar_Y * 2, solar_Z_max]); // abritrarily heigh and deep

    translate([solar_X + wall_overhang/2, -solar_Y/2, bracket_base_depth])
        rotate([0, 30])
            translate([-solar_X,0])
                cube([solar_X, solar_Y * 2, solar_Z_max]); // abritrarily heigh and deep
}

module main() {

    difference() {
        bracket_base();
        translate([0, 0, bracket_base_depth])
            panel();
        // taper();
    }
}

main();

