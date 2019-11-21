// This thing generates custom battery covers
//
// v2.0
//
// Licenced under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:243269

// ================ variables

//CUSTOMIZER VARIABLES


/* [Basic] */

// how long the battery cover is.  (This dimension is in the clip-to-hooks direction.)
length=50;

// how wide the battery cover is
width=30;

// how thick the battery cover is
thickness=0.75;

// radius for rounding over the corners of the battery cover
corner_radius=2;


/* [Hooks] */

// how wide the hook tabs are
hook_width=5;

// how long the hook tabs are
hook_length=3;

// How far the hooks are in/out relative to the edge of the battery cover (often the same as hook_length).
hook_offset=3;

// how far apart the hooks are (on the inside).  (To create one wide hook, just set this to 0.)
hook_spacing=10;

// How thick the case is where the hooks attach, aka, how high the hole in the hook should be.
hook_case_thickness=2;

// how thick the back of the hooks are
hook_back_thickness=1.0;

// how thick the top part of the hooks are
hook_top_thickness=1.0;


/* [Clip] */

// How wide the clip is
clip_width=10;

// How deep the clip is (overhang)
clip_tooth=1;

// How long the clip is
clip_length=3;

// This is used for a side-engagement clip.  Most clips are this way now.  It measures how wide the small part of the clip is.
clip_width_sides=10;

// This is for a front-engagement clip.  If unused, set it to 0, otherwise, how long the catch will be (usually about 2-3mm)
clip_length_catch=1;

// How far the clip is in/out relative to the edge of the battery cover.
clip_offset=0;

// This is how far down into the battery case the clip engages.  Usually it should be the same as "thickness" on the "basic" tab
clip_case_thickness=3.5;

// The thickness of the finger tab
clip_tab_length=1;

// how thick the clip material is (probably never need to change)
clip_thickness=1;

// spacing between the clip and the body for movement (probably never need to change)
clip_width_margin=0.5;

// how thick to make the spring part of the clip (probably never need to change)
clip_spring_thickness=0.75;


/* [Support gussets] */

// Which direction the support gussets go
gusset_orientation=0; // [0:clip_lengthwise,1:clip_widthwise]

// How thick the gussets are (set to 0 to turn off gussets)
gusset_thickness=0;

// How high the gussets are
gusset_height=1;

// How far apart the gussets are
gusset_spacing=10;


/* [Advanced] */

// Resolution
$fn=30;


/* [hidden] */

scoche=0.01;
halfscoche=scoche/2;

module clip(clip_width=15,clip_width_sides=10,clip_length=1,clip_case_thickness=5,clip_length_catch=3,clip_tab_length=3,clip_spring_thickness=0.75) {
	slope=0.33; // this is only a ballpark
	top_r=clip_length/3;
	top_r_x=clip_length-top_r;
	top_r_y=clip_length+clip_case_thickness/slope/2;
	overlap_tab_w=2;
	inside_void_d1=top_r*2-clip_spring_thickness*2;
	inside_void_d2=top_r*2-clip_spring_thickness*2;
	inside_void_x=top_r_x;
	clip_tab_thickness=1;
	rotate([90,0,0]) linear_extrude(clip_width) difference () {
		union(){ // the outside shape
			hull () {
				translate([0,clip_tab_thickness]) circle(r=clip_tab_thickness); // outside radius
				translate([clip_length-scoche,0]) square([scoche,clip_tab_thickness]); // inside corner
				translate([top_r_x,top_r_y]) circle(r=top_r); // top
				if(clip_length_catch>0){
					translate([-clip_length_catch+0.1,clip_case_thickness]) circle(r=scoche); // add a front overhang
				}
			}
			translate([-overlap_tab_w,0]) square([overlap_tab_w,clip_tab_thickness]); // the overlap tab
		}
		union(){
			translate([inside_void_x,0]) hull() { // The inside void
				translate([0,top_r_y]) circle(r=inside_void_d1/2);
				translate([-inside_void_d2/2,-clip_tab_length-scoche]) square([inside_void_d2,scoche]);
				// a hollow for being able to push the thing over (especially when opening is less than the hook)
				translate([-clip_tooth,0]) square([clip_tooth,clip_case_thickness]);
			}
			// trim the tab overhang
			translate([-clip_tab_length-clip_tooth,clip_tab_thickness]) square([clip_tooth*2,clip_case_thickness-clip_tab_length]);
		}
	}
}

module hook(size,hook_back_thickness,hook_top_thickness){
	difference(){
		cube(size);
		translate([hook_back_thickness,-size[1]/2,-hook_top_thickness]) cube([size[0],size[1]*2,size[2]]);
	}
}

module hooks(length,hook_length,thickness,hook_spacing,hook_width,hook_case_thickness,hook_back_thickness,hook_top_thickness,hook_offset){
	size=[hook_length+hook_back_thickness,hook_width,hook_case_thickness+hook_top_thickness+thickness];
	                translate([length/2-hook_back_thickness-hook_offset,hook_spacing/2,0]) hook(size,hook_back_thickness,hook_top_thickness);
	mirror([0,1,0]) translate([length/2-hook_back_thickness-hook_offset,hook_spacing/2,0]) hook(size,hook_back_thickness,hook_top_thickness);
}

module flatBase(length,width,corner_radius,thickness,clip_width,clip_length,clip_thickness,clip_width_margin=0.5,clip_offset=0,clip_spring_thickness=0.75){
	clip_hole=[clip_length+scoche-clip_offset-clip_spring_thickness,clip_width+clip_width_margin*2];
	linear_extrude(thickness) difference(){
		// the basic shape
		translate([-length/2,-width/2]) minkowski(){
			translate([corner_radius,corner_radius]) square([length-corner_radius*2,width-corner_radius*2]);
			if(corner_radius>0) circle(r=corner_radius);
		}
		// a hole for the clip
		translate([-length/2-scoche/2,-clip_hole[1]/2]) square(clip_hole); // the hole for the clip
	}	
}

module gussets(width,length,gusset_orientation=0,gusset_thickness=1,gusset_height=3,gusset_spacing=5){
	if(gusset_orientation==0){ // lengthwise
		translate([-length/2,gusset_spacing/2,0]) cube([length,gusset_thickness,gusset_height]);
		mirror([0,1,0])translate([-length/2,gusset_spacing/2,0]) cube([length,gusset_thickness,gusset_height]);
	}else{ // crosswise
		translate([gusset_spacing/2,-width/2,0]) cube([gusset_thickness,width,gusset_height]);
		mirror([1,0,0])translate([gusset_spacing/2,-width/2,0]) cube([gusset_thickness,width,gusset_height]);
	}
}

module cover(width=30,length=60,thickness=0.5,hook_case_thickness=3.9,
	gusset_orientation=0,gusset_thickness=1,gusset_height=3,gusset_spacing=5,
	corner_radius=1,hook_width=7.5,hook_spacing=29,clip_width=15,clip_width_sides=10,
	clip_length=1,clip_length_catch=3,clip_case_thickness=5,hook_length=5.8,clip_tab_length=3,
	clip_width_margin=0.5,clip_offset=0,hook_back_thickness=0.5,hook_top_thickness=0.5,clip_spring_thickness=0.75,
	hook_offset=0)
{
	gussetInset=max(hook_length,clip_length-clip_offset); // need to make sure it's short enough not to interfere with other parts
	flatBase(length,width,corner_radius,thickness,clip_width,clip_length,clip_thickness,clip_width_margin,clip_offset,clip_spring_thickness);
	hooks(length,hook_length,thickness,hook_spacing,hook_width,hook_case_thickness,hook_back_thickness,hook_top_thickness,hook_offset);
	gussets(width,length-gussetInset*2,gusset_orientation,gusset_thickness,gusset_height+thickness,gusset_spacing);
	translate([-length/2-clip_offset,clip_width/2,0]) clip(clip_width,clip_width_sides,clip_length,clip_case_thickness,clip_length_catch,clip_tab_length,clip_spring_thickness);
}


cover(width,length,thickness,hook_case_thickness,
	gusset_orientation,gusset_thickness,gusset_height,gusset_spacing,
	corner_radius,hook_width,hook_spacing,clip_width,clip_width_sides,
	clip_length,clip_length_catch,clip_case_thickness,hook_length,clip_tab_length,
	clip_width_margin,clip_offset,hook_back_thickness,hook_top_thickness,clip_spring_thickness,
	hook_offset);