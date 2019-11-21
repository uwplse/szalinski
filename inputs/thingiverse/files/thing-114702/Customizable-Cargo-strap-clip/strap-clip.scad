// strap clip.scad

/* [Global] */
// How many in a row
clips=2; // [1,2,3,4,5,6,7,8]

// Mirror clips on the other side
mirror="no"; // [no,yes]

/* [Strap Size] */
// Width of the strap
strap_width=28; // 

// Width once it is rolled up
roll_width=44; // 

/* [Clip Parameters] */
// Size of knob holding the strap in
clip_overhang=2.5;

// Thickness of the holder
clip_thickness=2.5;

// Width of the holder
clip_width=30;



/* [Hidden] */

$fs=0.1;

clipHangRadius=clip_thickness/2+clip_overhang/2;

/*             X
 *      <---roll_width-->
 *     |=================|  <--clip_thickness
 *     |                 | 
 *   Y |                 |   ^
 *     |__             __|   v strap_width
 * 
 *     ^               <> ---clip_overhang
 *      \-clip_thickness
 * 
 */

module clip() {
	*translate([roll_width,clip_thickness,0])
	cube([clip_thickness,strap_width,clip_width]);
	cube([roll_width+2*clip_thickness,clip_thickness,clip_width]);
	cube([clip_thickness,strap_width+clip_thickness*2,clip_width]);
	translate([roll_width+clip_thickness,0,0])
		cube([clip_thickness,strap_width+clip_thickness*2,clip_width]);
	translate([clipHangRadius,strap_width+clip_thickness*1.9,0])
		cylinder(r=clipHangRadius,h=clip_width);
	translate([roll_width+2*clip_thickness-clipHangRadius,strap_width+clip_thickness*1.9,0])
		cylinder(r=clipHangRadius,h=clip_width);
}

rotate([0,0,180]) {
	for (i = [0 : clips-1])
	{
	translate([i*(clip_thickness+roll_width),0,0])
	clip();
	if (mirror=="yes")
		translate([i*(clip_thickness+roll_width),clip_thickness/2,0])
			mirror([0,1,0])
				clip();
	}
}