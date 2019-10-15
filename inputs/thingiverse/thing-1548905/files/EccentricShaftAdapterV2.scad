//=============================
//  Eccentric shaft adapter for 3mm motor shaft
//      Designed for Pololu micro gear motors or any 3mm motor shaft
//
//  Designed by Andrew Moore, May 2016
//      http://www.thingiverse.com/TacPar
//
//      For questions, suggestions, or whatever, 
//      please PM me through thingiverse.
//
//      This work is licensed under a Creative Commons 
//      Attribution-ShareAlike 4.0 International License.
//      http://creativecommons.org/licenses/by-sa/4.0/


//=============================
//Constants
//=============================
inch = 25.4;

//=============================
//Render Variables
//=============================
$fn=100;


//=============================
//Mechanical Part Variables
//=============================
Eccentricity = 2.5; //set to 0 if you just want a big wheel.
                    //set for 5mm stroke 
                    //1mm eccentricity = 2mm stroke
                    //2mm = 4mm stroke
                    //3mm = 6mm stroke
Body_Dia = 12;
Body_Height = 15;
Shaft_Dia = 3;
Shaft_Tolerance = 0.25; //oversized radius for motor shaft hole
Key_Depth = .17; //how deep keyed cut is in motor shaft; default 20% = 0.2

//Sanity Checks on Dimensions... right now this error checking is not actually used for anything.
Dimension_Error = false;
if (Shaft_Tolerance >1)or (Body_Dia-(Shaft_Dia+Shaft_Tolerance+Eccentricity)<1)
{
    Dimension_Error = true;
}


module 3mmShaftAdapter()
{
	
	difference()
	{
		positives();
		negatives();
	}
	//add ons in areas that were erased...
	
	module positives()
	{
        translate([Eccentricity,0,Body_Height/2]) cylinder(r=Body_Dia/2, h=Body_Height, center=true);
	}

	module negatives()
	{


		//keyed shaft
		translate([0,0,0.1]) difference()
		{
			cylinder(r=Shaft_Dia/2+Shaft_Tolerance, h=2*Body_Height,  center=true);
			translate([(Key_Depth-1)*Shaft_Dia,0,0]) cube([Shaft_Dia,Shaft_Dia,2*Body_Height], center=true);
		}
		
		//set-screw holes at 25% and 75% of overall length
		translate([0,0,0.75*Body_Height]) rotate([0,-90,0])cylinder(r=.8, h=2*Body_Height);
        translate([0,0,0.25*Body_Height]) rotate([0,-90,0])cylinder(r=.8, h=2*Body_Height);
	}

}


3mmShaftAdapter();