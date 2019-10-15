// This should be 2mm larger that the hole in your spool. Eg. 60mm for a 58mm spool hole.
Hub_Diameter = 60;

// Hole in the hub for the spool rod. Should be slighly larger than the rod diameter.
Hole_Diameter = 10;

// Core of the hub. The default should usually be good, but you may need to adjust for very large hole or small hub.
Core_Diameter = 24;

// Thickness of the hub. It should at least 2mm thicker than the wall of your spool to cater for the catch on the hub.
Thickness = 12;

// You need at least 3 to be stable, but feel free to go crazy with this one.
Number_of_Arms = 3;

/* [Hidden] */
Catch_Thickness = 1;
Core_Radius = Core_Diameter / 2;
Catch_Radius = Hub_Diameter / 60 * 3;
Catch_X = Hub_Diameter / 60 * 27.86;
Catch_Y = Hub_Diameter / 60 * 2.1;
Hub_Radius = Hub_Diameter / 2;
Arm_Radius = (Hub_Radius + Core_Radius)/2;
Arm_Inner_Radius = Hub_Diameter / 4;
Tip_Width = Hub_Diameter / 30;

$fs = 0.5;

module Arm(){
    difference(){
        union(){
            translate([Hub_Radius-Arm_Radius,0,0]) cylinder(r=Arm_Radius,h=Thickness);
            translate([Catch_X,Catch_Y,0]) cylinder(r=Catch_Radius,h=Catch_Thickness);
            translate([Catch_X,Catch_Y,Thickness-Catch_Thickness]) cylinder(r=Catch_Radius,h=Catch_Thickness);
        }
        translate([Hub_Radius-Arm_Inner_Radius-Tip_Width,0,-1]) cylinder(r=Arm_Inner_Radius,h=Thickness+2);
        translate([0,-Hub_Radius,0]) cube([Hub_Diameter,Hub_Diameter,Thickness*2+2],center=true);
    }
    translate([Hub_Radius-Tip_Width/2,0,0]) cylinder(d=Tip_Width,h=Thickness);
}

difference() {
    union() {
        cylinder(r=Core_Radius,h=Thickness);
        for (a =[0 : 360/Number_of_Arms : 360])
            rotate([0,0,a]) Arm();
    }
    translate([0,0,-1]) cylinder(d=Hole_Diameter,h=Thickness+2);
}