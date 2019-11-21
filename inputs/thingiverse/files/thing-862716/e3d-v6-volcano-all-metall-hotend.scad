/*
Name: E3D-v6 Volcano All Metal HotEnd in OpenSCAD
Author: Jons Collasius from Germany/Hamburg

License: CC BY-NC-SA 4.0
License URL: https://creativecommons.org/licenses/by-nc-sa/4.0/

Creator of "E3D-v6 All Metal HotEnd": E3D Online - JR 
URL E3D v6: http://wiki.e3d-online.com/wiki/E3D-v6_Documentation
URL E3D Volcano: http://wiki.e3d-online.com/wiki/E3D-v6_%28Volcano%29_Documentation
*/

/* [Global] */

// resolution of round object. each line segment is fnr mm long. fnr = 1 crude and good for development (its faster), aim for fnr = 0.4 or smaller for a production render. smaller means more details (and a lot more time to render).
fnresolution = 0.4;
// detail level
detaillevel = 1; // [0:coarse render only outlines,1:fine render with all details]

print_part();

module print_part() {
	e3d();
}

module e3d() {
	difference() {
		union() {
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,6]) fncylinder(r=6,h=8);
			translate([0,0,13]) fncylinder(r=8,h=8);
			translate([0,0,20]) fncylinder(r=11.15,h=26);
			translate([0,0,0]) fncylinder(r=8,h=7);
			translate([0,0,45]) fncylinder(r=2,h=4.1);
			translate([-4.5,-4.5,49.6]) chamfercube([11.5,20,18.5],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
			translate([-4.5,-4.5,48.1]) chamfercube([11.5,12,5],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
			translate([0,0,67.1]) fncylinder(r=2.5,h=3);
			translate([0,0,69.1]) fncylinder(r=4.03,h=3,fn=6);
			translate([0,0,71.1]) fncylinder(r=3,r2=0.5,h=3);
		}
		if(detaillevel==1) {
			translate([0,0,-1]) fncylinder(r=1.6,h=64.1);
			translate([0,0,62.1]) fncylinder(r=0.25,h=4,fn=10);
			translate([0,0,16]) fnpipe(r=9,r2=4.475,h=1.5); 
			translate([0,0,18.5]) fnpipe(r=9,r2=4.475,h=1.5); 
			for ( i = [0 : 9] ) {
				translate([0,0,21+i*2.5]) fnpipe(r=12.15,r2=4.475+i*0.15,h=1.5); 
			}
			translate([-0.5,7.5,47.1]) fncylinder(r=3.05, h=22);
			translate([-1.5,7.5,47.1]) cube([2,8.5,22]);
			translate([-5.5,13,52.6]) rotate([0,90,0]) fncylinder(r=1.4, h=13.5);
			translate([-5.5,13,61.6]) rotate([0,90,0]) fncylinder(r=1.4, h=13.5);
			translate([-5.5,13,52.6]) rotate([0,90,0]) fncylinder(r=1.6, h=5.2);
			translate([-5.5,13,61.6]) rotate([0,90,0]) fncylinder(r=1.6, h=5.2);
			translate([8,4,59.1]) rotate([0,-90,0]) fncylinder(r=1.4, h=4.45);
			translate([8,4,62.6]) rotate([0,-90,0]) fncylinder(r=0.9, h=3);
			translate([8,4,62.6]) rotate([0,-90,0]) fncylinder(r=0.75, h=5.45);
		}
	}
}

module chamfercube(xyz=[0,0,0],side=[0,0,0,0],top=[0,0,0,0],bottom=[0,0,0,0],x=false,y=false,z=false) {
	translate([x==true?-xyz[0]/2:0,y==true?-xyz[1]/2:0,z==true?-xyz[2]/2:0]) difference() {
		cube(xyz);
		if(side[0]>=0) translate([0,0,xyz[2]/2]) rotate([0,0,45]) cube([side[0]*2,side[0]*3,xyz[2]+2],center=true);
		if(side[1]>=0) translate([xyz[0],0,xyz[2]/2]) rotate([0,0,-45]) cube([side[1]*2,side[1]*3,xyz[2]+2],center=true);
		if(side[2]>=0) translate([xyz[0],xyz[1],xyz[2]/2]) rotate([0,0,45]) cube([side[2]*2,side[2]*3,xyz[2]+2],center=true);
		if(side[3]>=0) translate([0,xyz[1],xyz[2]/2]) rotate([0,0,-45]) cube([side[3]*2,side[3]*3,xyz[2]+2],center=true);
		if(top[0]>=0) translate([xyz[0]/2,0,xyz[2]]) rotate([-45,0,0]) cube([xyz[0]+2,top[0]*2,top[0]*3,],center=true);
		if(top[2]>=0) translate([xyz[0]/2,xyz[1],xyz[2]]) rotate([45,0,0]) cube([xyz[0]+2,top[2]*2,top[2]*3,],center=true);
		if(top[3]>=0) translate([0,xyz[1]/2,xyz[2]]) rotate([0,45,0]) cube([top[3]*2,xyz[1]+2,top[3]*3,],center=true);
		if(top[1]>=0) translate([xyz[0],xyz[1]/2,xyz[2]]) rotate([0,-45,0]) cube([top[1]*2,xyz[1]+2,top[1]*3,],center=true);
		if(bottom[0]>=0) translate([xyz[0]/2,0,0]) rotate([45,0,0]) cube([xyz[0]+2,bottom[0]*2,bottom[0]*3,],center=true);
		if(bottom[2]>=0) translate([xyz[0]/2,xyz[1],0]) rotate([-45,0,0]) cube([xyz[0]+2,bottom[2]*2,bottom[2]*3,],center=true);
		if(bottom[3]>=0) translate([0,xyz[1]/2,0]) rotate([0,-45,0]) cube([bottom[3]*2,xyz[1]+2,bottom[3]*3,],center=true);
		if(bottom[1]>=0) translate([xyz[0],xyz[1]/2,0]) rotate([0,45,0]) cube([bottom[1]*2,xyz[1]+2,bottom[1]*3,],center=true);
	}	
}

// ######################################################################################################################
module fnpipe(r,r2,h,fn){
	if (fn==undef) {
		difference() {
			fncylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,$fn=2*r*3.14/fnresolution);
		}
	} else {
		difference() {
			fncylinder(r=r,h=h,fn=fn);
			translate([0,0,-1]) fncylinder(r=r2,h=h+2,fn=fn);
		}
	}
}

// ######################################################################################################################
module fncylinder(r,r2,h,fn){
	if (fn==undef) {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=2*r*3.14/fnresolution);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=2*r*3.14/fnresolution);
		}
	} else {
		if (r2==undef) {
			cylinder(r=r,h=h,$fn=fn);
		} else {
			cylinder(r=r,r2=r2,h=h,$fn=fn);
		}
	}
}