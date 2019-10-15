//Number of wires (2-6)
a=4;
//Spark Plug Wire Size (8-11mm)
b=10;

$fn=20;

module holder();
difference(){
    translate([0,0,2.5])cube([95, 20, 5], center=true);
    translate([-37.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([-22.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([-7.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([7.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([22.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([37.5,10-.25*b,2.5])cylinder(6,b/2,b/2,center=true);
    translate([47.5,0,2.5])cube([180-30*a,22,6],center=true);
}

holder();