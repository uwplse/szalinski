// FLEXY JOINT developed by Dale Price and Nick Parker
// based on Flexy Hand by Gyrobot


// Parameters designed to work with Thingiverse Customizer:

// Make a positive (the joint itself) or negative (mould)?
negative = 1; // [1:Negative mould,0:Positive]

// Mould/print depth: print multiple joints as one wide one and then cut them to size?
depth = 1; // [1:20]

// Spacing between multiple joints
padding = 3;

// How many Flexy Hand Large joints?
flexy_large_num = 4;

// How many Flexy Hand Small joints?
flexy_small_num = 11;

// How many custom sized joints?
custom_num = 0;

// Label for this mold
label = "Flexy Joints";

/* [Custom Sizes] */

// Diameter of end cylinders
custom_dia = 2;

// Thickness of joint middle
custom_thick = 1;

// Width of joint
custom_width = 1;

// Overall length of joint
custom_length = 10;


/* [Hidden] */

flexy_large_dia = 6.97;
flexy_large_thick = 4;
flexy_large_width = 16;
flexy_large_length = 18;

flexy_small_dia = 4.98;
flexy_small_thick = 2;
flexy_small_width = 12;
flexy_small_length = 15;

text_line_height = 4;

$fn = 50;

//=====================================

use <write/Write.scad>

flexy_large_total_w = ceil(flexy_large_num / depth) * (padding + flexy_large_dia);
flexy_small_total_w = ceil(flexy_small_num / depth) * (padding + flexy_small_dia);
custom_total_w = ceil(custom_num / depth) * (padding + custom_dia);

mould_x = flexy_large_total_w + flexy_small_total_w + custom_total_w + 2 * padding;
mould_y = max(flexy_large_width, flexy_small_width, custom_width) * depth;
mould_z = max(flexy_large_length, flexy_small_length, custom_length) + 2 * padding + 2 * text_line_height;

custom_text = str("d=",custom_dia,",t=",custom_thick,",w=",custom_width,",l=",custom_length);

mould_joint_width = depth * max(flexy_large_width, flexy_small_width, custom_width);


module flexy_joint(dia, thick, width, length) {
	translate([dia/2, -dia/2, 0]) {
		cylinder(d=dia, h=width, center=false);
		translate([0, -thick/2, 0])
			cube([length - dia, thick, width]);
		translate([length - dia, 0, 0])
			cylinder(d=dia, h=width, center=false);
	}
}

module flexy_large_joint(dia=flexy_large_dia, thick=flexy_large_thick, width=flexy_large_width, length=flexy_large_length) {
	flexy_joint(dia, thick, width, length);
}

module flexy_small_joint(dia=flexy_small_dia, thick=flexy_small_thick, width=flexy_small_width, length=flexy_small_length) {
	flexy_joint(dia, thick, width, length);
}

module mould() {
	difference() {
		cube([mould_x, mould_y, mould_z]);
		translate([padding,-1,mould_z - text_line_height-0.5]) rotate([90,0,0])
			write(label, h=text_line_height, t=-1.5);
	}
}
module joint_array(depth = 1, mould = 0) {
	translate([padding,padding,0]) {
		//make flexy large joints
		for(i = [0 : 1 : ceil(flexy_large_num / depth - 1)]) {
			translate([i * (flexy_large_dia + padding),0,0])
				rotate([0,0,90]) {
						if (mould == 0) flexy_large_joint(width=flexy_large_width*depth);
						if (mould == 1) flexy_large_joint(width=mould_joint_width);
				}
		}
		//text label
		if (flexy_large_num > 0) {
			translate([0,-5,mould_y])
			write("Flexy Large", h=text_line_height, t=-1.8);
		}
		//make flexy small joints
		translate([flexy_large_total_w, 0, 0]) {
			for(i = [0 : 1 : ceil(flexy_small_num / depth - 1)]) {
				translate([i * (flexy_small_dia + padding),0,0])
					rotate([0,0,90]){
						if (mould == 0) flexy_small_joint(width=flexy_small_width*depth);
						if (mould == 1) flexy_small_joint(width=mould_joint_width);
					}
			}
			if (flexy_small_num > 0) {
				translate([0,-5,mould_y])
					write("Flexy Small", h=text_line_height, t=-1.8);
			}
		}
		//make custom joints
		translate([flexy_large_total_w + flexy_small_total_w, 0, 0]) {
			for(i = [0: 1: ceil(custom_num / depth - 1)]) {
				translate([i * (custom_dia + padding), 0, 0])
					rotate([0,0,90]){
						if (mould == 0)flexy_joint(dia=custom_dia, thick=custom_thick, width=custom_width * depth, length=custom_length);
						if (mould == 1) flexy_joint(dia=custom_dia, thick=custom_thick, width=mould_joint_width, length=custom_length);
					}
			}
			if (custom_num > 0) {
				translate([0,-5,mould_y]) {
					write(custom_text, h=text_line_height, t=-1.8);
				}
			}
		}
	}
}

if ( negative == false ) {
	joint_array(depth=depth, mould=0);
}
else {
	difference() {
		mould();
		rotate([90,0,0]) translate([0,text_line_height,-mould_joint_width]) scale([1,1,1.1]) joint_array(depth=depth, mould=1);
	}
}
