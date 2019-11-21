union() {
difference() {
union() {
rotate_extrude(convexity=10,$fn=720)translate([20,0,0]) square(30);
translate([0,0,30]) rotate_extrude(convexity=10,$fn=720)translate([20,0,0]) square(10);
translate([0,0,30]) rotate_extrude(convexity=10,$fn=720)translate([12.5,0,0]) square([10,2]);
}
rotate_extrude(convexity=10,$fn=720) polygon(points=[[25,0],[35,25],[42,0]]);
translate([-3.5,0,0]) cube([7,60,7]);
}
translate([-3.5,20,0]) cube([4,5,2]);
translate([-0.5,45,0]) cube([4,5,2]);
}
