// Lucas Wilder - Michigan Technological University - EE 4777
// Microscope Slide Holder

// Number of slides
slides = 15;

// Slide thickness in mm
thickness = 1;

// Slide length in mm
length = 75;

//Slide width in mm
width = 25;

difference()
{
	// Union of main part to handle mounts
	union()
	{
		// Handle mounts
		translate([(4*slides+8)/2,(length+6.5)/2,(width/2)+6])
		cube(size = [4*slides+8,10,6],center = true);

		// Main body
		cube(size = [4*slides+8,length+6.5,(width/2)+3], center = false);
		
	}
	
	// Slides with tolerance
	for(i=[0:1:slides])
	{
		translate([3+(4*i),2.5,3]) 
		cube(size = [thickness+1,length+2,width],center = false);
	}
	
	// Center cut
	translate([3,5,-1])
	cube(size = [4*slides+2,length-3,width+4], center = false);
	
	//Handle slots
	translate([(4*slides+8)/2,(length+6.5)/2,(width/2)+5])
	cube(size = [4*slides+8,6,4],center = true);

}

