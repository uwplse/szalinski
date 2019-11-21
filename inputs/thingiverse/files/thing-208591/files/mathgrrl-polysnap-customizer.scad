// mathgrrl polysnap tiles

// AS SUBMITTED TO THINGIVERSE CUSTOMIZER - DO NOT MODIFY THIS COPY

//////////////////////////////////////////////////////////////////////////
// PARAMETERS ////////////////////////////////////////////////////////////

/* [Shape] */

// Choose the number of sides for the tile
sides = 5; // [3,4,5,6,7,8,9,10,11,12]

// Choose the number of snaps on each side
snaps = 3; // [2,3,4,5,6,7,8]

/* [Size] */

// Set the length of each side, in mm
side_length = 25; 

// Set the thickness of the tile, in mm
thickness = 3.5;

// Set the border thickness, in mm
border = 3.5;	

/* [Adjust Fit] */

// Add extra space between snaps, in mm
clearance = .17;

// Add extra length to the snaps, in mm
lengthen = .3;

//radius depends on side length
radius = side_length/(2*sin(180/sides)); 

//inside radius depends on the border thickness
inside = radius-border/(cos(180/sides)); 

//width of each snap depends on number of snaps	
snapwidth = radius*sin(180/sides)/snaps;

//////////////////////////////////////////////////////////////////////////
// RENDERS ///////////////////////////////////////////////////////////////

union(){
	//make the polygon base
	poly_maker(); 									
	
	//make the snaps
	snap_maker();	
}

//////////////////////////////////////////////////////////////////////////
// MODULES ///////////////////////////////////////////////////////////////

//build the polygon shape of the tile
//shape is made up of n=sides wedges that are rotated around
module poly_maker(){

	//subtract the smaller polygon from the larger polygon
	difference(){

		//extrude to thicken the polygon
		linear_extrude(height=thickness,center=true){ 

			//rotate the wedge n=sides times at angle of 360/n each time
			for(i=[0:sides]){

				//rotation is around the z-axis [0,0,1]
				rotate(i*360/sides,[0,0,1])	

					//make triangular wedge with angle based on number of sides
					polygon(

						//the three vertices of the triangle
						points =	[[0-.1,0-.1], //tweaks fix CGAL errors
									 [radius,0-.01],
									 [radius*cos(360/sides)-.01,radius*sin(360/sides)+.01]],

						//the order to connect the three vertices above
						paths = [[0,1,2]]
					);
			}
		}
		//extrude to thicken the center polygon that will be the hole
		linear_extrude(height=thickness+2,center=true){ 

			//rotate the wedge n=sides times at angle of 360/n each time			
			for(i=[0:sides]){

				//rotation is around the z-axis [0,0,1]
				rotate(i*360/sides,[0,0,1])	

					//make triangular wedge with angle based on number of sides
					polygon(

						//the three vertices of the triangle
						points =	[[0-.2,0-.2], //tweaks fix CGAL errors
									 [inside,0-.01],
									 [inside*cos(360/sides)-.01,inside*sin(360/sides)+.01]],

						//the order to connect the three vertices above
						paths = [[0,1,2]]
					);
			}
		}
	}
}

//build the snaps around the tile
//try the commands alone with i=1 and i=2 to see how this works
//remember to read from the bottom to the top to make sense of this
module snap_maker(){

	//rotate the side of snaps n=sides times at angle of 360/n each time
	for(i=[0:sides]){ 

		//rotation is around the z-axis [0,0,1]
		rotate(i*360/sides,[0,0,1]) 	

			//build snaps for first side at the origin and move into positions
			for(i=[0:snaps-1]){	

				//read the rest of the commands from bottom to top
				//translate the snap to the first side
				translate([radius,0,-thickness/2]) 

					//rotate the snap to correct angle for first side
					rotate(180/sides) 

						//for i^th snap translate 2*i snapwidths over from origin
						translate([0,2*i*snapwidth,0]) 

							//rounded box for snap made from a box and cylinder
							union(){

								//cube part of snap shape at the origin
								cube([thickness/2+lengthen,snapwidth-clearance,thickness]);

								//post at back of snap to avoid loose teeth
								//shifted a bit right to avoid overhangs when sides=3
								translate([-.5,.5,0])
									cube([thickness/2,snapwidth-clearance-.5,thickness]);
	
								//round part of snap shape at the origin
								//move cylinder to the end of the box
								translate([thickness/2+lengthen,snapwidth-clearance,thickness/2])

									//rotate cylinder to match box orientation
									rotate(90,[0,1,0]) 
										rotate(90,[1,0,0]) 

											//cylinder of the correct size to match box
											cylinder(	
												r=thickness/2,
												h=snapwidth-clearance,
												$fn=16  //number of sides
											);
							}
			}
	}
}
