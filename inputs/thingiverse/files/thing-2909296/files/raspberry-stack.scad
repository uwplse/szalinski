
// This is a remix from the awesome 
// Raspberry Pi Stackable Tray (https://www.thingiverse.com/thing:2187350)
// with a lot of reverse engineered code taken from
// Raspberry PI stack mount for Raspberry PI (https://www.thingiverse.com/thing:2883047).
//
// Like Miha Markic I preferred mounting the Rasperry Pi with screws.
// But I wanted to use M screws so I needed to modify the code for that.
//
// Additionally a added a cut for easier sd cards replacement for Raspberry 3 Pi and Odroid C2,
// moved the mounting holes a little bit so the Raspberry fits better into the case and
// made the wohle thing parametric so everyone can modify it to their special needs.

////////////////////////////////  Variables  ////////////////////////////////////

/* [General] */

// Gap style for SD card
sd_gap_style = 1; // [0:None, 1:Raspberry, 2:Odroid C2]

// Mounting type
mounting_type = 0; // [0: screws, 1: pins]

// Resolution
$fn = 80;

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

// Raspberry screw hole distance x
screw_holes_x = 58;


/* [Pillars] */

// Diameter of the small pillar
small_pillar_diameter = 5;

// Height of the small pillar
small_pillar_height = 25;


// Diameter of the large pillar
large_pillar_diameter = 10;

// Height of the large pillar
large_pillar_height = 12;


// Gap size for stacking
delta = .6;

// Stacking hole depth
stacking_hole_depth = 10;


/* [Mounting] */

// Move mounting position
mounting_offset = 13.6;

// Mounting foot height
screw_support_h = 4;

// Mounting foot diameter
screw_support_d = 6;

// Screw hole diameter
screw_support_hole_d = 2.8;

// Screw head diameter
screw_head_large_diameter = 4.2;

// Screw head diameter
screw_head_small_diameter = 2.7;

// Screw head diameter
screw_head_height = 1.4;


/* [Pins] */

// Pin diameter (Untested, plz leave comment if 2.4 needs to be changed)
pin_diameter = 2.4;

// Pin diameter
pin_length = 8;


/* [SD Card] */

// Length of the sd slot gap
sd_gap_length = 13;

// Depth of the sd slot gap
sd_gap_depth = 5;

// Gap y offset from the middle
sd_gap_odroid_offset = 11.2;


/* [hidden] */

// Avoid artifacts
clearance = 0.001;

// Calulated values

hole_full_d = small_pillar_diameter+delta;
between_pins_x = outer_large_x - large_pillar_diameter;
between_pins_y = outer_large_y - large_pillar_diameter;
horizontal_support_y = (between_pins_y-screw_holes_y-long_side_width)/2;


//////////////////////////////////  Build  //////////////////////////////////////

build();

/////////////////////////////////  Modules  ////////////////////////////////////

module build() {
    difference() {
        union() {
            quarter(-mounting_offset);
            translate([between_pins_x, 0]) {
                mirror([1, 0, 0]) quarter(+mounting_offset);
            }
            translate([0, between_pins_y]) {
                mirror([0, 1, 0]) quarter(-mounting_offset);
            }
            translate([between_pins_x, between_pins_y]) {
                mirror([1,0,0]) mirror([0,1,0]) quarter(+mounting_offset);
            }
        }

        // SD gap
        if (sd_gap_style == 1) { // Raspberry
            translate([
                -large_pillar_diameter/2-clearance,
                (outer_large_y-large_pillar_diameter)/2-sd_gap_length/2,
                -clearance
            ]) {
                sd_slot();
            }
        }
        if (sd_gap_style == 2) { // Odroid C2
            translate([
                between_pins_x/2-sd_gap_depth+sd_gap_odroid_offset,
                between_pins_y-horizontal_support_y+clearance,
                -clearance
            ]) {
                rotate(270, [0,0,1]) {
                    sd_slot();
                }
            }
        }
    }
}

module quarter(offset) {

    difference() {
        union() {
            pin();

            // front and back parts
            rotate(90)
                translate([0, -large_pillar_diameter/2])
                    cube([between_pins_y/2, large_pillar_diameter, base_plate_height]);
            
            // side parts
            translate([0, horizontal_support_y, 0])
                cube([
                    between_pins_x/2,
                    long_side_width,
                    base_plate_height
                ]);
            
            // Mounting feet
            translate([
                (between_pins_x-screw_holes_x+offset)/2,
                (between_pins_y-screw_holes_y)/2,
                base_plate_height
            ]) {
                cylinder(d=screw_support_d, h=screw_support_h);
            }
            
            // Mounting pins
            if (mounting_type == 1) {
                translate([
                    (between_pins_x-screw_holes_x+offset)/2,
                    (between_pins_y-screw_holes_y)/2,
                    screw_support_h+base_plate_height
                ]) {

                    cylinder(
                        d=pin_diameter,
                        h=pin_length
                    );
                }
            }
        }

        if (mounting_type == 0) {
            translate([
                (between_pins_x-screw_holes_x+offset)/2,
                (between_pins_y-screw_holes_y)/2,
                -clearance
            ]) {

                // Clearance hole for screws
                cylinder(
                    d=screw_support_hole_d,
                    h=screw_support_h+base_plate_height+2*clearance
                );

                // Screw head
                cylinder(
                    d1=screw_head_large_diameter,
                    d2=screw_head_small_diameter,
                    h=screw_head_height+clearance
                );
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
