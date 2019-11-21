



// preview[view:east, tilt:top diagonal]

/*[Parameters]*/

metal_bar_thickness = 2.0;      //
metal_bar_width = 22.0; //
raft_thickness = 0.8;   //
bed_thickness = 5.8;   //
clearance = 0.1;        //[0.0:0.0mm,0.1:0.1mm,0.2:0.2mm,0.3:0.3mm,0.4:0.4mm]
quantity = 2;   //[1:1,2:2,3:3,4:4]
inner_length = 10.0;    //
outer_length = 5.0;    //

/*[Hidden]*/

module anti_warping_jig() {
	fn=36;
	plate_thickness = 3.0;
	plate_side_width = 10.0;
	adj=0.1;

	all_height = metal_bar_thickness + raft_thickness + bed_thickness + clearance*2 + plate_thickness*2;
	all_width = inner_length + outer_length;
	all_depth = metal_bar_width + metal_bar_thickness*2 + clearance*4 + plate_side_width*2;

	plate_bevel_width = inner_length >= 4 ? 2 : ( inner_length >= 2 ? inner_length - 2 : 0 );
	plate_bevel_height = plate_thickness >= 2 ? 1 : ( plate_thickness >= 1 ? plate_thickness - 1 : 0 );

	//side_bevel_outer = outer_length >= 4 ? 2 : ( outer_length >= 2 ? outer_length - 2 : 0 );
	//side_bevel_inner = plate_side_width >= 4 ? 2 : ( plate_side_width >= 2 ? plate_side_width - 2 : 0 );


	for ( q = [0:quantity-1] ) {

		translate([0,q*(all_height+1.0),0]) {
			intersection() {
				union() {

					difference() {

						translate([
							-outer_length
							,-bed_thickness - clearance - plate_thickness
							,-all_depth/2
						]) {
							cube([
								all_width
								,all_height
								,all_depth
							]);
						}

						translate([
							0
							,-bed_thickness - clearance
							,-all_depth/2 - adj
						]) {
							cube([
								inner_length + adj
								,bed_thickness + clearance*2
								,all_depth + adj*2
							]);
						}

						translate([
							0
							,0
							,-all_depth/2 - adj
						]) {

							linear_extrude(height=all_depth + adj*2,center=false,convex=10) {
								polygon(points=[
									[ inner_length - plate_bevel_width , -bed_thickness - clearance + adj ]
									,[ inner_length - plate_bevel_width , -bed_thickness - clearance ]
									,[ inner_length , -bed_thickness - clearance - plate_bevel_height ]
									,[ inner_length + adj , -bed_thickness - clearance - plate_bevel_height ]
									,[ inner_length + adj , -bed_thickness - clearance + adj ]
								]);
							}

						}


						translate([
							adj
							,-clearance
							,0
						]) {

							rotate([0,-90,0]) {

								linear_extrude(height=outer_length + adj*2 , center=false,convex=10) {
									polygon(points=[
										[ metal_bar_width/2 + clearance , raft_thickness + metal_bar_thickness + clearance*2 ]
										,[ metal_bar_width/2 + clearance + metal_bar_thickness/2 + clearance , raft_thickness + metal_bar_thickness/2 + clearance ]
										,[ metal_bar_width/2 + clearance , raft_thickness ]
										,[ -metal_bar_width/2 - clearance , raft_thickness ]
										,[ -metal_bar_width/2 - clearance - metal_bar_thickness/2 - clearance , raft_thickness + metal_bar_thickness/2 + clearance ]
										,[ -metal_bar_width/2 - clearance , raft_thickness + metal_bar_thickness + clearance*2 ]
									]);
								}

							}

						}

						translate([
							0
							,-clearance
							,0
						]) {

							rotate([0,90,0]) {

								linear_extrude(height=inner_length + adj,center=false,convex=10) {
									polygon(points=[
										[ metal_bar_width/2 + clearance , raft_thickness + metal_bar_thickness + clearance*2 ]
										,[ metal_bar_width/2 + raft_thickness + metal_bar_thickness + clearance*2 + clearance , 0 ]
										,[ metal_bar_width/2 + raft_thickness + metal_bar_thickness + clearance*2 + clearance , - adj ]
										,[ -metal_bar_width/2 - raft_thickness - metal_bar_thickness - clearance*2 - clearance , - adj ]
										,[ -metal_bar_width/2 - raft_thickness - metal_bar_thickness - clearance*2 - clearance , 0 ]
										,[ -metal_bar_width/2 - clearance , raft_thickness + metal_bar_thickness + clearance*2 ]
									]);
								}

							}

						}











					}
				}
			}
		}


	}

}

anti_warping_jig();
