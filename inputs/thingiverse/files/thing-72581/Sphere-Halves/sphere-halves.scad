
// preview[view:south west, tilt:bottom diagonal]

// Radius of cube in mm (Must be 10mm or bigger)
cube_radius=20; 


rotate([180,0,0]) {
translate([cube_radius+5,0,0]) 
difference() {
difference() {
sphere(cube_radius, $fn=100);
translate([-cube_radius,-cube_radius,0]) cube(cube_radius*2);
}
translate([0,0,-6]) cylinder(h=6.1,r=3.05,$fn=30);

}

translate([-cube_radius-5,0,0]) 
difference() {
difference() {
sphere(cube_radius, $fn=100);
translate([-cube_radius,-cube_radius,0]) cube(cube_radius*2);
}
translate([0,0,-6]) cylinder(h=6.1,r=3.05,$fn=30);
}

union() {
translate([0,0,-1.5]) cylinder(h=1.5,r1=3,r2=2.5,$fn=30);
translate([0,0,-10]) cylinder(h=8.5,r=3,$fn=30);
translate([0,0,-11.5]) cylinder(h=1.5,r1=2.5,r2=3,$fn=30);
}
}
