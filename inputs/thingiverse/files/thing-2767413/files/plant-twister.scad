
height = 25;
width = 50;
thickness = 5;

$fn=60;

translate([thickness/2,0,0]) cylinder(r=thickness/2, h=height-thickness);
translate([width/2,0,0]) cylinder(r=thickness/2, h=height-thickness);
translate([width-thickness/2,0,0]) cylinder(r=thickness/2, h=height-thickness);

translate([0,-thickness/2,-thickness/2]) cube([width,thickness,thickness]);
