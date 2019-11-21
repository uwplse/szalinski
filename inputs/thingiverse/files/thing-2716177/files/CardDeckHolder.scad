/********************************
	CARD DECK HOLDER

Author: Luke Phillips
version 1.0 - 14-December-2017

This work is licensed under a 
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

*********************************/

/************ USER MODIFIABLE VARIABLES *************/
// These should reflect the size of your card decks, including some gap allowance 
stack_width=60; // width of the cards themselves (+ allowance)
stack_depth=20; // the height of the piles of cards you wish to hold (+ allowance)

// optionally you can create a floor by setting the height > 0
floor_height=0;

// dimensions of the main wall at the base of the holder
wall_width=4;
wall_height=10; // this doesn't need to be very tall, just enough to stop the cards sliding around. Make the cards more upright by extending the prongs instead, this will save plastic.

// dimensions of the extra card holding "prongs"
prong_width=15;
prong_height=10;

/************ USES *************/
CardDeckHolder(3, 6);
//CardDeckHolderClip();



/************ MODULES **********/
// calculated values
full_wall_height = wall_height + floor_height;
holder_width=stack_width+wall_width;
holder_depth=wall_width+stack_depth;


// modules for parts of the holder
module FrontWall() {
	cube([wall_width, holder_width, full_wall_height]);
}
module SideWall() {
	cube([stack_depth, wall_width, full_wall_height]);
}
module CardProng() {
	cube([wall_width, prong_width, prong_height]);
}
module FloorPiece() {
	cube([stack_depth, stack_width, floor_height]);
}

module BasicStackHolder() {
	// NOTE Only creates rear and left walls, front and right walls are added after the  been repetitions in the main CardDeckHolder module
	
	FrontWall(); // actually rear wall :)
	translate([0, 2*wall_width, full_wall_height]) 
		CardProng();
	translate([0, stack_width - prong_width, full_wall_height]) 
		CardProng();
	translate([wall_width, 0, 0]) 
		SideWall(); // left side
	translate([wall_width, wall_width, 0]) 
		FloorPiece();
}

module CardDeckHolder(holdersWide, holdersDeep) {

	// build the holders "wide"
	for(w=[0:holdersWide-1]) {
		// build the holders "deep"
		for(d=[0:holdersDeep-1]) {
			translate([d*holder_depth, w*holder_width, 0]) BasicStackHolder();
		}
	}
	
	// build the final front and side walls
	translate([holdersDeep*holder_depth, 0, 0]) 
		cube([wall_width,
			holdersWide*holder_width, 
			full_wall_height]);
	
	translate([0, holdersWide*holder_width, 0]) 
		cube([holdersDeep*holder_depth + wall_width,
			wall_width, 
			full_wall_height]);
	
}


/********************************
	CARD DECK HOLDER CLIPS

These will help stop multi-part card deck holders from moving around.

They are not really designed to make the holders rigid just stop 
a bit of the lateral movement

*********************************/
clip_wall_width=2;
fudge_factor=1.2;

module ClipWall() {
	cube([stack_depth - fudge_factor, clip_wall_width, wall_height - fudge_factor]);
}

module CardDeckHolderClip() {
	ClipWall();
	translate([0, clip_wall_width, 0]) cube([stack_depth - fudge_factor, 2*wall_width + fudge_factor, clip_wall_width]);
	translate([0, clip_wall_width + 2*wall_width, 0]) ClipWall();
	
}
