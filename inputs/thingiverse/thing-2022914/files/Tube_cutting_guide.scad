//	Rocket tube cutting guide
//  by Bryan Duke @GrouchoDuke

//  modified code from Justblair's Parametric Model Rocket Fin Alignment Tool

// Parametric 

tube_diameter	=	32 		;//mm measured tube outer diameter  
jig_height		=	30		;//mm height of jig
wall_thickness	=	4  		;//mm desired wall thickness
$fn = 150;  // Changes the smoothness of the curves


difference(){
	// Create the solid shapes 
			cylinder (r = (tube_diameter/2) + wall_thickness, h =jig_height);
	
	// Create the cutout shapes
	
	// Rocket tube body
	translate ([0,0,-0.5])
		cylinder (r=tube_diameter/2, h = jig_height + 10 );


}





