
///////////////
// Variables //
///////////////

/* [Option] */

// 0: without switch block, 1: With switch block
switch = 1;

/* [General] */

// Battery case height
b_height = 48;

// Battery case length
b_length = 26.6;

// Battery case width
b_width = 17.4;

// Latern stick diameter
stick_diameter = 8.8;

// Screw hole diameter
screw_hole_diameter = 4.2;

/* [Switch] */

// Switch width
switch_x = 20;

// Switch length
switch_y = 13.8;

// Switch height
switch_z = 20;


/* [Misc] */

// Resolution
$fn=96;

// Avoid artifacts
clearance = 0.01;

// Wall width
wall_width = 2;


///////////
// Build //
///////////

if (switch) {
    translate([
        (b_length+2*wall_width)/2-switch_x/2-wall_width,
        -switch_y-wall_width,
        0
    ]) {
        difference() {
            cube([
                switch_x+2*wall_width,
                switch_y+2*wall_width,
                switch_z
            ]);
            translate([wall_width,wall_width,-clearance]) {
                cube([
                    switch_x,
                    switch_y,
                    switch_z+2*clearance
                ]);
            }
        }
    };
}

difference() {

    hull() {

        // Outer cube
        cube([
            b_length+2*wall_width,
            b_width+2*wall_width,
            b_height+wall_width
        ]);
        
        // Stick case
        translate([
            (b_length+2*wall_width)/2,
            (b_width)+stick_diameter,
            0
        ]) {
            cylinder(
                d=stick_diameter+2*wall_width,
                h=b_height+wall_width
            );
        }
    }

    // Battery hole
    translate([wall_width,wall_width,wall_width]){
        cube([b_length, b_width, b_height+clearance]);
    }
    
    // Stick hole
    translate([
        (b_length+2*wall_width)/2,
        (b_width)+stick_diameter,
        wall_width
    ]) {
        cylinder(
            d=stick_diameter,
            h=b_height+wall_width+clearance
        );
    }
    
    translate([
        (b_length+2*wall_width)/2,
        b_width+stick_diameter+2*wall_width,
        b_height/3+wall_width
    ]) {
        rotate(270, [1,0,0]) {
            cylinder(
                d=screw_hole_diameter,
                h=2*wall_width+clearance
            );
        }
    }
    
    translate([
        (b_length+2*wall_width)/2,
        b_width+stick_diameter+2*wall_width,
        b_height/3*2+wall_width
    ]) {
        rotate(270, [1,0,0]) {
            cylinder(
                d=screw_hole_diameter,
                h=2*wall_width+clearance
            );
        }
    }
}
