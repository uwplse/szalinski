/* [Global] */


/* [Resolution] */

resolution = 6; // [6:100]



/* [Hidden] */

dome_size= 10;


print_part();

module print_part() {
	
	// this will create a high resolution sphere with parametric resolution

	difference()
	{
	
		sphere (dome_size,$fn=resolution);

		translate([0,0,-dome_size])
		
		{
		cube(dome_size*2, center =true);

		//cylinder(r=2, h=20, center= true, $nf=40);

		}	
	}
	
}