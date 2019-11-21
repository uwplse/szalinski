/*
 * Variables for Thingiverse Customizer
 * ==================================================================
 *
 */

// The number of AA cells in your battery holder
Cell_Count = 1;

// Mounting holes needed or not
Mounting_Holes = "yes";//[yes,no]

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
			cylinder(h = height+1, r1 = radius, r2 = radius, center = true, $fn = 100);
	}
}

module battery_box(cells,mounting_holes)
{
	difference()
	{
		union()
		{
			translate([0, 0, 10/2])
				cube(size=[50+8+8, 15*cells, 10], center=true);
	
			translate([50/2+7+2/2, 0, 20/2])
				cube(size=[2, 15*cells, 20], center=true);

			translate([-(50/2+7+2/2), 0, 20/2])
				cube(size=[2, 15*cells, 20], center=true);

			translate([-(50/2+7-3/2), 0, 11.5/2+10/2])
				cube(size=[3, 15*cells, 11.5], center=true);

			translate([(50/2+7-3/2), 0, 11.5/2+10/2])
				cube(size=[3, 15*cells, 11.5], center=true);
			
			// mounting flanges	
            if (mounting_holes=="yes")
            {
			translate([20, cells*15/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([20, cells*15/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-20, cells*15/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, cells*15/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([20, -(cells*15/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([20, -(cells*15/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-20, -(cells*15/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, -(cells*15/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);
            }
		}
		
		for (i=[0:cells-1])
		{
			// battery cradle
			translate([0, -cells*15/2+15/2+15*i, 15/2+10/2])
			rotate(90, [0, 1, 0])
				cylinder(r=15/2, h=50+4+4, center=true, $fn = 100);
			
			// spring cut-out
			translate([50/2+7-1/2, -cells*15/2+15/2+15*i, 15/2+10/2])
				cube(size=[1, 5.5, 30], center=true);

			translate([50/2+7-1.4/2, -cells*15/2+15/2+15*i, 11.5/2+10/2])
				cube(size=[1.4, 10.5, 11.6], center=true);

			translate([-(50/2+7-1/2), -cells*15/2+15/2+15*i, 15/2+10/2])
				cube(size=[1, 5.5, 30], center=true);

			translate([-(50/2+7-1.4/2), -cells*15/2+15/2+15*i, 11.5/2+10/2])
				cube(size=[1.4, 10.5, 11.6], center=true);

			// solder flange cut-out
			translate([(50/2+7-7/2), -cells*15/2+15/2+15*i, 3/2])
				cube(size=[7, 5.5, 3.1], center=true);

			translate([(50/2), -cells*15/2+15/2+15*i, 3/2])
				cylinder(r=5.5/2, h=3.1, center=true, $fn = 50);

			translate([-(50/2+7-7/2), -cells*15/2+15/2+15*i, 3/2])
				cube(size=[7, 5.5, 3.1], center=true);

			translate([-(50/2), -cells*15/2+15/2+15*i, 3/2])
				cylinder(r=5.5/2, h=3.1, center=true, $fn = 50);

			// polarity marking (+)
			translate([20, -cells*15/2+15/2+15*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);

			translate([20, -cells*15/2+15/2+15*i, 4/2+4.5])
				cube(size=[2, 6, 4], center=true);

			// polarity marking (-)
			translate([-20, -cells*15/2+15/2+15*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);
		}
		
		if (cells>=2)
		{
			for (i=[0:cells-2])
			{
				// bottom cut-out for cell connections
				translate([0, -cells*15/2+15+15*i, 2.5/2])
				rotate(17, [0, 0, 1])
					cube(size=[50, 2, 2.6], center=true);			
			}
		}
		
		// bottom cut-out for output wires
		translate([25/2, -cells*15/2+15/2+15*0, 2.5/2])
			cube(size=[25, 2, 2.6], center=true);			

		translate([3/2, -cells*15/2+15/2+15*0+1, 2.5/2])
			edge(4, 2.6);

		translate([3/2, -cells*15/2+15/2+15*0-1, 2.5/2])
		rotate(-90, [0, 0, 1])
			edge(4, 2.6);

		translate([-25/2, -cells*15/2+15/2+15*(cells-1), 2.5/2])
			cube(size=[25, 2, 2.6], center=true);			
	
		translate([-3/2, -cells*15/2+15/2+15*(cells-1)+1, 2.5/2])
		rotate(90, [0, 0, 1])
			edge(4, 2.6);

		translate([-3/2, -cells*15/2+15/2+15*(cells-1)-1, 2.5/2])
		rotate(180, [0, 0, 1])
			edge(4, 2.6);

		// bottom polarity marking (+)
		translate([7, -cells*15/2+15/2+15*0-4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);

		translate([7, -cells*15/2+15/2+15*0-4.5, 1.5/2])
			cube(size=[1.5, 4, 1.6], center=true);

		// bottom polarity marking (-)
		translate([-7, -cells*15/2+15/2+15*(cells-1)+4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);
		
		// mounting holes
		if (mounting_holes=="yes")
        {
        translate([20, cells*15/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-20, cells*15/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([20, -(cells*15/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-20, -(cells*15/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);
        }
		// bottom cut-out for output wire
		translate([0, 0, 2.5/2])
			cube(size=[3, cells*15+5, 2.6], center=true);

		// cutout to ease battery removal
		translate([0, 0, 20/2+10/2])
		rotate(90, [1, 0, 0])
			cylinder(r=20/2, h=cells*15+5, center=true, $fn = 100);
		
		// rounded corners on end plates
		translate([0, -cells*15/2, 20])
		rotate(90, [0, 1, 0])
			edge(4, 50+8+8+5);

		translate([0, cells*15/2, 20])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(4, 50+8+8+5);

		translate([0, -cells*15/2, 16.5])
		rotate(90, [0, 1, 0])
			edge(3, 50+7+7);

		translate([0, cells*15/2, 16.5])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(3, 50+7+7);
	}
}

battery_box(Cell_Count,Mounting_Holes);