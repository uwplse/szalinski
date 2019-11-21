//Handlebar Watch/GPS Holder by eriqjo
//
//v0.2 Moved the mount forward on the handlebar so it can actually be installed
//v0.1 Initial release
//

//CUSTOMIZER VARIABLES

/* [Measurements] */

//How wide is the wrist strap, mm?
Strap_Width = 25;

//Simulated wrist diameter (thickest), mm
Wrist_Dia_A = 55;

//Simulated wrist diameter (thinnest), mm
Wrist_Dia_B = 45;

//Diameter of the handlebar, mm
HB_Diameter = 37;

//END CUSTOMIZER VARIABLES

difference(){
	scale([Wrist_Dia_A, Wrist_Dia_B, 1])
		cylinder(h = Strap_Width, r = 0.5, center = true, $fn = 30);
	translate([0,5 + (Wrist_Dia_B - HB_Diameter)/2, 0])
		cylinder(h = Strap_Width +1, r = HB_Diameter/2, center = true);
	translate([0,5 + (Wrist_Dia_B - HB_Diameter)/2 + (Wrist_Dia_B/2 + 1)/2, 0])
		cube([HB_Diameter, Wrist_Dia_B/2 + 1, Strap_Width +1], center = true);
} //d


