/*************************************************************************************************/
/* TabletStand - Copyright 2014 by ohecker                                                       */
/* This file is licensed under CC BY-SA 4.0 (http://creativecommons.org/licenses/by-sa/4.0/deed) */
/*************************************************************************************************/

use <utils/build_plate.scad>
/* [Basic] */

// The width of the tablet in millimeters (including 1-2 additional millimeters as tolerance).
tablet_width=119; // [50:200]

// Length of the tablet that should be supported by the stand (in millimeters). Normally the tablet will be longer than this and the upper part of the tablet will rise above the stand.
tablet_covered_length=140; // [50:200]

// The thickness of the tablet (millimeters). Add approximately 1 millimeter as tolerance.
tablet_thickness=13; // [5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

// Pattern of the openings on the front side. If you choose "Self Defined (Advanced)" then you can define the positions and diameters manually in the "Advanced" Tab.
openings_position_pattern = 1; //[0:__________ None,4:OOO_______ Left,2:___OOOO___ Middle,1:________OOO Right,6:OOOOOOO___ Left&Middle,3:___OOOOOOO Middle&Right,5:OOO____OOO Left&Right,7:OOOOOOOOOO All,8:Self Defined (Advanced) ]

/* [Advanced] */

// The thickness of the walls of the stand (millimeter).
wall_thickness=2; // [2,2.5,3,4]

// The radius of the quarter circles ("ears") at the bottom which prevent the tablet from slipping out of the stand. If set to 0 then the radius will be automatically determined (1/6 of the tablet width).
holding_disc_radius=0;

// The (outer) diameter of the large pole (millimeter). If set to 0 then the diameter will be automatically determined (taking the smaller value of 1/2 of the length of the baseplate and 1/3 of the tablet width).
pole_diameter=0;

// The position of the center of the pole given as fraction of the length of the base plate
pole_position_ratio=0.6; // [0.4:0.6]

// The angle of the stand in degrees. Note that lower angles might be difficult to print.
angle=55; // [45,50,55,60,65]

// Position and diameters of openings on the front side (e.g. sound: loudspeaker and microphone) if "Self Defined (Advanced)" is selected. Each opening is defined by two values: 1. the position of the opening (in millimeters in x-direction, where 0 is the symmetry plane of the stand; left side = negative values) 2. the diameter of the opening (in millimeters)
opening_positions_and_diameters=[[15,7],[25,7],[35,7],[45,7]];

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */
$fn=100;
big = 500;	// "big" dimension for creating helper object for boolean operations; do not customize
epsilon=0.01;	// "small" value for shifting/extending objects to ensure correct boolean operations; do not customize


// the dimensions of the baseplate are defined by the projection of the stand itself
baseplate_length = (tablet_covered_length+wall_thickness)*cos(angle);

// block needs to be lifted by some amount to create space for the openings for sound
lift = tablet_thickness * ( 1-cos(angle));
// the effective diameter of the pole (given by rule or advanced configuration)
pole_diameter_effective = (pole_diameter == 0 ) ? min( baseplate_length / 2, tablet_width / 3) : pole_diameter;
// the effective radius of the holding discs ("ears"; given by rule or advanced configuration)
holding_disc_radius_effective = (holding_disc_radius == 0 ) ? tablet_width / 6 : holding_disc_radius;

// thickness of the main block
block_thickness = tablet_thickness+wall_thickness;
// length of the main block
block_length = tablet_covered_length+wall_thickness+block_thickness;
// width of the main block
block_width = tablet_width+2*wall_thickness;

/******************************* the main object ***************************/
// The main object: Create the stand and move it to the center...
translate([0,-(baseplate_length-block_thickness*sin(angle))/2,0]) stand();
// the build plate (for display only)
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 


/******************************* decomposition of the stand ****************/
// The stand consists of three main components:
// - the "holder" which is the encasement of the tablet (tilted by the given angle)
// - the baseplate
// - the pole between the back part of the holder and the baseplate
module stand() {
	difference() {
		union() {
			intersection() {
				translate([0,0,lift]) rotate([angle,0,0]) holder();
				only_pos_z();   	// cut off all parts which are below the surface after tilting the holder
				translate([0,-block_thickness*sin(angle),0]) only_pos_y();	// cut off all parts which protrude to the front
			}
			baseplate();
			translate([0,0,epsilon]) pole();	// pole is solid here
 		}
		pole_hollow_portion();		// make pole hollow
	}
}


// The holder (which is the encasement of the tablet) consist of
// - the basic block where
// - the cutout for the tablet is subtracted
// - the optional "openings for sound" (loudspeaker, microphone) are subtracted
// - plus the two "ears" which prevent the tablet from slipping out
module holder() {
	union() {
		difference() {
			block();
			cutout_for_tablet();
			all_openings_for_sound();
		}
		ears();
	}
}

/******************************* the (main) block  ********************************/
/*                                                                                */

// The block is a cube. Its dimensions are mainly given by the dimension of the tablet plus thickness of the walls.
// The block is extended in y-direction for the same value as its thickness.
// This additional space is needed to form the connection to the base plate and allow to integrate the
// optional openings for sound.
module block () {
    translate([-(tablet_width+2*wall_thickness)/2,-block_thickness,0])
	cube(size=[block_width,block_length,block_thickness]);
}

// The opening in the base for the tablet is simply defined by the given dimensions of the tablet
module cutout_for_tablet () {
	translate([-tablet_width/2,wall_thickness,wall_thickness])
	cube(size=[tablet_width,tablet_covered_length+epsilon,tablet_thickness+epsilon]);
}

/******************************* the openings for sound ***************************/
/*                                                                                */

module all_openings_for_sound() {
	if(openings_position_pattern == 8 ) {
		all_openings_for_sound_advanced();
	} else {
		all_openings_for_sound_pattern();
	}

}

// The positions of the "openings for sound" are given by a vector of two dimensional vectors in this case.
// Each of these two dimensional vectors holds
// - the position of the opening (in millimeters in x-direction, where 0 is the symmetry plane of the stand; 
//    left side = negative values)
// - the diameter of the hole (in millimeters)

module all_openings_for_sound_advanced() {
	for( b = opening_positions_and_diameters ) {
		opening_for_sound(b[0],b[1]);
    }
}

// If the positions of the "openings for sound" are given by a pattern then the openings are equally spaced
// over the whole front and grouped into three sections: left, middle and right. Only the openings in acticated
// sections will be produced.
module all_openings_for_sound_pattern() {

	holes_left = (floor(openings_position_pattern/4) % 2 == 1);
	holes_middle = (floor(openings_position_pattern/2) % 2 == 1);
	holes_right = (openings_position_pattern % 2 == 1);

	diameter_opening = tablet_thickness * 0.6;
	square_opening = tablet_thickness * 0.9;
	number_of_openings = floor( tablet_width / square_opening );
	increment = tablet_width / number_of_openings;
	start_position_left = -tablet_width/2 + increment/2; /*+ square_opening/2*/;

	number_openings_on_side = ceil( number_of_openings / 3 );


	for( i = [0:number_of_openings-1] ) {
		assign(current_position = start_position_left+i*increment) {
			if( i < number_openings_on_side-1 ) {
				if(holes_left) {
					opening_for_sound(current_position,diameter_opening);
				}
			} else if ( i >= number_of_openings-number_openings_on_side+1 ) {
				if(holes_right) {
					opening_for_sound(current_position,diameter_opening);
				}
			} else {
				if(holes_middle) {
					opening_for_sound(current_position,diameter_opening);
				}
			}
		} 
	}	
}


// Each "opening for sound" is modeled by (part of) a torus. This torus results in a circular opening at the front of the stand
// as well as in the (tilted) bottom part of the holder. The center of the torus is the upper front edge of the baseblock.
module opening_for_sound(pos,dia) {
	translate([pos,wall_thickness,block_thickness])
	rotate([0,90,0])
	rotate_extrude(convexity = 20,$fn=40)
	translate([tablet_thickness/2, 0, 0])
	circle(r = dia/2,$fn=10);
}

/******************************* the "ears"  **************************************/
/*                                                                                */

// Two "ears" (one left, one right)
module ears() {
   ear();
   mirror([1,0,0]) ear();
}

// The left ear is a quarter of a flat cylinder
module ear() {
	translate([-(tablet_width+2*wall_thickness)/2,0,tablet_thickness+wall_thickness])
		intersection() {
			cylinder(h=wall_thickness,r=holding_disc_radius_effective, center=true);
			cube(holding_disc_radius_effective+epsilon);
   		}
}

/******************************* the baseplate  ***********************************/
/*                                                                                */


module baseplate() {
	translate([-(tablet_width+2*wall_thickness)/2,-lift/tan(angle),0])
	cube(size=[tablet_width+2*wall_thickness,baseplate_length+lift/tan(angle),wall_thickness]);
}

/************************* objects for creating the (hollow) pole  ****************/
/*                                                                                */

// The relative position of the pole on the baseplate is given by a ratio
pos_pole=pole_position_ratio*baseplate_length;

// The pole (not hollow yet) is a cylinder which only extends below the base.
module pole() {
	intersection() {
		translate([0,pos_pole,0]) cylinder(h=tablet_covered_length,r=pole_diameter_effective/2);
		translate([0,0,lift]) rotate([angle,0,0]) only_neg_z();
	}
}


module pole_hollow_portion() {
	translate([0,pos_pole,-epsilon]) cylinder(h=tablet_covered_length,r=pole_diameter_effective/2-wall_thickness);
}


/*************************** helper objects for boolean operations ****************/
/* Actually it would be much easier to use cubes with larger dimensions ("big")   */
/* for boolean operations. Unfortunately in the Thingiverse Customizer the preview*/                                                                                /* will be scaled so that obviously all objects are within view. This seems to    */
/* also include these helper objects which results in a too small preview.        */
/* Making the following objects as small as possible avoids this. (But is error   */
/* prone.)                                                                        */

// helper object (cube above the surface) for boolean operations 
module only_pos_z() {
	translate([0,0,(block_length+epsilon)/2])
	cube([block_width+epsilon,2*baseplate_length+epsilon,block_length+epsilon],center=true);
}

// helper object ("big" cube below the surface) for boolean operations 
module only_neg_z() {
	translate([0,(block_length+block_thickness+epsilon)/2,-(block_length+epsilon)/2])
	cube([block_width+epsilon,(block_length+2*block_thickness+epsilon),block_length+epsilon],center=true);
}

// helper object ("big" cube with positive x-coordinates) for boolean operations 
module only_pos_y() {
	translate([0,(block_length+epsilon)/2,block_length/2])
	cube([block_width+epsilon,block_length+epsilon,block_length+epsilon],center=true);
}
