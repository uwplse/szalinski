// Parametric Shock Cord Mount created by: Nick Estes <nick@nickstoys.com>
// Released under a Creative Commons - share alike - attribution license

tube_diameter = 24;
base_thickness = 1.5;
length = 36;
loop_thickness = 2;
loop_height = 8;
loop_width = 6;
loop_length = 24;
base_width = 12;

$fa=.2;
$fs=.2;

module base() {
    translate([-tube_diameter/2+base_thickness/2,0,0]) intersection() {
        difference() {
            cylinder(length, r=tube_diameter/2);
            translate([0,0,-.5]) cylinder(length+1, r=tube_diameter/2-base_thickness);
        }
        translate([0,-base_width/2,0]) cube([tube_diameter, base_width, length]);
    }
}

module loop() {
    difference() {
        translate([-base_thickness,loop_width/2,length/2]) rotate([90,0,0]) scale([1,loop_length/2/loop_height,1]) difference() {
            cylinder(loop_width, r=loop_height/2+loop_thickness);
            translate([0,0,-.5]) cylinder(loop_width+1, r=loop_height/2);
        }
        translate([0,-loop_width/2-.5,-.5]) cube([loop_height+loop_thickness+1,loop_width+1,length+1]);
    }
}

union() {
    base();
    loop();
}
