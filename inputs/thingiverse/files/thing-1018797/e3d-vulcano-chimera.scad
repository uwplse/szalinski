/*
Name: E3D Chimera Dual Volcano HotEnd in OpenSCAD
Author: Professional 3D - Jons Collasius from Germany/Hamburg
URL Professional 3D: http://professional3d.de

License: CC BY-NC-SA 4.0
License URL: https://creativecommons.org/licenses/by-nc-sa/4.0/

Creator of "E3D Volcano": E3D Online - JR 
URL E3D Volcano: http://wiki.e3d-online.com/wiki/E3D-v6_%28Volcano%29_Documentation

Creator of "E3D Chimera": E3D-Online 
URL E3D Chimera: http://e3d-online.com/Multi-Extrusion/Chimera
*/

// ######################################################################################################################
/* [Global] */

// resolution of round object. each line segment is fnr mm long. fnr = 1 crude and good for development (its faster), aim for fnr = 0.4 or smaller for a production render. smaller means more details (and a lot more time to render).
resolution = 0.25;
// detail level
detaillevel = 1; // [0:coarse render only outlines,1:fine render with all details]
// 
withfan = 1; // [0:render without fan frame,1:render with fan frame]
// ######################################################################################################################
print_part();

// ######################################################################################################################
module print_part() {
	e3d();
}

// ######################################################################################################################
module e3d() {
	chimera_and_cyclops_body();
	for(i=[[9,0,0],[-9,0,0]]) translate(i) fncylinder(d=6.8,h=14);
	translate([9,0,-2]) rotate([180,0,0]) volcano_heater(rotate=0); 
	translate([-9,0,-2]) rotate([180,0,0]) volcano_heater(rotate=0); 
}

// ######################################################################################################################
module chimera_and_cyclops_body() {
	if (withfan==1) translate([-15,-12-10,0]) difference() {
		// fan
		chamfercube([30,9.5,30]);
		// fan holes
		if(detaillevel==1) {
			translate([15,0,15]) rotate([-90,0,0]) fncylinder(d=28,h=9.5,enlarge=1);
			translate([15,0,15]) for(i=[0:3]) rotate([0,i*90,0]) translate([12,0,12]) rotate([-90,0,0]) fncylinder(d=3.2,h=9.5,enlarge=1);
		}
	}
	translate([-15,-12,0]) difference() {
		union() {
			// main block
			chamfercube([30,18,30]);
		}
		if(detaillevel==1) {
			// filament
			for(i=[6,24]) translate([i,12,0]) {
				fncylinder(d=4.2,h=30,enlarge=1);
				translate([0,0,-1]) fncylinder(d=7,h=15);
				translate([0,0,13.995]) fncylinder(d=7,d2=4.2,h=1.005);
				translate([0,0,23.5]) fncylinder(d=8,h=7.5);
				translate([0,0,22.5]) fncylinder(d2=8,d=4.2,h=1.005);
			}
			// cooling slots
			slotspace=1.75;
			for(i=[0:6]) translate([-1,-1,1.75+i*(1.75+(16/7))]) chamfercube([32,7,(16/7)]);
			// back mount
			for(i=[[10.5,10,20],[19.5,10,20],[15,10,10]]) translate(i) rotate([-90,0,0]) fncylinder(d=3,h=9);
			// top mount
			for(i=[[6.5,3,22],[23.5,3,22],[15,15,22]]) translate(i) fncylinder(d=3,h=9);
			// back mount
			for(i=[[6,-1,3],[24,-1,3],[6,-1,11],[24,-1,11]]) translate(i) rotate([-90,0,0]) fncylinder(d=3,h=20);
			// fan mount
			for(i=[[3,-1,27],[27,-1,3]]) translate(i) rotate([-90,0,0]) fncylinder(d=2.8,h=7);
		}
	}	
}

// ######################################################################################################################
module volcano_heater(rotate=0) {
// 48.1
	rotate([0,0,rotate])	difference() {
		union() {
			translate([0,0,-3.1]) fncylinder(r=2,h=4.1);
			translate([-4.5,-4.5,1.5]) chamfercube([11.5,20,18.5],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
			translate([-4.5,-4.5,0]) chamfercube([11.5,12,5],side=[0.4,0.4,0.4,0.4],top=[0.4,0.4,0.4,0.4],bottom=[0.4,0.4,0.4,0.4]);
			translate([0,0,19]) fncylinder(r=2.5,h=3);
			translate([0,0,21]) fncylinder(r=4.03,h=3,fn=6);
			translate([0,0,23]) fncylinder(r=3,r2=0.5,h=3);
		}
		if(detaillevel==1) {
			translate([-0.5,7.5,-1]) fncylinder(r=3.05, h=22);
			translate([-1.5,7.5,-1]) cube([2,8.5,22]);
			translate([-5.5,13,4.5]) rotate([0,90,0]) fncylinder(r=1.4, h=13.5);
			translate([-5.5,13,13.5]) rotate([0,90,0]) fncylinder(r=1.4, h=13.5);
			translate([-5.5,13,4.5]) rotate([0,90,0]) fncylinder(r=1.6, h=5.2);
			translate([-5.5,13,13.5]) rotate([0,90,0]) fncylinder(r=1.6, h=5.2);
			translate([8,4,11]) rotate([0,-90,0]) fncylinder(r=1.4, h=4.45);
			translate([8,4,14]) rotate([0,-90,0]) fncylinder(r=0.9, h=3);
			translate([8,4,14]) rotate([0,-90,0]) fncylinder(r=0.75, h=5.45);
		}
	}
}

// ######################################################################################################################
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
module fncylinder(r,r2,d,d2,h,fn,center=false,enlarge=0,pi=3.1415926536){
	translate(center==false?[0,0,-enlarge]:[0,0,-h/2-enlarge]) {
		if (fn==undef) {
			if (r2==undef && d2==undef) {
				cylinder(r=r?r:d?d/2:1,h=h+enlarge*2,$fn=floor(2*(r?r:d?d/2:1)*pi/resolution));
			} else {
				cylinder(r=r?r:d?d/2:1,r2=r2?r2:d2?d2/2:1,h=h+enlarge*2,$fn=floor(2*(r?r:d?d/2:1)*pi/resolution));
			}
		} else {
			if (r2==undef && d2==undef) {
				cylinder(r=r?r:d?d/2:1,h=h+enlarge*2,$fn=fn);
			} else {
				cylinder(r=r?r:d?d/2:1,r2=r2?r2:d2?d2/2:1,h=h+enlarge*2,$fn=fn);
			}
		}
	}
}