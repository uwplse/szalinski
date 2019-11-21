//************** MC2020 Antenna Holder **************
//*    2.4GHz Antenna holder replacement instead of MPX part  *
//*            Henning Stöcklein   Version 28.11.2015                 *
//*          License: Free to use non-commercial only               *
//***********************************************

use <write/Write.scad>

//***************** User parametric data *************
// Put slider switch below antenna socket
Use_Switch = 1; // [0:w/o switch, 1:with slider switch]

// Text placed on right side of slider
Text_Right = "J" ;

// Text placed on left side of slider
Text_Left = "S" ; 

// Switch Plate Cutout Width
switch_plate_w = 24 ; // [22:28]

// Switch Plate Cutout Height
switch_plate_h = 8 ; // [7:10]

// Switch M2 screw hole diameter
holedia = 1.2 ;

// Switch M2 screw hole distance
holedist = 19 ; // [15:22]

// Switch slider hole width
slider_width = 9.5 ; 

// Switch slider hole height
slider_height = 4.2 ;

// Print Support Grid into switch hole
use_support = 1 ; // [0: w/o support, 1:with support]

//************** End of parametric data ***************

// Table for frame sides
framedata = [ [
[0		,	0		],
[0		,	11.5	],
[11.5	,	38		],
[18.0	,	36.5	],
[19.5 ,	34.0	],
[19.5	,	0		]],
[[0,1,2,3,4,5]]] ;

//****************************************************
// sidebody out of polygon chain
//****************************************************
module sideframe() 
{
  scale ([1,1,1]) {
 	 linear_extrude(height=2.5) polygon(framedata[0],framedata[1]);
  }
}

//****************************************
// Combine all parts
//****************************************
module frame() {
 difference() {
  union() {
	translate ([0,0,-20-2.5]) sideframe();		// right side
	translate ([0,0, 20]) sideframe();			// left side

	translate ([-1,6.3, 0]) rotate ([0,0,-0.6])
	  cube ([4,12.6,40],center=true);	// lower front plane
	translate ([4.1,25, 0]) rotate ([0,0,-23.5])
	  cube ([3,28.3,40],center=true);								// front main plate
	translate ([6.3,24.0, 19.6]) rotate ([0,45,-23.5])
	  cube ([1.5,28,4],center=true);
	translate ([6.3,24.0, -19.6]) rotate ([0,-45,-23.5])
	  cube ([1.5,28,4],center=true);
	translate ([9.5,34, 0]) rotate ([0,0,-38])
	  cube ([2,8,40],center=true);
	translate ([12.6,36.2, 0]) rotate ([0,0,-13])
	  cube ([3,3,40],center=true);

	translate ([1,6, 19.5]) rotate ([0,45,0])
	  cube ([1.5,12,4],center=true);
	translate ([1,6, -19.5]) rotate ([0,-45,0])
	  cube ([1.5,12,4],center=true);

	translate([7.1,23,0]) rotate ([90,0,90-23.5])		// Inner wall for antenna socket
     cylinder (r1=15,r2=6.5,h=8.5,$fn=40,center=true) ;
  }

  translate ([7.8,38, 0]) cube ([6,3,40.05],center=true);
  translate ([9.86,39.2, 0]) rotate ([0,0,-24])
    cube ([4,4,40.05],center=true);
  translate ([14.5,36.2, 0]) rotate ([0,0,-40])
	 cube ([3,6,40-0.05],center=true);
 }
}

module socket() {
  cylinder (r=6.2/2, h=15, $fn=20) ;
  translate ([0,0,0]) cylinder (r=8/2, h=3.5, $fn=6) ;
  translate ([0,0,8.5]) cylinder (r=8/2, h=1.8, $fn=6) ;
}

// Cutout for Slider Switch (switch used to select different HF modules)
module switch() {
  if (use_support == 0)
    cube ([slider_width, slider_height, 8], center=true) ;					  // Slider is (9.1 / 3.8)

  // Cutout with 2 support ribs
  translate ([+slider_width/2-2.7/2, 0, 0]) cube ([2.7, slider_height, 8], center=true); 
  translate ([-slider_width/2+2.7/2, 0, 0]) cube ([2.7, slider_height, 8], center=true);
  translate ([0,0,0]) cube ([3.1-(slider_width-9.5), slider_height, 8], center=true);

  translate ([0,0,-2]) cube ([switch_plate_w, switch_plate_h, 4], center=true) ; // Gehäuse (23.5 / 7.5)

/*
  // Screw holes M2 from outside
  translate ([-19/2,0,0]) cylinder (r=1, h=10, $fn=20, center=true); 
  translate ([+19/2,0,0]) cylinder (r=1, h=10, $fn=20, center=true); 
  // Chamfers for screw holes
  translate ([-19/2,0,2.4]) cylinder (r1=1, r2=2, h=1, $fn=20, center=true); 
  translate ([+19/2,0,2.4]) cylinder (r1=1, r2=2, h=1, $fn=20, center=true); 
*/

  // Blind holes for screws from inside
  translate ([-holedist/2,0,0]) cylinder (r=holedia/2, h=3.5, $fn=10, center=true); 
  translate ([+holedist/2,0,0]) cylinder (r=holedia/2, h=3.5, $fn=10, center=true); 
}

// Outside cutout around the switch
module switchprism_outer() {
  hull() {
    translate ([0,0,0]) cube ([34,9,0.1], center=true) ;
    translate ([0,0,2]) cube ([24,6,0.1], center=true) ;
  }
}

// Inside socket for the switch
module switchprism_inner() {
  hull() {
    translate ([0,0,0]) cube ([36,11,0.1], center=true) ;
    translate ([0,0,1.5]) cube ([27, 9, 0.1], center=true) ;
  }
}


//************************************
//*              Select here what to print
//************************************

//* Antenna holder itself
rotate ([90,0,0]) difference()
{
  union()
  {
    frame() ;
    if (Use_Switch == 1)
       translate ([1,6.8,0]) rotate ([0,90,0]) switchprism_inner() ;
  }
  
  translate([3,24.5,0]) rotate ([90,0,90-23.5])
     cylinder (r1=14,r2=6,h=5.5,$fn=40,center=true);			// Outer groove for socket
  translate([3,24.5,0]) rotate ([90,0,90-23.5]) 
     cylinder (r=6.5/2,h=14,$fn=20,center=true);			    // Antenna socket hole
  translate([10,21.5,0]) rotate ([90,0,90-23.5]) 
     cylinder (r=9.4/2,h=2.05,$fn=6,center=true);				// M6 Nut Hexagon hole
  translate ([0,0,0]) cube ([50,2.2,50], center=true) ;		// Cut ground plate

  if (Use_Switch == 1)
  {
     translate ([1.5,6.8,0]) rotate ([0,-90,0]) switch() ;                 // Subtract Switch Body
     translate ([-3,6.8,0]) rotate ([0,90,0]) switchprism_outer() ;    // Subtract Space for switch lever

     // Text "J" and  "S" below switch slider
     translate ([-1.3,6.8,8]) rotate ([0,-90,0]) write (Text_Right, t=1.5, h=4.2, center=true) ;
     translate ([-1.3,6.8,-8]) rotate ([0,-90,0]) write (Text_Left, t=1.5, h=4.2, center=true) ;
  }

  // Logo in basement
  //  translate ([1.5,7.5,0]) rotate ([0,90,0]) write ("HST 11.2015", t=1.5, h=4.1, center=true) ;
}
