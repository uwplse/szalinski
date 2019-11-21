// Multiple Customizable Washer
// NIS 12/01/2019
// Version 1.1

// inner diameter in mm
inner = 26; // [0.4:0.1:540]

// border in mm
border = 6; // [0.4:0.1:30]

// thickness in mm
thickness = 2.6;  // [0.2:0.1:40]

// rows
rows = 5;

// cols
cols = 3;

// preview[view:south, tilt:top]

// #######################################################
// based on 953338
// info customizer.makerbot.com/docs 

outer = inner + border;
$fn=120;

module myWasher (inner, outer, thickness) {

    difference() {
        cylinder(d=outer, h=thickness);
        translate([0,0,-thickness]) # cylinder(d=inner, h=thickness*3);
    };
}

// dimensions in mm


for(runY = [0 : rows-1])
    for(runX = [0 : cols-1])
    {
      translate([runX*(2+outer), runY*(2+outer), 0])
      color("blue") myWasher (inner, outer, thickness);
    }

