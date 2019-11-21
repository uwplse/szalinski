// Lucas Wilder - Michigan Technological University - EE 4777
// Handle

// Height from bottom of holder to top of handle in mm
handleHeight = 100;

// Number of slides
slides = 15;

actualHeight = handleHeight-21.5;

union()
{
	difference()
	{
		union()
		{
			// Main body
			cube(size = [(4*slides)+14,actualHeight,5.5],
							center = false);
		
		}
	
		// Main cut
		translate([3,-6,0]) 
		cube(size = [(4*slides)+8,actualHeight+3,5.5],
				center = false);	

	}
	
	cube(size = [9,2,5.5]);
	translate([7,0,0]) cube(size = [2,2.5,5.5]);

	translate([(4*slides)+5,0,0])cube(size = [9,2,5.5]);
	translate([(4*slides)+5,0,0]) cube(size = [2,2.5,5.5]);
}