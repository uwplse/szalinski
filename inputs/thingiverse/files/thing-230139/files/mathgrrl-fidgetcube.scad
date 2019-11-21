// mathgrrl print-in-place fidget cube

////////////////////////////////////////////////////////////////
// PARAMETERS //////////////////////////////////////////////////

// Decide whether you want the pieces to be full cubes or snub on one side
snub = "yes"; // [no:Cube Pieces,yes:Snub Pieces]

// Choose a side length for the cubes, in mm
cube_height = 20; 

// Choose a stacking clearance factor, in mm (controls distance between cubes)
stacking_clearance = .3;

// Choose a hinge radius, in mm
hinge_radius = 1.5; 

// Choose a hinge clearance factor, in mm (controls distance around hinge parts)
hinge_clearance = .45;

// Other variables that people don't get to choose
$fn=24*1;
fudge = .01*1;
corner_radius = .1*cube_height;
outside_height = .4*(cube_height-2*stacking_clearance);
inside_height = (cube_height-2*stacking_clearance)-2*outside_height;
cone_height = 1.4*hinge_radius; 

////////////////////////////////////////////////////////////////
// RENDERS /////////////////////////////////////////////////////

rotate(-45,[0,0,1])
translate([0,0,2*cube_height])
	rotate(90,[0,1,0])
		union(){
		// one row of four cubes
			row_assembly();
		// another row of four cubes
		translate([0,2*cube_height,2*cube_height])
			rotate(-90,[1,0,0])
				mirror([0,0,1])
					mirror([1,0,0]) 
						row_assembly();
		}

////////////////////////////////////////////////////////////////
// MODULES /////////////////////////////////////////////////////

// one row of the assembly
module row_assembly(){
	union(){
		color("blue") 
			hinged_cube(180,[1,0,0],[1,0,0]);
		
		color("red")
			translate([-cube_height/2,cube_height/2,0])
				mirror([0,1,0])
					translate([-cube_height/2,cube_height/2,0]) 
						rotate(90,[1,0,0]) 
							hinged_cube(0,[1,0,0],[0,0,0]);
		
		color("green")
			translate([cube_height,cube_height/2,cube_height/2])
				rotate(-90,[0,1,0])
					rotate(180,[1,0,0])
						mirror([0,1,0])
							translate([-cube_height/2,cube_height/2,0]) 
								rotate(90,[1,0,0]) 
									hinged_cube(180,[0,1,0],[0,1,0]);
		
		color("yellow")
			translate([-cube_height,cube_height,cube_height])
				rotate(-90,[1,0,0])
					rotate(90,[0,0,1])
						rotate(-90,[1,0,0])
							hinged_cube(0,[1,0,0],[0,0,0]);
	}
}

// one cube to rule them all
module hinged_cube(the_angle,the_vector,the_mirror){
	difference(){
	// cube and cylinders to start
		union(){
		// cube with inside top and bottom cylinders carved out
			difference(){
			// start with clearance cube in corner
				translate([cube_height/2,cube_height/2,cube_height/2])
					rotate(the_angle,the_vector)
						mirror(the_mirror)
							rounded_cube([cube_height,cube_height,cube_height]); 
			// take away inside top cylinder with clearance
				translate([cube_height,0,0])
					rotate(90,[0,0,1])
						rotate(90,[0,1,0])
							translate([0,0,stacking_clearance+outside_height+inside_height])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			// take away inside bottom cylinder with clearance
				translate([cube_height,0,0])
					rotate(90,[0,0,1])
						rotate(90,[0,1,0])
							translate([0,0,stacking_clearance-fudge])
								cylinder(	h=outside_height+fudge, 
												r1=hinge_radius+fudge+hinge_clearance, 
												r2=hinge_radius+fudge+hinge_clearance);
			}
		// top cylinder on outside hinge
			translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2, 
								r1=hinge_radius, 
								r2=hinge_radius);
		// bottom cylinder on outside hinge
			translate([0,0,stacking_clearance+corner_radius/2])
				cylinder(	h=outside_height-hinge_clearance-corner_radius/2,
								r1=hinge_radius,
								r2=hinge_radius);
		// inside hinge cylinder
			translate([cube_height,0,0])
				rotate(90,[0,0,1])
					rotate(90,[0,1,0])
						translate([0,0,stacking_clearance+outside_height])
							cylinder(	h=inside_height, 
											r1=hinge_radius, 
											r2=hinge_radius);
		// attacher for inside hinge cylinder
			translate([cube_height,0,0])
				rotate(90,[0,0,1])
					rotate(90,[0,1,0])
						translate([0,0,stacking_clearance+outside_height])
							rotate(45,[0,0,1])
								translate([-.8*hinge_radius,0,0])
									cube([1.6*hinge_radius,2*hinge_radius,inside_height]);			
		// inside hinge top cone 
			translate([cube_height,0,0])
				rotate(90,[0,0,1])
					rotate(90,[0,1,0])
						translate([0,0,stacking_clearance+outside_height+inside_height])
							cylinder(	h=cone_height, 
											r1=hinge_radius, 
											r2=0);
		// inside hinge bottom cone 
			translate([cube_height,0,0])
				rotate(90,[0,0,1])
					rotate(90,[0,1,0])
						translate([0,0,stacking_clearance+outside_height-cone_height])
							cylinder(	h=cone_height, 
											r1=0, 
											r2=hinge_radius);
		}
	// take away middle cylinder with clearance
		translate([0,0,stacking_clearance+outside_height-hinge_clearance-fudge])
			cylinder(	h=inside_height+2*hinge_clearance+2*fudge, 
							r1=hinge_radius+fudge+hinge_clearance, 
							r2=hinge_radius+fudge+hinge_clearance);
	// take away top cone with clearance
		translate([0,0,stacking_clearance+outside_height+inside_height+hinge_clearance-fudge])
			cylinder(h=cone_height, r1=hinge_radius, r2=0);
	// take away bottom cone with clearance
		translate([0,0,stacking_clearance+outside_height-cone_height-hinge_clearance+fudge])
			cylinder(h=cone_height, r1=0, r2=hinge_radius);
	}
}

// module for making rounded cubes from convex hull of corners
module rounded_cube() {
	dist = cube_height/2-corner_radius-stacking_clearance;
		hull() {
		// seven of the eight vertices of a cube
			translate([dist,dist,dist])
				sphere(r=corner_radius); 
			translate([-dist,dist,dist]) 
				sphere(r=corner_radius);
			translate([dist,-dist,dist])
				sphere(r=corner_radius);
			translate([-dist,-dist,dist]) 
				sphere(r=corner_radius);
			translate([dist,dist,-dist])
				sphere(r=corner_radius);
			translate([dist,-dist,-dist]) 
				sphere(r=corner_radius);
			translate([-dist,-dist,-dist]) 
				sphere(r=corner_radius);
		// don't include the eighth if snub desired
			if (snub=="yes"){
				}
			else{
				translate([-dist,dist,-dist]) 
					sphere(r=corner_radius);
				}
		}
}
