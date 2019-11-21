/* 	Nut-Leia By schlem
		theschlem@gmail.com
	 	6-17-13

A glue-on nut trap for use with laser-cut birch
plywood parts or what have you.  I used these
to hold the bed levelling hardware on my  
Printrbot+

I originally modelled it with square tabs to increase
the torque of the glue attachment, which led to 
the predictable development of a "cinnamon-buns" 
Princess Leia Organa silhouette.  

https://en.wikipedia.org/wiki/Princess_Leia

Hexagon, ellipticalCylinder modules poached from:
 *  OpenSCAD Shapes Library (www.openscad.org)
 *  Copyright (C) 2009  Catarina Mota
 *  Copyright (C) 2010  Elmo Mäntynen
 *
 *  License: LGPL 2.1 or later

*/

// ***************  First Things ***************  

$fn=50*1;

// ***************  Parameters ***************    

// Size of Nut in mm
nut = 5;		// across flats, in MILIMETERS
//		Here's a handy link to inch --> mm conversions
//		http://mdmetric.com/tech/cvtcht.htm



//=== constants and relative values ===

height = nut * .33333333;	// scales height:nut
buns_scale = .80*1;				// scales buns:head

// ***************  Top Level code ***************   

union(){
	jaws(nut);
	CinnamonBuns(nut*buns_scale, (nut/2)*buns_scale, height, nut);
}

// ***************  Modules ***************  

//=== jaws === 

module jaws(x = 4, z = 2) {
	translate([0,0,height/2])
	difference(){
		cylinder(h = height, r =x, center = true);
		
		translate([x/5,0,0])
		union(){
		hexagon(x,x);
		translate([x/2,0,0])
			cube(x, center = true);
		}
		translate([nut*1.8,0,0])
		cube (nut*2, center = true);
	}
}

//=== CinnamonBuns === 

module CinnamonBuns(r1 = 3, r2 = 1.5, h = 2, t = 3){
	translate([0,t,0])
	ellipticalCylinder(r1*buns_scale,r2*buns_scale,h);	

	translate([0,-t,0])
	ellipticalCylinder(r1*buns_scale,r2*buns_scale,h);	
}

//=== hexagon === size is the XY plane size, height in Z

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
} 

//=== ellipticalCylinder === 

module ellipticalCylinder(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}





