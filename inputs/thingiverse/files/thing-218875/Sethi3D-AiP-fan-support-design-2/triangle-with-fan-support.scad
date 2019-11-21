// Copyright (c) Claudio Luis Marques Sampaio <patola@gmail.com>
// All rights ignored.
//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions
//are met:
//1. Redistributions of source code must retain the above copyright
//   notice, this list of conditions and the following disclaimer.
//2. Redistributions in binary form must reproduce the above copyright
//   notice, this list of conditions and the following disclaimer in the
//   documentation and/or other materials provided with the distribution.
//3. Neither the name of the University nor the names of its contributors
//   may be used to endorse or promote products derived from this software
//   without specific prior written permission.
//
//THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND
//ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE
//FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
//OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
//HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
//OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
//SUCH DAMAGE.

// Level of detail
detail=200; // [20:draft, 50:moderate, 200:final]
// Diameter of nozzle opening in mm
opening=8; // [4:14]
// Angle of nozzle opening relative to the fan opening
angle=40; // [0:60]
// Angle of fan relative to support triangle
fanangle=30; // [0:90]
// Nozzle length (keep it short lest it will touch the heated bed)
nozzlelength=30; // [20:40]

$fn=detail;
rotate([180,0,0]) union() {
difference() {
	// support triangle
	linear_extrude(height=5.6) difference() {
		union() {
			polygon(points=[[0,0],[50.8,0],[50.8,5],[5,35],[0,35]]);
			polygon(points=[[50.8,0],[48.3,-2.5],[48.3,0]]);
			polygon(points=[[0,2.6],[-6,2.6],[-6,7.1],[0,7.1]]);
			polygon(points=[[0,18.7],[-6,18.7],[-6,23.2],[0,23.2]]);
		}
		polygon(points=[[0,11.2],[3,11.2],[3,8.9],[5.4,8.9],[5.4,11.2],[7.3,11.2],[7.3,14.6],[5.4,14.6],[5.4,16.9],[3,16.9],[3,14.6],[0,14.6]]);
		polygon(points=[[30.9,0],[30.9,3],[28.6,3],[28.6,5.4],[30.9,5.4],[30.9,7.3],[34.3,7.3],[34.3,5.4],[36.6,5.4],[36.6,3],[34.3,3],[34.3,0]]);
		translate([32.6,11.95,0]) circle(r=1.65);
		translate([42.2,6.75,0]) circle(r=1.65);
		translate([7.7,2.6,0]) square([4.6,3.4]);
		translate([7.7,4.3,0]) circle(r=1.7);
		translate([12.3,4.3,0]) circle(r=1.7);
	}
	// slanted opening for wires
	translate([2,0,10]) rotate([0,45,0]) cube([20,4,3]);
}

// Polygon linking the triangle to the fan mount part
linear_extrude(height=5.6) polygon(points=[[5,35],[61,6],[63,0],[50,0],[50,5]]);

// cylinder linking the polygon to the rest of the fan mount part
translate([60,2,5.6]) rotate([0,-180,0]) cylinder(r=4,h=47.6); 

translate([58,-48,18]) rotate([0,90,0]) difference() {
	translate([20,50,0]) rotate([fanangle,0,0]) union() {
		difference () {
			cube([40,50,5.6]);
			translate([20,28,-.2]) cylinder(r=18,h=6);
			translate([4,12,-.2]) cylinder(r=1.2,h=6);
			translate([36,12,-.2]) cylinder(r=1.2,h=6);
			translate([36,44,-.2]) cylinder(r=1.2,h=6);
			translate([4,44,-.2]) cylinder(r=1.2,h=6);
		}
		rotate([180,0,90]) union() {
			for (loc=[9:5.8:49.6]) {
				translate([loc,-7.6,-5.6]) linear_extrude(height=5.6) polygon(points=[[-1.5,0],[1.5,0],[0,8.6]]);
			}
			translate([9,-4,-5.6]) cube([40,1,5.6]);
		}
		// cone for restricting air flow
		translate([20,28,0]) mirror([0,0,-1]) difference() {
			// I am using hull() here to slant the cone if
			// needed. For that, just change the "y" value
			// in the second term of hull, e.g.
			// translate([0,8,20]) will shift the center
			// 8 mm downward.
			hull() {
				cylinder(r=20,h=0.01);
				translate([0,7,nozzlelength]) rotate([-angle,0,0]) cylinder(r=opening+2,h=0.01);
			}
			translate([0,0,-0.1]) hull() {
				cylinder(r=18,h=0.01);
				translate([0,7,nozzlelength+0.2]) rotate([-angle,0,0]) cylinder(r=opening,h=0.01);
			}
		}	
	}
	translate([100,100,-10]) cube([100,100,10]);
}
}