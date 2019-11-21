// Outside diameter of cone base. (All measurements are in millimeters!!)
cone_diameter = 16;
// Height of cone.
cone_height = 10;
//Thickness of cone walls.
wall = 0.6;
// Outside diameter of neck.
neck_diameter = 4;
// Height of neck.
neck_height = 5;
// Diameter of hole for dart. (Depth of hole is automatically 2mm less than neck height.)
hole_size = 2;
union() {
difference() {
    // bottom cylinder
    cylinder(h = cone_height, r1 = cone_diameter/2, r2 = neck_diameter/2, center = false, $fn=100);
    // inside cylinder
    cylinder (h = cone_height - wall, r1 = cone_diameter/2 - wall, r2 = neck_diameter/2 - wall, center = false, $fn=100);
}
difference() {
    // neck
    translate([0,0,cone_height]) cylinder(h = neck_height, r = neck_diameter/2, $fn=100);
    // shaft hole
    translate([0,0,cone_height + 2]) cylinder(h = neck_height - 2, r = hole_size/2, $fn=100);
}
}
    