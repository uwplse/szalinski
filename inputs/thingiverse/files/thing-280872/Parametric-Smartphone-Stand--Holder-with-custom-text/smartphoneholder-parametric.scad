// Original von Hardest
// TODO: Copyright Infos

use <write/Write.scad>

// Gap in mm. Adjust to your phone size.
gap_thickness = 11; // [5:15]

// Width in mm.
width = 40;

// Length in mm.
length = 125;

// Height in mm.
height = 15; // [10:25]

// The text. Can also be empty.
text = "Text";

// Text height in mm.
textSize = 11; // [4:20]

// Radius of the corners. 0 = no corners.
corner_radius = 13; // [0:20]

module roundedBox(size, radius, sidesonly) {
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
		  y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);
		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
			  y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis])
				translate([x,y,0])
				cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
		  y = [radius-size[1]/2, -radius+size[1]/2],
		  z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}

module roundedCube(dim,r,sidesOnly) {
	translate([dim[0]/2,dim[1]/2,dim[2]/2]) roundedBox(dim,r,sidesOnly);
}

module smartphoneholder() {
	$fn=100;
	rotate([0,0,180]) translate([-width/2+1,(-length/3)*2,height]) color("red") {
		write(text, h=textSize,t=2.5,font="write/orbitron.dxf",center=true);
	}

	difference () {
		roundedCube ([width,length,height],corner_radius,true);
		union () {
			translate ([-1,15,height/4]) rotate (a = 40, v=[1,0,0]) cube (size = [width+2,height*2,gap_thickness]);
			translate ([-1,(length/2+gap_thickness/2),height/2]) rotate (a = 90, v=[1,0,0]) cube (size = [width+2,height*2,gap_thickness]);
			translate ([-1,length-10,height/2]) rotate (a = 120, v=[1,0,0]) cube (size = [width+2,height*2,gap_thickness]);
		}
	}
}

translate([width/2,length/2,0]) rotate([0,0,180]) smartphoneholder();