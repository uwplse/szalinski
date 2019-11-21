

inscription = "Petersilie";   

/* [Overall sign dimensions] */

// total width of sign. Adjust for sufficient space to comfortably accomodate all letters
width = 128;				// [40:200]

bottom_plate_depth = 12;		// [0.4:0.2:50]

bottom_plate_height = 2;		// [0.4:0.2:50]

back_plate_depth = 2;			// [0.4:0.2:50]

back_plate_height = 8;			// [0.4:0.2:50]

peg_length = 140;			// [10:180]

// distance as percentage of sign width
peg_distance = 67;                      // [10:100]

// Strength of ground pegs
peg_width = 8;				// [1:32]

peg_joint_radius = bottom_plate_depth-peg_width;


/* [Font Settings] */
font="Pacifico";			// [Lobster, Pacifico, Chewy ]

// distance of first letter from left edge
indent=0;				// [0:40]

text_height = 28;			// [8:64]

// How far letters protrude from back plate
text_emboss = 2;			// [0:16]

// extent of back plate and letter merging region
text_overlap=2;				// [1:16]

// letter distance. The smaller, the closer the letters. Making them touch each other increases mechanical stability.
text_spacing=0.8;			// [0.5:0.01:3]

/* [Horizontal helper beam for i and j dots] */
beam_start=90;				// [0:200]

// set beam end smaller than beam start for no beam at all
beam_end=110;				// [0:200]

// beam elevation as percentage of font height
beam_elev=88;				// [0:100]

beam_height=1;				// [0:100]

beam_depth=1;				// [0:10]



$fn = 60;				// [8:90]

// --------------------------------------------------------------------------------------------------------------



// included from library
module joint(Breite, Tiefe, Radius)  {
	translate([0, -Radius, 0])
	difference()  {
		cube([Radius*2+Breite, Radius, Radius+Tiefe]);

		for (x=[0, Radius*2+Breite]) {		// left and right
			translate([x, 0, -0.01])
			rotate([0, 0,  90])
			cylinder(Radius+Tiefe, Radius, Radius);
		}

		translate([0, 0, Tiefe+Radius])		// front
		rotate([0, 90, 0])
		cylinder(Radius*2+Breite, Radius, Radius);
	}
}



module pegs(x)  {
	module peg(x)  {
		module Spitze(x)  {
			module wedge(rotation)  {
				translate([-0.6,0,0])
				rotate([0, 0, 100])
				cube([peg_width*3, peg_width, peg_width]);
			}
			translate([peg_width/2, 0, 0])  {
				wedge(110);
				mirror(1) wedge(110);
			}
		}

		translate([x-peg_joint_radius, 0, 0])
		joint(peg_width, peg_width, peg_joint_radius);

		translate([x, -peg_length])
 		difference() {							// peg
			cube([peg_width, peg_length, peg_width]);
			Spitze(x);
		}
	}
	peg(x);									// left peg point
	peg(width-x-peg_width);							// right peg point
}


cube([width, back_plate_height+bottom_plate_height, back_plate_depth]);		// back plate
cube([width, bottom_plate_height, bottom_plate_depth]);				// bottom plate
pegs(width*(100-peg_distance)/200);						// ground pegs
linear_extrude(height = text_emboss + back_plate_depth)				// inscription
	translate([indent, back_plate_height+bottom_plate_height-text_overlap])
	text(inscription, font=font, size=text_height, spacing=text_spacing);
if(beam_start<beam_end)								// horizontal helper beam
	translate([beam_start, back_plate_height+bottom_plate_height-text_overlap-beam_height/2+beam_elev*text_height/100, 0])
	cube([beam_end-beam_start, beam_height, beam_depth]);
