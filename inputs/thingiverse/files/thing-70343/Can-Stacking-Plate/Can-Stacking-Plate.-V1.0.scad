// Can Stacking Plate:
//
//	Simple Cylinder with plate to help stacking cans in the pantry.
//   We use 45 degree settings to allow overhang printing if required.
//

// In mm.
	DiameterOfCan = 75; 

// In mm.
	HeightOfStacker = 20;

	InnerSpacing = 1 * 1;
	ThicknessOfCylinder = DiameterOfCan/7; 
	ThicknessOfPlate = 2 * 1;
	HeightOfPlate = ( HeightOfStacker - ThicknessOfPlate)/2 ;

// Offset and rotate for build platform.

	translate([0,HeightOfStacker/2,(DiameterOfCan + InnerSpacing+ThicknessOfCylinder)/2.165 ]) 
	rotate([90,45/2,0]) 

// Generate outer cylinder

	difference() {

		cylinder( h=HeightOfStacker, r=(DiameterOfCan + InnerSpacing + ThicknessOfCylinder)/2, $fa = 45);
 		cylinder( h=HeightOfStacker, r=(DiameterOfCan + InnerSpacing)/2, $fs = 1 );
	}

// Offset and rotate for build platform.

	translate([0,HeightOfStacker/2,(DiameterOfCan + InnerSpacing+ ThicknessOfCylinder)/2.16 ]) 
	rotate([90,45/2,0])	
	translate([0,0,HeightOfPlate ])

// Generate inner support.
	
	difference() {
		cylinder( h=ThicknessOfPlate, r=(DiameterOfCan + InnerSpacing)/2, $fs = 1);
		cylinder( h=ThicknessOfPlate, r=(DiameterOfCan + InnerSpacing)/2.2, $fs = 30);
	}
