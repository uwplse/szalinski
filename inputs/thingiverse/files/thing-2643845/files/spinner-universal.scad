// Parametric Spinner cap for Electric Motor Folding Prop
// Design by Henning Stoecklein 23.2.2014
// Version 13.11.2017 for customizer (default: Epsilon XL3 with 5mm Shaft)
//
// ****** Free Usage for non-commercial use only *******
//
// WARNING: Folding props create high forces - use at your own risc! 

// Cap shape polynomic exponent (1=linear, 2=hyperbolic)
cap_p = 1.6 ; // [1.1:0.05:2.0]

// Spinner radius (unprecise, so try out...)
cap_radius = 19.8  ; // [12:0.5:30]

// Spinner height (unprecise, so try out...)
cap_height= 33;	 // [18:0.5:40]

// Cap wall thickness
thick = 1.1 ; // [0.8:0.1:2.5]

 // Diameter of motor shaft hole
dcenter = 5.4 ; // [4:0.1:12]

// Diameter of 2 axial M2 screw holes
dScrewM2 = 1.6 ; // [1.2:0.1:2.5]

// Distance of 2 axial M2 screw holes
distScrewM2 = 20 ; // [15:0.5:40]

 // Height of center disc
disc_h = 3.0 ; // [2:0.1:4]

// Y width of prop center piece block
zblock_y = 12.6;

// Z cap_height of prop center piece block (0 for glider nose w/o center piece)
zblock_z = 10.5; //  [0:0.1:20]

screw_d = 3.2  ;    // Screw hole diameter
screw_offs = 5.0 ;  // Screw x position offset
hresol = 20;		// cap_height step resolution (15 is OK)
wresol = 3;		// cap mm step angle resolution (3 is OK)

// Thickness of support fins
fin = 1.1 ; // [0.6:0.1:2]

// Thickness of support block
sup = 0.5 ; // [0.4:0.1:0.8]

// Support structure below center piece block cutout
support = 1 ; // [0:No, 1:Yes]

// Cutout for prop center piece (0 = solid spinner for pure glider nose)
centercut = 1 ; // [0:No, 1:Yes]

// Chamfer at bottom outside
bottomchamfer = 1 ; // [0:No, 1:Yes]

// Internal scale factors for cap calculation
step = hresol/cap_radius;
fhe  = cap_height/pow(cap_radius,cap_p);

// *********************************************************
// Select top level object here
spinnercap() ;
//
// *********************************************************

//********* Position of polygon points ********
//             #1                    #2
//        (r+1, (r+1)^p)     (thick+r+1, (r+1)^p))
//
//       #0                 #3
//   (r, r^p)         (thick+r, r^p)
//*************************************

// Function to define cap_height of point on Hyperboloid surface at radius r
function hypt (r)= cap_height-fhe*pow(r,cap_p) ;

// Filled Hyperboloid with inner diameter
module hyperbel_inner()
{
  for (i = [0:hresol-1]) {
     assign (r = i/step)
     polygon (points=
       [[0, fhe*pow(r,cap_p)],
        [0, fhe*pow(r+1/step,cap_p)],
        [r+1/step, fhe*pow(r+1/step,cap_p)],
        [r, fhe*pow(r,cap_p)]],
        paths=[[0,3,2,1]]) ;
  }
}

// Filled Hyperboloid with outer diameter
module hyperbel_outer()
{
  for (i = [0:hresol-1]) {
     assign (r = i/step)
     polygon (points=
       [[0, fhe*pow(r,cap_p)], 
        [0, fhe*pow(r+1/step,cap_p)],
        [thick+r+1/step, fhe*pow(r+1/step,cap_p)],
		[thick+r, fhe*pow(r,cap_p)]],
        paths=[[0,3,2,1]]) ;
  }
}

module spinnercap()
{
  difference() {
    union() 
    {
    spinner() ;

    // Holding Disc with fins and M2 screw holes 
    difference() {
      intersection() {
        union() {
            
          // Center holding disc 
          translate ([0,0, zblock_z+disc_h/2]) cylinder (r=cap_radius, h=disc_h, center=true, $fn=20) ; 
          
         // Fins around center holding disc
         for (i = [0:7])
         {
            rotate ([0,0,27+i*140/8]) hull()
            {
              translate ([8, 0, zblock_z])  cube ([0.1,fin,0.1]) ;
              translate ([cap_radius, 0, zblock_z])  cube ([0.1,fin,0.1]) ;
              translate ([cap_radius, 0, 0]) cube ([0.2,fin,0.1]) ;
            }
            rotate ([0,0,180+27+i*140/8]) hull()
            {
              translate ([8, 0, zblock_z])  cube ([0.1,fin,0.1]) ;
              translate ([cap_radius, 0, zblock_z])  cube ([0.1,fin,0.1]) ;
              translate ([cap_radius, 0, 0]) cube ([0.2,fin,0.1]) ;
            }
          } // for

          // 2 domes for axial M2 screws
          translate ([+distScrewM2/2, 0, zblock_z+disc_h+1.5]) 
                cylinder (r1=3+dScrewM2, r2=1.2+dScrewM2, h=3, center=true, $fn=20) ;
         translate ([-distScrewM2/2, 0, zblock_z+disc_h+1.5]) 
                cylinder (r1=3+dScrewM2, r2=1.2+dScrewM2, h=3, center=true, $fn=20) ;
        } // union

        spinnersurface() ;

      } // intersect

      // Center hole for motor shaft
      translate ([0,0,11.75-4.8/2]) cylinder (r=dcenter/2, h=20, center=true, $fn=20) ;
      
      // M2 axial screw holes
      translate ([+distScrewM2/2, 0, zblock_z+disc_h/2]) cylinder (r=dScrewM2/2, h=12, center=true, $fn=20) ;
      translate ([-distScrewM2/2, 0, zblock_z+disc_h/2]) cylinder (r=dScrewM2/2, h=12, center=true, $fn=20) ;
    } // diff      

/*
    // Chamfer between holding disk and spinner cap
    difference() {
       translate ([0,0, zblock_z-1]) cylinder (r=17, h=2, center=true, $fn=40) ;     // Disk (r see r1 above)
       translate ([0,0, zblock_z-1]) cylinder (r2=14, r1=17, h=2.05, center=true, $fn=40) ;
     }
*/
   } // union
   
   // Bottom chamfer cutout
   if (bottomchamfer == 1)
      for (i = [1:8:360])
          rotate ([0, 0, i]) translate ([1.9+cap_radius, 0, 0]) rotate ([0,-45,0]) cube ([2, 20, 2], center=true) ;

   if (centercut == 1)
   {
      // Cutout for Prop folding centerpiece
      translate ([0, 0, zblock_z/2]) cube ([80, zblock_y, zblock_z], center=true);

      // 2 radial Screw holes
     translate ([-screw_offs, 15, zblock_z-8/2]) rotate ([90,0,0]) cylinder (r=screw_d/2, h=20, center=true, $fn=20) ;
     translate ([+screw_offs,-15, zblock_z-8/2]) rotate ([90,0,0]) cylinder (r=screw_d/2, h=20, center=true, $fn=20) ;
   } // if centercut

  } // union

  // Put support structure under baseblock cutout
  if (support == 1)
  {
    difference () 
    {  
     union () 
     {
      translate ([0, zblock_y*0.22, zblock_z/2]) cube ([2*cap_radius, sup, zblock_z], center=true);
      translate ([-cap_radius+0.5, 0, zblock_z/2]) cube ([sup, 12*0.5, zblock_z], center=true);

      translate ([0, -zblock_y*0.22, zblock_z/2]) cube ([2*cap_radius, sup, zblock_z], center=true);
      translate ([cap_radius-0.5, 0, zblock_z/2]) cube ([sup, 12*0.5, zblock_z], center=true);
    } // union

	// Disassembly break holes near center hole
    translate ([11,-1.3-0.5,10]) cube ([2,1.0,1.0]) ;
    translate ([11,+1.3-0.5,10]) cube ([2,1.0,1.0]) ;

	// Center hole
    translate ([0,0,11.75-4.8/2]) cylinder (r=1+dcenter/2, h=20, center=true, $fn=20) ;

    translate ([-13,-1.3-0.5,10]) cube ([2,1.0,1.0]) ;
    translate ([-13,+1.3-0.5,10]) cube ([2,1.0,1.0]) ;

    translate ([-7.8,-5,7]) cube ([1.0,10,4]) ;
    translate ([6.8,-5,7]) cube ([1.0,10,4]) ;
  } // diff

  difference ()
  {
     translate ([0,0, 11/2]) cylinder (r=7.4, h=11, $fn=8, center=true) ;  // Octagon support dome
     translate ([0,0, 11/2]) cylinder (r=6.8, h=11.05, $fn=8, center=true) ;
      
     // Disassembly break holes
    for (i = [0:20])
       rotate ([0,0,i*360/20])  translate ([5,0,zblock_z-1.5/2]) cube ([3,1.0,1.5]) ;

   } // diff
 } // if support
} // module

// Subtract Outer from Inner hyperbolic shell to create spinner cap
module spinner()
{
  difference() {
    translate ([0,0,cap_height]) rotate ([180,0,0])
      rotate_extrude (convexity = 100, $fa=wresol) hyperbel_outer();
    translate ([0,0,cap_height-thick]) rotate ([180,0,0])
      rotate_extrude (convexity = 100, $fa=wresol) hyperbel_inner();
  }
}

// Define outer hyperbolic shell for boolean cut operations
module spinnersurface()
{
    translate ([0,0,cap_height]) rotate ([180,0,0])
      rotate_extrude (convexity = 100, $fa=wresol) hyperbel_outer();
}
