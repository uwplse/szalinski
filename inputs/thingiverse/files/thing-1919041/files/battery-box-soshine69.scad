/*
 * Variables for Thingiverse Customizer
 * ==================================================================
 *
 */

// The number of AA cells in your battery holder
Cell_Count = 1;
$fn = 100;

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
			cylinder(h = height+1, r1 = radius, r2 = radius, center = true);
	}
}

module battery_box(cells)
{
	difference()
	{
		union()
		{
			translate([0, 0, 12/2])
				cube(size=[67.3+2+8, 18.3*cells, 8], center=true);
	
			translate([67.3/2+3+2/2, 0, 22/2])
				cube(size=[2, 18.3*cells, 18], center=true);

			translate([-(67.3/2+3+2/2), 0, 22/2])
				cube(size=[2, 18.3*cells, 18], center=true);

			translate([-(67.3/2+3-2/2), 0, 11.5/2+10/2])
				cube(size=[2, 18.3*cells, 11.5], center=true);

			translate([(67.3/2+3-2/2), 0, 11.5/2+10/2])
				cube(size=[2, 18.3*cells, 11.5], center=true);

			// mounting flanges	
			translate([20, cells*18.3/2+4/2, 3/2+2])
				cube(size=[7, 4, 3], center=true);

			translate([20, cells*18.3/2+4, 3/2+2])
				cylinder(r=7/2, h=3, center=true);

			translate([-20, cells*18.3/2+4/2, 3/2+2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, cells*18.3/2+4, 3/2+2])
				cylinder(r=7/2, h=3, center=true);

			translate([20, -(cells*18.3/2+4/2), 3/2+2])
				cube(size=[7, 4, 3], center=true);

			translate([20, -(cells*18.3/2+4), 3/2+2])
				cylinder(r=7/2, h=3, center=true);

			translate([-20, -(cells*18.3/2+4/2), 3/2+2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, -(cells*18.3/2+4), 3/2+2])
				cylinder(r=7/2, h=3, center=true);
		}
		
		for (i=[0:cells-1])
		{
			// battery cradle
			translate([0, -cells*18.3/2+18.3/2+18.3*i, 18.3/2+10/2])
			rotate(90, [0, 1, 0])
				cylinder(r=18.3/2, h=69.3, center=true);
			
			// spring cut-out
			translate([72.3/2-1/2, -cells*18.3/2+18.3/2+18.3*i, 18.3/2+10/2])
				#cube(size=[1, 5.5, 30], center=true);

			translate([72.3/2-2/2, -cells*18.3/2+18.3/2+18.3*i, 16/2+10/2])
				cube(size=[2, 9.8, 12], center=true);

			translate([-(72.3/2-1/2), -cells*18.3/2+18.3/2+18.3*i, 18.3/2+10/2])
				#cube(size=[1, 5.5, 30], center=true);

			translate([0, -cells*18.3/2+18.3/2+18.3*i, 18.3/2+10/2])
				cube(size=[72.3, 6, 6], center=true);

			translate([-(72.3/2-2/2), -cells*18.3/2+18.3/2+18.3*i, 16/2+10/2])
				cube(size=[2, 9.8, 12], center=true);

			// solder flange cut-out
			translate([(67.3/2+3-7/2), -cells*18.3/2+18.3/2+18.3*i, 3/2])
				cube(size=[7, 5.5, 5], center=true);

			translate([(67.3/2)-4, -cells*18.3/2+18.3/2+18.3*i, 3/2])
				cylinder(r=5.5/2, h=5, center=true);

			translate([-(67.3/2+3-7/2), -cells*18.3/2+18.3/2+18.3*i, 3/2])
				cube(size=[7, 5.5, 5], center=true);

			translate([-(67.3/2)+4, -cells*18.3/2+18.3/2+18.3*i, 3/2])
				cylinder(r=5.5/2, h=5, center=true);
            
			// polarity marking (+)
			translate([20, -cells*18.3/2+18.3/2+18.3*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);

			translate([20, -cells*18.3/2+18.3/2+18.3*i, 4/2+4.5])
				cube(size=[2, 6, 4], center=true);

			// polarity marking (-)
			translate([-20, -cells*18.3/2+18.3/2+18.3*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);
		}
		
		if (cells>=2)
		{
			for (i=[0:cells-2])
			{
				// bottom cut-out for cell connections
				translate([0, -cells*18.3/2+18.3+18.3*i, 2.5/2])
				rotate(17, [0, 0, 1])
					cube(size=[67.3, 2, 5.5], center=true);			
			}
		}
		
		// bottom cut-out for output wires
		translate([25/2, -cells*18.3/2+18.3/2+18.3*0, 2.5/2])
			cube(size=[25, 2, 5.5], center=true);			

		translate([3/2, -cells*18.3/2+18.3/2+18.3*0+1, 2.5/2])
			edge(4, 5.5);

		translate([3/2, -cells*18.3/2+18.3/2+18.3*0-1, 2.5/2])
		rotate(-90, [0, 0, 1])
			edge(4, 5.5);

		translate([-25/2, -cells*18.3/2+18.3/2+18.3*(cells-1), 2.5/2])
			cube(size=[25, 2, 5.5], center=true);			
	
		translate([-3/2, -cells*18.3/2+18.3/2+18.3*(cells-1)+1, 2.5/2])
		rotate(90, [0, 0, 1])
			edge(4, 5.5);

		translate([-3/2, -cells*18.3/2+18.3/2+18.3*(cells-1)-1, 2.5/2])
		rotate(180, [0, 0, 1])
			edge(4, 5.5);

		// bottom polarity marking (+)
		translate([7, -cells*18.3/2+18.3/2+18.3*0-4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);

		translate([7, -cells*18.3/2+18.3/2+18.3*0-4.5, 1.5/2])
			cube(size=[1.5, 4, 1.6], center=true);

		// bottom polarity marking (-)
		translate([-7, -cells*18.3/2+18.3/2+18.3*(cells-1)+4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);
		
		// mounting holes
		translate([20, cells*18.3/2+4, 3/2])
			cylinder(r=3.3/2, h=10, center=true);

		translate([-20, cells*18.3/2+4, 3/2])
			cylinder(r=3.3/2, h=10, center=true);

		translate([20, -(cells*18.3/2+4), 3/2])
			cylinder(r=3.3/2, h=10, center=true);

		translate([-20, -(cells*18.3/2+4), 3/2])
			cylinder(r=3.3/2, h=10, center=true);

		// bottom cut-out for output wire
		translate([0, 0, 2.5/2])
			cube(size=[3, cells*18.3+5, 5.5], center=true);

		/*
		// cutout to ease battery removal
		translate([0, 0, 20/2+10/2])
		rotate(90, [1, 0, 0])
			cylinder(r=20/2, h=cells*18.3+5, center=true);
		*/

		// rounded corners on end plates
		translate([0, -cells*18.3/2, 20])
		rotate(90, [0, 1, 0])
			edge(4, 67.3+8+8+5);

		translate([0, cells*18.3/2, 20])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(4, 67.3+8+8+5);

		translate([0, -cells*18.3/2, 16.5])
		rotate(90, [0, 1, 0])
			edge(3, 67.3+6);

		translate([0, cells*18.3/2, 16.5])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(3, 67.3+6);
	}
}

battery_box(Cell_Count);