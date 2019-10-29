//SD/microSD pocket customizable (army knife style)
//by Yannis Kari
//ToDo: add minisd slot


use <text_on/text_on.scad>

part = 2; // [1:top, 2:holder, 3:bottom]

ext_radius = 5;
size_x = 29;
size_y = 92;
hole_dia = 3.2;
magnet_dia = 3.3;
magnet_height = 1;
magnets = 3;
layers = 3; // layers below magnets 1...10
layer_height = 0.2;
first_layer_height = 0.3;
offset_x = 0.3;
offset_y = 0.3;

slot1 = 1; // [1:SD, 2:4x microSD]
slot2 = 2; // [1:SD, 2:4x microSD]
finger_push = 0; // [1:Yes, 0:No]
finger_pull = 1; // [1:Yes, 0:No]
spacer = 1; // [1:Yes, 0:No]

//Hidden
$fn = 50;
//Calc
magnet_h = magnets * magnet_height;
size_z = magnet_h + first_layer_height + (layers-1)*layer_height;

module SD(){
	translate([-offset_x/2,-offset_y/2,0])cube([24+offset_x,32+offset_y,2.5+0.1]);
	if (finger_push == 1) translate([24/2,32/2,-size_z+2.5-0.1])cylinder(d=19,h=size_z-2.5+0.2);
}

module microSDx4(){
	translate([-offset_x/2,-offset_y/2,0])cube([11+offset_x,15+offset_y,2.5+0.1]);
	translate([11+2-offset_x/2,-offset_y/2,0])cube([11+offset_x,15+offset_y,2.5+0.1]);
	translate([-offset_x/2,15+2-offset_y/2,0])cube([11+offset_x,15+offset_y,2.5+0.1]);
	translate([11+2-offset_x/2,15+2-offset_y/2,0])cube([11+offset_x,15+offset_y,2.5+0.1]);
	if (finger_push == 1){
		translate([11/2,15/2,-size_z+2.5-0.1])cylinder(d=9,h=size_z-2.5+0.2);
		translate([13+11/2,15/2,-size_z+2.5-0.1])cylinder(d=9,h=size_z-2.5+0.2);
		translate([11/2,17+15/2,-size_z+2.5-0.1])cylinder(d=9,h=size_z-2.5+0.2);
		translate([13+11/2,17+15/2,-size_z+2.5-0.1])cylinder(d=9,h=size_z-2.5+0.2);
	}
}

module base(thick){
	hull(){
		translate([ext_radius,ext_radius,0])cylinder(d=ext_radius*2,h=thick);
		translate([ext_radius,size_y-ext_radius,0])cylinder(d=ext_radius*2,h=thick);
		translate([size_x-ext_radius,size_y-ext_radius,0])cylinder(d=ext_radius*2,h=thick);
		translate([size_x-ext_radius,ext_radius,0])cylinder(d=ext_radius*2,h=thick);
	}
}

module screw_holes(thick){
	translate([size_x-5.5,5.5,-0.1])cylinder(d=hole_dia,h=thick+0.2);
	translate([5.5,size_y-5.5,-0.1])cylinder(d=hole_dia,h=thick+0.2);
}

module screw_heads(thick){
	translate([size_x-5.5,5.5,thick-3])cylinder(d=5.7,h=3+0.1);
	translate([5.5,size_y-5.5,thick-3])cylinder(d=5.7,h=3+0.1);
}

module magnet_holes(thick){
	translate([5.5,5.5,size_z-magnet_h])cylinder(d=magnet_dia,h=magnet_h+0.1);
	translate([29-29/4,size_y-5.5,0.7])cylinder(d=magnet_dia,h=thick-0.7+0.1);
}

module nut_grooves(thick){
	translate([size_x-5.5,5.5,-0.1])rotate([0,0,45])cylinder(d=6.8,h=2.5+.1,$fn=6);
	translate([5.5,size_y-5.5,-0.1])rotate([0,0,45])cylinder(d=6.8,h=2.5+0.1,$fn=6);
}

module print_part(type){
	difference(){
		union(){
			if(type == 2){
				base(size_z);
				translate([size_x-ext_radius,size_y-ext_radius])cube([ext_radius,ext_radius,size_z]);
				difference(){
					translate([size_x-size_x/4,size_y,0])cylinder(d=29/2,h=size_z);
					if (finger_pull) translate([size_x-size_x/4,size_y,size_z])rotate([-15,0,0])cylinder(d=29/2-4,h=size_z);
				}
			}
			else base(size_z);
		}
		if (type == 2){
			if (slot1 == 1) translate([2.5,13,size_z-2.5]) SD();
			else if (slot1 == 2) translate([2.5,13,size_z-2.5]) microSDx4();
			if (slot2 == 1) translate([2.5,47,size_z-2.5]) SD();
			else if (slot2 == 2) translate([2.5,47,size_z-2.5]) microSDx4();
			difference(){
				union(){
					translate([size_x/2-22/2,size_y,-0.1])cylinder(d=22,h=size_z+0.2);
					translate([-0.1,size_y-11,-0.1])cube([size_x/2-11+0.1,11,size_z+0.2]);
				}
				if (spacer){
					translate([size_x/2-22/2,size_y,-0.1])cylinder(d=17,h=size_z+0.2);
					translate([-0.1,size_y-8.5,-0.1])cube([size_x/2-11+0.1,8.5,size_z+0.2]);
				}
			}
			screw_holes(size_z);
			magnet_holes(size_z);
		}
		else{
			screw_holes(size_z);
			magnet_holes(size_z);
			if (type == 1){
				screw_heads(size_z);
				translate([size_x/2,size_y/2,size_z-0.2/2])rotate([0,0,90])text_extrude("Memory Cards",extrusion_height=0.4+0.1,size=6,font="Spin Cycle OT",center=true);
			}
			else{
				nut_grooves();
				translate([size_x/2,size_y/2,0.2/2])rotate([180,0,90])text_extrude("HackerMagnet",extrusion_height=0.4+0.1,size=6,font="Spin Cycle OT",center=true);
			}
		}
	}
}

if (part == 3) translate([size_x,0,size_z])rotate([0,180,0]) print_part(part);
else print_part(part);