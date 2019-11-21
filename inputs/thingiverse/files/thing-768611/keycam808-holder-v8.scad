//**********************************************
//               Housing for Keycam 808 #16 
//  (C) 2015  Henning Stoecklein  (hestoeck@gmx.de)
//
//   Source code and printed objects based on it
//   may be used freely for private purposes only.
//
//**********************************************
// Changelog:
// 19.07.2015   - Parametric Lens diameter and position
// 18.10.2015   - Optimized for Thingiverse Customizer
// 21.12.2015   - Added mount points for Eachine 250 Racequad 
//
//**********************************************

use <write/Write.scad>
// fontsize = 8;
// font = "write/orbitron.dxf";

// Digitized table for keycam #808 frame shape
framedata = [ [
[0.0,	0.0	],
[0.1,	1.5	],
[0.2,	2.2	],
[0.3,	2.9	],
[0.4,	3.5	],
[0.5,	4.1	],
[0.7,	5.0	],
[1.0	,	5.9	],
[1.5	,	6.8	],
[2.0	,	7.5	],
[2.5	,	8.0  ],
[3.0	,	8.4	],
[3.5	,	8.72 ],
[4.0	,	8.95	],
[5.0	,	9.3	],
[6.0	,	9.5	],
[7.0	,	9.6	],
[8.0	,	9.61	],
[9.0	,	9.61	],
[10	,	9.62	],
[11	,	9.61	],
[12	,	9.59	],
[13	,	9.55	],
[14	,	9.5	],
[15	,	9.46	],
[16	,	9.38	],
[17	,	9.32	],
[18	,	9.26	],
[19	,	9.15	],
[20	,	9.05	],
[21	,	8.95	],
[22	,	8.79	],
[23	,	8.65	],
[24	,	8.46	],
[25	,	8.29	],
[26	,	8.01	],
[27	,	7.65	],
[28	,	7.1	],
[29	,	6.4	],
[30	,	5.5	],
[30.5,	4.9	],
[31	,	4.1	],
[31.5,	3.0	],
[32	,	1.45	],
[32.1,	0.0	]],
[[0,1,2,3,4,5,6,7,8,9,
 10,11,12,13,14,15,16,17,18,19,
 20,21,22,23,24,25,26,27,28,29,
 30,31,32,33,34,35,36,37,38,39,
 40,41,42,43,44]]] ;

//*************** User definable parameters ***************

/* [Object selection] */

// Which objects to show?
visible = "housing" ; // ["all":All objects, "housing":Holder Housing, "socket":Fixation socket, "clip":Fixation clip]

// Fixation concept
Fixation = 1 ; // [0:None, 1:M3 Screws, 2:Servo horn, 3:Eachine 250 Racequad mount]

// Bottom Cutout?
Cutout = 1 ;  // [0:Solid bottom, 1:Bottom cutout]

// Show ghost objects?
ghosts = 0 ; // [0:No, 1:Yes]

// Add support structure (SD / USB)?
support = 1 ; // [0:No, 1:Yes]


/* [Lense Tube] */

// Lense tube inner radius
R_Lens = 4.4 ;  // [1.8:Pinhole, 3.0:Small Lens, 4.4:Wide Angle (808#16v3), 5.0:Ultra Big]

// Lense tube Y position (relative to center axis)
Y_Lens = -2 ; // [-3:-3, -2:-2 (808#16v3), -1:-1, 0:0, 1:+1, 2:+2, 3:+3]

// Lense tube Z position (relative to bottom)
Z_Lens = 8.5 ; // [6:6.0, 6.5:6.5, 7:7.0, 7.5:7.5, 8:8.0, 8.5:8.5 (808#16v3), 9:9.0]

// Gap around Lens Tube
Lens_Gap = 0.8 ; // [0.6:Very small, 0.8:Small, 1.0:Medium, 1.2:Big, 1.4:Very Big]

// Tube wall thickness around Lens
Lens_Wall = 1.0 ; // [0.8:Very Thin, 1.0:Thin, 1.2:Medium, 1.7:Thick, 2.0:Very Thick]

// Lens tube height
Tube_height = 5; // [2:8]

/* [Keycam Housing] */

// Body Chamfer Resolution (be aware of CPU time!)
Chamfer_Resolution = 6 ; // [4:Sharp, 6:Single Chamfer, 8: Multi Chamfer, 10:Smooth Radius]

// Body Wall Thickness
Body_wall = 1.35 ; // [1.05: Ultra Thin, 1.2:Thin, 1.35:Medium, 1.45:Thick, 1.55:Very Thick]

// Additional Gap between Cam and Housing (x/y)
Gap_XY = 1.0 ; // [1.0:None, 1.02:2% of Size, 1.04:4% of Size, 1.06:6% of Size] 

// Additional Height of Housing related to Cam (z)
Gap_Z = 1.0 ; // [1.0:None, 1.02:2% of Size, 1.04:4% of Size, 1.06:6% of Size] 


/* [M3 Socket] */

// Socket cylinder height
sht = 6 ;		// [5:10]

// Socket cylinder diameter
scydia = 7.5 ;	// [6.5:Very small, 7.0:Small, 7.5:Standard, 8.0:Big, 8.5:Very big]

// Socket ground plane diameter
spldia = 14 ; // [11:16]

// Socket ground plane thickness
splthk = 0.9 ; // [0.8:0.8, 0.85:0.85, 0.9:0.9: 1:1.0, 1.2:1.2, 1.4:1.4, 1.5:1.5]

/* [Servo horn] */

// Horn Center diameter
horn_center_dia = 7.6 ;  // [6.0:8.0]

// Horn Outer diameter
horn_outer_dia = 4.0 ;  // [3.0:5.0]

// Horn X length
horn_x_distance = 33 ;   // [25:42]

// Horn Y length
horn_y_distance = 13.3 ;   // [10:15]

/* [Eachine Racequad mount points] */

// Hole distance X
eachine_x = 37 ;

// Hole distance Y
eachine_y = 39 ;

// Hole diameter for rubber damper
eachine_d = 4.7 ;

// Wall around holes
eachine_wall = 5 ;

// Thickness of hole latch
eachine_thick = 1.6 ;

// Rubber damper outer diameter
earubber_d = 9.5 ;

// Rubber damper height
earubber_h = 2.3 ;

//****************************************************
// Keycam body out of 2 polygon chains (1 mirrored)
//****************************************************
module keycam() 
{
  scale ([1.62*Gap_XY,1.73*Gap_XY,1.75*Gap_Z])
  {
 	 linear_extrude(height=8) polygon(framedata[0],framedata[1]);
    translate ([0,0.015,0]) mirror([0,1,0])
  	   linear_extrude(height=8) polygon(framedata[0],framedata[1]);
  }
}

//***************************************************
// Enlarge body with additional minkowski hull
//***************************************************
module minkocam()
{
  $fn=Chamfer_Resolution ;	// 4=sharp edges, 6=chamfered, 12=with radius
  minkowski()
  {
    keycam () ;
    sphere (r=Body_wall) ;	 	// 1.3 = ca. 1.0mm wall thickness
  }
}

//*************************************************
//* Cube with round edges
//*************************************************
module roundcube (x, y, z, rad)
{
    hull() {
      translate ([-x/2+rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([-x/2+rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
    }
}

//*************************************************
//* Eachine Racequad Fixing Plate - added part
//*************************************************
module eachine_add() 
{
    difference()
    {
        roundcube (eachine_x+eachine_d+eachine_wall, eachine_y+eachine_d+eachine_wall, 
                eachine_thick, eachine_d) ;
        translate ([eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true,$fn=20) ;
        translate ([eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
        translate ([-eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
        translate ([-eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
    }
}

//*************************************************
//* Eachine Racequad Fixing Plate - subtracted part
//*************************************************
module eachine_sub() 
{
    translate ([eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([eachine_x/2, +eachine_y/2, eachine_thick+earubber_h-0.2]) 
        cylinder (h=1.4, r1=earubber_d/2, r2=earubber_d/2-1.5, center=true,$fn=25) ;

    translate ([eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([eachine_x/2, -eachine_y/2, eachine_thick+earubber_h-0.2]) 
        cylinder (h=1.4, r1=earubber_d/2, r2=earubber_d/2-1.5, center=true,$fn=25) ;

    translate ([-eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([-eachine_x/2, +eachine_y/2, eachine_thick+earubber_h-0.2]) 
        cylinder (h=1.4, r1=earubber_d/2, r2=earubber_d/2-1.5, center=true,$fn=25) ;

    translate ([-eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([-eachine_x/2, -eachine_y/2, eachine_thick+earubber_h-0.2]) 
        cylinder (h=1.4, r1=earubber_d/2, r2=earubber_d/2-1.5, center=true,$fn=25) ;
}

//*************************************************
//* Servo horn as optional fixation object
//*************************************************
module servohorn()
{
  horn_height = 1.6 ;
    
  cylinder (r=horn_center_dia/2, h=3.05, center=true, $fn=20);
  hull() 
  { 
    translate ([0,0,2]) cylinder (r=horn_center_dia/2, h=horn_height, center=true, $fn=20);
    translate ([0,horn_x_distance/2,2]) cylinder (r=horn_outer_dia/2, h=horn_height, center=true, $fn=20);
    translate ([0,-horn_x_distance/2,2]) cylinder (r=horn_outer_dia/2, h=horn_height, center=true, $fn=20);
  }
  hull() 
  { 
    translate ([horn_y_distance/2,0,2]) cylinder (r=horn_outer_dia/2, h=horn_height, center=true, $fn=20);
    translate ([-horn_y_distance/2,0,2]) cylinder (r=horn_outer_dia/2, h=horn_height, center=true, $fn=20);
  }
}

//*************************************************
//* M3 screw as optional fixation object
//*************************************************
module M3_screw()
{
  cylinder (r=3.4/2, h=6, center=true, $fn=20);
  translate ([0,0,3+1.45/2]) cylinder (r1=3.4/2, r2=6.5/2, h=1.5, center=true, $fn=20);
  translate ([0,0,3+1.45+0.8/2]) cylinder (r=6.5/2, h=0.8, center=true, $fn=20);
}

//*******************************************************************
// Subtract keycam from increased keycam volume (with minkowsi hull)
//*******************************************************************
module keycamhousing()
{
  difference() {
    union()
    {
      minkocam();
      translate ([0,Y_Lens,Z_Lens]) rotate ([0,90,0])
         cylinder (r1=R_Lens+Lens_Gap+Lens_Wall, r2=R_Lens+Lens_Gap+Lens_Wall+2, Tube_height, center=true, $fn=40) ;	 // Lens tube

      if (Fixation == 3)                                   // add selected fixation plate
           translate ([25,0,-0.4]) eachine_add() ;
    }

    translate ([0,0,0.9]) scale ([1,1,2]) keycam() ;					// space for cam body
    translate ([2,0,-0.5]) scale ([0.91,0.88,2]) keycam() ;				// space in bottom

    if ((Fixation == 3) || (Fixation == 0))
    {
       if (Cutout == 1)
         translate ([2,0,-5]) scale ([0.91,0.88,2]) keycam() ;				// or cutout in bottom
    }

    translate ([0,Y_Lens,Z_Lens]) rotate ([0,90,0]) 
       cylinder (r=R_Lens+Lens_Gap, h=10, center=true, $fn=40) ;		// Lens hole
    translate ([53,0,7]) cube ([4,3,6], center=true) ;  				// clip slot

    translate ([45.5 ,-14,8.5]) cube ([4,10,3], center=true) ;			// SD slot
    translate ([40.5 ,-14,8.5]) cube ([4,10,3], center=true) ;
    translate ([35.5 ,-14,8.5]) cube ([4,10,3], center=true) ;
    if (support == 0) 
    {
        translate ([40.5 ,-14,8.5]) cube ([10,10,3], center=true) ;
    }

    if (Fixation == 3)                                   // subtracted selected fixation
         translate ([25,0,-0.4]) eachine_sub() ;

    hull() { 															// USB slot   
       translate ([10.4,-17,5.4]) cube ([5.5,6,0.5], center=true) ;
       translate ([10.9,-17,10.1]) cube ([4.5,6,0.5], center=true) ;
       if (support == 0) 
       {
            translate ([14,-17,5.4]) cube ([4,6,0.5], center=true) ;
            translate ([14,-17,10.1]) cube ([4,6,0.5], center=true) ;
       }
    }
    hull() { 															// USB slot   
       translate ([16.8,-17,5.4]) cube ([5.5,6,0.5], center=true) ;
       translate ([16.3,-17,10.1]) cube ([4.5,6,0.5], center=true) ;
    }
  } // difference
  
  // Strengthening bars in the basement
  if ((Fixation != 3) && (Fixation != 0))                          // only if no EACHINE or NONE fixing
  {
//      if (Cutout == 0)                                                  // and no bottom cutout
      {
         translate ([25,0,-0.0]) cube ([8,32,1.8],center=true) ;
         translate ([25,0,-0.0]) cube ([50,10,1.8],center=true) ;

         // Logo in basement
         translate ([12.7,9,-0.5]) rotate ([0,0,0]) write ("HST", t=0.4, h=5.2, center=true) ;
         translate ([12.9,-9,-0.5]) rotate ([0,0,0]) write ("2015", t=0.4, h=5.2, center=true) ;
      }
  }
}

//*******************************************
//* Snap-In Clip to fix Keycam at rear end
//*******************************************
module clip() 
{
   difference() 
   {
       hull ()
       {
         translate ([-5,0,0]) cylinder (r=2.5,h=2.8,$fn=15,center=true);
         translate ([-12,0,0]) cylinder (r=2.8,h=2.8,$fn=15,center=true);
       }
       translate ([-8.5,0,0]) cube ([6,1.5,6], center=true) ;  // slot
       translate ([-7.2,1.6,0]) cube ([3.0,3.6,4], center=true) ;
       translate ([-4,3.1,0]) cube ([8,4,6], center=true) ;
       translate ([-4,2.9,0]) rotate ([0,0,-18]) cube ([6,4,6], center=true) ;
   }
}

//***********************************************
//* Threaded socket to glue into foamy aircraft 
//***********************************************
module socket() 
{
   rthr = 1.3;		// Thread core hole radius (M3 = core 2.5mm)
   zoffs   = -25 ;	// z position

   difference()
   {
      union() 
      {
	    // 2 domes with chamfered end caps
        translate ([16,0, zoffs]) cylinder (r=scydia/2, h=sht, center=true, $fn=20);
        translate ([16,0, zoffs-sht/2-1]) cylinder (r1=2,r2=scydia/2,h=2, center=true, $fn=20);
        translate ([34,0, zoffs]) cylinder (r=scydia/2, h=sht, center=true, $fn=20);
        translate ([34,0,zoffs-sht/2-1]) cylinder (r1=2,r2=scydia/2,h=2, center=true, $fn=20);

	    // Plate inbetween
        translate ([25,0,zoffs-1]) cube ([14,1.2,sht+2], center=true) ;

        // Ground plate
	    hull() {
          translate ([16,0,zoffs+sht/2]) cylinder (r=spldia/2, h=splthk, center=true, $fn=40);
          translate ([34,0,zoffs+sht/2]) cylinder (r=spldia/2, h=splthk, center=true, $fn=40);
	    } // hull
      } // union
      
      // Thread core holes with chamfers
      translate ([16,0,zoffs]) cylinder (r=rthr, h=sht+5, center=true, $fn=20);
      translate ([16,0,zoffs+0.5+sht/2]) cylinder (r1=rthr,r2=3,h=2,center=true, $fn=20);
      translate ([34,0,zoffs]) cylinder (r=rthr, h=sht+5, center=true, $fn=20);
      translate ([34,0,zoffs+0.5+sht/2]) cylinder (r1=rthr,r2=3,h=2,center=true, $fn=20);
   } // diff
}

//********************************
//  Complete Housing with fixation socket
//********************************
module housing()
{
  difference()
  {
    keycamhousing();						// the keycam housing itself

    // subtract objects which fix the housing
    if (Fixation == 1)
    {
       translate ([16,0,-4]) M3_screw() ;	
       translate ([34,0,-4]) M3_screw() ;
    }

    if (Fixation == 2)
    {
       translate ([25,0,-1.8]) rotate ([0,0,90]) servohorn() ;
    }
  } // difference
} // module


//****************************************
// Select here what to see
//****************************************
if (ghosts == 1)
{
   translate ([0,0,30]) %keycam() ;				// show the keycams ghost
   if (Fixation == 1)
   {
       translate ([16,0,18]) %M3_screw() ;
       translate ([34,0,18]) %M3_screw() ;
   }

   if (Fixation == 2)                                   // show selected fixation ghosts
   {
       translate ([25,0,-10]) rotate ([0,0,90]) %servohorn() ;
   }
}

if (visible == "all")
{
    housing() ;
    translate ([60,0,4]) rotate ([0,90,90]) clip() ; 	// 60 = display pos / 52.7 = working
    if (Fixation == 1)
    {
      socket() ;								// Socket for 2 x M3 screws
    }     
}

if (visible == "housing")
{
    housing() ;
}

if (visible == "clip")
{
    translate ([60,0,4]) rotate ([0,90,90]) clip() ; 	// 60 = display pos
}

if (visible == "socket")
{
   socket() ;								// Socket for 2 x M3 screws
}
