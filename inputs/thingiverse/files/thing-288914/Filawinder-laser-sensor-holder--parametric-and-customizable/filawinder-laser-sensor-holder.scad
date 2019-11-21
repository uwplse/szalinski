// Filawinder laser sensor holder
//
// © 2015 Holger 'h0lger' Reichert
// http://h0lger.de
// mail@h0lger.de
// 
// License: CC BY-SA 4.0


/* [Basic parameters] */

// Width of the base in mm. The size between the walls.
base_width = 65;

// Length of the base in mm.
base_length = 60;
// Thickness of the base plate in mm.
base_thickness = 4.4;

// Height of the side walls in mm. 
wall_height = 70;
// Thickness of the side walls in mm.
wall_thickness = 7;

/* [Advanced parameters] */

// The width of the sensor cutout, bottom.
sensor_width_1 = 27;
// The width of the sensor cutout, top.
sensor_width_2 = 8;
// The height of the sensor cutout, bottom.
sensor_height_1 = 20;
// The height of the sensor cutout, top.
sensor_height_2 = 30;
// The distance of the sensor cutout from the base.
sensor_offset = 12;

// The diamater of the laser hole.
laser_diameter = 12;
// The distance between the laser hole and the base.
laser_offset = 47;

// Diameter of the holes in the base plate.
hole_diameter = 4; // [1:7]
// How much holes in the base plate?
hole_count = 5; // [0:10]

// Corner rounding radius for the walls.
rounding = 3; // [0:6]

/* [Hidden] */

$fn=40;

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

// base
difference() {
	roundedCube([base_width, base_length, base_thickness], rounding, true);
	baseholes();
}

// wall with laser
difference() {
	translate([0, 0, 0]) roundedCube([wall_thickness, base_length, wall_height + base_thickness], rounding, false);
	color([1,1,0,0.1]) translate([-1, base_length/2, laser_offset+base_thickness]) rotate([0, 90, 0]) cylinder(r=laser_diameter/2, h=wall_thickness+200, $fn=20);
	translate([-1, base_length/2, base_thickness+10]) rotate([0, 90, 0]) cylinder(r=hole_diameter/2, h=wall_thickness+2, $fn=20);
}

// wall with sensor
difference() {
	translate([base_width-wall_thickness, 0, 0]) roundedCube([wall_thickness, base_length, wall_height+base_thickness], rounding, false);
	translate([base_width+1, (base_length/2)-(sensor_width_1/2), base_thickness+sensor_offset]) rotate([0, 0, 90]) sensorholder();
	translate([base_width-wall_thickness-1, base_length/2, base_thickness+sensor_offset+sensor_height_1+sensor_height_2+4]) rotate([0, 90, 0]) cylinder(r=hole_diameter/2, h=wall_thickness+2, $fn=20);
}

// cut-out for the sensor
module sensorholder() {
	cube([sensor_width_1, wall_thickness+2, sensor_height_1]);
	translate([(sensor_width_1-sensor_width_2)/2, 0, sensor_height_1-1]) cube([sensor_width_2, wall_thickness+2, sensor_height_2+1]);
}

// cut-out for the base holes
module baseholes() {
	x=(base_width-(wall_thickness*2))/hole_count-1;
	for(i = [0 : hole_count-1]) {
	      translate([wall_thickness+(hole_diameter/2)+(x*i)+(x/2), 8, -1]) cylinder(r=hole_diameter/2, h=base_thickness+2, $fn=20);
	      translate([wall_thickness+(hole_diameter/2)+(x*i)+(x/2), base_length-8, -1]) cylinder(r=hole_diameter/2, h=base_thickness+2, $fn=20);
	}
}
