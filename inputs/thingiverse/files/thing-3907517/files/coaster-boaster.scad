//Number of dots
n=12;
//Sphere size (0=No sphere)
y=10;


module base(){
    cylinder(h=5.1,r=100,center=false);}
module hole(){
    difference(){
        translate([0,0,5])cylinder(h=5,r=100,center=false);
        translate([0,0,4])cylinder(h=10,r=85,center=false);}} 
$fn=100;
deg=360/n;
module dot(){
    union(){
        translate([92.5,0,10])sphere(4);
        translate([92.5,0,5.5])cylinder(h=11,d=10,center=true);}}
module middle(){
    union(){
        translate([0,0,5])sphere(y);
        translate([0,0,3])cylinder(h=5,d=y*2.5,center=true);}}
module wood(){
    translate([0,0,5])cube([170,2,4],center=true);
    translate([0,20,5])cube([170,2,4],center=true);
    translate([0,-20,5])cube([170,2,4],center=true);
    translate([0,-40,5])cube([160,2,4],center=true);
    translate([0,40,5])cube([160,2,4],center=true);
    translate([0,-60,5])cube([150,2,4],center=true);
    translate([0,60,5])cube([150,2,4],center=true);
    translate([0,-80,5])cube([100,2,4],center=true);
    translate([0,80,5])cube([100,2,4],center=true);}
module cut(){
    translate([0,0,-500.01])cube([1000,1000,1000],center=true);}
//Putting it all together
module plank(){
    difference(){
        base();
        wood();}}
module lineup(){
   for (i=[0:n-1])
     rotate([0,0,deg*i]) dot(0);}
module coaster(){
    union(){
        color("brown")plank();
        color("black")hole();}}
module clean(){
    difference(){
        middle();
        cut();}}
module vikings(){
    union(){
        coaster();
        color("grey")lineup();
        color("gray")clean();}}
vikings();