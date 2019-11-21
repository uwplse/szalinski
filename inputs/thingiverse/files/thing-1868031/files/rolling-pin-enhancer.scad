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

// Diameter of rolling pin.
diameter = 40.5; 		// [30:0.5:70]
// Thickness of the rolled dough.
width = 7; 				// [1:1:10]
// Height of the extender.
height = 5; 			// [2:1:10]
// Number of the extenders
number = 2; 			// [1:One, 2:Two, 4:Four]
// Sharp facet. NOTE! Depends on opportunities of Your printer
facet = 1; 			// [1:On, 0:Off]
// Dual sharp facet, if "Sarp facet" is on.
second_facet = 0; 	// [1:On, 0:Off]
// Thickness of "Sarp facet". NOTE! May be NOT MORE then Height/2!
thickness = 1; 			// [1:0.5:5]

/* [Hidden] */

//$fn=64;
d=diameter;
w=width;
h=height;
th=thickness;

r1=(d/2+w);
r2=(d/2+(w-1));

if (th > (h/2)) {
	th = round(h/2);
}

if(number==4) {
	guide(d,d);
	guide(d,-d);
	guide(-d,d);
	guide(-d,-d);
} else if(number==2) {
	guide(0,d);
	guide(0,-d);
} else {
	guide(0,0);
}

module guide(x,y) {
	translate([x,y,0]){
		difference(){
			union(){
				color("green")
					if(facet==1){
						if(second_facet==1){
							union(){
								cylinder(h=th,r1=r2,r2=r1,center=false);
								translate([0,0,th]){
									cylinder(h=th,r1=r1,r2=r2,center=false);
								}
							}
						} else {
							cylinder(h=2*th,r1=r1,r2=r2,center=false);
						}
					} else {
						cylinder(h=h,r=r1,center=false);
					}
				color("red")
					cylinder(h=h,d=(d+(2*th)),center=false);
			}
			color("yellow")
				translate([0,0,-(th/2)])
					cylinder(h=h+th,d=d,center=false);
			color("blue")
				translate([((d/2)-th),-(th/2),-(th/2)])
					linear_extrude(h=(h+th), slices=(5*h), twist=(3*h))
						square([(w+(2*th)),(th)],false);
		}
	}
}
