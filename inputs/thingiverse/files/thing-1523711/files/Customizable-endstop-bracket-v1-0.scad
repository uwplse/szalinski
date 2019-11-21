// Customizable endstop bracket by Cees Moerkerken
// http://www.thingiverse.com/thing:1523711
// v1.0 - 27-04-2016
// preview[view:north, tilt:top]

//CUSTOMIZER VARIABLES

/* [General_dimensions] */
// Thickness of the bracket in mm
thickness=2;
// Width of the bracket
width=20;

/* [Side1_dimensions] */
// Length of the part 
L1=20;
// Distance between the center of the bolts
frame_bolt_space=10;
// Bolt diameter incl margin (m3 = 3.2mm printed)
frame_bolt_d=3.2;// [2.2,3.2,4.2,5.2,6.2]

/* [Side2_dimensions] */
// Length of the part 
L2=30;
// Distance between the center of the bolts
endstop_bolt_space=10;
// Bolt diameter
endstop_bolt_d=2.2;
// Start of the endstop bolt hull on Side 2
endstop_mount_start=15;// [3:45]
// End of the endstop bolt hull on Side 2
endstop_mount_end=25;// [3:45]

//CUSTOMIZER VARIABLES END

/* [Hidden] */
$fn=60;

difference(){
    translate([2,2,0])minkowski(){
        cube([width-4,L1-4,thickness/2]);
        cylinder(r=2,h=thickness/2);
    }
    translate([width/2-frame_bolt_space/2,L1/2,-.1])cylinder(d=frame_bolt_d,h=thickness+.2);
    translate([width/2+frame_bolt_space/2,L1/2,-.1])cylinder(d=frame_bolt_d,h=thickness+.2);
}
difference(){
    translate([2,thickness/2,2])minkowski(){
        cube([width-4,thickness/2,L2-4]);
        rotate([90,0,0])cylinder(r=2,h=thickness/2);
    }
    hull(){
        translate([width/2-endstop_bolt_space/2,thickness+.1,endstop_mount_start])rotate([90,0,0])cylinder(d=endstop_bolt_d, h=thickness+.2);
        translate([width/2-endstop_bolt_space/2,thickness+.1,endstop_mount_end])rotate([90,0,0])cylinder(d=endstop_bolt_d, h=thickness+.2);
    }
    hull(){
        translate([width/2+endstop_bolt_space/2,thickness+.1,endstop_mount_start])rotate([90,0,0])cylinder(d=endstop_bolt_d, h=thickness+.2);
        translate([width/2+endstop_bolt_space/2,thickness+.1,endstop_mount_end])rotate([90,0,0])cylinder(d=endstop_bolt_d, h=thickness+.2);
    }
}
