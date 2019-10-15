$fn = 100*1;

// Drawer door thickness 
drawer_thickness = 16.6; // [5:0.1:40]
// Handle width 
width = 60; // [20:120]

// How much the handle will protrude from the drawer door
handle_depth = 20; // [15:30]

handle_height = 20; // [16:30]

handle_facing = "up"; // [up,down]

// Height of outter wall (not the handle)
middle_height = 20; // [15:40]

// Height of the inner wall 
inner_height = 30; // [20:50]

// Thickness of bridges between inner and middle wall and between middle wall and the handle (for PLA recommended at least 3mm otherwise it will band)
thickness_bottom = 3; // [2:0.1:5]
// Vertial walls thickness
thickness_wall = 3; // [2:0.1:5]

handle_rotate = 180*1;

thicknessMiddleAdd = 1*1;

angleMiddle = 1*1;
angleHandle = -3*1;

rounded = 8*1;

module rl(m, rounded) {
        cube([m[0], m[1]-rounded*2, m[2]], center=true);
        translate([0, 0, rounded/2])
            cube([m[0], m[1], m[2]-rounded], center=true);
        translate([0, m[1]/2-rounded, -m[2]/2+rounded])
            rc(m[0], rounded);
        translate([0, -m[1]/2+rounded, -m[2]/2+rounded])
            rc(m[0], rounded);
    }

     
    module rc(thickness, rounded) {
        rotate([0,90,0])
            cylinder(thickness, r=rounded, center=true);
    }
	
	
//---------------------------------
// MAIN PROGRAM
//---------------------------------
rotate([0,0,0]) {
    // INNER
    translate([-thickness_wall/2, 
				0, 
				thickness_bottom/2 - inner_height/2])
        rl([thickness_wall, width, inner_height], rounded);
    
    // MIDDLE
    translate([drawer_thickness + thickness_wall/2, 0, 0]) 
        rotate([0, angleMiddle, 0])
            translate([0, 
						0, 
						thickness_bottom/2 - middle_height/2 - 0.1])
				cube([thickness_wall, width, middle_height], center=true);
                //rl([thickness_wall, width, middle_height], rounded);

    // Drawer bridge
    translate([(drawer_thickness)/2, 0, 0]) 
        cube([drawer_thickness + thickness_wall * 2, width, thickness_bottom], center=true);

	if (handle_facing == "up") {
		echo ("facing up");
		handle_rotate = 180; }
	else {
		echo ("facing down");
		handle_rotate = 0; }
	echo ("handle rotate: ", handle_rotate);
		
	if (handle_facing == "up")
	{
		// Handle bridge
		translate([handle_depth/2 + drawer_thickness - 0.2, // - thicknessMiddleAdd / 3.1, 
					0, 
					thickness_bottom - middle_height - 0.1]) 
			cube([handle_depth, width, thickness_bottom], center=true);
		
		// HANDLE
		translate([handle_depth + drawer_thickness - thickness_wall/2 + thickness_wall - 0.2, 
					0, 
					handle_height/2 - middle_height + thickness_bottom/2])  //thickness_bottom + 0]) 
			rotate([180, 0, 0])
				translate([-thickness_wall, 0, 0]) //handle_height/2])
					rl([thickness_wall, width, handle_height], rounded);
	}
	else // handle facing down
	{
		// Handle bridge
		translate([handle_depth/2 + drawer_thickness - 0.2, // - thicknessMiddleAdd / 3.1, 
					0, 0])
					//thickness_bottom - middle_height - 0.1]) 
			cube([handle_depth, width, thickness_bottom], center=true);
		
		// HANDLE
		translate([handle_depth + drawer_thickness - thickness_wall/2 + thickness_wall - 0.2, 
					0, 
					handle_height/2 - middle_height + thickness_bottom/2]) //thickness_bottom + 0]) 
			rotate([0, 0, 0])
				translate([-thickness_wall, 0, 0]) //handle_height/2])
					rl([thickness_wall, width, handle_height], rounded);
	}		
}