//Variable Description

MoldRadius=50; // Possible Values
MoldHeight=100; // Possible Values
HoleR=1.5; // Possible Values
Wall=(MoldRadius-3);

difference() {
	cylinder(r=MoldRadius, h=MoldHeight, $fn=50);
		translate([0, 0, 10])
		cylinder(r=Wall, h=MoldHeight, $fn=50);
		
//Bottom Holes
		for ( i = [0 : 5] )
			{
    				rotate( i * 360 / 6, [0, 0, 1])
    				translate([0, MoldRadius/2, 0])
    				cylinder(r = HoleR, h=10);
			}
// Side Holes

for ( z = [0 : 2] )

	{		
		for ( i = [0 : 5] )
			{
    				rotate( i * 360 / 6, [0, 0, 1])
    				translate([0, 0, MoldHeight/4 * (z+1)])
				rotate([0,90,0])
    				cylinder(r = HoleR, h=MoldRadius+10);
			}

		}
 	}
