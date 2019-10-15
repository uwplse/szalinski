//	*********************************************
//	*  Fin Alignment Tools for Model Rockets	*
//	*	   Blair Thompson (aka Justblair)		*
//	*		    www.justblair.co.uk				*
//	*********************************************

//  Changes by Nick Estes <nick@nickstoys.com>:
//    Jig fin width now calculated correctly
//    Fin tab ends uses the wall_thickness
//    brim_width now configurable
//    cylinder smoothness modified from $fn method to $fs/$fa method
//    Center cutout now based on jig_height (previously failed on tall jigs)

// Parametric 

tube_diameter	=	50.8 		;//mm measured tube outer diameter
fin_width		=	2.5 	;//mm measured fin width
fin_number		=	4		;// Number of fins
jig_height		=	20		;//mm height of jig
jig_fin_width	=	25		;//mm width of jig fin holders
wall_thickness	=	2		;//mm desired wall thickness

brim_width = 15;

glue_clearance	=	6		;//mm inner gap to prevent glue sticking to jig

$fs=0.2;
$fa=0.2;

difference(){
	// Create the solid shapes 
	union(){

			cylinder (r = (tube_diameter/2) + brim_width, h = 2);
			cylinder (r = (tube_diameter/2) + wall_thickness, h =jig_height);

		for (i = [0:fin_number - 1]){
			
			// Fin holders
			rotate( i * 360 / fin_number, [0, 0, 1])
				translate (-[(fin_width + wall_thickness * 2) / 2, 0, 0])
					cube([fin_width + wall_thickness * 2, jig_fin_width + tube_diameter/2,jig_height]);
			
			// End Ties
			rotate( i * 360 / fin_number, [0, 0, 1])
				translate ([-(fin_width + wall_thickness * 2) / 2, 0, 0])
					cube([fin_width + wall_thickness * 2, jig_fin_width + tube_diameter/2 + wall_thickness, 4]);
					
			// Inner gap	
			rotate( i * 360 / fin_number, [0, 0, 1])
				translate ([0, tube_diameter/2, 0])
					cylinder (r = glue_clearance + wall_thickness, h =jig_height);
		}
	}
	
	// Create the cutout shapes
	
	// Rocket tube body
	translate ([0,0,-0.5])
		cylinder (r=tube_diameter/2, h = jig_height+1 );

	for (i = [0:fin_number - 1]){
	
		// Fin cutouts
		rotate( i * 360 / fin_number, [0, 0, 1])
			translate ([-fin_width/2, 0, -0.5])
				cube([fin_width, jig_fin_width + tube_diameter/2+0.1, jig_height + 1]);
				
		// Inner gap		
		rotate( i * 360 / fin_number, [0, 0, 1])
			translate ([0, tube_diameter/2, -0.5])
				cylinder (r = glue_clearance, h = jig_height + 1);
	}
}




