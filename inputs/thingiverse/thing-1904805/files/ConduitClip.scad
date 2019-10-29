//-----------------------------------------
// Counduit Tube for electric wires Clip
//
// (c) Pedro Barrio 2016
//-----------------------------------------

// Interior diameter
intDiameter  = 16  ;

// Wall Thickness
wallThick    =  2;

// Wall Thickness
wallThick    =  2;

// Open Angle
openAngle    = 90 ;

// Tube Length
clipWide     = 16  ;

// Center Distance
distToCenter  = 20;

// Screw Diameter
screwDiameter  =  3.5;

// Screw Head diameter
screwHeadDiameter = 6;

// Screw Head Heigth
screwHeadHeigth = 2;

// Screw Hole Length
screHoleLength  = 8;

// circle precision
$fn=50;

	difference () {
		union()
		{
		// Clip
		cylinder( clipWide , intDiameter/2 + wallThick , intDiameter/2 + wallThick , center = true);
		// Base 
		translate ([-distToCenter/2,0,0])
			cube ([ distToCenter ,intDiameter+2 * wallThick,clipWide], center = true);
		}
    	cylinder( clipWide , intDiameter/2             , intDiameter/2             , center = true);
		PieSlice (clipWide ,intDiameter/2 + wallThick + 0.1, openAngle);				
		
		translate([-distToCenter /2,0,0])
			rotate([0,90,0])
				rotate(90)
				Hole(distToCenter, screwDiameter, screwHeadDiameter, intDiameter / 2 + screwHeadHeigth, screHoleLength);
	}




// Hole for screw
// ht = totalheigth
// hh = screw Head heigth
// d1 = diameter for screw
// d2 = diameter for screw head

module Hole ( ht = 8, d1 = 3, d2 = 5, hh= 2, l = 10 )
{
	
		// Side 1
		translate ([-(l-d1)/2,0,-hh/2])
			cylinder(ht-hh, d1/2, d1/2, center =  true);
		translate ([-(l-d1)/2,0,(ht-hh)/2])
			cylinder(hh, d2/2, d2/2, center =  true);
		
	

		// Side 2
		translate ([0,0,-hh/2])
			cube ([l-d1,d1,ht-hh], center = true);
		translate ([0,0,(ht-hh)/2])
			cube ([l-d1,d2,hh], center = true);

		// Side 2
		translate ([(l-d1)/2,0,-hh/2])
			cylinder(ht-hh, d1/2, d1/2, center =  true);
		translate ([(l-d1)/2,0,(ht-hh)/2])
			cylinder(hh, d2/2, d2/2, center =  true);
		
}



// Pie sector
module PieSlice(h = 10, r=3.0,a=30) {
	
 	rotate (-a/2) intersection() {
   		cylinder(h, r,r, center =  true);
 	
		translate ([0,0,-h/2]) cube([r,r,h]);
	   rotate(a-90) translate ([0,0,-h/2]) cube([r,r,h]);
  }
} 