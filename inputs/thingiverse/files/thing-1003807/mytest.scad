//Cube height
height = 4;
//Cube thickness
thickness = 3; //[1,2,3,4,5]
//Cube width
width = 2; //[2:5]

color([1,0,0]) cube([width,thickness,height]);
translate([3,0,0])
color([0,1,0]) cube([width,thickness,height]);
translate([6,0,0])
color([0,0,1]) cube([width,thickness,height]);