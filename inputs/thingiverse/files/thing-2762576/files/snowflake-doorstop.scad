//!OpenSCAD

arms = 6; //[2:1:7]
diameter = 150;
thickness = 15;
outside_thickness = 2;

intersection() {
scale([(diameter / 136), (diameter / 136), 1]){
difference() {
for (j = [1 : abs(1) : arms]) {
rotate([0, 0, (j * (360 / arms))]){
// chain hull
for (i = [0 : abs(50) : 50 - 50]) {
hull() {
translate([0, (10.5 + i), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
translate([0, (10.5 + (i + 50)), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

// chain hull
for (i = [0 : abs(20) : 20 - 20]) {
hull() {
translate([i, (35 + i), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
translate([(i + 20), (35 + (i + 20)), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

// chain hull
for (i = [0 : abs(20) : 20 - 20]) {
hull() {
translate([(i * -1), (35 + i), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
translate([((i + 20) * -1), (35 + (i + 20)), 0]){
cylinder(r1=8, r2=8, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

}
}

for (j = [1 : abs(1) : arms]) {
rotate([0, 0, (j * (360 / arms))]){
// chain hull
for (i = [0 : abs(50) : 50 - 50]) {
hull() {
translate([0, (10.5 + i), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
translate([0, (10.5 + (i + 50)), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

// chain hull
for (i = [0 : abs(20) : 20 - 20]) {
hull() {
translate([i, (35 + i), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
translate([(i + 20), (35 + (i + 20)), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

// chain hull
for (i = [0 : abs(20) : 20 - 20]) {
hull() {
translate([(i * -1), (35 + i), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
translate([((i + 20) * -1), (35 + (i + 20)), 0]){
cylinder(r1=3, r2=3, h=thickness, center=false);
}
}  // end hull (in loop)
} // end loop

}
}

cylinder(r1=11, r2=11, h=thickness, center=false);
}
difference() {
cylinder(r1=16, r2=16, h=thickness, center=false);

cylinder(r1=11, r2=11, h=thickness, center=false);
}
}

scale([(diameter / 50), (diameter / 50), 1]){
union(){
translate([0, 0, outside_thickness]){
cylinder(r1=26, r2=5.9, h=(thickness - outside_thickness), center=false);
}
cylinder(r1=26, r2=26, h=outside_thickness, center=false);
}
}

}
