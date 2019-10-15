//**********************************************
//*    Battery Tray for 4 x AA Cells (Mignon)
//*  Customizable with Thingiverse customizer
//*
//*     Version 2.10.2016 Henning Stöcklein
//*           free for non-commercial use
//*
//* History:
//* 20-DEC-2015: Optional cutout in the middle of each cell to read the battery label
//* 23-DEC-2015: Cell distance factor [%] for extra fat cells
//*                     Optional bottom groove for rubber band
//* 02-OCT-2016: Battery Type selector (d and h joined)
//*                     Custom Cell Type added
//*                     LiIon 18650 and LR44 button cell added
//*                     Height Correction Factor added
//*                     Select Longhole Cutout (none, one side, both sides)
//*                     All numeric parameters customizable with slider controls 
//*                     Added charging cap option (not yet in customizer)
//*
//**********************************************

// What to display?
objects = "TRAY" ; // ["TRAY": Battery tray, "CAP": Charging cap]

// Battery Type
cell_type = "Li-18650" ; // ["A": A Baby, "AA": AA Mignon, "AAA": AAA Micro, "LR44": LR44 button cell, "Li-18650": 18650 LiIon, "Custom": Custom - free]

// Battery cell diameter for "Custom" type
cell_d = 14.1 ;   // [8:0.1:30]

// Battery cell height for "Custom" type
cell_h = 50.0 ;   // [5:0.2:80]

// Radial clearance between cell and wall
gap    = 0.6 ; // [0:0.05:1.5]

// Wall and bottom thickness
wall    = 1.3 ; // [1:0.05:2.5]

// Number of battery cells
numcells = 4 ; // [1:8]

// Cell distance in % of diameter
distance = 105 ; // [95:110]

// Height Correction Factor [%]
h_cor = 100 ; // [90:110]


/* [Longhole Cutout Dimensions] */
// Create longhole view window at half height?
cutoffs = -10 ; // [0:Both sides, -10: Only one side, 100:None]

// View Window Cutout Radius
r_window = 3 ; // [0:0.1:5]

// View Window Cutout Height in %
h_window = 30 ; // [10:60]


/* [Rubber band guide Dimensions] */
// Create guide for rubber band ?
rubberguide = 1 ;  // [0: No, 1: Yes]

// Rubber guide width
guide_w  = 2 ; // [1:0.1:3.5]

// Rubber band width
rubber_w = 4.4  ; // [2:0.1:6]

// Create top groove for rubber band on top ?
rubber_topgroove = 1 ;  // [0: No, 1: Yes]

// Create bottom groove for rubber band on top ?
rubber_botgroove = 1 ;  // [0: No, 1: Yes]

// Groove depth
groove_h = 0.8 ; // [0.0:0.1:2.0]


/* [Charge Cap Dimensions] */
// Cap height
capht = 5 ;  // [3:0.2:15]

// Cap wall and bottom thickness
capwall    = 2.8 ; // [1:0.05:4]

// Cap charge bolt hole diameter
capbolt_d  = 3.5 ; // [2:0.1:4]


//********* end of customizable params ***************

// Select d and h according to selected cell type. Leave "custom" dimensions unchanged...
if (objects == "TRAY") {
  if (cell_type == "A")         tray (25.0, h_cor/100 * 50.0) ;
  if (cell_type == "AA")       tray (14.1, h_cor/100 * 50.0) ;
  if (cell_type == "AAA")      tray (10.4, h_cor/100 * 44.6) ;
  if (cell_type == "LR44")      tray (11.7, h_cor/100 * 5.4) ;
  if (cell_type == "Li-18650") tray (18.3, h_cor/100 * 65.0) ;
  if (cell_type == "Custom")  tray (cell_d, h_cor/100 * cell_h) ;
}

if (objects == "CAP") translate ([0,0,-5]) 
{
  if (cell_type == "A")         chargecap (25.0, capht) ;
  if (cell_type == "AA")       chargecap (14.1, capht) ;
  if (cell_type == "AAA")      chargecap (10.4, capht) ;
  if (cell_type == "LR44")      chargecap (11.7, capht) ;
  if (cell_type == "Li-18650") chargecap (18.3, capht) ;
  if (cell_type == "Custom")  chargecap (cell_d, capht) ;
}


//* Module definition
module tray (cdia, cht)
{
    difference()
    {
        for (i = [0:numcells-1])
            translate ([i*cdia*distance/100,0,0]) 
                cylinder (r=cdia/2 + gap+wall, h=cht+wall, $fn=40) ;
        for (i = [0:numcells-1])
        {
            translate ([i*cdia*distance/100,0,wall]) cylinder (r=cdia/2 + gap, h=cht+wall, $fn=40) ;

            //* Cutout optional longhole window
            if (h_window != 0) hull()
            {
                translate ([i*cdia*distance/100, cutoffs, cht/2+h_window/200*cht]) 
                    rotate ([90,0,0]) cylinder (r=r_window, h=2*cdia, center=true, $fn=25) ;
                translate ([i*cdia*distance/100, cutoffs, cht/2-h_window/200*cht]) 
                    rotate ([90,0,0]) cylinder (r=r_window, h=2*cdia, center=true, $fn=25) ;
            }
            translate ([i*cdia*distance/100,0,wall]) cylinder (r=cdia/2 + gap, h=cht+wall, $fn=40) ;
        }
        translate ([(numcells-1)/2*cdia*distance/100, 0, cht/2+2*wall]) cube ([(numcells-1)*cdia, cdia/2, cht+wall], center=true) ;
        
        if (rubber_topgroove == 1)
          translate ([-cdia-wall, 0, cht+wall+rubber_w-groove_h]) 
             rotate ([0,90,0]) cylinder (r=rubber_w, h=(numcells+1)*cdia, $fn=30) ;

       if (rubber_botgroove == 1)
          translate ([-cdia-wall, 0, -rubber_w+groove_h]) 
             rotate ([0,90,0]) cylinder (r=rubber_w, h=(numcells+1)*cdia, $fn=30) ;
    }   

    if (rubberguide == 1)
    {
        translate ([-cdia*0.53-wall, guide_w/2+rubber_w/2, cht/2+wall/2]) cube ([2.5, guide_w, cht+wall], center=true) ;
        translate ([-cdia*0.53-wall, -guide_w/2-rubber_w/2, cht/2+wall/2]) cube ([2.5, guide_w, cht+wall], center=true) ;
        translate ([(numcells-1)*cdia*distance/100+cdia*0.53+wall, guide_w/2+rubber_w/2, cht/2+wall/2]) cube ([2.5, guide_w, cht+wall], center=true) ;
        translate ([(numcells-1)*cdia*distance/100+cdia*0.53+wall, -guide_w/2-rubber_w/2, cht/2+wall/2]) cube ([2.5, guide_w, cht+wall], center=true) ;
    }
} // module


module chargecap (cdia, cht)
{
    difference()
    {
       union() {
          translate ([0,0,1]) cylinder (r=cdia/2 + gap/2 +2*capwall, h=capht+capwall-1, $fn=40) ;
          translate ([0,0,0]) 
              cylinder (r2=cdia/2+gap/2+2*capwall, r1=cdia/2+gap/2+2*capwall-1, h=1, $fn=40) ;
       }
       translate ([0,0,capwall]) cylinder (r=cdia/2 + gap/2 +capwall, h=capht+0.1, $fn=40) ;

       // M3 thread hole for charge contact
       translate ([0,0,-1]) cylinder (r=capbolt_d/2, 40, $fn=30) ;

       // Slot opening cut
       translate ([0,0,capht/2+capwall]) cube ([50, cdia+wall, capht+0.1], center=true) ;
       translate ([cdia/2+wall+10/2,0,capht/2+capwall]) cube ([10, 50, capht+0.1], center=true) ;
       translate ([-cdia/2-wall-10/2,0,capht/2+capwall]) cube ([10, 50, capht+0.1], center=true) ;
    }
} // module


module battery()
{
    translate ([0,0,wall]) cylinder (r=cdia/2, h=cht, $fn=30) ;
}

// %battery() ;
