/*
 * Parametric Hole Mold
 *
 * By: Mike Creuzer <thingiverse@creuzer.com>
 * 
 * http://www.thingiverse.com/thing:22006
 *
 * Version 1.0
 */


// everything is in mm so if you want to use inches, use the following conversion
//inchestomm = 25.4 ;

height    = 5;
// Remember the diameter is twice the radius (full circle size)
diameter = 25; // Remember the diameter is twice the radius (full circle size)

rows   = 1; // Number of rows to have
cols    = 2; // Number of cols to have



difference() {
	shell();
	holes(2); // make 'em taller so we cut right through, otherwise we end up with a thin shell
}



// make the frame of the mould
module shell()
{
	minkowski()
	{
		hull() {	
			holes();	
		}
		cylinder(r=2);
	}
}


// calculate the series of holes needed to make the mold
module holes( multiplier = 1 )
{
for ( i = [1 : rows] )
{
	
	for ( j = [1 : cols] )
	{
		if(i % 2 == 1)
		{
			translate([(2 * diameter + 1) * i -  i   , ((2 * diameter + 2) * j) + diameter, 0])
				cylinder(r =diameter, h = height * multiplier, $fa=6, center = true);
		
		}else
		{
			translate([(2 * diameter + 1) * i - i  , (2 * diameter + 2) * j , 0])
				cylinder(r =diameter, h = height * multiplier, $fa=6, center = true);
		
		
		}
	}
}

}