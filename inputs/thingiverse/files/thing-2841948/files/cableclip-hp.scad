// cable clips henry piller 2018
// variable description
high=10; // [5:25]
clip=10; // [5:25]
bohrung = 1; //[0:Nein,1:ja]
/* [Hidden] */
$fn=80;
difference(){
union(){
difference() {
 cylinder(h=high,r1=clip/2,r2=clip/2,center=false);
 union(){
    cylinder(h=high,r1=clip/2-.5,r2=clip/2-.5,center=false);
   rotate([90,0,0]) translate([-high,0,-clip/2])  cube([high+.5,high+.5,clip/3],center=false);}}
   rotate([90,0,0]) translate([-clip/2,0,-clip/2])  cube([clip,high,1],center=false);}
if (bohrung==1) {rotate([90,0,0]) translate([0,high/2,-clip/2])   cylinder(h=high*1.5,r1=high/10,r2=high/5,center=false);}
else {// no drill 
 }}