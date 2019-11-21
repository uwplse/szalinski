// Thickness of cord
T=1.5;
// Width of bracket
w=60;
// Thickness of wall
wall=4;
// Minimum thickness of picture sandwich
minT=5;
// Maximum thickness of picture sandwich
maxT=10;
// radius of rounded edges
r=2;

Dhole=T+2;

use <MCAD/boxes.scad>

difference(){
	translate([0,0,maxT/2+T])roundedBox([w,w,maxT+2*T],r,$fn=16);
	difference(){
		translate([0,0,maxT+2*T])cube([w-2*wall,w-2*wall,2*maxT],center=true);
		translate([-w/2,-w/2+wall,2*T+minT])rotate([45,0,0])cube([w,maxT,maxT]);
		translate([-w/2+wall,-w/2,2*T+minT])rotate([0,-45,0])cube([maxT,w,maxT]);
	}
	rotate([0,0,45])translate([0,-w,-1])cube(2*w);
	translate([Dhole/2,0,w/4+T])cube(w/2,center=true);
	translate([0,Dhole/2,w/4+T])cube(w/2,center=true);
	translate(-(w/4-Dhole/2)*[1,1,0])cylinder(r=Dhole/2,h=2*maxT,center=true,$fs=1);
	translate([0,-w/2,(maxT+2*T)/2])rotate([90,0,0])monogram(h=0.6);
}

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[3,2.5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}