/* Copyright © 2016. Alexander Golikov.
 * 
 * This file is free software: you can redistribute it and/or modify it under the terms of the Creative Commons Attribution-NonCommercial-ShareAlike International Public License, either version 4.0 of the License, or (at your option) any later version.
 * 
 * This file is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Creative Commons Attribution-NonCommercial-ShareAlike International Public License for more details.
 * 
 * You should have received a copy of the Creative Commons Attribution-NonCommercial-ShareAlike International Public License along with this file.
 * 
 * If not, see https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.
 */

// Height of bottom part
h1=37;//[40:10:150]
// Height of top part a+b=100; a/b=1.618; a=100-b; 100=2.618*b;
h2=67;//[40:10:150]
// Bottom radius
r1=47;//[30:5:80]
// Middle radius
r2=31;//[20:5:70]
// Top radius
r3=53;//[40:5:100]
// Thickness of walls
s=0.5;//[0.5:0.1:2]
// Number of corners
c=7 ;//[3:1:19]
// Bottom twist angle
a1=-71;//[-180:5:180]
// Top twist angle
a2=-67;//[-180:5:180]

/* [Hidden] */

tc1=r2/r1;
tc2=r3/r2;
sl1=h1/(s*2);
sl2=h2/(s*2);
//sl1=100;
//sl2=100;
//24 8b fb
// [34/255,139/255,251/255]

color("red")translate([0,0,s])union() {
	union() {
		translate([0,0,-s])linear_extrude(height = s, center = false, convexity = 10, twist = 0,slices=5,scale=1,$fn=c)
			circle(r1);
		difference() {
			linear_extrude(height = h1, center = false, convexity = 10, twist = a1,slices=sl1,scale=tc1,$fn=c)
				circle(r1);
			translate([0,0,-s/2])
				linear_extrude(height = h1+s, center = false, convexity = 50, twist = a1,slices=sl1,scale=tc1,$fn=c)
					circle(r1-s);
		}
	}
	rotate([0,0,-a1]) {
		translate([0,0,h1-(s/2)]) {
			difference() {
				linear_extrude(height = h2, center = false, convexity = 10, twist = a2,slices=sl2,scale=tc2,$fn=c)
					circle(r2);
				translate([0,0,-s/2])
					linear_extrude(height = h2+s, center = false, convexity = 50, twist = a2,slices=sl2,scale=tc2,$fn=c)
						circle(r2-s);
			}
		}
	}
}


