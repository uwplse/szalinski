
// Hilt Text line1
hilt_textL1 = "Rutgers Kendo Club";
// Hilt Text line2
hilt_textL2 = "Rank";

// Hilt Text line3 at bottom
hilt_textL3 = "KendoKa Name";

// Hilt Thickness
thickness = 7.5;
// Hilt Outer Diameter
outer_diameter = 78;
// Hilt Inner Diameter
inner_diameter = 32;

//use <Write.scad>
use <write/Write.scad>

union () {
difference () {
cylinder(r=outer_diameter/2-thickness/2,h=thickness);
translate([0,0,-0.25]) cylinder(r=inner_diameter/2,h=thickness+1);
writecylinder(hilt_textL1,[0,0,0],(inner_diameter/4+outer_diameter/4)+6,thickness,face="top");

 writecylinder(hilt_textL2,[0,0,0],(inner_diameter/4+outer_diameter/4)-1,thickness,face="top");


writecylinder(hilt_textL3,[0,0,0],(inner_diameter/4+outer_diameter/4)+3,thickness,face="top",ccw=true,h=6,,space=1);

}
translate([0,0,thickness/2]) rotate_extrude () translate([outer_diameter/2-thickness/2,0,0]) circle(r=thickness/2);
}

