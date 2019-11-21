//**********************************************
//       Foldable Nano Quadrocopter "Flixcopter FNQ 220"
//           (C) Henning Stöcklein 2015 - 2016
// 
//  Source Code and created objects are free for private use

// ********** Change log *************************************
// 08.04.2015  - 1st Draft of boom concept with parametric mount
// 01.05.2015  - Arm with motorholder insert, 1st sample print
//  			     - Fixing block with 2 assymetric screw holes
// 02.05.2015  - Screw holes moved to symmetric position
//                  - Chamfers at hinge block and screw holes
//                  - Separate motor holder removed, single part now
//                  - optional support structure at motorholder added
// 03.05.2015  - Cable tunnel for 1811-2000 below rotor bell added
// 04.05.2015  - Frame with "mickey ears" and screw holes for arms
//			        - Movable legs with integrated stop nut holder
//                  - 1st complete print and positive test assembly
// 09.05.2015  - Lower Frame rotated (flat surface below)
//                  - 4 long holes in lower frame, each below a ESC
//                  - battery fixing via 2 bolts (in 2 additional holes)
// 			        - internal bars for ESC fixation and side walls 
// 10.05.2015  - Socket chamfers at internal ESC walls
//                  - Sources for parametric "simple boom" included
//                  - Support structure in motor dome removed
//                  - Exploded view and pure view (optional)
//                  - Sources translated to English
//  17.05.2015 - Optional upper frame with Naze32 31x31 footprint 
//  12.07.2015 - Increase lower walls between ESCs
//                  - Reduce size of lower walls at arm hinge 
//                  - Parametric position of cooling holes 
//                  - Add stopper bars for arm storage position
//                  - Legs strengthened & with const height for sideprint
//                  - Optional coverdome for 31 x 31 footprint added (for GPS, RX etc.)
// 14.07.2015  - Reduce bars between FC domes, increase dome height (room for RX)
//                  - Added Jeti Duplex RMK PPM receiver (ghost)
//                  - Added antenna holder for RSAT receiver 
// 16.07.2015  - Added strengthening tube in motor holder & print supply tube above
// 18.07.2015  - Added holder for 2 Neopixel LEDs, further motor holder strengthening
// 19.07.2015  - Antenna holder moved into frame_upper_31x31, Jeti RSAT adapted
// 22.07.2015  - Motor holder for HK DYS BX1306 motor added 
// 25.07.2015  - Adapter plate for Flip32 mini added
// 23.08.2015  - Cylindrical hinge cutout to reduce cable movement when folding
//                  - BX1306 motor fixing holes with chamfers
//                  - Plush_6A elko position modified (placed on top of ESC)
// 28.02.2016  - Adaption for Customizer: Select Object to print and setup basic dimensions
// 04.03.2016  - Bugfix: Armslots are symmetric now, even with Quad_W > 45°
//                  - Top cover added for Customizer selection
//                  - Some parameters with fine tuneable step size
// 23.04.2016  - Bugfix: Flight Position Stopper Plates. StopperWall, StopperGap added
//      (V24)    - Optional cylindrical fill of Flight position stoppers added (StopperFill).
//
// ******* User definable paramters *******************************

/* [Object to print] */
// Select object to show / print
show = "all" ; // ["all":All parts assembled, "exp":All parts exploded, "boom":Motor boom, "top":Top frame, "bot":Bottom frame, "leg":Leg, "neo":Neopixel holder, "ant":Antenne holder, "cov":top cover plate, "debug":only bottom plate + booms]

// Show additional electronic components
ghosts = 0 ; // [0:w/o electronic parts, 1:With ghost components]

// Select flight controller footprint
FC_footprint = "31x31" ; // ["31x31":Naze32 30.5x30.5mm, "45x45":MultiWii 45x45mm, "none":No footprint]

/* [Frame Dimensions] */
// Frame Basic Length
Quad_L = 90 ;	// [80:150]

// Frame Basic Width
Quad_B = 70 ;	 // [65:100]

// Boom Flight Position Angle
Quad_W = 50 ; // [45:65]

// Jeti RSAT antenna holder on top
ant_holder = 1 ; // [0:w/o antenna holder, 1:with antenna holder]

// Cover dome on top
top_cover = 1 ; // [0:w/o top cover, 1:with top cover]

// Height of 4 Flight Controller screw domes
Dome_H = 6 ;  // [3:0.5:10]

// Geometry of Flight Position Stoppers 
StopperFill = 1 ; // [0:No fill-only stopper blades, 1:Side blades filled]

/* [Boom Dimensions] */
// Motor type
motor_type = "hk1811sup" ; // ["hk1811sup":HK1811 with support, "hk1811":HK1811 without support, "bx1306":BX1306]

// Height of rotor bell
H_Rotor = 7.5 ; // [7.5:7.5 for HK1811 Motor, 10.0:10 Low for BX1306, 12.0:12 High for BX1306]

// Inner radius of motor holder around rotor bell
R_Rotor = 9.7 ; // [9.7:9.7 for HK1811 Motor, 10.0:10.0 for BX1306 Motor]

// Length of boom tube (to motor center, 5" prop: 85, 4" prop: 75) 
L_Arm = 85 ; // [60:120]

// Outer Radius of Boom Cylinder
R_Arm = 4.5 ; // [4.0:0.1:5.0]

// Wall thickness of boom tube
Wall_Arm = 0.9 ; // [0.7:0.1:1.2]

// Ovality factor of boom (H to W ratio in %)
Q_Arm   = 105 ; // [90:120]

// Chamfers at BX1306 motor fixing holes
Hole_chamfers = 1 ; // [0:No chamfers, 1:Chamfers]

// Wall thickness around rotor bell
Wall_Rotor = 1.2 ; // [0.9:0.1:1.5]

// Wall thickness at motor holder socket
Wall_Sockel = 1.5 ; 

/* [Leg dimensions] */
// Wideness of leg
 W_leg = 8.5 ; // [7.5:0.1:12]

// Material thickness of leg
H_leg = 3.2 ; // [2.5:0.1:4.0]

// Length extension of leg
 L_leg = 0 ;  // [0:15] 
 
// Use stop nuts or cut thread yourself
legeco = 0 ; // [1:Thread core hole, 0:M3 stop nut hole]

/* [Top cover  parameters] */
// Cover dome height
h_dome = 7; // [4:15]

// Dome cylinder radius
radome = 3.0 ; // [2:0.1:3.8]

// Border frame height
kragen = 1.5 ; // [1:0.1:3]

/* [Further internal parameters] */
// Height of chamfer below
H_Rotfase = 1 ;				
// Height of cone at lower side of motor holder
H_Rotkegel = 3 ;				
// Motor flange radius 1
R_hold1 = 4.5 ;				
// Motor flange radius 2
R_hold2 = 6 ;
// Motor flange height
H_hold = 8.8 ;				
// Lower flange outside radius (for stiff motor fixing)
R_Naussen = 5.2 ;
// Hole radius for "simple holder"
R_Nabe = 3.0 ;
// Position of M2.5 Motor fixing thread
MFix_z = 2.0 ; // [1.5:0.1:2.5]
// Radius cable channel inside boom
R_cable = 2.9;				
// Propeller Diameter (5"=127, 4"=102, 3"=76)
D_prop = 126 ; // [76:152]
// Hinge length
L_Hinge  = 20; // [18:22]		
// Hinge width
B_Hinge  = 14 ; // [12:16]	
// M3-Screw hole radius
R_Screw = 1.53 ;	 // [1.4:0.05:1.65]
// M3-Screw thread core hole
R_M3core = 1.2 ;
// axial length of chamfer hinge -> boom tube
H_HFase = 3.54 ;				
// axial backstand of internal bar in hinge
stegbak  = 1.0 ;				
// axial length of nose bar in hinge
stegovl  = 5 ;				
// Plate size reduction towards "mickey ears"
Quad_red = 11 ;	
// Thickness of lower frame plate
Quad_H = 1.6;	 // [1.3:0.1:2.0]
// Distance of Arm-End to Frame-Outline
Armbord = 18 ; // [15:18]
// Radius of Mickey Ears 
Quadmic_R = 18.0 ; // [17:20]
// Side walls thickness in lower frame
LowerWall = 1.4 ; // [1.0:0.1:2.0]
// Gap between lower side wall and upper frame
LowerSlot = 0.2 ;	 // [0.15:0.05:0.25]	
// Width of flight position stopper 
StopperWall = 1.6 ; // [1.3:0.1:2.0]
// Gap of flight position stopper to boom
StopperGap = 0.4 ; // [0.1:0.1:0.6]
// Height of storage position stopper 
Stopper_H = 3 ;  // [2.0:0.1:4.0]
// Height of strengthening X-dir bars around FC
QXbar_H = Dome_H*0.65 ; 
// Height of strengthening Y-dir bars around FC (w space for RX)
QYbar_H = 0.5 ;				
// Antenna hole radius
r_antenna = 1.2 ; // [1.2:0.1:1.5]

// *************************************************
// Quadrocopter Motor Arm (adapted for HK 1811-2000 motor)
// *************************************************
module arm_1811(support)
{
    // Hollow motor holder
    difference() {
       union() {
          translate ([0,0,H_Rotfase]) 
			cylinder (r=R_Rotor+Wall_Rotor, h=H_Rotor+Wall_Sockel-H_Rotfase, $fn=60) ;

	    // Cone below rotor bell
          translate ([0,0,-H_Rotkegel/2-H_Rotfase/2]) 
          		cylinder (r2=R_Rotor+Wall_Rotor, r1=R_Naussen, h=H_Rotkegel, $fn=40) ;

          // Flange tube holder with chamfer
          translate ([0,0,-H_hold]) cylinder (r1=R_Naussen, r2=R_Naussen+1, h=H_hold-H_Rotfase, $fn=40) ;
          translate ([0,0,-H_hold-1]) cylinder (r1=R_Naussen-1, r2=R_Naussen, h=1, $fn=40) ;

	    // Cylinder for flange fix screws
          translate ([0,0,-H_hold/2+MFix_z]) rotate ([90,0,0]) scale ([1.4,1,1]) cylinder (r=2.3, h=2*R_Naussen+3, $fn=20, center=true) ;  

          // Oval boom
          scale ([1,Q_Arm/100,1]) translate ([0,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm, h=L_Arm, $fn=40) ;

          // Hinge block
          translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;

          // Chamfer between hinge and boom
          hull() {
             translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
             scale ([1,Q_Arm/100,1]) translate ([L_Arm-L_Hinge-H_HFase,0,R_Arm]) rotate ([0,90,0]) 
			cylinder (r=R_Arm, h=0.1, center=true, $fn=30) ;          
          }

	     // Cable tube below motor holder (outside)
         translate ([9.5,0,+0.2]) rotate ([0,-110,0]) scale ([1.1,1.33*Q_Arm/112,1]) cylinder (r = R_cable+0.9, h=24, $fn=40, center=true) ;
       }
      
       translate ([0,0,Wall_Sockel]) cylinder (r=R_Rotor, h=H_Rotor+0.05, $fn=40) ;			// Around rotor 
       translate ([0,0,-1.85]) cylinder (r2=R_Rotor, r1=R_Nabe-2, h=3.4, $fn=40) ;			// Below rotor, conic hole
       cylinder (r=R_Nabe+0.2, h=50, center=true, $fn=30) ;								// flange hole

       scale ([1,Q_Arm/100,1]) translate ([R_Rotor+Wall_Arm,0,R_Arm]) rotate ([0,90,0]) 			// boom tube hollow with end cap
			cylinder (r=R_Arm-Wall_Arm, h=L_Arm+0.1, $fn=30) ;

      // Cable tube at rotor, rotated part (inside)
      translate ([12.7,0,+0.0]) rotate ([0,-110,0]) scale ([0.72,1.2,1]) cylinder (r = R_cable, h=18, $fn=20, center=true) ;
	 // Cable tube, horizontal part
      translate ([6,0,-0.0]) rotate ([0,91,0]) scale ([0.8,1.3,1]) cylinder (r = 2.2, h=9.5, $fn=20, center=true) ;
      translate ([6.8,0,-0.6]) rotate ([0,91,0]) scale ([1.0,1.3,1]) cylinder (r = 2.2, h=6, $fn=20, center=true) ;

	// Hole for motor fixing screws M2.5
      translate ([0,0,-H_hold/2+MFix_z]) rotate ([90,0,0]) cylinder (r = 0.7, h=30, $fn=20, center=true) ;

	 // 50% wider hole in boom within hinge block, with chamfer
       hull() {
         scale ([1,1.50*Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2+stegbak,0,R_Arm]) rotate ([0,90,0])
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
         scale ([1,Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2-H_HFase/3-1.6,0,R_Arm]) rotate ([0,90,0]) 	
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
       }

       // M3 holes in hinge
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
    
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;

	 // 4 Chamfers at hinge block
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 2*R_Arm]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 2*R_Arm]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 0]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 0]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;    

       // Cylindrical cutout at hinge base for less cable movement when folding
       translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=40) ;
    }

    // Vertical bar with screw holes in hinge block
   difference() { 
     hull() {
       translate ([L_Arm-L_Hinge/2+stegbak/2, 0, R_Arm]) cube ([L_Hinge-stegbak, 1+2*R_Screw, 2*R_Arm-0.5], center=true) ;
       translate ([L_Arm-L_Hinge/2-stegovl, 0, R_Arm]) cube ([L_Hinge, 0.5, 2*R_Arm-0.5], center=true) ;
     }

     // Again 4 M3 screw holes incl chamfers
     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
  } 

  // Strengthening tube in motor dome (only possible together with support tube)
  if (support == 1) 
  {
    difference() { 
       union() {
         translate ([0,0,-1.5]) cylinder (r=R_Nabe+1.5, h=2, $fn=30) ;		    // Strenghtening tube
         translate ([0,0,-0.5]) cylinder (r1=R_Nabe+3, r2=R_Nabe+1.0, h=2, $fn=30) ;  // chamfer
       }
       cylinder (r=R_Nabe+0.2, h=50, center=true, $fn=30) ;								    // Flange hole
       translate ([R_Nabe+1.4,0,0]) scale ([1.3,0.95,1]) cylinder (r=R_cable, h=10, center=true, $fn=30) ;	            // Cable hole
    } // difference 

    // Support-tube in motor dome (can be broken away after print)
    difference() { 
        translate ([0,0,1]) cylinder (r=R_Nabe+0.8, h=H_Rotor+Wall_Sockel-1, $fn=30) ;	// Thin tube
        cylinder (r=R_Nabe+0.2, h=50, center=true, $fn=30) ;								        // Flange hole
        translate ([0,0,0.3]) rotate ([0,0,30]) cube ([10,2.5,4], center = true) ;				// 3 x 2 cutouts
	    translate ([0,0,0.3]) rotate ([0,0,90]) cube ([10,2.5,4], center = true) ;		
	    translate ([0,0,0.3]) rotate ([0,0,150]) cube ([10,2.5,4], center = true) ;
    } // difference

  } // if
}

// ****************************************************
//    Motor Arm for DYS BX1306 HK #66402 (optional)
// ****************************************************
module arm_bx1306()
{
    // Hollow Boom
    difference() {
       union() {
          translate ([0,0,H_Rotfase]) 
			 cylinder (r=R_Rotor+Wall_Rotor, h=H_Rotor+Wall_Sockel-H_Rotfase, $fn=60) ;
          translate ([0,0,H_Rotfase+H_Rotor+0.5]) 
			 cylinder (r1=R_Rotor+Wall_Rotor, r2=R_Rotor+Wall_Rotor-0.6, h=0.6, $fn=60) ;
          cylinder (r1=R_Rotor+Wall_Rotor-H_Rotfase, r2=R_Rotor+Wall_Rotor, h=H_Rotfase, $fn=50) ;
 
          // Strengthening fin between boom and motor dome
          hull() {
              translate ([R_Rotor,0,H_Rotor+1]) rotate ([0,90+36,0]) cylinder (r=0.8, h=10, $fn=10) ;
              translate ([R_Rotor,0,3]) rotate ([0,90,0]) cylinder (r=1.5, h=10, $fn=10) ;
          }
           
          // Oval boom tube
         scale ([1,Q_Arm/100,1]) translate ([0,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm, h=L_Arm, $fn=40) ;

          // Hinge block
          translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;

          // Chamfer between hinge and boom
          hull() {
             translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
             scale ([1,Q_Arm/100,1]) translate ([L_Arm-L_Hinge-H_HFase,0,R_Arm]) rotate ([0,90,0]) 
			cylinder (r=R_Arm, h=0.1, center=true, $fn=30) ;          
          } // hull
       } // union
      
       translate ([0,0,Wall_Sockel]) cylinder (r=R_Rotor, h=H_Rotor+1.01, $fn=30) ;		// rotor hole
       translate ([0,0,0.5]) cylinder (r=5.5/2, h=2, $fn=30) ;	                                    // center groove
       scale ([1,Q_Arm/100,1]) translate ([8,0,R_Arm]) rotate ([0,90,0]) 						    // tube boom hole
			cylinder (r=R_Arm-Wall_Arm, h=L_Arm+0.1, $fn=30) ;
       scale ([1,Q_Arm/100,1]) translate ([8-6+0.1,0,R_Arm]) rotate ([0,90,0]) 					// tube boom hole
			cylinder (r2=R_Arm-Wall_Arm, r1=R_Arm-Wall_Arm-1.5, h=6, $fn=30) ;

       // 4 holes in boom bottom for fixing screws, with optional chamfers
       for (i= [0:3]) {
           assign (rot = i*90) rotate ([0,0,45+rot]) 
           {
             translate ([12/2, 0, -1]) cylinder (r=2.3/2, h=10, $fn=20) ;                         // hole
             if (Hole_chamfers == 1)
                 translate ([12/2, 0, -0.1]) cylinder (r2=2.3/2, r1=2.3/2+1, h=1, $fn=20) ;     // chamfer
           } // rotate
       } // for

	 // 50% wider hole in hinge block
       hull() {
         scale ([1,1.50*Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2+stegbak,0,R_Arm]) rotate ([0,90,0])
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
         scale ([1,Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2-H_HFase/3,0,R_Arm]) rotate ([0,90,0]) 	
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
       }

       // M3 holes
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

       // M3 chamfers
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
       translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;

	 // 4 Hinge chamfers
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 2*R_Arm]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 2*R_Arm]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 0]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 0]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       
       // Cylindrical cutout at hinge base for less cable movement when folding
       translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=40) ;
    }

    // Vertical bar in hinge block
   difference() { 
     hull() {
       translate ([L_Arm-L_Hinge/2+stegbak/2, 0, R_Arm]) cube ([L_Hinge-stegbak, 1+2*R_Screw, 2*R_Arm-0.5], center=true) ;
       translate ([L_Arm-L_Hinge/2-stegovl, 0, R_Arm]) cube ([L_Hinge, 0.5, 2*R_Arm-0.5], center=true) ;
     }

     // Again M3 holes incl chamfers
     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
     translate ([L_Arm-L_Hinge/2-L_Hinge/3+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+1, h=1, center=true, $fn=20) ;
     
       // Again cylindrical cutout at hinge base for less cable movement
      translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=40) ;
  }
}

// *************************************************
// Boom with selected motor flange
// *************************************************
module boom()
{
   if (motor_type == "hk1811sup") arm_1811(1) ;
   if (motor_type == "hk1811") arm_1811(0) ;
   if (motor_type == "bx1306") arm_bx1306() ;
}


// *************************************************
// Drill 2 Holes for Motor Arm (same coordinate system as the arm)
// *************************************************
module armslots(startw, endw)
{
      cylinder (r=R_Screw, h=20, center=true, $fn=20) ;									// anchor point
   
      for (angle = [startw : 10 : endw-10])												// Long hole
      {
          hull() {
             rotate ([0,0,angle]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
             rotate ([0,0,angle+10]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
          }
      }

      hull() {																			// Rest in long hole...
          rotate ([0,0,endw]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
          rotate ([0,0,endw-10]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
      }
}

// *************************************************
//   Module "Rounded Cube"
// *************************************************
module roundcube (x, y, z, rad)
{
    hull() {
      translate ([-x/2+rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([-x/2+rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=30) ;
    }
}

// *************************************************
//   Frame Basis Geometry with all holes for motor Arms
// *************************************************
module frame_basis()
{
    difference()
    {
        union()
        {
             cube ([Quad_L-Quad_red, Quad_B-Quad_red, Quad_H], center=true) ;
             translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R, h=Quad_H, center=true, $fn=50) ;
             translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R, h=Quad_H, center=true, $fn=50) ;
             translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R, h=Quad_H, center=true, $fn=50) ;
             translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R, h=Quad_H, center=true, $fn=50) ;
         } // union
         
         // 4 slot footprints for the arms
         translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) rotate ([0,0,-90]) armslots (0, Quad_W) ;
         translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) rotate ([0,0,90-Quad_W]) armslots (0, Quad_W) ;
          translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) rotate ([0,0,-90-Quad_W]) armslots (0, Quad_W) ;
         translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) rotate ([0,0,90]) armslots (0, Quad_W) ;
   } // diff
}

// *************************************************
//    Lower Frame Shell
// *************************************************
module frame_lower()
{
    difference ()
    {
      frame_basis() ;

	 // Cooling / weight reduction holes in the middle under the ESC's
      hull() {
          translate ([ 45/2-16, Quad_B/9, 0]) cylinder (r=4.5, h=15, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/9, 0]) cylinder (r=4.5, h=15, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/9, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/9, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }

      translate ([24,0,0]) cylinder (r=7, h=10, $fn=20, center=true) ;			// weight red holes between arms
      translate ([-24,0,0]) cylinder (r=7, h=10, $fn=20, center=true) ;
    }

   // Battery rubber bolts with 2 sided chamfers
   translate ([20,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r=1.5, h=9, $fn=20, center=true);
   translate ([20+9/2+1.4/2,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r1=1.5, r2=0.8, h=1.4, $fn=20, center=true);
   translate ([20-9/2-1.4/2,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r2=1.5, r1=0.8, h=1.4, $fn=20, center=true);
   translate ([-20,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r=1.5, h=9, $fn=20, center=true);
   translate ([-20+9/2+1.4/2,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r1=1.5, r2=0.8, h=1.4, $fn=20, center=true);
   translate ([-20-9/2-1.4/2,0,1.5/2]) rotate ([0,90,0]) scale ([1,1.6,1]) cylinder (r2=1.5, r1=0.8, h=1.4, $fn=20, center=true);

   // Side walls 
   difference ()
   {
     union()
     {
         translate ([0,(Quad_B-Quad_red-LowerWall)/2, Quad_H/2+R_Arm-LowerSlot/2]) 
            cube ([Quad_L-36, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
        translate ([0,-(Quad_B-Quad_red-LowerWall)/2, Quad_H/2+R_Arm-LowerSlot/2]) 
            cube ([Quad_L-36, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
     }

    // Subtract Arms stopper plates for flight position
    translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,-180+Quad_W]) translate ([-9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,-Quad_W]) translate ([9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,+Quad_W]) translate ([-9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,-Quad_W]) translate ([-9, B_Hinge/2-10+StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
   }

   // Flight position Stopper blades cylindrical fill?
   // Create these as intersection of mickey ears with stopper blade hull of one side
   if (StopperFill > 0)
   {
       clen = 12.5 - (Quad_W - 55)/10 ;      // correction of stopper length

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-180+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
                translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-Quad_W]) translate ([-15, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R, h=20, center=true, $fn=50) ;
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R-LowerWall, h=20, center=true, $fn=50) ;
           } // difference
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-180+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
                translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-Quad_W]) translate ([-15, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R, h=20, center=true, $fn=50) ;
              translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Quadmic_R-LowerWall, h=20, center=true, $fn=50) ;
           } // diff
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,-Quad_W]) translate ([15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R, h=20, center=true, $fn=50) ;
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R-LowerWall, h=20, center=true, $fn=50) ;
           } // diff
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,-Quad_W]) translate ([15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R, h=20, center=true, $fn=50) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Quadmic_R-LowerWall, h=20, center=true, $fn=50) ;
           } // diff
       } // intersection
   } // if 

    // Big wall in the middle with extension to the battery rubber bolts
   translate ([0,0, Quad_H/2]) rotate ([45, 0, 0]) cube ([40, 1.8, 1.8], center=true) ;	// socket chamfer
    hull () {
       translate ([0,0, Quad_H/2+R_Arm-LowerSlot/2]) cube ([22, 1.1, 2*R_Arm-LowerSlot], center=true) ;
       translate ([0,0, Quad_H/2+3/2]) cube ([40, 1.4, 2], center=true) ;
    }

   // Two lower inner walls / bars only for ESC fixation
  translate ([0,Quad_B/4.8, Quad_H/2]) rotate ([45, 0, 0]) cube ([30, 1.8, 1.8], center=true) ;	// socket chamfer
   hull () {
      translate ([0,Quad_B/4.8, Quad_H/2+2/2]) cube ([30, 1.3, 2], center=true) ;
      translate ([0,Quad_B/4.8, Quad_H/2+R_Arm]) cube ([22, 1.2, 1.3*R_Arm], center=true) ;
   }
  translate ([0,-Quad_B/4.8, Quad_H/2]) rotate ([45, 0, 0]) cube ([30, 1.8, 1.8], center=true) ;	// socket chamfer
   hull () {
      translate ([0,-Quad_B/4.8, Quad_H/2+2/2]) cube ([30, 1.4, 2], center=true) ;
      translate ([0,-Quad_B/4.8, Quad_H/2+R_Arm]) cube ([22, 1.2, 1.3*R_Arm], center=true) ;
   }

  // Arms stopper plates for flight position, if not replaced by cylindrical fill
//  if (StopperFill < 2)
  {
    translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-180+Quad_W]) translate ([-11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
    translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-Quad_W]) translate ([-11, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
    translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-Quad_W]) translate ([11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
    translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, Quad_H/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,+Quad_W]) translate ([-11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
   }
      
   // Arm stopper bars for storage position
   translate ([Quad_L/2-6,Quad_B/2-Armbord-B_Hinge/2-LowerWall, Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([Quad_L/2-6,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([-Quad_L/2+6,Quad_B/2-Armbord-B_Hinge/2-LowerWall, Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([-Quad_L/2+6,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ;  
}

// *************************************************
//    Upper Frame Shell with 45x45 FC footprint
// *************************************************
module frame_upper_45x45()
{
    difference ()
    {
      frame_basis() ;

	 // Weight reduction holes in the middle
      hull() {
          translate ([ 45/2-12, 45/2-10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
          translate ([-45/2+12,45/2-10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-12, -45/2+10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
          translate ([-45/2+12,-45/2+10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
      }
      
      // Holes for M3 threads
      translate ([+22.5,+22.5,0]) cylinder (r=R_M3core, h=20, $fn=20, center=true) ;
      translate ([+22.5,-22.5,0]) cylinder (r=R_M3core, h=20, $fn=20, center=true) ;
      translate ([-22.5,+22.5,0]) cylinder (r=R_M3core, h=20, $fn=20, center=true) ;
      translate ([-22.5,-22.5,0]) cylinder (r=R_M3core, h=20, $fn=20, center=true) ;	
    } // difference

    // Holder for FC footprint 45x45 (e.g. Crius AIO V2)
   difference() {
      union() {
        translate ([+22.5,+22.5,0]) cylinder (r1=3.2, r2=2.5, h=Dome_H, $fn=20) ;		// Domes for M3 screws
        translate ([+22.5,-22.5,0]) cylinder (r1=3.2, r2=2.5, h=Dome_H, $fn=20) ;
        translate ([-22.5,+22.5,0]) cylinder (r1=3.2, r2=2.5, h=Dome_H, $fn=20) ;
        translate ([-22.5,-22.5,0]) cylinder (r1=3.2, r2=2.5, h=Dome_H, $fn=20) ;

        translate ([+22.5-2.5,0,Quad_H/2+QYbar_H/2]) cube ([1.5, 45, QYbar_H], center=true) ;   // Bars betw FC domes
	    translate ([-22.5+2.5,0,Quad_H/2+QYbar_H/2]) cube ([1.5, 45, QYbar_H], center=true) ;
	    translate ([0,+22.5,     Quad_H/2+QXbar_H/2]) cube ([45, 1.5, QXbar_H], center=true) ;
 	    translate ([0,-22.5,     Quad_H/2+QXbar_H/2]) cube ([45, 1.5, QXbar_H], center=true) ;
      }

      translate ([+22.5,+22.5,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;				// Dome holes for M3 threads
      translate ([+22.5,-22.5,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;
      translate ([-22.5,+22.5,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;
      translate ([-22.5,-22.5,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;	
   }
}

// *************************************************
//    Upper Frame Shell w/o FC footprint
// *************************************************
module frame_upper_blanco()
{
    frame_basis() ;
}

// *************************************************
//    Upper Frame Shell with 30.5 x 30.5 FC footprint
// *************************************************
module frame_upper_31x31()
{
    difference ()
    {
      frame_basis() ;

	  // Holes for M3 threads
      translate ([+30.5/2,+30.5/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;
      translate ([+30.5/2,-30.5/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;
      translate ([-30.5/2,+30.5/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;
      translate ([-30.5/2,-30.5/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;	           

	// Cooling / weight reduction holes in the middle under the ESC's
      hull() {
          translate ([ 45/2-16, Quad_B/9, 0]) cylinder (r=4.5, h=15, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/9, 0]) cylinder (r=4.5, h=15, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/9, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/9, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/3.2, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }

      translate ([25,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;			// weight red holes between arms
      translate ([-25,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;     
    } // difference

    // Holder for FC footprint 30.5x30.5 (e.g. Naze32)
   difference() {
      union() {
        translate ([+30.5/2,+30.5/2,0]) cylinder (r1=3.4, r2=2.6, h=Dome_H, $fn=20) ;		// Domes for M3 screws
        translate ([+30.5/2,-30.5/2,0]) cylinder (r1=3.4, r2=2.6, h=Dome_H, $fn=20) ;
        translate ([-30.5/2,+30.5/2,0]) cylinder (r1=3.4, r2=2.6, h=Dome_H, $fn=20) ;
        translate ([-30.5/2,-30.5/2,0]) cylinder (r1=3.4, r2=2.6, h=Dome_H, $fn=20) ;

	    translate ([+30.5/2,0,Quad_H/2+QYbar_H/2]) cube ([1.5, 30.5, QYbar_H], center=true) ;   // Bars betw FC domes
	    translate ([-30.5/2,0,Quad_H/2+QYbar_H/2]) cube ([1.5, 30.5, QYbar_H], center=true) ;
 	    translate ([0,+30.5/2-1,Quad_H/2+QXbar_H/2]) cube ([30.5, 1.5, QXbar_H], center=true) ;
 	    translate ([0,-30.5/2+1, Quad_H/2+QXbar_H/2]) cube ([30.5, 1.5, QXbar_H], center=true) ;
      } // union
      
      translate ([+30.5/2,+30.5/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;		// Holes for M3 threads
      translate ([+30.5/2,-30.5/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;
      translate ([-30.5/2,+30.5/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;
      translate ([-30.5/2,-30.5/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;	           
   } // difference
}

// *************************************************
//    Upper Frame Shell with selectable FC footprint
// *************************************************
module frame_upper ()
{
    if (FC_footprint == "31x31") frame_upper_31x31() ;
    if (FC_footprint == "45x45") frame_upper_45x45() ;
    if (FC_footprint == "none")  frame_upper_blanco() ;
        
    // Jeti RSAT antenna holder on top
    if (ant_holder == 1) translate ([-35,0,Quad_H/2+2.5]) antenna_holder() ;
}

// *************************************************
//   Variable Cover dome 
// *************************************************
module cover_dome(foot)
{
   // Holder for FC footprint
   difference() {
      union() {
        translate ([0,0,h_dome]) hull() {
            translate ([+foot/2,+foot/2,0]) cylinder (r=radome, h=1.2, $fn=20) ;		// Top plate = Round cube
            translate ([+foot/2,-foot/2,0]) cylinder (r=radome, h=1.2, $fn=20) ;		
            translate ([-foot/2,+foot/2,0]) cylinder (r=radome, h=1.2, $fn=20) ;		
            translate ([-foot/2,-foot/2,0]) cylinder (r=radome, h=1.2, $fn=20) ;		
        } // hull
        translate ([+foot/2,+foot/2,0]) cylinder (r=radome, h=h_dome, $fn=20) ;		// Domes for M3 screws
        translate ([+foot/2,-foot/2,0]) cylinder (r=radome, h=h_dome, $fn=20) ;
        translate ([-foot/2,+foot/2,0]) cylinder (r=radome, h=h_dome, $fn=20) ;
        translate ([-foot/2,-foot/2,0]) cylinder (r=radome, h=h_dome, $fn=20) ;

        translate ([0,+foot/2+radome-1.2/2,h_dome-1.2/2]) cube ([foot, 1.2, kragen], center=true) ;	// Small side wall
        translate ([0,-foot/2-radome+1.2/2,h_dome-1.2/2]) cube ([foot, 1.2, kragen], center=true) ;	
        translate ([+foot/2+radome-1.2/2,0,h_dome-1.2/2]) cube ([1.2,foot, kragen], center=true) ;	
        translate ([-foot/2-radome+1.2/2,0,h_dome-1.2/2]) cube ([1.2,foot, kragen], center=true) ;	
      } // union
      
      translate ([+foot/2,+foot/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;		// Holes for M3 bolts
      translate ([+foot/2,-foot/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;
      translate ([-foot/2,+foot/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;
      translate ([-foot/2,-foot/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;	           
   } // difference
}

module dome()
{
   if (FC_footprint == "31x31") cover_dome (30.5) ;
   if (FC_footprint == "45x45") cover_dome (45) ;
}

// *************************************************
//    4 spacers for 30.5 x 30.5 FC footprint
// *************************************************
module spacers_31x31()
{
   h_spc = 2.5;
   kragen = 1.0 ;
    
   // Holder for FC footprint 30.5x30.5 (e.g. Naze32)
   difference() {
      union() {
        translate ([+30.5/2,+30.5/2,0]) cylinder (r=2.8, h=h_spc, $fn=20) ;		// Domes for M3 screws
        translate ([+30.5/2,-30.5/2,0]) cylinder (r=2.8, h=h_spc, $fn=20) ;
        translate ([-30.5/2,+30.5/2,0]) cylinder (r=2.8, h=h_spc, $fn=20) ;
        translate ([-30.5/2,-30.5/2,0]) cylinder (r=2.8, h=h_spc, $fn=20) ;

        translate ([0,+30.5/2+2.8-1.2/2,h_spc-1.2/2]) cube ([30.5, 1.2, kragen], center=true) ;	// Small side wall
        translate ([0,-30.5/2-2.8+1.2/2,h_spc-1.2/2]) cube ([30.5, 1.2, kragen], center=true) ;	
        translate ([+30.5/2+2.8-1.2/2,0,h_spc-1.2/2]) cube ([1.2,30.5, kragen], center=true) ;	
        translate ([-30.5/2-2.8+1.2/2,0,h_spc-1.2/2]) cube ([1.2,30.5, kragen], center=true) ;	
      } // union
      
      translate ([+30.5/2,+30.5/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;		// Holes for M3 bolts
      translate ([+30.5/2,-30.5/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;
      translate ([-30.5/2,+30.5/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;
      translate ([-30.5/2,-30.5/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;	           
   } // difference
}

// *************************************************
//         Leg with optional integrated M3 stop nut holder
// *************************************************
module leg()
{
   translate ([L_Arm-L_Hinge/2,0,-Quad_H-H_leg/2]) rotate ([0, 180, 90]) difference() {
      union() {
         hull() {
	      translate ([0,-7,0]) cylinder (r=W_leg/2, h=H_leg, center=true, $fn=30) ;
	      translate ([0,2,0]) cube ([W_leg, 14, H_leg], center=true) ;
	      translate ([0,2,H_leg/2]) rotate ([6,0,0]) cube ([W_leg, 18, 0.1], center=true) ;
	   }
         hull() {
	      translate ([0,9,0]) rotate ([0,90,0]) cylinder (r=H_leg/2, h=W_leg, center=true, $fn=20) ;
	      translate ([0,4,0]) rotate ([0,90,0]) cylinder (r=H_leg/2, h=W_leg, center=true, $fn=20) ;
	      translate ([0,11,1]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.3, h=W_leg, center=true, $fn=20) ;
	   }
         hull() {
	      translate ([0,11,1]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.3, h=W_leg, center=true, $fn=20) ;
	      translate ([0,10,0.7]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.2, h=W_leg, center=true, $fn=20) ;
	      translate ([0,13,2.5]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.3, h=W_leg, center=true, $fn=20) ;
	   }
         hull() {
	      translate ([0,13,2.5]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.3, h=W_leg, center=true, $fn=20) ;
	      translate ([0,15,4.5]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.2, h=W_leg, center=true, $fn=20) ;
	   }
         hull() {
	      translate ([0,15,4.5]) rotate ([0,90,0]) cylinder (r=H_leg/2+0.2, h=W_leg, center=true, $fn=20) ;
	      translate ([0,17,7]) rotate ([0,90,0]) cylinder (r=H_leg/2-0.0, h=W_leg, center=true, $fn=20) ;
	   }
         hull() {
	      translate ([0,17,7]) rotate ([0,90,0]) cylinder (r=H_leg/2-0.0, h=W_leg, center=true, $fn=20) ;
	      translate ([0,22+0.9*L_leg,14+L_leg]) rotate ([0,90,0]) cylinder (r=H_leg/2-0.2, h=W_leg, center=true, $fn=20) ;
	   }

       // Thread threngthening cylinders for ECO, to drill M3 yourself
       if (legeco == 1) {
          translate ([0,-6,2.5]) cylinder (r2=2.4, r1=4.0, h=5, center=true, $fn=20) ;		
          translate ([0,6,2.5]) cylinder (r2=2.4, r1=4.0, h=5, center=true, $fn=20) ;		
       } // if
      } // union

      // Create M3 through holes with stop nut   OR   M3 core thread hole w/o nut
      if (legeco == 1) {
        translate ([0,-6,0]) cylinder (r=1.2, h=20, center=true, $fn=20) ;		// M3 thread core
        translate ([0,6,0]) cylinder (r=1.2, h=20, center=true, $fn=20) ;		// M3 thread core 
      }
      else {    
        translate ([0,-6,0]) cylinder (r=1.6, h=20, center=true, $fn=20) ;		// M3 screw whole
        translate ([0,-6,2]) cylinder (r=6.5/2, h=5, center=true, $fn=6) ;   	// stop nut hole
        translate ([0,6,0]) cylinder (r=1.6, h=20, center=true, $fn=20) ;		// M3 screw whole
        translate ([0,6,2]) cylinder (r=6.5/2, h=5, center=true, $fn=6) ;     	// stop nut hole
      } // else
   }
}


// *************************************************
//         Motor Hobbyking 1811-2000 (#5358)
// *************************************************
module motor_1811()
{
   translate ([0,0,0-9.5])   cylinder (r=1, h=30, $fn=10) ;						// Shaft
   translate ([0,0,1.5-9.5]) cylinder (r=3, h=10, $fn=20) ;						// Stator flange
   translate ([0,0,11-9.5]) cylinder (r=17.5/2, h=7.5, $fn=30) ;					// Rotor bell
   translate ([0,0,16.5-9.5]) cylinder (r=5/2, h=5, $fn=20) ;					// Rotor adaptor
   translate ([0,-2,9.2-9.5]) rotate ([0,90,0]) cylinder (r=0.8, h=20, $fn=10) ;	// Wire 1
   translate ([0, 0,9.2-9.5]) rotate ([0,90,0]) cylinder (r=0.8, h=20, $fn=10) ;	// Wire 2
   translate ([0,+2,9.2-9.5]) rotate ([0,90,0]) cylinder (r=0.8, h=20, $fn=10) ;	// Wire 3 
}

// *************************************************
//         Prop Hobbyking 5x3" (#22753)
// *************************************************
module prop_5x3()
{
   translate ([0,0,12.2]) cylinder (r=3, h=6.5, $fn=15) ;						// Flange
   translate ([0,0,15.2]) cylinder (r=D_prop/2, h=1, $fn=30) ;				// Props
}

// *************************************************
//         ESC Hobbyking Plush 6A, Elko position modified (on top)
// *************************************************
module plush_6a()
{
   cube ([25.5, 12, 1.3], center=true) ;										// PCB
   translate ([-5,0,3.5]) rotate ([0,90,0]) cylinder (r=2.6, h=12, $fn=15) ;		// Elko
}

// *************************************************
//         Flight Controller 45 x 45mm (e.g. Crius AIO Mega V2)
// *************************************************
module fc_45x45()
{
   difference() {
      cube ([55, 52, 1.6], center=true) ;										// PCB
      translate ([+22.5,+22.5,0]) cylinder (r=R_Screw, h=2, $fn=20) ;				// Hole for M3 screw
      translate ([+22.5,-22.5,0]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-22.5,+22.5,0]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-22.5,-22.5,0]) cylinder (r=R_Screw, h=2, $fn=20) ;	
  }
}

// *************************************************
//         Flight Controller 30.5 x 30.5mm (e.g. TimeCop Naze32)
// *************************************************
module fc_31x31()
{
   difference() {
      cube ([35, 35, 1.6], center=true) ;										// PCB
      translate ([+30.5/2,+30.5/2,0]) cylinder (r=R_Screw, h=2, $fn=20) ;			// Hole for M3 screw
      translate ([+30.5/2,-30.5/2,0]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-30.5/2,+30.5/2,0]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-30.5/2,-30.5/2,0]) cylinder (r=R_Screw, h=2, $fn=20) ;	
  }
}

// *************************************************
//         Flight Controller 30.5 x 30.5mm (e.g. TimeCop Naze32)
// *************************************************
module fc()
{
    if (FC_footprint == "31x31") fc_31x31() ;
    if (FC_footprint == "45x45") fc_45x45() ;
}

// *************************************************
//      Adapter for Flight Controller Flip32 Mini to 30.5 x 30.5mm
//           (PCB of flip32 mini is 14.6 x 31.3 x 1.65)
// *************************************************
module fc_flip32mini()
{
   frame = 0.3 ;                                                                            // border around Flip32mini PCB
   mpcb_x = 15.0 ;                                                                        // Flip32 mini PCB dimensions
   mpcb_y = 31.7 ; 

   difference() {
      union() {
         roundcube (36, 36, 1.2, 2) ;										            // instead Naze32 PCB
         translate ([0,0,1]) roundcube (17, 33, 2, 1.5) ;			            // socket for Flip32 mini
      }
      translate ([0,0,1.8]) roundcube (mpcb_x, mpcb_y, 2, 0.5) ;			// PCB cutout for Flip32 mini 
      translate ([0,0,-1]) roundcube (mpcb_x-2*frame, mpcb_y-2*frame, 10, 1.0) ; // hole below PCB

      translate ([+30.5/2,+30.5/2,-1]) cylinder (r=R_Screw, h=2, $fn=20) ;		// Holes for M3 screw
      translate ([+30.5/2,-30.5/2,-1]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-30.5/2,+30.5/2,-1]) cylinder (r=R_Screw, h=2, $fn=20) ;
      translate ([-30.5/2,-30.5/2,-1]) cylinder (r=R_Screw, h=2, $fn=20) ;	
  }
}

// *************************************************
//         Receiver JETI Duplex RMK2 / RSAT2 with short antennas
// *************************************************
module jeti_rsat()
{
      cube ([19, 35, 3], center=true) ;										    // PCB
      // Straight antennas
//      translate ([4, 35/2,0]) rotate ([0,90,60]) cylinder (r=0.7, h=72, $fn=10) ;	            // Antenna 1
//      translate ([-4,35/2,0]) rotate ([0,90,120]) cylinder (r=0.7, h=72, $fn=10) ;            // Antenna 2

      // Bent for antenna holder
      translate ([4, 35/2+14,0]) rotate ([90,0,0]) cylinder (r=0.7, h=14, $fn=10) ;	         // Antenna 1
      translate ([4, 35/2+14,0]) rotate ([0,96,62]) cylinder (r=0.7, h=40, $fn=10) ;

      translate ([-4,35/2+14,0]) rotate ([90,0,0]) cylinder (r=0.7, h=14, $fn=10) ;            // Antenna 2
      translate ([-4,35/2+14,0]) rotate ([0,96,118]) cylinder (r=0.7, h=40, $fn=10) ;
}

// *************************************************
//         Antenna holder for Jeti RMK receiver 
// *************************************************
module antenna_holder()
{
   difference() {
      hull() {                                                                                             // Fixing Block
          translate ([0,0,-2.2]) cube ([5, 24, 1], center=true) ;
          translate ([0,0,2.2]) cube ([5, 16, 0.1], center=true) ;
       }
      translate ([0,-6,0]) rotate ([0,80,25]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;   // Antenna 1
      translate ([0,6,0]) rotate ([0,80,-25]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;   // Antenna 2
       
      hull() {                                                                                          // Weight Reduction
         translate ([0,-3,0]) cylinder (r=1.5, h=20, $fn=20, center=true) ;  
         translate ([0,3,0]) cylinder (r=1.5, h=20, $fn=20, center=true) ;  
      }
   }
}

// *************************************************
//     LED holder for 2x SMD 5050 Neopixel, to be clipsed between front legs
//  interrupt print @z=3mm and place pre-wired LEDs into holder, then resume
// *************************************************
module neopixel_holder()
{
   difference() {
     translate ([0,0,0]) cube ([4, (Quad_B-Armbord-B_Hinge)/2-1, 2*R_Arm], center=true) ;
    
     // Holes for arm stopper bars in storage position
     translate ([0,Quad_B/2-Armbord-B_Hinge/2-LowerWall-0.2, -R_Arm+Stopper_H/2]) 
	  	 cube ([6, LowerWall, Stopper_H], center=true) ; 
     translate ([0,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall-0.2), -R_Arm+Stopper_H/2]) 
		  cube ([6, LowerWall, Stopper_H], center=true) ;  

     // Rect 5x5mm holes for 2 LEDs
      translate ([-1,-3.8,0]) cube ([2.5, 5, 5], center=true) ;   // Front Frame for LED 1
      translate ([-1,3.8,0])  cube ([2.5, 5, 5], center=true) ;   // for LED 2

      translate ([-0.6,-3.8,0]) cube ([2.0, 5.5, 5.5], center=true) ;   // LED 1
      translate ([-0.6,3.8,0])  cube ([2.0, 5.5, 5.5], center=true) ;   // LED 2

     // Holes for wiring inlay
     hull() {
       translate ([0.5,0,1]) rotate ([90,0,0]) cylinder (r=0.9, h=14, $fn=20,center=true) ;
       translate ([0.5,0,2.5]) rotate ([90,0,0]) cylinder (r=0.9, h=14, $fn=20,center=true) ;
       translate ([0.5,0,-2.5]) rotate ([90,0,0]) cylinder (r=0.9, h=14, $fn=20, center=true) ;
     }
      hull() {
        translate ([0.5,-6.5,2.5]) rotate ([90,0,0]) cylinder (r=0.6, h=3, $fn=20,center=true) ;
        translate ([0.5,-6.5,0]) rotate ([90,0,0]) cylinder (r=0.6, h=3, $fn=20,center=true) ;
      } // hull

      // Cable outlet at backside
      hull() {
        translate ([1,-(Quad_B-Armbord-B_Hinge)/4+1.2,2.5]) rotate ([90,0,90]) cylinder (r=0.8, h=3.1, $fn=20,center=true) ;
        translate ([1,-(Quad_B-Armbord-B_Hinge)/4+1.2,0]) rotate ([90,0,90]) cylinder (r=0.8, h=3.1, $fn=20,center=true) ;
        translate ([1,-(Quad_B-Armbord-B_Hinge)/4+0.5,2.5]) rotate ([90,0,90]) cylinder (r=0.8, h=3.1, $fn=20,center=true) ;
        translate ([1,-(Quad_B-Armbord-B_Hinge)/4+0.5,0]) rotate ([90,0,90]) cylinder (r=0.8, h=3.1, $fn=20,center=true) ;
      } // hull
   } // difference
}

// ******************************************************
//      Complete Quadro, booms in flight, with optional ghost motors & props
// ******************************************************
module quadro(angle)
{
  frame_lower() ;
  translate ([0,0,2*R_Arm+1.6]) frame_upper() ;

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) {  boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  { boom() ; leg(); }

   if (top_cover == 1) translate ([0,0,Dome_H+2*R_Arm+1.6]) dome() ;
   
   // If selected, show electronic components as ghosts
   if (ghosts == 1)
   {
      // Motors and props 
      translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0])  { %motor_1811() ; %prop_5x3() ; }
      translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0])  {%motor_1811() ; %prop_5x3() ; }
      translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0])  {%motor_1811() ; %prop_5x3() ; }
      translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  {%motor_1811() ; %prop_5x3(); }

      // 4 ESCs PLUSH 6A between the frames
      %translate ([1,20.5,3]) rotate ([0,0,180]) plush_6a() ;
      %translate ([2, 7,3]) rotate ([0,0,0]) plush_6a() ;
      %translate ([2,-7,3]) rotate ([0,0,0]) plush_6a() ;
      %translate ([1,-20.5,3]) rotate ([0,0,180]) plush_6a() ;

     // Jeti Duplex RMK receiver sandwiched below FC
     %translate ([0,0,14]) rotate ([0,0,90]) jeti_rsat() ;

     // Flight Controller on top
     %translate ([0,0,11.5+Dome_H]) fc() ;
   } // if 
}

// *************************************************
//     Complete Quadro, exploded view with ghosts
// *************************************************
module quadro_exploded(angle)
{
  translate ([0,0,-60]) frame_lower() ;
  translate ([0,0,2*R_Arm]) frame_upper() ;

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) 
	  { translate ([0,0,-20])  boom() ; if (ghosts == 1) %motor_1811() ; translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;   translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;   translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;  translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }

   if (top_cover == 1) translate ([0,0,45]) dome() ;

   if (ghosts == 1)
   {
       // 4 ESCs PLUSH 6A between the frames
       %translate ([1,20.5,3 -40]) rotate ([0,0,180]) plush_6a() ;
       %translate ([2, 7,3    -40]) rotate ([0,0,0]) plush_6a() ;
       %translate ([2,-7,3   -40]) rotate ([0,0,0]) plush_6a() ;
       %translate ([1,-20.5,3-40]) rotate ([0,0,180]) plush_6a() ;

       // Jeti Duplex RMK receiver sandwiched below FC
       %translate ([0,0,14+10]) rotate ([0,0,90]) jeti_rsat() ;
 
      // Flight Controller on top
      %translate ([0,0, 15+20]) fc() ;
   } // if
}

// ******************************************************
//      Only Bottom Plate and Boom arms, for Debugging
// ******************************************************
module quadro_debug(angle)
{
  frame_lower() ;

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
/*
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, Quad_H/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) {  boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, Quad_H/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  { boom() ; leg(); }
*/
}


//******************************************************
//*  Select down here what objects to see / render / print
//*  Remark: Cutaway views ("difference ... ) only for debugging
//******************************************************
// ["all":All parts assembled, "exp":All parts exploded, "boom":Motor boom, "top":Top frame, "bot":Bottom frame, "leg":Leg, "neo":Neopixel holder, "ant":Antenne holder]

if (show == "all") quadro (Quad_W) ;            // 0 = booms in park / Quad_W = in flight
if (show == "exp") quadro_exploded (Quad_W) ;	   // optional: exploded view
if (show == "leg") leg() ;
if (show == "ant") translate ([-35,0,13.5]) antenna_holder() ;         // Jeti RSAT antenna holder
if (show == "neo") translate ([Quad_L/2-8,0,R_Arm]) rotate ([0,0,180]) neopixel_holder() ;
if (show == "boom") boom();
if (show == "bot") frame_lower();
if (show == "top") frame_upper();
if (show == "cov") translate ([0,0,Dome_H+8]) dome();
if (show == "debug") quadro_debug (Quad_W) ;  
    
// quadro (0, ghosts) ;                                         // booms in storage position 

// ******************************************************
//   Cutaway views, only for debugging and documentation purposes
// ******************************************************
difference() {
//  boom (ghosts) ;                                                                       // Arm type depends on motor type
//  translate ([-20,0,0]) cube ([40, 200, 200 ], center=true) ;				// Debug: Motor Dome Vert Cut Y/Z plane
//  translate ([0,-20,0]) cube ([200, 40, 200 ], center=true) ;				// Debug: Motor Dome Vert Cut X/Z plane
//  translate ([0,0,R_Arm+10]) cube ([200, 200, 20 ], center=true) ;		// Debug: Complete Horiz Cut
}

// translate ([0,0,17]) spacers_31x31() ;
// fc_flip32mini() ;
