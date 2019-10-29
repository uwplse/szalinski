//
// Raspberry Pi stack - Parametric power supply holder
//

// Variables
/////////////

/* [General] */

// Resolution
$fn = 50;

// Base thickness
base_plate_height = 2.4;

// Total x width
outer_large_x = 91.5;

// Total y width
outer_large_y = 79.5;

// Long side width
long_side_width = 10;

// Raspberry screw hole distance y
screw_holes_y = 49;


/* [Pillars] */

// Diameter of the small pillar
small_pillar_diameter = 5;

// Height of the small pillar
small_pillar_height = 30;


// Diameter of the large pillar
large_pillar_diameter = 10;

// Height of the large pillar
large_pillar_height = 12;


// Gap size for stacking
delta = .6;

// Stacking hole depth
stacking_hole_depth = 10;


/* [Power supply] */

// Power supply wing length
power_supply_wing_length = 22.5;

// Power supply wing width
power_supply_wing_width = 60;

// Power lip height
power_supply_lip_height = 4;


/* [hidden] */

// Avoid artifacts
clearance = 0.001;


// Calulated values
/////////////////////

hole_full_d = small_pillar_diameter+delta;
between_pins_x = outer_large_x - large_pillar_diameter;
between_pins_y = outer_large_y - large_pillar_diameter;
horizontal_support_y = (between_pins_y-screw_holes_y-long_side_width)/2;


// Build
/////////

build();


// Modules
////////////

module build() {
    difference() {
        union() {
            quarter();
            translate([between_pins_x, 0]) {
                mirror([1, 0, 0]) quarter();
            }
            translate([0, between_pins_y]) {
                mirror([0, 1, 0]) quarter();
            }
            translate([between_pins_x, between_pins_y]) {
                mirror([1,0,0]) mirror([0,1,0]) quarter();
            }
        }
    }
}

module quarter() {

    difference() {
        union() {
            pin();

            // front and back parts
            rotate(90) {
                translate([0, -large_pillar_diameter/2, 0]) {
                    cube([
                        between_pins_y/2,
                        large_pillar_diameter,
                        base_plate_height
                    ]);
                }
            }
            
            // side parts
            translate([0, horizontal_support_y, 0]) {
                cube([
                    between_pins_x/2,
                    long_side_width,
                    base_plate_height
                ]);
            }
            
            // Power supply part
            translate([between_pins_x/2,-power_supply_wing_length+horizontal_support_y,0]) {
                
                // Wing
                cube([
                    power_supply_wing_width/2,
                    power_supply_wing_length,
                    base_plate_height
                ]);

                // Lip
                cube([
                    power_supply_wing_width/2,
                    base_plate_height,
                    base_plate_height+power_supply_lip_height
                ]);
            }
        }
        
        // Stacking hole
        translate([0, 0, -clearance]) {
            pin_hole(stacking_hole_depth+2*clearance);
        }
    }
}

module pin() {
    union() {
        difference() {
            cylinder(d=large_pillar_diameter, h=large_pillar_height);
            pin_hole();
        }
        translate([0, 0, large_pillar_height]) small_pin(small_pillar_height);
    }
}

module small_pin(z) {
    cylinder(d=small_pillar_diameter, h=z);
}

module pin_hole(h) {
    cylinder(d=hole_full_d, h=h);
}

module sd_slot() {
    cube([
        sd_gap_depth+clearance,
        sd_gap_length,
        base_plate_height+2*clearance
    ]);
}
