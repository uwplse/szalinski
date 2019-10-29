// MK8 air cage, for Prusa i3 Pro B. traps air from extruder feeder cooler, routes to pipe end, where an air nozzle
// can be connected to.
//
// 2016Sep13, ls  (http://www.thingiverse.com/Bushmills)
//	v0.0.1   initial version
//	v0.0.2   support changed to interleaved pillars 
// 2016Sep14, ls
//	v0.0.3   support changed to perforated walls. lowered blocks. thicker walls around air chamber.
//               gave pipe end foundation more substance.
// 2016Sep15, ls
//	v0.0.4   added foundation to pipe end to avoid sagging
// 2016Sep19, ls
//	v0.0.5   eliminated "pillars_" from air chamber variable names, changing to "wall_" 
//	         own variable for pipe end wall thickness. rather than reusing air chamber wall thickness. 
//	         slicing may benefit from slic3r --spiral-vase option.

$fn=50;
// show object inside at percentage depth
explode=0;			// [0:100]

// *********************************************************
/* main frame setting */

// adjustable in very small steps, because this determines the degree of leakyness 
cooler_width=40.2;		// [32:0.1:64]

// adjustable in very small steps, because this determines the degree of leakyness 
cooler_height=40.2;		// [32:0.1:64]

// overall depth of item, excluding pipe end
depth=16;			// [10:0.1:32]

// how far does extruder side retainment protrude into cooler
brim=2;                         // [0:0.1:10]

// how thick is extruder side retainment
brim_strength=1;			// [0.4:0.1:5]

// thickness of frame opposite of air chamber 
far_wall=0.7;			// [0.4:0.1:5]

// thickness of frame on side of holding blocks 
base=3;				// [0.4:0.1:10]

// thickness of opposite side  
roof_wall=1;			// [0.4:0.1:5]

height=base+cooler_height+roof_wall;


// *************************************************
/* mounting blocks */

block_height=7;			// [2:0.1:20]

// affects hole distance, which is (cooler_width - block_width) as holes are block centered 
block_width=8;			// [2:0.1:20]

// bore diameter for screws
mount_hole=3.8;			// [2:0.1:8]

// fan immersion shortens blocks on fan side, allowing fan to penetrate air cage, reducing leakage.
fan_immersion=1;		// [0:0.1:8]


// ***********************
/* air chamber settings */

// thickness of walls surrounding air chamber, and pipe and wall strength
air_chamber_wall=1.2;		// [0.1:0.1:8]

// "chamber" refers to dimensions of hollow space inside
air_chamber_width=12;		// [4:1:32]

// brim around air passage
air_passage_brim=2;		// [0:0.1:8]

airpassage_length=cooler_height-block_height-2*air_passage_brim;

width=far_wall+cooler_width+air_chamber_width+2*air_chamber_wall;

air_chamber_height=height-2*air_chamber_wall;
air_chamber_depth=depth-2*air_chamber_wall;
air_chamber_x=far_wall+cooler_width+air_chamber_wall;
air_chamber_y=air_chamber_wall+0;

// support for pipe end sided roof. distance means "maximum distance", as actual distance will be calculated
wall_distance=8;		// [1:0.1:24]

// thickness of air chamber walls, seperating lanes
wall_strength=0.4;		// [0.2:0.1:2]

// **********************************************
/* pipe end */

pipe_end_foundation_length=1;	// [0:0.1:8]
pipe_end_foundation_foot=4; 	// [0:0.1:8]
pipe_end_length=5;		// [0:0.1:16]

// outer diameter
pipe_end_diameter=4.2;		// [1:0.1:8]
pipe_end_wall=0.4;		// [0.2:0.1:4]
pipe_end_elevation_percent=20;	// [0:100]

pipe_end_radius=pipe_end_diameter/2;
pipe_end_x=air_chamber_width/2+air_chamber_wall;
pipe_end_y=air_chamber_wall+pipe_end_radius;
little=0.1+0;


// ************************************************************

lanes=ceil((air_chamber_width-wall_strength)/wall_distance);
lanes_spacing=(air_chamber_width+air_chamber_wall/(lanes+1)-wall_strength/2)/lanes;

module wall()  {
	difference()  {
		cube([wall_strength, air_chamber_height, air_chamber_depth]);

		for (i=[0:5])   {
		translate([-little/2, i*air_chamber_height/5, 3])
		cube([wall_strength+little, air_chamber_height/6, air_chamber_depth-8]);
		}
	}
}

module support()  {
	for (lane=[0:lanes])  {
		translate([lane*lanes_spacing+air_chamber_wall, air_chamber_wall-little/2, air_chamber_wall])
		wall();
	}
}


module pipe_end_bore()  {
	cylinder(depth+pipe_end_length-air_chamber_wall+pipe_end_foundation_length+little/2,
	pipe_end_radius-pipe_end_wall,
	pipe_end_radius-pipe_end_wall);
}

module pipe_end()  {
	translate([0, 0, -little])
	cylinder(pipe_end_foundation_length,
	         pipe_end_radius+pipe_end_foundation_foot,
                 pipe_end_radius+pipe_end_foundation_foot);

	cylinder(pipe_end_length+pipe_end_foundation_length,				// pipe
		pipe_end_radius,
		pipe_end_radius);

}

module air_chamber()  {
	difference()  {
		union()  {
		        difference()  {
				cube([air_chamber_width+2*air_chamber_wall, height, depth]);			// air chamber enclosure

				translate([air_chamber_wall, air_chamber_wall, air_chamber_wall])		// carve out air chamber
				cube([air_chamber_width, air_chamber_height, air_chamber_depth]);		

				translate([air_chamber_wall+air_chamber_width-little/2,				// air passage opening
				           base+block_height+air_passage_brim,
				           air_chamber_wall+air_passage_brim])
				cube([air_chamber_wall+little,
				      airpassage_length,
				      air_chamber_depth-2*air_passage_brim]);
			}

			support();

			translate([pipe_end_x,
				pipe_end_y+(air_chamber_height-pipe_end_diameter)*pipe_end_elevation_percent/100,
				depth-little/2])
			pipe_end();

		}

		translate([pipe_end_x,
		           pipe_end_y+(air_chamber_height-pipe_end_diameter)*pipe_end_elevation_percent/100,
	        	   air_chamber_wall])
		pipe_end_bore();
	}
}




module block(width, height, depth, dia)  {
	difference()  {
		cube([width, height, depth-fan_immersion]);

		translate([width/2, height/2, -little/2])
		cylinder(depth+little, dia/2, dia/2);
	}
}

module cooler_frame()  {

	difference()  {

		cube([cooler_width+far_wall, height, depth]);			// base block

		translate([brim, base, -little/2])			// bottom (extruder-faced) opening
		cube([cooler_width-2*brim, cooler_height, brim_strength+little]);

		translate([-little/2, base, brim_strength])		// cooler containment
		cube([cooler_width+little/2, cooler_height, depth-brim_strength+little]);
	}

	for (x=[0:1])
	translate([x*(cooler_width-block_width), base, 0])
	block(block_width, block_height, depth-fan_immersion, mount_hole);	// fan mount block 
}


module air_cage()  {
	air_chamber();

	translate([air_chamber_width+air_chamber_wall*2, 0, 0])
	cooler_frame();
}


difference()  {
	air_cage();

	if(explode)
	translate([0-little/2, 0-little/2, depth*explode/100])
	cube([width+little, height+little, depth*(100-explode)/100+little/2]);
}
