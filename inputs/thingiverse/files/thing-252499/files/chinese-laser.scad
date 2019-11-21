// preview[view:northwest, tilt:bottomdiagonal]

/* [holder chinese laser] */

// min width of the plastic walls.
wall = 2; // plastic walls are 2mm

// we will model the whole thing based on the hole in the middle, since that is all we care about. It should be the measured from the male part on the bike light you want to attach here.
innerWidth = 17.21; // the side to side of the shaft
innerDepth = 3.6; // the depth the shaft
// height does not matter much for the male part, as it will pass trhu the whole part. So just enter a good height so that it reaches the latch on the bottom.
partHeight = 22.75;
// width of the thumb thing for the latch
handle_width = 11.6;

module main_part(){
	latch();
	difference(){
		// the main block where we will chip the pieces away
		cube([ innerWidth/2 + wall, innerDepth+wall*2 , partHeight] );
		main_cuts();
	}
}
module latch(){
	// bottom latch
	translate([ 0, 0, -wall ] ){
		cube( [ handle_width/2 -0.5, wall, wall] );
	}
	// the latching block
	translate([ 0, wall, -3-wall ] ){
		cube( [ 5.20/2, 1.15, 3] );
	}
	// the lachking block base
	translate([ 0, 0, -3-wall ] ){
		cube( [ handle_width/2, wall, 3] );
	}
	//handle();
}
module handle(){
	// the handle
	translate([ 0, wall, -3-wall ] ){
		rotate([45, 0, 0])
			difference(){
				cylinder( h=wall, r=handle_width/2);
				color("blue") rotate([0,0,90])
					translate([0, -handle_width/2-0.001,-0.001])
						cube([ handle_width/2+0.002, handle_width+0.002 , handle_width+0.002]);
			}
	}

}

module main_cuts(){
	// the inner shaft
	translate( [ -0.001, wall, -0.001] ){
		cube([ innerWidth/2+0.001, innerDepth, partHeight+0.002] );
	}
	// the front wall opening
	translate( [ -0.001, (wall)+innerDepth-0.001, -0.001] ){
		cube([ innerWidth/2-wall+0.001, wall+0.002, partHeight+0.002] );
	}
	// the two cuts on the side leading to the latch so that it can move back/forth
	translate( [ handle_width/2-0.5, -0.001, -0.001] ){
		cube([ 0.55, wall+0.002, partHeight/3+0.001]);
	}
}

main();
module main(){
	translate([0,0,-partHeight]){
		main_part();
		actual_mirror();
		handle();
	}
}

// mirror the geometry... why the fuck mirror does not copy? that way it is just an alias to rotate()
module actual_mirror(){
	mirror([10,0,0]){
		main_part();
	}
}
