/*
	Parametric Eccentric Weight for Vibrobot 
	by Kevin Osborn
*/
//Shaft Diameter in mm  
shaftdiameter = 1.0; 
//Weight Diameter in mm
weightdiameter =12;
//Arm Length in mm
armLength = 12;

/* [hidden] */
shaftR = shaftdiameter/2;
weightR = weightdiameter/2;
$fn=50;

union(){
difference(){
cylinder(r1=5,r2=5,h=4);
cylinder(r1=shaftR,r2=shaftR,h=15);
translate([3,-7,0])cube([14,14,5]);
}
translate([-armLength-2,-2,0])cube([armLength,4,4]);
translate([-(armLength+weightR),0,0])cylinder(r1=weightR,r2=weightR,h=5);
difference(){
translate([0,0,3.9])cylinder(r1=3,r2=3,h=4);
cylinder(r1=shaftR,r2=shaftR,h=15);
}
}