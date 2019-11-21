length=150; // [50:150]
diameter=12; // [5:50]
thickness=3; // [2:10]
notch_distance=40; // [10:40]
notch_width=2; // [2:5]

/* [Hidden] */

height=thickness + diameter * 1.5;
width=diameter + thickness * 2;

difference() {
    cube([length, width, height]);
    // top retangular channel
    translate([0, thickness, thickness + diameter * 0.5]) cube([length, diameter, diameter * 1.5]);

    // V 
    translate([0, thickness, thickness + diameter * 0.5]) rotate([90,0,0]) rotate([0,90,0]) linear_extrude(length) polygon([
    [0, 1],
    [0,0],
    [diameter * 0.5, -diameter * 0.5],
    [diameter, 0],
    [diameter, 1]
    ]);
    
    // notch
    translate([notch_distance, 0, thickness]) cube([notch_width, thickness * 2 + diameter, diameter * 1.5]);
}


