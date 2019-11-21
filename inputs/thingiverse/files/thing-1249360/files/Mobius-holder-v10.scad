//**********************************************
//               Housing for Mobius ActionCam
//  (C) 5.1.2016  Henning Stoecklein  (hestoeck@gmx.de)
//
//   Source code and printed objects based on it
//   may be used freely for private purposes only.
//
//**********************************************
// Changelog incl. previous keycam concepts:
// 19.07.2015   - Parametric Lens diameter and position
// 18.10.2015   - Optimized for Thingiverse Customizer
// 21.12.2015   - Added mount points for Eachine 250 Racequad 
// 05.01.2016   - Conversion based on KEYCAM#808_V8.SCAD
// 06.01.2016   - Geometric adaptions to my Mobius 3 with C lens
//                   - Optional strengthening fins added
// 21.01.2016   - Chamfer at bottom frame, pinhole fixation
//
//**********************************************

//*************** User definable parameters ***************

/* [Object selection] */
// Which objects to show?
visible = "housing" ; // ["all":All objects, "housing":Holder Housing, "socket":Fixation socket]

// Fixation concept
Fixation = 3; // [0:None, 1:M3 Screws, 2:Servo horn, 3:Eachine 250 Racer mount]

// Bottom total cutout?
Cutout = 1 ;  // [0:Solid bottom, 1:Bottom cutout]

// Bottom Frame Cutout X in %
bottomspace_x = 93 ; // [75:96]
    
// Bottom Frame Cutout Y in %
bottomspace_y = 86 ; // [75:96]

// Show ghost objects?
ghosts = 0 ; // [0:No, 1:Yes]

// Add support structure (SD / USB)?
support = 1 ; // [0:No, 1:Yes]

// Optional fixation with M3 screw
M3_fixing = 0 ; // [0:No, 1:Yes]

/* [Lense Tube] */
// Lense tube inner radius
R_Lens = 8.7 ;  // [7.0: Some other Lens, 8.7:Mobius V3 C-Lens]

// Lense tube Y position (relative to center axis)
Y_Lens = -4.8 ; // [0:Centered, -4.8:Mobius V3 C-Lens]

// Lense tube Z position (relative to bottom)
Z_Lens = 9.3; // [8.0: Some other lens, 9.3:Mobius V3 C-Lens]

// Gap around Lens Tube
Lens_Gap = 0.8 ; // [0.6:Very small, 0.8:Small, 1.0:Medium, 1.2:Big, 1.4:Very Big]

// Tube wall thickness around Lens
Lens_Wall = 1.3 ; // [0.8:Very Thin, 1.0:Thin, 1.3:Medium, 1.7:Thick, 2.0:Very Thick]

// Lens tube length
Tube_height = 6; // [2:10]

/* [Mobius Housing] */
// Body Chamfer Resolution (be aware of CPU time!)
Chamfer_Resolution = 6 ; // [4:Sharp, 6:Single Chamfer, 8: Multi Chamfer, 10:Smooth Radius]

// Body Wall Thickness
Body_wall = 1.45 ; // [1.05: Ultra Thin, 1.2:Thin, 1.35:Medium, 1.45:Thick, 1.55:Very Thick]

// Additional Gap between Cam and Housing (x/y)
Gap_XY = 1.0 ; // [1.0:None, 1.02:2% of Size, 1.04:4% of Size, 1.06:6% of Size] 

// Additional Height of Housing related to Cam (z)
Gap_Z = 1.0 ; // [1.0:None, 1.02:2% of Size, 1.04:4% of Size, 1.06:6% of Size] 

// Mobius housing Corner Radius
mob_rad = 3.0 ;

// Mobius X dimension
mob_x = 59 ;

// Mobius Y dimension
mob_y = 36 ;

// Mobius Z dimension
mob_z = 18.5 ;

/* [M3 Socket] */
// Socket screw distance
s_screw = 12 ;  // [8:16]

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

/* [Eachine Racer mount points] */
// Hole distance X
eachine_x = 37 ;

// Hole distance Y
eachine_y = 39 ;

// Hole diameter for rubber damper
eachine_d = 5.8 ;

// Wall radius around holes
eachine_wall = 5 ;

// Thickness of bottom plate
eachine_thick = 2.0 ;

// Rubber damper outer diameter
earubber_d = 9.5 ;

// Rubber damper height
earubber_h = 2.1 ;

// Optional strengthening fins at the side
fins = 1 ; // [0:no side fins, 1:Side fins]

// X position offset
xpos_eachine = 0 ; // [-10:10]

//****************************************************
// Keycam body out of 2 polygon chains (1 mirrored)
//****************************************************
module keycam() 
{
  scale ([Gap_XY, Gap_XY, Gap_Z])
  {
     translate ([mob_x/2, 0, mob_z/2])
 	    roundcube (mob_x, mob_y, mob_z, mob_rad);
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
        hull() {
            roundcube (eachine_x+eachine_d+eachine_wall, eachine_y+eachine_d+eachine_wall, 
                eachine_thick, eachine_d) ;
           roundcube (mob_x, mob_y, eachine_thick, 1) ;
        }

        // Rubber fixing holes
        translate ([eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true,$fn=20) ;
        translate ([eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
        translate ([-eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
        translate ([-eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
        
        // Hole Chamfers on top
        translate ([eachine_x/2, +eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
        translate ([eachine_x/2, -eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
        translate ([-eachine_x/2, +eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
        translate ([-eachine_x/2, -eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;

        // Hole Chamfers on bottom
        translate ([eachine_x/2, +eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;
        translate ([eachine_x/2, -eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;
        translate ([-eachine_x/2, +eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;
        translate ([-eachine_x/2, -eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;

    }
}

//*************************************************
//* Eachine Racequad Fixing Plate - subtracted part
//*************************************************
module eachine_sub() 
{
    rbclh = 3.0 ;        // rubber clearance height
    rcld = 4.4 ;         // rubber clearance min diameter offset
    
    // Rubber fixing holes
    translate ([eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true,$fn=20) ;
    translate ([eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
    translate ([-eachine_x/2, +eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;
    translate ([-eachine_x/2, -eachine_y/2, 0]) cylinder (h=eachine_thick+1, r=eachine_d/2, center=true, $fn=20) ;

     // Hole Chamfers in top
     translate ([eachine_x/2, +eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
     translate ([eachine_x/2, -eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
     translate ([-eachine_x/2, +eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;
     translate ([-eachine_x/2, -eachine_y/2, eachine_thick-1]) cylinder (h=1, r1=eachine_d/2, r2=eachine_d/2+1, center=true,$fn=20) ;

     // Hole Chamfers on bottom
     translate ([eachine_x/2, +eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;
     translate ([eachine_x/2, -eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;
     translate ([-eachine_x/2, +eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;      translate ([-eachine_x/2, -eachine_y/2, -0.9]) cylinder (h=1, r2=eachine_d/2, r1=eachine_d/2+1, center=true,$fn=20) ;

    translate ([eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h+rbclh/2]) 
        cylinder (h=rbclh+0.1, r1=earubber_d/2, r2=earubber_d/2-rcld, center=true,$fn=25) ;

    translate ([eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h+rbclh/2])
        cylinder (h=rbclh+0.1, r1=earubber_d/2, r2=earubber_d/2-rcld, center=true,$fn=25) ;

    translate ([-eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([-eachine_x/2, +eachine_y/2, eachine_thick/2+earubber_h+rbclh/2]) 
        cylinder (h=rbclh+0.1, r1=earubber_d/2, r2=earubber_d/2-rcld, center=true,$fn=25) ;

    translate ([-eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h/2]) 
        cylinder (h=earubber_h, r=earubber_d/2, center=true,$fn=25) ;
    translate ([-eachine_x/2, -eachine_y/2, eachine_thick/2+earubber_h+rbclh/2]) 
        cylinder (h=rbclh+0.1, r1=earubber_d/2, r2=earubber_d/2-rcld, center=true,$fn=25) ;
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
    findist = 11 ;           // X distance of strengthening fins
    findy = 5.5 ;              // Outer Y position / size of fins
    
    difference() {
    union()
    {
      minkocam();
      translate ([0,Y_Lens,Z_Lens]) rotate ([0,90,0])
         cylinder (r1=R_Lens+Lens_Gap+Lens_Wall, r2=R_Lens+Lens_Gap+Lens_Wall+1.6, Tube_height, center=true, $fn=40) ;	 // Lens tube

      if (Fixation == 3)                                   // add selected fixation plate
      {
         translate ([mob_x/2+xpos_eachine,0,-0.2]) eachine_add() ;

         // Add optional strengthening fins at the housing sides
          if (fins == 1) for(i=[-1:1])
         {
           hull()
           {
              translate ([mob_x/2+i*findist,mob_y/2,mob_z/2+0.7]) cylinder (r=0.8, h=mob_z, center=true,$fn=15) ;
              translate ([mob_x/2+i*findist,mob_y/2+findy,0]) cylinder (r=0.8, h=0.1, center=true,$fn=15) ;
              translate ([mob_x/2+i*findist,-mob_y/2,mob_z/2+0.7]) cylinder (r=0.8, h=mob_z, center=true,$fn=15) ;
              translate ([mob_x/2+i*findist,-mob_y/2-findy,0]) cylinder (r=0.8, h=0.1, center=true,$fn=15) ;
           } // hull
         } // for
      } // if eachine
      
      // Add optional dome for fixing screw
      if (M3_fixing == 1)
      {
        hull() {
            translate ([mob_x+1.8, -1.3, mob_z-3/2+0.5]) cylinder (r=2.1, h=3.0+Body_wall, $fn=20, center=true) ;
            translate ([mob_x+0.5, -1.3, mob_z-3/2-8]) cylinder (r=0.5, h=0.1, $fn=20, center=true) ;
        }
      } // if
      
     // Add small domes for fixation needles
     translate ([mob_x-5.3,mob_y/2+1,2.0]) rotate ([90,0,0]) cylinder (r=1.5, h=1.8, center=true, $fn=15) ;
     translate ([mob_x-5.3,-mob_y/2-1,2.0]) rotate ([90,0,0]) cylinder (r=1.5, h=1.8, center=true, $fn=15) ;

      
    } // union

    translate ([0,0,0.9]) scale ([1,1,2]) keycam() ;					// space for cam body
    translate ([mob_x*(100-bottomspace_x)/200,0,-0.5])
       scale ([bottomspace_x/100,bottomspace_y/100,2]) keycam() ;	 // bottom frame

    // Chamfer at bottom 
    hull() {
       translate ([mob_x*(100-bottomspace_x)/200,0,0.2])
           scale ([bottomspace_x/100,bottomspace_y/100,0.01]) keycam() ;
       translate ([mob_x*(100-bottomspace_x)/200,0,0.8])
           scale ([bottomspace_x/98,bottomspace_y/96,0.01]) keycam() ;
    }
 
    if ((Fixation == 3) || (Fixation == 0))
    {
       if (Cutout == 1)
         translate ([mob_x*(100-bottomspace_x)/200,0,-5])
            scale ([bottomspace_x/100,bottomspace_y/100,2]) keycam() ;	 // cutout in bottom 
    }

    if (M3_fixing == 1)                                         // Optional hole for M2.5 fixing screw
       translate ([mob_x+1.8, -1.3, mob_z-3/2+1]) cylinder (r=1.1, h=3.0+Body_wall, $fn=20, center=true) ;

    translate ([0,Y_Lens,Z_Lens]) rotate ([0,90,0]) 
       cylinder (r=R_Lens+Lens_Gap, h=15, center=true, $fn=40) ;		// Lens tube hole

    // SD card slot at the housing backside
    translate ([mob_x, 7.3, 3.0+mob_z/2]) rotate ([0,0,90]) 
    {
      translate ([5.0 , 0, 0]) cube ([4,10,2.5], center=true) ;
      translate ([0 , 0, 0]) cube ([4,10,2.5], center=true) ;
      translate ([-5.0 , 0, 0]) cube ([4,10,2.5], center=true) ;
      if (support == 0) cube ([10,10,2.5], center=true) ;
    }
 
    if (Fixation == 3)                                   // subtracted selected fixation
         translate ([mob_x/2+xpos_eachine,0,-0.2]) eachine_sub() ;

    // Mini-USB slot at the housing backside
    translate ([mob_x, -8.6, 4])  rotate ([0,0,-90])
    {
      hull() { 
        translate ([-3.6, 0, 5.4]) cube ([5.5,5.5,0.5], center=true) ;
        translate ([-3.1, 0, 10.1]) cube ([4.5,5.5,0.5], center=true) ;
        if (support == 0) 
        {
            translate ([0,0, 5.4]) cube ([4,5.5,0.5], center=true) ;
            translate ([0,0, 10.1]) cube ([4,5.5,0.5], center=true) ;
        }
      }
      hull() { 
        translate ([2.8, 0, 5.4]) cube ([5.5,5.5,0.5], center=true) ;
        translate ([2.3, 0, 10.1]) cube ([4.5,5.5,0.5], center=true) ;
      }
    } // rotate
    
    // Red LED opening at rear housing corner
    translate ([mob_x,mob_y/2-3.5,mob_z-2.5]) rotate ([0,90,0]) cylinder (r=1.2, h=10, center=true, $fn=15) ;

    // Two side holes for fixation needles
    translate ([mob_x-5.3,mob_y/2,2.0]) scale ([1,1,1.2]) rotate ([90,0,0]) cylinder (r=0.65, h=10, center=true, $fn=15) ;
    translate ([mob_x-5.3,-mob_y/2,2.0]) scale ([1,1,1.2]) rotate ([90,0,0]) cylinder (r=0.65, h=10, center=true, $fn=15) ;
    
  } // difference
  
  // Strengthening bars in the basement
  if ((Fixation != 3) && (Fixation != 0))                    // only if no EACHINE or NONE fixing
  {
//    if (Cutout == 0)                                         // and no bottom cutout
      difference()
      {
        union()
        {
           translate ([mob_x/2, 0, 0]) cube ([8, mob_y, 1.8], center=true) ;
           translate ([mob_x/2, 0, 0]) cube ([mob_x, 10, 1.8], center=true) ;
        }

        translate ([0,Y_Lens,Z_Lens]) rotate ([0,90,0])                 // Subtract lens tube 
           cylinder (r=R_Lens+Lens_Gap, h=10, center=true, $fn=40) ;		// again
      }
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
        translate ([mob_x/2-s_screw,0, zoffs]) cylinder (r=scydia/2, h=sht, center=true, $fn=20);
        translate ([mob_x/2-s_screw,0, zoffs-sht/2-1]) cylinder (r1=2,r2=scydia/2,h=2, center=true, $fn=20);
        translate ([mob_x/2+s_screw,0, zoffs]) cylinder (r=scydia/2, h=sht, center=true, $fn=20);
        translate ([mob_x/2+s_screw,0,zoffs-sht/2-1]) cylinder (r1=2,r2=scydia/2,h=2, center=true, $fn=20);

	    // Plate inbetween
        translate ([mob_x/2,0,zoffs-1]) cube ([2*s_screw,1.2,sht+2], center=true) ;

        // Ground plate
	    hull() {
          translate ([mob_x/2-s_screw,0,zoffs+sht/2]) cylinder (r=spldia/2, h=splthk, center=true, $fn=40);
          translate ([mob_x/2+s_screw,0,zoffs+sht/2]) cylinder (r=spldia/2, h=splthk, center=true, $fn=40);
	    } // hull
      } // union
      
      // Thread core holes with chamfers
      translate ([mob_x/2-s_screw,0,zoffs]) cylinder (r=rthr, h=sht+5, center=true, $fn=20);
      translate ([mob_x/2-s_screw,0,zoffs+0.5+sht/2]) cylinder (r1=rthr,r2=3,h=2,center=true, $fn=20);
      translate ([mob_x/2+s_screw,0,zoffs]) cylinder (r=rthr, h=sht+5, center=true, $fn=20);
      translate ([mob_x/2+s_screw,0,zoffs+0.5+sht/2]) cylinder (r1=rthr,r2=3,h=2,center=true, $fn=20);
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

    // subtract plane below to get 100% even floor plane
    translate ([30,0,0.3-5-Body_wall]) cube ([100, 100, 10], center=true) ; 

    // subtract objects which fix the housing
    if (Fixation == 1)
    {
       translate ([mob_x/2-s_screw,0,-4]) M3_screw() ;	
       translate ([mob_x/2+s_screw,0,-4]) M3_screw() ;
    }

    if (Fixation == 2)
    {
       translate ([mob_x/2,0,-1.8]) rotate ([0,0,90]) servohorn() ;
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
       translate ([mob_x/2-s_screw,0,18]) %M3_screw() ;
       translate ([mob_x/2+s_screw,0,18]) %M3_screw() ;
   }

   if (Fixation == 2)                                   // show selected fixation ghosts
   {
       translate ([mob_x/2,0,-10]) rotate ([0,0,90]) %servohorn() ;
   }
}

if (visible == "all")
{
    housing() ;
    if (Fixation == 1)
    {
      socket() ;								// Socket for 2 x M3 screws
    }     
}

if (visible == "housing")
{
    housing() ;
}

if (visible == "socket")
{
   socket() ;								// Socket for 2 x M3 screws
}
