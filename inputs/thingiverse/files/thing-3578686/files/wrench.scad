$fn = 64;					// So the cylinders are smooth
layer=0.2;
thread=0.5;

nut_diameter = 5.6;			// My M3 nut measured ~5.4, I added a fudge factor
nut_thickness = 2.31;

// Calculate some nice values

wrench_thickness = 1.2 * nut_thickness;
wrench_length = 5.25 * nut_diameter;
wrench_head_extra_d = 1.2 * nut_diameter;	// If your wrench is big, you
										// probably just want this to be 10


difference(){
	model();
	interlock013DNegative([3*wrench_length,3*wrench_head_extra_d],layer);
	translate([0,0,wrench_thickness-layer]) interlock013DNegative([3*wrench_length,3*wrench_head_extra_d],2*layer);
}

intersection(){
	model();
	interlock013D([3*wrench_length,3*wrench_head_extra_d],thread,layer);
}

intersection(){
	model();
	translate([0,0,wrench_thickness-layer]) interlock013D([3*wrench_length,3*wrench_head_extra_d],thread,layer);
}

module model(){
	translate([wrench_length,1.2*wrench_head_extra_d,0]) rotate(90) wrench();
}

module wrench(){
	// Something to make wrench heads for us

	module wrench_head(thickness, nut_d, head_extra, open_ended) {
		difference() {
			translate([0, 0, -thickness / 2]) {
				cylinder(h = thickness, r = (nut_d + head_extra) / 2);
			}

			rotate(30) {
				hexagon(nut_d, thickness * 1.1);
			}

			translate([0, nut_d / 2, 0]) {
				if (open_ended) {
					box(nut_d, nut_d + head_extra / 2, thickness * 1.1);
				}
			}
		}
	}

	// Put us flat on the bed
	translate([0, 0, wrench_thickness / 2]) {

		// The handle
		box(nut_diameter, wrench_length, wrench_thickness);

		// Make the closed head
		translate([0, -((wrench_length + wrench_head_extra_d) / 2), 0]) {
			wrench_head(wrench_thickness, nut_diameter, wrench_head_extra_d, false);
		}

		// And the open head
		translate([0, (wrench_length + wrench_head_extra_d) / 2, 0]) {
			wrench_head(wrench_thickness, nut_diameter, wrench_head_extra_d, true);
		}
	}
}

module interlock013DNegative(size=[30,30],layer=0.2){
	cube([size.x,size.y,layer]);
}

module interlock013D(size=[30,30],thickness=0.5,layer=0.2){
	linear_extrude(layer) translate([-1,-4]) interlock01([size.x+10,size.y+8],thickness);
}

module interlock01(size=[30,30],thickness=0.5){
	for(j=[0:(size.x-1)/10]){
		translate([j*10,0]) 
		for(i=[0:(size.y-1)/8]){
			translate([0,i*6]) mirror([0,0,0]) interlock01Block(thickness);
			translate([10,(i+0.5)*6]) mirror([1,0,0]) interlock01Block(thickness);
		}
	}

	module line(points=[[0,0],[1,1]],t=0.5){
		for(i=[0:len(points)-2]) hull(){
			translate(points[i]) circle(d=t);
			translate(points[i+1]) circle(d=t);
		}
	}

	module interlock01Block(t=0.5){
		line([
			[4,1],[3,1],[2,0],[1,0],[0,1],[2,1],[2,2],[0,2],[1,3],[2,3],[3,2],[4,2],
			[5,3],[3,3],[2,4],[1,4],[1,5],[2,5],[3,6],[4,6],[5,5],[4,5],[3,5],[3,4],[4,4],[5,4],[6,4]
		],t);
	}
}

/*
 *  OpenSCAD Shapes Library (www.openscad.org)
 *  Copyright (C) 2009  Catarina Mota
 *  Copyright (C) 2010  Elmo Mäntynen
 *
 *  License: LGPL 2.1 or later
*/

// size is a vector [w, h, d]
module box(width, height, depth) {
  cube([width, height, depth], true);
}

// size is a vector [w, h, d]
module roundedBox(width, height, depth, radius) {
  size=[width, height, depth];
  cube(size - [2*radius,0,0], true);
  cube(size - [0,2*radius,0], true);
  for (x = [radius-size[0]/2, -radius+size[0]/2],
       y = [radius-size[1]/2, -radius+size[1]/2]) {
    translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
  }
}

module cone(height, radius, center = false) {
  cylinder(height, radius, 0, center);
}

module ellipticalCylinder(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}

module ellipsoid(w, h, center = false) {
  scale([1, h/w, 1]) sphere(r=w/2, center=center);
}

// wall is wall thickness
module tube(height, radius, wall, center = false) {
  difference() {
    cylinder(h=height, r=radius, center=center);
    cylinder(h=height, r=radius-wall, center=center);
  }
}

// wall is wall thickness
module tube2(height, ID, OD, center = false) {
  difference() {
    cylinder(h=height, r=OD/2, center=center);
    cylinder(h=height, r=ID/2, center=center);
  }
}

// wall is wall thickness
module ovalTube(height, rx, ry, wall, center = false) {
  difference() {
    scale([1, ry/rx, 1]) cylinder(h=height, r=rx, center=center);
    scale([(rx-wall)/rx, (ry-wall)/rx, 1]) cylinder(h=height, r=rx, center=center);
  }
}

// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

// size is the XY plane size, height in Z
module octagon(size, height) {
  intersection() {
    cube([size, size, height], true);
    rotate([0,0,45]) cube([size, size, height], true);
  }
}

// size is the XY plane size, height in Z
module dodecagon(size, height) {
  intersection() {
    hexagon(size, height);
    rotate([0,0,90]) hexagon(size, height);
  }
}

// size is the XY plane size, height in Z
module hexagram(size, height) {
  boxWidth=size/1.75;
  for (v = [[0,1],[0,-1],[1,-1]]) {
    intersection() {
      rotate([0,0,60*v[0]]) cube([size, boxWidth, height], true);
      rotate([0,0,60*v[1]]) cube([size, boxWidth, height], true);
    }
  }
}

module rightTriangle(adjacent, opposite, height) {
  difference() {
    translate([-adjacent/2,opposite/2,0]) cube([adjacent, opposite, height], true);
    translate([-adjacent,0,0]) {
      rotate([0,0,atan(opposite/adjacent)]) dislocateBox(adjacent*2, opposite, height+2);
    }
  }
}

module equiTriangle(side, height) {
  difference() {
    translate([-side/2,side/2,0]) cube([side, side, height], true);
    rotate([0,0,30]) dislocateBox(side*2, side, height);
    translate([-side,0,0]) {
      rotate([0,0,60]) dislocateBox(side*2, side, height);
    }
  }
}

module 12ptStar(size, height) {
  starNum = 3;
  starAngle = 360/starNum;
  for (s = [1:starNum]) {
    rotate([0, 0, s*starAngle]) cube([size, size, height], true);
  }
}

//-----------------------
//MOVES THE ROTATION AXIS OF A BOX FROM ITS CENTER TO THE BOTTOM LEFT CORNER
module dislocateBox(w, h, d) {
  translate([0,0,-d/2]) cube([w,h,d]);
}

//-----------------------
// Tests
//module test2D_ellipse(){ellipse(10, 5);}
module test_ellipsoid(){ellipsoid(10, 5);}

//module test2D_egg_outline(){egg_outline();}