// preview[view:northwest, tilt:bottomdiagonal]

/* [Assembly Settings] */

// how low to put the holder on the bracket. Biggest issue here is to balance the part in a solid position while also benefiting from the cuts next to the latch on the bottom. Too low and it is too loose on the bracket. too high and there is no movement on the latch.
mix_top = 5;

/* [holder chinese laser] */

// min width of the plastic walls.
clf_wall = 2; // plastic walls are 2mm

// we will model the whole thing based on the hole in the middle, since that is all we care about. It should be the measured from the male part on the bike light you want to attach here.
clf_innerWidth = 17.21; // the side to side of the shaft
clf_innerDepth = 3.6; // the depth the shaft
// height does not matter much for the male part, as it will pass trhu the whole part. So just enter a good height so that it reaches the latch on the bottom.
clf_partHeight = 22.75;
// width of the thumb thing for the latch
clf_handle_width = 11.6;

/*
T shapped connector for rear bike racks
*/



/* [Rear Rack] */
// distance from center of center screw to center of any side screw
screw_center_horizontal = 25.5;
// distance from center of top screw to center of bottom screw
screw_center_vertical = 18;
// thickness of the part. must be larger than screw head depth as we will try to make screw flush
thickness = 6;
// radius of the screw head. i.e. half of the mm wrench you want to use
hex_head_radius = 4; //[1:12]
// depth of the screw head.
hex_head_depth = 4;
// margin from the screw to the edge of the part
hex_head_margin = 3;
// radius for hole for the screw body, obviously must be smaller than hex_head_radius
screw_hole_radius = 2;
// direction of the hex head (0=flat top, 30=pointy top)
hex_head_rotation = 0; // [0,30]
// how much the hex head hole should pierce trhu the holder part being attached (not usable on this part alone)
hex_head_pierce = 100;

/* [Hidden] */
Ttop_height = 2*hex_head_radius + 2*hex_head_margin;
Tver_height = screw_center_vertical + hex_head_radius+ hex_head_margin + Ttop_height/2;

module main_part(){
	latch();
	difference(){
		// the main block where we will chip the pieces away
		cube([ clf_innerWidth/2 + clf_wall, clf_innerDepth+clf_wall*2 , clf_partHeight] );
		main_cuts();
	}
}
module latch(){
	// bottom latch
	translate([ 0, 0, -clf_wall ] ){
		cube( [ clf_handle_width/2 -0.5, clf_wall, clf_wall] );
	}
	// the latching block
	translate([ 0, clf_wall, -3-clf_wall ] ){
		cube( [ 5.20/2, 1.15, 3] );
	}
	// the lachking block base
	translate([ 0, 0, -3-clf_wall ] ){
		cube( [ clf_handle_width/2, clf_wall, 3] );
	}
	//handle();
}
module handle(){
	// the handle
	translate([ 0, clf_wall, -3-clf_wall ] ){
		rotate([45, 0, 0])
			difference(){
				cylinder( h=clf_wall, r=clf_handle_width/2);
				color("blue") rotate([0,0,90])
					translate([0, -clf_handle_width/2-0.001,-0.001])
						cube([ clf_handle_width/2+0.002, clf_handle_width+0.002 , clf_handle_width+0.002]);
			}
	}

}

module main_cuts(){
	// the inner shaft
	translate( [ -0.001, clf_wall, -0.001] ){
		cube([ clf_innerWidth/2+0.001, clf_innerDepth, clf_partHeight+0.002] );
	}
	// the front wall opening
	translate( [ -0.001, (clf_wall)+clf_innerDepth-0.001, -0.001] ){
		cube([ clf_innerWidth/2-clf_wall+0.001, clf_wall+0.002, clf_partHeight+0.002] );
	}
	// the two cuts on the side leading to the latch so that it can move back/forth
	translate( [ clf_handle_width/2-0.5, -0.001, -0.001] ){
		cube([ 0.55, clf_wall+0.002, clf_partHeight/3+0.001]);
	}
}

//clf_main();
module clf_main(){
	translate([0,0,-clf_partHeight]){
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
module T() {
	translate([0,-thickness/2,-Ttop_height/2])
	union(){
		difference() {
			union(){
				// top of the T
				cube(center=true,[screw_center_horizontal*2, thickness, Ttop_height]);
				translate([screw_center_horizontal,0,0]) rotate(a=90,v=[1,0,0])
					cylinder(r=Ttop_height/2+0.05, h=thickness, center=true);
				translate([-screw_center_horizontal,0,0]) rotate(a=90,v=[1,0,0])
					cylinder(r=Ttop_height/2+0.05, h=thickness, center=true);
				// NOTE: the +0.05 on the cylinders above is to remove one artifact when it joing the body. without it, it looked like the radius was smaller than the height of the cube
				// vertical part of T
				translate([0,0,Ttop_height/2-Tver_height/2])
					cube(center=true,[Ttop_height, thickness, Tver_height]);

				// ATTACH THE MAIN HOLDER TO THE BRACKET
				// undo the translate above
				translate([0,thickness/2,0])
					// move it down
					translate([0,0,-mix_top])
						// make the rear wall flush
						translate([0,-clf_wall-0.001,0])
							clf_main();
////////////////////////////////////////////////////////////////////////

			}
			// center hole, top
			translate([0,0,0])
				hex_head();
			// center hole, bottom
			translate([0,0,-screw_center_vertical])
				hex_head();
			// right ... yeah, our axis ended up a little off :)
			translate([-screw_center_horizontal,0,0])
				hex_head();
			// left
			translate([screw_center_horizontal,0,0])
				hex_head();
		}
	}
}

/** a sane way to create hexagons. fuck understanding polyhedron syntax at this hour of the night
*/
module hex_head(){
	// logic of this http://hexnet.org/content/hexagonal-geometry
	rotate( a=hex_head_rotation, v=[0,1,0])
	union(){
		translate([0,hex_head_pierce/2+thickness/2-hex_head_depth/2+0.001,0]){
			cube( size = [hex_head_radius,hex_head_pierce+ hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
			rotate( a=60, v=[0,1,0])
				cube( size = [hex_head_radius, hex_head_pierce+hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
			rotate( a=120, v=[0,1,0])
				cube( size = [hex_head_radius, hex_head_pierce+hex_head_depth+0.001, (hex_head_radius * sqrt(3))], center=true );
		}

		rotate(a=90,v=[1,0,0])
			translate([0,0,0])
				cylinder(r=screw_hole_radius, h=thickness+0.001+0.001+0.001+0.001, center=true, $fn=99);
				// NOTE: some reason the +0.001 was not working there... 0.004 did the trick, leaving syntax as 0.001 as i will find it with my regexps later
	}
}

T();

