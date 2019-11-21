// This generates custom battery covers
// Licenced under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:243269

// ================ variables

//CUSTOMIZER VARIABLES

/* [Basic] */

// how long the battery cover is.  (This dimension is in the clip-to-ears direction.)
length=50; // 10:200

// how wide the battery cover is
width=30; // 10:200

// how thick the battery cover is
thickness=0.5;  // 0.1:10

// radius for rounding over the corners of the battery cover
corner_radius=2;  // 0:10

// how thick the case plastic is
case_thickness=3.5;

/* [Ears] */

// how wide the ear tabs are
ear_width=5;  // 2:25

// how wide the ear tabs are
ear_length=5;  // 2:25

// how far apart the ear tabs are.  (To create one wide tab, just set this to 0.)
ear_spacing=10;  // 1:100

// How thick the case is where the ears attach.  Usually it should be the same as "thickness" on the "basic" tab
ear_case_thickness=3.5;  // 0.1:10

/* [Clip] */

// How wide the clip is
clip_width=15; // 5:50

// How deep the clip is
clip_length=5.8; // 5.8

// This is used for a side-engagement clip.  Most clips are this way now.  It measures how wide the small part of the clip is.
clip_width_sides=10;

// This is for a front-engagement clip.  If unused, set it to 0, otherwise, how long the catch will be (usually about 2-3mm)
clip_length_catch=1;

// How far the clip is in/out relative to the edge of the battery cover.
//clip_indent=0;  // -15:15

// This is how far down into the battery case the clip engages.  Usually it should be the same as "thickness" on the "basic" tab
clip_case_thickness=3.5;  // 0.1:10

// The thickness of the finger tab
tab_thickness=1;

/* [Gussets] */

// Which direction the support gussets go
gusset_orientation=0; // [0:clip_lengthwise,1:clip_widthwise]

// How thick the gussets are (set to 0 to turn off gussets)
gusset_thickness=0;

// How high the gussets are
gusset_height=0;

// How far apart the gussets are
gusset_spacing=0;

/* [Advanced] */

// Resolution
$fn=30;

// end variables

cover(width,length,thickness,case_thickness,gusset_thickness,corner_radius,ear_width,ear_spacing,clip_width,clip_width_sides,clip_length,clip_length_catch,clip_case_thickness,ear_length,tab_thickness);

module clip(clip_width=15,clip_width_sides=10,clip_length=1,clip_case_thickness=5,clip_length_catch=3,tab_thickness=3) {
	rotate([90,0,0]){
		difference () {
			union(){ // the outside shape
				hull () {
					translate([0,0,0]) cylinder(r=1,h=clip_width); // outside radius
					translate([5,0,0]) cylinder(r=1,h=clip_width); // inside fadius
					translate([3.6,10.4,0]) cylinder(r=2,h=clip_width); // top
					if(clip_length_catch>0){
						translate([-clip_length_catch+0.1,clip_case_thickness,0]) cylinder(r=0.1,h=clip_width); // add a front overhang
					}
				}
				translate([-2,-1,0]) cube([2,tab_thickness,clip_width]); // the overlap tab
			}
			union(){ // The inside void
				hull() { 
					translate([3.6,10.4,0]) cylinder(r=1,h=clip_width);
					translate([3.5,-2,0]) cylinder(r=1,h=clip_width);
					translate([2.9,-2,0]) cylinder(r=1,h=clip_width);
				}
				//translate([-tab_thickness,0,0]) cube([3,clip_case_thickness,clip_width]); // trim off outside
				translate([-2,-2,0]) cube([5,clip_case_thickness,(clip_width-clip_width_sides)/2]); // trim off left side
				translate([-2,-2,clip_width-(clip_width-clip_width_sides)/2]) cube([5,clip_case_thickness,(clip_width-clip_width_sides)/2]); // trim off right side
			}
		}
	}
}

module cover(width=30,length=60,thickness=0.5,case_thickness=3.9,gusset_thickness=4.5,corner_radius=1,ear_width=7.5,ear_spacing=29,clip_width=15,clip_width_sides=10,clip_length=1,clip_length_catch=3,clip_case_thickness=5,ear_length=5.8,tab_thickness=3) {
	difference(){
		// the base shape
		union(){
			// the face
			translate([-length/2,-width/2,0]) 
			minkowski(){
				cube([length,width,thickness]);
				if(corner_radius>0) cylinder(r=corner_radius,h=thickness);
			}
			// gussets
			translate([8.1,0,0]) cube([54.8,1.6,gusset_thickness]);
			translate([8.1,64.4,0]) cube([54.8,1.6,gusset_thickness]);
			// the ears
			translate([(length-ear_length-thickness)/2,(ear_spacing/2)-(ear_width/2),thickness*2]) cube([ear_length+thickness,ear_width,case_thickness+thickness]);
			translate([(length-ear_length-thickness)/2,(-ear_spacing/2)+(-ear_width/2),thickness*2]) cube([ear_length+thickness,ear_width,case_thickness+thickness]);
		}
		union(){
			translate([(-length/2)-corner_radius,-clip_width/2-1,0]) cube([clip_length,clip_width+2,thickness*2]); // the hole for the clip
			translate([(length-ear_length)/2+thickness,-width/2,thickness*2]) cube([30,width,case_thickness-thickness]); // ear notch 
		}
	}
	// the clip itsself
	translate([(-length/2)-corner_radius,clip_width/2,1]) clip(clip_width,clip_width_sides,clip_length,clip_case_thickness,clip_length_catch,tab_thickness);
}