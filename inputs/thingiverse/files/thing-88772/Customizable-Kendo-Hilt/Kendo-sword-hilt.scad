
// Hilt Text
hilt_text = "THE DOJO";

// Hilt Thickness
thickness = 7.5;
// Hilt Outer Diameter
outer_diameter = 78;
// Hilt Inner Diameter
inner_diameter = 32;


use <write/Write.scad>

$fn=60;
union () {
difference () {
cylinder(r=outer_diameter/2-thickness/2,h=thickness);
translate([0,0,-0.25]) cylinder(r=inner_diameter/2,h=thickness+1);
writecylinder(hilt_text,[0,0,0],inner_diameter/2+0.20*outer_diameter,thickness,face="top");
rotate ([0,0,90]) writecylinder(hilt_text,[0,0,0],inner_diameter/2+0.20*outer_diameter,thickness,face="top");
rotate ([0,0,180]) writecylinder(hilt_text,[0,0,0],inner_diameter/2+0.20*outer_diameter,thickness,face="top");
rotate ([0,0,270]) writecylinder(hilt_text,[0,0,0],inner_diameter/2+0.20*outer_diameter,thickness,face="top");
}
translate([0,0,thickness/2]) rotate_extrude () translate([outer_diameter/2-thickness/2,0,0]) circle(r=thickness/2);
}

