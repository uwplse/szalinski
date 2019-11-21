// separate parts for printing
print_sep=1; // [0:"no,1:"yes"]

module blopp() {
translate([4,-10,0])
difference() {
minkowski() {
cube([12,20,1]);
  sphere(1, $fn=45);
}
union() {
translate([-2,-2,-10])
cube([25,30,10]);
translate([6,15,-.1])
cylinder(4.9,1.6,1.6,$fn=60);
translate([6,5,-.1])
cylinder(4.9,1.6,1.6,$fn=60);
}
}


translate([0,-10,3.2])
rotate([-90,0,0])
difference() {
union () {
translate([0,1.9,1])
minkowski() {
    cube([4,.4,3]);
  sphere(.9, $fn=45);
}
cylinder(4.9,2,2,$fn=60);
}
translate([0,0,-.1])
cylinder(5.2,1.1,1.1,$fn=60);
}

translate([0,0.05,3.2])
rotate([-90,0,0])
difference() {
union () {
translate([0,1.9,1])
minkowski() {
    cube([4,.4,3]);
  sphere(.9, $fn=45);
}
cylinder(4.9,2,2,$fn=60);
}
translate([0,0,-.1])
cylinder(5.2,1.1,1.1,$fn=60);
}
}

blopp();
color("red")
translate([-8*print_sep,0,0])
rotate([0,0,180])
blopp();
