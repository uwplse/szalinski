//*******************************
//* Holding clip for Stepper Motor Cable
//* Design 31.12.2014 Henning Stöcklein
//*     Free for non-commercial use
//*
//* Customizable Version 29.12.2015
//*******************************

use <write/Write.scad>

// Clip height
H_cube = 7 ; // [5:14]

// Clip length
L_cube = 25 ; // [7:25]

// Clip width
W_cube = 10 ; // [8:15]

// Clip body chamfer size
R_Chamf = 1.0 ;

// Cable channel diameter
D_cab = 5.5 ;

// Channel bottom height
H_Bottom = 1.0 ;

// Screw hole distance
D_dist = 13 ; // [10:20]

// Screw dome diameter
D_dome = 8.5 ;

// Screw hole diameter
D_screw = 2.8 ;

// Screw head diameter
D_head = 5.8 ;

// Screw head hole height
H_head = 3 ;

// Screw head chamfer height
H_chamf = 1.2 ;

// Cutaway (for display purposes only)
cutaway = 0 ; // [0:No cutaway, 1:Cutaway display]



// Text mode
text_mode = 1 ; // [0:No text, 1:Embossed text, 2:Added text]

// Text on cable channel
Text = "X axis" ;

// Text size
txt_size = 5 ;

// Text height (z direction)
txt_height = 0.6 ;

//**************** end of  custom parameters *******************

// Cube with chamfers
module minkocube (x, y, z, rd)
{
  minkowski() {
    cube ([x-1.71*rd,y-1.71*rd,z-1.71*rd], center=true) ;
    sphere (r=rd, $fn=6) ;
  }
}

// Screwed Clip 
module clip()
{
  difference() {
    union() {
      minkocube (L_cube, W_cube, H_cube, R_Chamf) ;
      hull() {
        translate ([0,-D_dist/2,0]) cylinder (r=D_dome/2, h=H_cube, center=true, $fn=30) ;
        translate ([0,D_dist/2,0]) cylinder (r=D_dome/2, h=H_cube, center=true, $fn=30) ;
      }
    }
    
    // Screw holes for M2.5
    translate ([0,-D_dist/2,0]) cylinder (r=D_screw/2, h=15, center=true, $fn=20) ;
    translate ([0,D_dist/2,0]) cylinder (r=D_screw/2, h=15, center=true, $fn=20) ;

    // Screw head hole for M2.5
    translate ([0,-D_dist/2, H_cube/2-H_head/2]) cylinder (r=D_head/2, h=H_head+0.05, center=true, $fn=20) ;
    translate ([0, D_dist/2, H_cube/2-H_head/2]) cylinder (r=D_head/2, h=H_head+0.05, center=true, $fn=20) ;

	 // Chamfer at screw head
    translate ([0,-D_dist/2, H_cube/2-H_head-H_chamf/2]) 
           cylinder (r1=D_screw/2, r2=D_head/2, h=H_chamf, center=true, $fn=25) ;
    translate ([0, D_dist/2, H_cube/2-H_head-H_chamf/2])
            cylinder (r1=D_screw/2, r2=D_head/2, h=H_chamf, center=true, $fn=25) ;

    // Cable channel
    hull() {
      translate ([0,0,-H_Bottom]) rotate ([0,90,0]) cylinder (r=D_cab/2, h=80, center=true, $fn=30) ;
      translate ([0,0,-D_cab]) rotate ([0,90,0]) cylinder (r=D_cab/2, h=80, center=true, $fn=30) ;
    }

    // Subtract text on top (mode = emboss)
    if (text_mode == 1)
       translate ([0, 0, H_cube/2]) rotate ([0,0,180]) write (Text, t=txt_height, h=txt_size, center=true) ;
  }

  // Text on top (mode = add)
  if (text_mode == 2)
        translate ([0, 0, H_cube/2]) rotate ([0,0,180]) write (Text, t=txt_height, h=txt_size, center=true) ;
}

difference()
{
    clip();
    if (cutaway == 1) 
       translate ([0, -40, -40]) cube ([80, 80, 80]) ;
}
