// How wide should your glasses be?
width=135; // [125:150]

// How wide should the bridge be?
bridge=10; // [10:25]

// How long should the arms be?
arm=145; // [125:160]

// How thick should the frame be?
thickness=3; // [2:5]


$fn = 50;
difference(){
difference(){
minkowski(){

difference(){
union(){
difference(){

hull(){
translate([0,width/5+bridge/2,0])
rotate([0,90,0])
cylinder(thickness, d=width/3);

translate([0,width/2-width/12,width/10])
rotate([0,90,0])
cylinder(thickness, d=width/12);

translate([0,0,3])
rotate([0,0,0])
cube([thickness,bridge/2,width*.13]);}}

difference(){
mirror([0,1,0])
hull(){
translate([0,width/5+bridge/2,0])
rotate([0,90,0])
cylinder(thickness, d=width/3);

translate([0,width/2-width/12,width/10])
rotate([0,90,0])
cylinder(thickness, d=width/12);

translate([0,0,3])
rotate([0,0,0])
cube([thickness,bridge/2,width*.13]);}}}


union(){
translate([0,0,bridge/2])
rotate([0,90,0])
cylinder(thickness*3, d=width*.13, center=true);

translate([0,0,bridge/2])
rotate([0,180,0])
linear_extrude(height=bridge*2, scale=2)
square(bridge, center=true);}}

*sphere([thickness/3]);}

translate([0,width/5+bridge/2,0])
rotate([0,90,0])
cylinder(thickness*3, d=width/3-thickness, center=true);}

translate([0,-width/5-bridge/2,0])
rotate([0,90,0])
cylinder(thickness*3, d=width/3-thickness, center=true);}

difference(){
union(){
hull(){
translate([0,width/2.3,width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);

translate([-arm*(2/3),width/2.3,width/15])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);}

hull(){
translate([-arm*(2/3),width/2.3,width/15])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);

translate([-arm,width/2.3,-width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);}

translate([-arm,width/2.3,-width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*4);}

translate([0,width/2.3,width/9])
rotate([0,0,0])
cube(thickness*3, center=true);}



mirror([0,1,0])
difference(){
union(){
hull(){
translate([0,width/2.3,width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);

translate([-arm*(2/3),width/2.3,width/15])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);}

hull(){
translate([-arm*(2/3),width/2.3,width/15])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);

translate([-arm,width/2.3,-width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*2);}

translate([-arm,width/2.3,-width/9])
rotate([90,0,0])
cylinder(thickness, d=thickness*4);}

translate([0,width/2.3,width/9])
rotate([0,0,0])
cube(thickness*3, center=true);}



translate([0,0,0])
rotate([0,0,0])
cube(0,0,0);

translate([0,0,0])
rotate([0,0,0])
cylinder(0, d=0);

translate([0,0,0])
rotate([0,0,0])
sphere(0);

