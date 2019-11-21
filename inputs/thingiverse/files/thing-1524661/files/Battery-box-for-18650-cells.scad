/*
 * Variables for Thingiverse Customizer
 * ==================================================================
 *
 */

// The number of cells in your battery holder
Cell_Count = 2;
// AA:50.5;18650:65
Cell_Long = 65;
// AA:14.5;18650:18
Cell_Wide = 18;
// 1:series connection; 2:parallel connection
Connection = 1;	
// 1:yes; 2:no
mounting_flanges = 1; 

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

module battery_box(cells)
{
	difference()
	{
		union()
		{
			translate([0, 0, Cell_Wide*(4/3)/4])
				cube(size=[Cell_Long+7+7, Cell_Wide*cells, Cell_Wide*(4/3)/2], center=true);
	
			translate([Cell_Long/2+5.5, 0, Cell_Wide*(4/3)/2])
				cube(size=[3, Cell_Wide*cells, Cell_Wide*(4/3)], center=true);

			translate([-(Cell_Long/2+5.5), 0, Cell_Wide*(4/3)/2])
				cube(size=[3, Cell_Wide*cells, Cell_Wide*(4/3)], center=true);

			translate([-(Cell_Long/2+5-2), 0, Cell_Wide*0.8/2+Cell_Wide*(4/3)/4])
				cube(size=[2, Cell_Wide*cells, Cell_Wide*0.7], center=true);

			translate([(Cell_Long/2+5-2), 0, Cell_Wide*0.8/2+Cell_Wide*(4/3)/4])
				cube(size=[2, Cell_Wide*cells, Cell_Wide*0.7], center=true);
			
			// mounting flanges	
            if (mounting_flanges == 1)
            {
			translate([20, cells*Cell_Wide/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([20, cells*Cell_Wide/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-20, cells*Cell_Wide/2+4/2, 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, cells*Cell_Wide/2+4, 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([20, -(cells*Cell_Wide/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([20, -(cells*Cell_Wide/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);

			translate([-20, -(cells*Cell_Wide/2+4/2), 3/2])
				cube(size=[7, 4, 3], center=true);

			translate([-20, -(cells*Cell_Wide/2+4), 3/2])
				cylinder(r=7/2, h=3, center=true, $fn = 60);
		}
    }
        
        if (mounting_flanges == 2)
        {
            
        }
		
		for (i=[0:cells-1])
		{
			// battery cradle
			translate([0, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
			rotate(90, [0, 1, 0])
				cylinder(r=Cell_Wide/2, h=Cell_Long+2+2, center=true, $fn = 100);
			
			// spring cut-out
			translate([Cell_Long/2+3, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 12, 12], center=true);
            
            translate([Cell_Long/2+3, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 4, 30], center=true);
            
            translate([Cell_Long/2+3-1/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 8, 12], center=true);
			
			translate([-(Cell_Long/2+3), -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 12, 12], center=true);
            
            translate([-(Cell_Long/2+3), -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 4, 30], center=true);
            
            translate([-(Cell_Long/2+3-1/2), -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, Cell_Wide/2+10/2])
				cube(size=[1, 8, 12], center=true);

			// solder flange cut-out
			translate([(Cell_Long/2+5-6/2), -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 3/2])
				cube(size=[6, 6, 3.1], center=true);

			translate([(Cell_Long/2)-1/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 3/2])
				cylinder(r=6/2, h=3.1, center=true, $fn = Cell_Long);

			translate([-(Cell_Long/2+5-6/2), -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 3/2])
				cube(size=[6, 6, 3.1], center=true);

			translate([-(Cell_Long/2)+1/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 3/2])
				cylinder(r=6/2, h=3.1, center=true, $fn = Cell_Long);

			// polarity marking (+)
			translate([20, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);

			translate([20, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 4/2+4.5])
				cube(size=[2, 6, 4], center=true);

			// polarity marking (-)
			translate([-20, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*i, 4/2+4.5])
				cube(size=[6, 2, 4], center=true);
		}
		
		if (cells>=2)
		{
			for (i=[0:cells-2])
			{
				// bottom cut-out for cell connections
				if (Connection == 1)
				{
					translate([0, -cells*Cell_Wide/2+Cell_Wide+Cell_Wide*i, 2.5/2])
					rotate(17, [0, 0, 1])
						cube(size=[Cell_Long, 2, 2.6], center=true);
				}

				if (Connection == 2)
				{			
					translate([Cell_Long/2+3, -cells*Cell_Wide/2+Cell_Wide+Cell_Wide*i, 2.5/2])
					rotate(90, [0, 0, 1])
						cube(size=[Cell_Wide, 2, 2.6], center=true);

					translate([-Cell_Long/2-3, -cells*Cell_Wide/2+Cell_Wide+Cell_Wide*i, 2.5/2])
					rotate(90, [0, 0, 1])
						cube(size=[Cell_Wide, 2, 2.6], center=true);
				}
			}
		}
		
		// bottom cut-out for output wires
		translate([Cell_Long/4, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*0, 2.5/2])
			cube(size=[Cell_Long/2, 2, 2.6], center=true);			

		translate([3/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*0+1, 2.5/2])
			edge(4, 2.6);

		translate([3/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*0-1, 2.5/2])
		rotate(-90, [0, 0, 1])
			edge(4, 2.6);

		translate([-Cell_Long/4, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*(cells-1), 2.5/2])
			cube(size=[Cell_Long/2, 2, 2.6], center=true);			

		translate([-3/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*(cells-1)+1, 2.5/2])
		rotate(90, [0, 0, 1])
			edge(4, 2.6);

		translate([-3/2, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*(cells-1)-1, 2.5/2])
		rotate(180, [0, 0, 1])
			edge(4, 2.6);

		// bottom polarity marking (+)
		translate([7, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*0-4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);

		translate([7, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*0-4.5, 1.5/2])
			cube(size=[1.5, 4, 1.6], center=true);

		// bottom polarity marking (-)
		translate([-7, -cells*Cell_Wide/2+Cell_Wide/2+Cell_Wide*(cells-1)+4.5, 1.5/2])
			cube(size=[4, 1.5, 1.6], center=true);
		
		// mounting holes
		translate([20, cells*Cell_Wide/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-20, cells*Cell_Wide/2+4, 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([20, -(cells*Cell_Wide/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		translate([-20, -(cells*Cell_Wide/2+4), 3/2])
			cylinder(r=3.3/2, h=4, center=true, $fn = 30);

		// bottom cut-out for output wire
		translate([0, 0, 2.5/2])
			cube(size=[3, cells*Cell_Wide+5, 2.6], center=true);

		// cutout to ease battery removal
		translate([0, 0, 20/2+10/2])
		rotate(90, [1, 0, 0])
			cylinder(r=20/2, h=cells*Cell_Wide+5, center=true, $fn = 100);
		
		// rounded corners on end plates
		translate([0, -cells*Cell_Wide/2, Cell_Wide*(4/3)])
		rotate(90, [0, 1, 0])
			edge(4, Cell_Long+8+8+5);

		translate([0, cells*Cell_Wide/2, Cell_Wide*(4/3)])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(4, Cell_Long+8+8+5);

		translate([0, -cells*Cell_Wide/2, Cell_Wide*(4/3)*0.95-3])
		rotate(90, [0, 1, 0])
			edge(3, Cell_Long+4+4);

		translate([0, cells*Cell_Wide/2, Cell_Wide*(4/3)*0.95-3])
		rotate(90, [0, 1, 0])
		rotate(-90, [0, 0, 1])
			edge(3, Cell_Long+4+4);
	}
}

battery_box(Cell_Count);