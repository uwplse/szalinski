
// Hilt Text line1
hilt_textL1 = "Rutgers Kendo Club";

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
translate([0,0,-0.25]) cylinder(r=inner_diameter/2,h=thickness+1);}
union () {
writecylinder(hilt_textL1,[0,0,0],(inner_diameter/4+outer_diameter/4)+5,thickness,h=6,t=2,face="top",space=1);


writecylinder(hilt_textL3,[0,0,0],(inner_diameter/4+outer_diameter/4)+4,thickness,face="top",ccw=true,h=6,t=2,space=1);

}
translate([0,0,thickness/2]) rotate_extrude () translate([outer_diameter/2-thickness/2,0,0]) circle(r=thickness/2);
}

