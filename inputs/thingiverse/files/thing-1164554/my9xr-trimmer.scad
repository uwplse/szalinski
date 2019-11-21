//**************************************************
//*  Trim button block to retrofit into MPX Profi transmitter gimbal 
//*  28.11.2014 Henning Stoecklein - free for noncemmercial use
//**************************************************

// Show ghost objects?
ghost = 0 ; // [0:No ghosts, 1:Show additional objects]

// Make cable holder?
cable_holder = 1 ; // [0:No holder, 1:Make cable holder hole]

// Basic gimbal adapter dimension X
blx = 53 ;

// Basic gimbal adapter dimension Y
blh = 5.5;

// Trim lever button knob width
trimx = 6; // [4:8]

// Trim lever button knob height
knob_height = 1.2 ;

// Trim button travel restriction block height
travel = 5.5 ;

// Trim lever height (don't change)
trimy = 8.5;

// Microswitch fixation snap height
snap_height = 0.6 ;

// Cutout radius for integrated lever hinge (2.2 = hard, 2.6 = soft)
hinge_cutout = 2.3;

stegx = 29 ;
bspc  = 6.6 ;

// Trimmerblock
module 9xr_trimmer()
{
	// Basisblock
   difference() {
     union()
     {
		 hull() {
		   translate ([5.5,5.5,0]) cylinder (r=5.5, h=blh, $fn=30) ;
		   translate ([blx-5.5,5.5,0]) cylinder (r=5.5, h=blh, $fn=30) ;
		 }

        // Fixing blocks for Micro switches
        translate ([38-8/2,-4,0]) cube ([8, 6, 8]);
        translate ([15-8/2,-4,0]) cube ([8, 6, 8]);
        
         // Bar in between
        translate ([(blx-30)/2,0,0]) cube ([30, 2, 8]);
         
        // Cable holder
        if (cable_holder == 1)
           translate ([blx/2,11,blh]) rotate ([90,0,0]) cylinder (r=2, h=2, $fn=15);
     }

	  // 4-edge-holes and holes for micro switch
     translate ([38-bspc/2,-3.5,0.5]) cube ([bspc, 8, bspc]);
     translate ([15-bspc/2,-3.5,0.5]) cube ([bspc, 8, bspc]);
     translate ([38,4,3.7]) rotate ([90,0,0]) cylinder (r=2, h=10, $fn=20);
     translate ([15,4,3.7]) rotate ([90,0,0]) cylinder (r=2, h=10, $fn=20);

	  // Screw holes
     translate ([(blx-45.2)/2,5.5,-0.1]) cylinder (r=3.3/2, h=6, $fn=20) ;
     translate ([(blx-45.2)/2+45.2,5.5,-0.1]) cylinder (r=3.3/2, h=6, $fn=20);

	  // Chamfers 
     translate ([(blx-45.2)/2,5.5,-0.9]) cylinder (r1=3, r2=1, h=2, $fn=20);
     translate ([(blx-45.2)/2+45.2,5.5,-0.9]) cylinder (r1=3, r2=1, h=2, $fn=20);
		
	  // Big long hole 
     hull() 
     {
       translate ([blx*0.2,5.5,-0.1]) cylinder (r=3.5, h=10, $fn=20);
       translate ([blx*0.8,5.5,-0.1]) cylinder (r=3.5, h=10, $fn=20);
     }

     // Hole in cable holder if required 
     if (cable_holder ==1) 
        hull() 
        {
	       translate ([blx/2,12,blh]) rotate ([90,0,0]) cylinder (r=0.6, h=4, $fn=15);
	       translate ([blx/2,12,blh-2.5]) rotate ([90,0,0]) cylinder (r=0.6, h=4, $fn=15);
	     }
   }
 
   // Ramp clips for Snap-in switch fixation
   hull() {
	  translate ([38-2.5/2,0.5,0.5]) cube ([2.5, 0.05, snap_height]);
	  translate ([38-2.5/2,1.95,0.5]) cube ([2.5, 0.05, 0.05]);
   }
   hull() {
	  translate ([15-2.5/2,0.5,0.5]) cube ([2.5, 0.05, snap_height]);
	  translate ([15-2.5/2,1.95,0.5]) cube ([2.5, 0.05, 0.05]);
   }

	// Clips for switch fixation
   translate ([15+2.6,0.55,bspc+0.5]) rotate ([0,45,0]) cube ([1.2, 1.45, 0.5]);
   translate ([15+3.2-bspc,0.55,bspc-0.3]) rotate ([0,-45,0]) #cube ([1.2, 1.45, 0.5]);
   translate ([38+2.6,0.55,bspc+0.5]) rotate ([0,45,0]) #cube ([1.2, 1.45, 0.5]);
   translate ([38+3.2-bspc,0.55,bspc-0.3]) rotate ([0,-45,0]) #cube ([1.2, 1.45, 0.5]);
 
	// Operation Lever
   translate ([38-5/2,-8.1,0]) cube ([5, 1.4, 5.5]) ;
   translate ([15-5/2,-8.1,0]) cube ([5, 1.4, 5.5]) ;

 	// End block to constrain lever travel
   translate ([38-5/2,-travel,0]) cube ([5, 1.5, 1.5]) ;
   translate ([15-5/2,-travel,0]) cube ([5, 1.5, 1.5]) ;

   // Hole for hinge
   difference() 
   {
     union() {
       translate ([(blx-5)/2,-8,0]) cube ([5, 8, 4.6]) ;		// Hinge block

       // Connecting rod between 2 trim switches
       hull() {
			translate ([(blx-stegx)/2,-trimy,0]) cube ([stegx, 1, 4.6]) ;
     		translate ([(blx-stegx)/2,-trimy-3,0.9]) cube ([stegx, 0.5, 3.1]) ;
		 }
     }
 
     translate ([blx/2-3.2,-7.8,-0.1]) cylinder (r=hinge_cutout, h=10, $fn=30);
     translate ([blx/2+3.2,-7.8,-0.1]) cylinder (r=hinge_cutout, h=10, $fn=30);
   }

   // Trim button (Prism)
   hull() {
     translate ([1+(blx-30)/2,-trimy-3,(blh-3.7)/2]) cube ([trimx, 0.1, 3.1]) ;
     translate ([1+(blx-30)/2,-trimy-7,(blh-1.4)/2]) cube ([trimx, 0.1, knob_height]) ;
   }
   hull() {
     translate ([(blx-30)/2+29-trimx,-trimy-3,(blh-3.7)/2]) cube ([trimx, 1, 3.1]) ;
     translate ([(blx-30)/2+29-trimx,-trimy-7,(blh-1.4)/2]) cube ([trimx, 1, knob_height]) ;
   }
}

module smd_taster()
{
   cube ([5, 5, 1.2], center=true) ;
   translate ([0,0,0.2]) cylinder (r=1, h=1.5, $fn=20, center=true) ;
}

module taster()
{
   cube ([6.2, 6.2, 3.5], center=true) ;
   translate ([0,0,1.6]) cylinder (r=3.4/2, h=6.7, $fn=20, center=true) ;
}

9xr_trimmer() ;

if (ghost == 1)
{
  rotate ([90,0,0]) translate ([(blx-23)/2-0,3.5]) %taster() ;
  rotate ([90,0,0]) translate ([(blx+23)/2+0,3.5]) %taster() ;
}
