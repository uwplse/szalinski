// Spacing between bars
spacing = 2;
// Vertical spacing between layers
vspacing = .7;
// Diameter of bars
d = 1;
// Width of mesh area (x)
width = 30;
// Depth of mesh area (y)
depth = 30;
// Height of mesh area (z)
height = 4;

for (z=[0:vspacing*2:height]) {
for (x=[0:spacing:width]) 
	translate([x,0,z]) rotate([-90,0,0]) rotate([0,0,360/16]) cylinder(r=d/2, h=depth, $fn=8);
for (y=[0:spacing:depth]) 
	translate([0,y,vspacing+z]) rotate([0,90,0]) rotate([0,0,360/16]) cylinder(r=d/2, h=width, $fn=8);
}
translate([0,0,-vspacing])
	cube([width,depth,vspacing]);