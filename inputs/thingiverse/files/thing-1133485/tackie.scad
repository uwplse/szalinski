// This generates stand-in components and mounting hardware for tactile push buttons.
//
// Licensed under Creative Commons: Attribution, Share-Alike
//		http://creativecommons.org/licenses/by-sa/3.0/
// For attribution you can direct people to the original file on thingiverse:
// 		http://www.thingiverse.com/thing:1133485

/* [Visibility] */

// show the button
show_button=1; // [1:yes,0:no]

// show snap-clasps to hold the button
show_clasps=1; // [1:yes,0:no]

// Whether the generated model is in the pushed(down) state or is in the up state 
generate_pushed=1; // [1:pushed/down,0:released/up]

/* [Tactile Button Settings] */

// this is the width of the button body.  We assume its' square, so this is both x and y width.
body_width=10;

// how high the body is
body_height=5;

// the diameter of the button's post
post_dia=5;

// how high above the body the post is when it is all the way up
post_height_up=3;

// how high above the body the post is when it is pressed down
post_height_down=2;

// how wide the leads for the legs are
leg_width=1;

// how far apart the leads are (this is measured from the center of the leads)
leg_spacing=5;

/* [Clasp Settings] */

// How thick (and therefore, stiff) the clasps are
clasp_spring_thickness=0.75;

// How far the clasp extends from the button surface
clasp_extra_h=10;

/* [Hidden] */

scoche=0.05;
halfscoche=scoche/2;

// generates a tackie button, centered x,y on the origin but with its bottom on z=0
// (legs extend below the z plane)
// leg_spacing is center-to-center
module tackie(post_height,body_width=10,body_height=5,post_dia=5,leg_width=1,leg_spacing=3,leg_thickness=0.75) {
	center=-body_width/2;
	z_center=-body_height/2;
	legcenter=leg_width/2;
	union() {
		// the body
		color([0.25,0.25,0.25,0.99]) translate([center,center,0]) cube([body_width,body_width,body_height]);
		// the legs
		color([0.75,0.75,0.75,0.99]) union(){
			translate([-(leg_spacing/2+legcenter),-(center              ),z_center]) cube([leg_width,leg_thickness,body_height]);
			translate([ (leg_spacing/2-legcenter),-(center              ),z_center]) cube([leg_width,leg_thickness,body_height]);
			translate([-(leg_spacing/2+legcenter), (center-leg_thickness),z_center]) cube([leg_width,leg_thickness,body_height]);
			translate([ (leg_spacing/2-legcenter), (center-leg_thickness),z_center]) cube([leg_width,leg_thickness,body_height]);
		}
		// the button
		color([0.75,0.75,0.75,0.99]) translate([0,0,body_height]) cylinder(r=post_dia/2,h=post_height,$fn=12);
	}
}

// returns snap-clasps for a given tackie
module top_clasps(body_width=10,body_height=5,post_dia=5,spring_thickness=0.99,extra_h=10) {
	overhang_max=(body_width-post_dia)/2; // This is the max possible.  We may want less than this.
	overhang=(overhang_max+spring_thickness)*0.5;
	inside_overhang=overhang*1.33;
	snap_angle=30;
	spring_width=body_width*2/3;
	overshoot=overhang/tan(snap_angle);
	h=extra_h+body_height;
	for(a=[0:180:360]) rotate([0,0,a]) {
		difference(){
			translate([-body_width/2-spring_thickness,-spring_width/2,0]) union(){
				translate([0,0,0]) cube([spring_thickness,spring_width,h]);// the springy sides
				translate([0,0,-overshoot]) difference(){
					cube([inside_overhang,spring_width,overshoot+body_height+spring_thickness]); // the clip body
					rotate([0,snap_angle,0]) translate([0,-halfscoche,0]) cube([inside_overhang,spring_width+scoche,overshoot+body_height+spring_thickness]);
				}
			}
			translate([-body_width/2,-body_width/2,0]) cube([body_width,body_width,body_height]); // cut out the button body
		}
	}
}

if(show_clasps==1){
	color([1,0,0,0.75]) top_clasps(body_width,body_height,post_dia,clasp_spring_thickness,clasp_extra_h);
}

if(show_button==1){
	tackie(generate_pushed==1?post_height_down:post_height_up,body_width,body_height,post_dia,leg_width,leg_spacing);
}
