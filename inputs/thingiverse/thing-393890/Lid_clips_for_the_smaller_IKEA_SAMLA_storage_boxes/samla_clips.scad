/*
 * Variables for Thingiverse Customizer
 * ==================================================================
 *
 */

// The width of the clips in mm (I use 10 mm and have 4 clips per box)
Clips_Width = 10;


/*
 * Library function: edge
 * ==================================================================
 *
 * Used to make roundes edges on objects
 *
 */
module edge(radius, height)
{
	difference()
	{
		translate([radius/2-0.5, radius/2-0.5, 0])
			cube([radius+1, radius+1, height], center = true);

		translate([radius, radius, 0])
			cylinder(h = height+1, r1 = radius, r2 = radius, center = true, $fn = 50);
	}
}

module ikea_samla_clips(width)
{
	length = 25;
	difference()
	{
		union()
		{
			
			translate([0, 0, -3/2])
				cube(size=[length, width, 3], center=true);
		
			translate([length/2-3/2, 0, -(8+3)/2])
				cube(size=[3, width, 8+3], center=true);
		
			difference()
			{
				translate([length/2, 0, -(8+3+1.5)/2])
					cube(size=[6, width, 8+3-1.5], center=true);
			
				translate([length/2+3+1, 0, -(8+3+1.5)/2-1])
				rotate(20, [0, 1, 0])
					cube(size=[6, width+1, 8+3], center=true);
			}
			
			translate([-length/2+3, 0, -3])
			rotate(-90, [1, 0, 0])
				edge(8, width);
		
			translate([-(length/2-3/2), 0, -(12+3+3)/2])
				cube(size=[3, width, 12+3+3], center=true);
		
			translate([-(length/2-(3+4+3)/2), 0, -12-3-3/2])
				cube(size=[3+4+3, width, 3], center=true);
		
			translate([-(length/2-(3+4+3)+(3/2)), 0, -12-3])
				cube(size=[3, width, 3+3], center=true);
				
			translate([length/2-3, 0, -3])
			rotate(-90, [1, 0, 0])
			rotate(90, [0, 0, 1])
				edge(2, width);				
		}
		
		union()
		{
			translate([-length/2, 0, 0])
			rotate(-90, [1, 0, 0])
				edge(8+3, width+1);
				
			translate([-length/2, 0, -12-3-3])
			rotate(-90, [1, 0, 0])
			rotate(-90, [0, 0, 1])
				edge(1, width+1);
			
			translate([-length/2+3+4+3, 0, -12-3-3])
			rotate(-90, [1, 0, 0])
			rotate(-180, [0, 0, 1])
				edge(1, width+1);

			translate([length/2-3, 0, -8-3])
			rotate(-90, [1, 0, 0])
			rotate(-90, [0, 0, 1])
				edge(1, width+1);
		
			translate([length/2, 0, -8-3])
			rotate(-90, [1, 0, 0])
			rotate(-180, [0, 0, 1])
				edge(1, width+1);
		
			translate([length/2, 0, 0])
			rotate(-90, [1, 0, 0])
			rotate(90, [0, 0, 1])
				edge(1, width+1);
				}	
	}
}

ikea_samla_clips(Clips_Width);