//!OpenSCAD

arms = 6; //[2:1:9]
diameter = 50;
thickness = 2;

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
