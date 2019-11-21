// Author: Neon22
// July 2018

// preview[view:south west, tilt:top diagonal]

/* [Parameters] */
Wedge_length = 100; // [50:300]
Wedge_width  = 30;  // [10:60]
Wedge_height = 25;  // [5:100]
Wall_thickness = 3; // [0.5:5]

/* [Text] */
Word       = "VACANT";
Word_font  = "Liberation Mono";
Word_style = "Bold"; // [Regular,Bold,Bold Italic,Italic,Condensed,Oblique,Extra Light]

/* [Adjust] */
// Adjust to fit the length
Word_stretch = 0.73;
// Adjust so word hits both sides.
Word_adjust  = 1.01; // [0.9:0.01:1.2]
// Tilt word so its flat on slope.
Tilt_word    = true;

/* [Hidden] */
word_angle = Tilt_word ? tilt() : 0;
font_description = str(Word_font,":style=",Word_style);
//
Delta = 0.1;
cyl_res = 80;

	
//----------------------
// what angle for slope - based on length
function tilt() = atan2(Wedge_height,Wedge_length);

// clip out the top of the wedge
module clip_angle() {
	translate([0,-Delta,Wedge_height/2])
	rotate([0,tilt(),0])
		cube(size=[Wedge_length*1.5,Wedge_width+Delta*2, Wedge_height*2]);
}

// clip excess text from the base
module clip_base() {
	translate([0,-Wedge_width,-Wedge_height*2.5])
		cube(size=[Wedge_length*1.5,Wedge_width*2+Delta*2, Wedge_height*2]);
}

module basic_wedge () {
	// round bit
	difference() {
		// outer cyl
		cylinder(r=Wedge_width/2, h=Wedge_height, $fn=cyl_res, center=true);
		// inner cyl
		cylinder(r=Wedge_width/2-Wall_thickness, h=Wedge_height+Delta*2, $fn=cyl_res, center=true);
		// cutoff RHS
		translate([0,-Wedge_width/2,-Wedge_height/2-Delta])
			cube(size=[Wedge_length,Wedge_width+Delta*2, Wedge_height+Delta*2]);
	}
	// long bit
	translate([0,-Wedge_width/2,-Wedge_height/2])
		difference() {
			// outer cube
			cube(size=[Wedge_length,Wedge_width,Wedge_height]);
			// inner cube
			translate([-Delta,Wall_thickness,-Delta])
				cube(size=[Wedge_length+Delta*2,Wedge_width-Wall_thickness*2,Wedge_height+Delta*2]);
			// angle clip
			translate([0,0,Wedge_height/2])
				clip_angle();
		}
}

// Text
module base_text(tilt=0) {
	translate([0,0,-Wedge_height/2])
	rotate([0,tilt,0])
	scale([Word_stretch,Word_adjust,1])
	linear_extrude(height=Wedge_height, convexity=4)
		text(Word, size=Wedge_width-Wall_thickness, valign="center", font=font_description);
}

module clipped_text() {
	difference() {
		base_text(word_angle);
		translate([0,-Wedge_width/2,0])
			clip_angle();
		clip_base();
	}
}

//---------------------
rotate([0,0,-90])
translate([0,0,Wedge_height/2]) {
	basic_wedge();
	clipped_text();
}