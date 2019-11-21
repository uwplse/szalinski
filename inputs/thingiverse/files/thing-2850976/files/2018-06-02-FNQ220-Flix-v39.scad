//**********************************************
//       Foldable Nano Quadrocopter "Flixcopter FNQ 220"
//           (C) Henning Stöcklein 2015 - 2018
// 
//  Source Code and created objects are free for private use

// ********** Change log *************************************
// 08.04.2015  - 1st Draft of boom concept with parametric mount
// 01.05.2015  - Arm with motorholder insert, 1st sample print
//  			     - Fixing block with 2 assymetric screw holes
// 02.05.2015  - Boom screw holes moved to symmetric position
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
//  12.07.2015 - Increase lower walls between ESCs, reduce lower walls at arm hinge 
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
//                  - Top dome/cover added for Customizer selection
//                  - Some parameters with fine tuneable step size (0.1)
// 25.03.2016  - Optional space for up to 7 5x5mm Neopixel in BX1306 motor booms
// 23.04.2016  - Bugfix: Flight Position Stopper Plates. StopperWall, StopperGap added
//      (V24)    - Optional cylindrical fill of Flight position stoppers added (StopperFill).
// 28.04.2016  - Boom variant for BX1306 motor with up to 7 internal Neopixel LEDs 
// 01.05.2016  - Variable cylindrical $FN resolution "FNres"
// 07.01.2017  - Extended Chamfer Feature (3-step) at Arm Hinge of boom_1181 
// 09.01.2017  - Optional: boom_1181 with 3 Neopixel windows
//                  - Top chamfer H_TOPFASE at rotor bell
// 01.11.2017  - New smaller FC footprints for PICOBLX controller etc.
// 19.02.2018  - Further adaptions to smaller footprints
//                  - Antenna holder scaleable and with adapted position
// 21.02.2018  - Antenna holder optional on bottom frame (between legs)
//                   - Front cover optional (between legs)
// 24.02.2018  - Top FC cover optional (optimized for 20x20 FC) 
//                    - FC adapter from 31x31 to 20x20 (PICOBLX) made selectable
//                    - Z position of adapter, flat cover and roof cover adapts in assembled object
//                    - Neopixel motor boom types selectable by flag "NeoBoom" (experimental)
// 02.03.2018   - Leg (eco version) improved with less overhangs and chamfers (printability)
//                    - FC adapter with variable inner footprint
// 04.03.2018   - Top FC roof cover with optional "big side opening" for OMNIBUS USB 
//                   - Liz95Cam_holder added
//  08.03.2018  - BX1306 rotor hole with inside bottom chamfer
//          (V34) - M3 hinge hole chamfer made scalable
//                   - Scalable chamfer on motor side of BX1306 boom
//                   - Internal chamfers in hinge block increased (better cable assembly)
//  11.03.2018  - More rotatoric symmetrical objects clustered into FOR loops
//                   - Rooftop "huge opening" made scalable
//  17.03.2018 - Battery rubber bolts made scalable, z position fixed
//                   - Upper and lower frame thickness separated and made scalable
//                   - Chamfer at lower frame (scalable)
//                   - Lower frame ESC fixing concept selectable (ESC_type)
//                   - Battery rubber bolts selectable in X/Y direction
//  18.03.2018 - Roof cover type "Spherical dome" added as alternative to "tilted roof" 
//  04.04.2018 - Chamfers at both boom sides increased
//                   - Ghost parts for ESC variants updated (4-in-1 ESC 20x20 added) 
//  29.05.2018  - Hole for BX1306 motor center added (V38)
//  02.06.2018  - Hinge Length increased to 21mm for better cable assembly, 
//                     New parameter HingeM3Pos for position of M3 hole in hinge
//                   - Q_Arm default increased to 107% (slightly wider booms) 
//
// *********************** User definable parameters *******************************

/* [(1) Object to print] */
// Select object to show / print
show = "all" ; // ["all":All parts assembled, "exp":All parts exploded, "boom":Motor boom, "top":Top frame, "bot":Bottom frame, "leg":Leg, "neo":Neopixel holder, "cam":FPV videocam holder, "ant":Antenne holder, "cov":top cover plate, "roof": top roof cover, "adap": FC adapter, "debug":only bottom plate + booms]

// Show additional electronic components
ghosts = 0 ; // [0:w/o electronic parts, 1:With ghost components]

// Select flight controller footprint
FC_footprint = 30.5 ; // [15:15x15mm, 16:16x16mm, 20:20x20mm (Pico BLX), 30.5:30.5x30.5mm (Naze32), 45:45x45mm (MultiWii), 0:No footprint]

// Segment resolution of cylinders
FNres = 50 ; // [20:Low for fast preview, 35:Medium, 50:High for Printout, 75:SuperHigh for Freaks]

/* [(2) Frame Dimensions] */
// Frame Basic Length (X)
Quad_L = 90 ;	// [70:150]

// Frame Basic Width (Y)
Quad_B = 70 ;	 // [60:100]

// Boom Flight Position Angle
Quad_W = 50 ; // [45:65]

// Thickness of BOT frame plate
FrBot_h = 1.8 ; // [1.3:0.1:2.5]
// Thickness of TOP frame plate
FrTop_h = 1.6;	 // [1.3:0.1:2.5]

// Height of lower frame outer chamfer
LowerCmf = 0.8 ; // [0:0.1:1.4]
// Height of upper frame outer chamfer
UpperCmf = 0.8 ; // [0:0.1:1.4]

// Neopixel Motor Boom?
NeoBoom = 0 ; // [0:No Neopixel, 1:With Neopixel pockets]

// Jeti RSAT antenna holder
ant_holder = 2 ; // [0:w/o antenna holder, 1:with ant holder on top, 2:with lower ant holder]

// Front cover 
front_cover = 1 ; // [0:w/o light, 1:with front LED housing]
// Front Cover Hole Type
frontcover_hole = 2 ; // [0:w/o hole, 1:Cylindrical hole, 2:Square hole for 1 Neopixel PCB]

//  Show Cover dome on top
top_cover = 0 ; // [0:w/o top cover, 1:with flat top cover]
// Show Roof cover on top
roof_cover = 1 ; // [0:w/o top cover, 1:with roof cover]
// Show FC adapter plate 31x31 to 20x20
FC_adapter = 1 ; // [0:w/o adapter, 1:with adapter]

// Height of 4 Flight Controller screw domes
Dome_H = 4.5 ;  // [3:0.5:10]

// Geometry of Flight Position Stoppers 
StopperFill = 1 ; // [0:No fill-only stopper blades, 1:Side blades filled]

// Diameter of battery rubber bolts
rub_d = 3.4 ; // [2:0.1:3.5]

// Orientation of battery rubber bolts
rub_orient = "XY" ; // ["X":rubber bar into flight direction, "Y":rubber bar rectangular flight direction, "XY":rubber bar in both directions, "none":no rubber bars]

// Fixing concept for ESC in lower frame
ESC_type = "plush6" ; // ["none":Emtpy space, "plush6":3 walls for 4 x Plush6, "20x20":4 domes 20x20 footprint]
// Dome height for 4-in-1 ESC footprint
ESC_domeh = 3 ; // [0:0.1:6]

/* [(3) Boom Dimensions] */
// Motor type
motor_type = "bx1306" ; // ["hk1811sup":HK1811 with support, "hk1811":HK1811 without support, "bx1306":BX1306]

// Height of rotor bell
H_Rotor = 11 ; // [7.5:7.5 for HK1811 Motor, 10:10 Low for BX1306, 11:11 Med for BX1306, 12:12 High for BX1306]

// Inner radius of motor holder around rotor bell
R_Rotor = 10.0 ; // [9.7:9.7 for HK1811 Motor, 10.0:10.0 for BX1306 Motor]

// Length of boom tube (to motor center, 5" prop: 85, 4" prop: 75) 
L_Arm = 85 ; // [60:120]

// Outer Radius of Boom Cylinder
R_Arm = 4.5 ; // [4.0:0.1:5.0]

// Wall thickness of boom tube
Wall_Arm = 1.0 ; // [0.7:0.1:1.2]

// Ovality factor of boom (H to W ratio in %)
Q_Arm   = 107 ; // [90:120]

// Chamfers at BX1306 motor fixing holes
Hole_chamfers = 0 ; // [0:No chamfers, 1:Chamfers]

// Chamfer at motor side of BX1306 boom
bmo_chamf = 1.5 ; // [0:0.1:2]

// Wall thickness around rotor bell
Wall_Rotor = 1.3 ; // [0.9:0.1:1.5]

// Wall thickness at motor holder socket
Wall_Sockel = 1.5 ; 

/* [(4) Leg dimensions] */
// Wideness of leg
 W_leg = 8.5 ; // [7.5:0.1:12]

// Material thickness of leg
H_leg = 3.2 ; // [2.5:0.1:4.0]

// Length extension of leg
 L_leg = 0 ;  // [0:15] 
 
// Use stop nuts or cut thread yourself
legeco = 1 ; // [1:M3 thread core hole, 0:M3 stop nut hole]

// End radius (bigger improves printability)
r_leg = 5 ; // [4:10]

/* [(5) Top cover and FC adapter parameters] */
// Cover dome height
h_dome = 7; // [4:15]

// Dome cylinder radius
radome = 3.0 ; // [2:0.1:3.8]

// Border frame height
kragen = 1.5 ; // [1:0.1:3]

// FC adapter inner footprint (for smaller FCs)
FC_inner = 20 ; // [15:15x15mm, 16:16x16mm, 20:20x20mm]

// FC adapter inner dome height
FC_hdome = 4.6 ; // [1:0.1:8]

// FC adapter inner dome hole radius
FC_rdome = 1.2 ; // [0.6:0.1:2.0]

// FC adapter dome wall thickness
FC_rdwall =  1.8 ; // [0.8:0.1:2.5]

/* [(6) Roof cover hat parameters] */
// Roof cover type
roof_type = "roof" ; // ["roof":tilted roof, "sphere":Spherical dome] 

// Base plate dimensions
dz = 8.0 ;

// FC holder dimensions
fcz = 1.2 ; // Holding plate height
fcds = 16 ; // FC hole distance
fchole = 2.1 ;
fctrap = 3 ; // Trapez part of FC holder
fcpin = 1 ; // [0:Fixing holes, 1:Fixing pins]
fcpind = 2.2; // FC pin diameter

// Roof wall thickness
wall = 1.1  ;
wallcor = 0.4 ;

// roof height
roof_h = 11 ; // [8:20]
// roof top length 
roof_l = 20 ; // [15:25]
// roof top radius
roof_r = 4.5 ; // [2:0.5:8]
roof_fins = 0 ; // [0:no fins, 1:Fins inside roof]

// Fixing holes diameter
dhole = 3.4 ;
// screw head diameter
dhead = 5.7;
// socket height
capsock_z = 4 ; // [2:0.5:8]

// USB slot size parameter
USB_slot = 2 ; // [0:No USB slot, 1:with USB slot, 2:with huge open side cutout]
USBx = 8.8 ;
USBy = 6 ;
USBz = 5.3;
slot_x = 7.5 ;
slot_z = 2.6 ;
// USB slot position
USBpos_x = 2.8 ;
USBpos_y = -0.5 ;
USBpos_z = 5.7 ;
// USB "huge side cutout" diameter in % of base width
USBcut_d = 45 ; // [30:60]

/* [(7) Video camera dimensions] */
// x size of camera module (Flight Direction)
vtx_x = 10 ;    // [8:0.5:15]
// y width of camera module 
vtx_y = 15.2 ; // [15.2:Lizard 95, 20.6:BG TX01, 22: Fix 22mm, 25:Fix 25mm, 28:BG DTX03]
// z height of camera module
vtx_z = 14 ; // [10:18]
// x center position offset of camera
vtx_posx = 10 ; // [8:0.1:20]
// wall thickness
vtxwall = 1.5 ; // [0.9:0.1:2.0]

/* [(8) Antenna Holder dimensions] */
// Antenna hole radius
r_antenna = 1.2 ; // [1.2:0.1:1.5]
// Antenna hole distance
ant_dist = 10 ; // [8:0.5:12]
// Antenna spread angle
ant_angle = 40 ; // [20:55]
// Antenna holder x size (Flight Direction)
anth_x = 4 ; // [3:0.2:6]
// Antenna holder y width
anth_y = 21 ; // [19:25]
// Wall thickness
ant_wall = 2.2 ; // [2:0.5:4]

/* [(9) Further internal parameters] */
// Neopixel frame parameters
NeoZPos = -1.5 ;
D_Neo = 18.5 ;
H_Neo = 6.5 ;

// Height of chamfer below rotor dome
H_Rotfase = 1 ;				
// Height of chamfer on top
H_Topfase = 0.4 ;
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
// Radius of Neopixel Ring around rotor bell in boom
R_Neoring = 2.1 ; 
// Position of M2.5 Motor fixing thread
MFix_z = 2.0 ; // [1.5:0.1:2.5]
// Radius cable channel inside boom
R_cable = 2.9;				
// Propeller Diameter (5"=127, 4"=102, 3"=76)
D_prop = 126 ; // [76:152]
// Hinge length
L_Hinge  = 21.5; // [18:0.2:23]		
// Hinge width
B_Hinge  = 14 ; // [12:16]	
// Position of M3 Holes in Hinge
HingeM3Pos = 16.7 ;
// M3-Screw hole radius
R_Screw = 1.6 ;	 // [1.4:0.05:1.7]
// M3-Screw thread core hole
R_M3core = 1.2 ;
// M3 hinge chamfer size
hcha = 1.2 ; // [0.8:0.1:1.4]

// Extended Chamfer Radius at Arm Hinge in Percent
Q_ExtChamfer1 = 125 ; // [100:130]
Q_ExtChamfer2 = 108 ; // [100:120]

// Axial length of chamfer hinge segments -> boom tube
H_HFase = 3.8 ;           // [1:0.1:5]
L_ExtChamfer1 = 6.0 ; // [0:0.1:15]
L_ExtChamfer2 = 12.0 ; // [0:0.1:15]

// axial backstand of internal bar in hinge
stegbak  = 1.0 ;				
// axial length of nose bar in hinge
stegovl  = 5 ;				
// Plate size reduction towards "mickey ears"
Quad_red = 11 ;	
// Distance of Arm-End to Frame-Outline
Armbord = 18 ; // [15:18]
// Radius of Mickey Ears 
Mickey_r = 18.0 ; // [17:20]
// Radius of top frame weight reduction holes on 31x31 footprint
r_wrhole = 3.0 ; // [3.0:0.1:4.5]
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
// Height of boom snap groove in lower frame
BoomSnap = 0.2 ;  // [0.0:0.1:0.4]
// Height of strengthening X-dir bars around FC
QXbar_H = Dome_H ; 
// Height of strengthening Y-dir bars around FC (w space for RX)
QYbar_H = 0.5 ;

//************************************************
//* Rounded Cube Submodules 
//************************************************
module round2cube (x, y, z, rad)
{
    hull() {
      translate ([-x/2, -y/2, 0]) cylinder (r=0.01,h=z,center=true, $fn=30) ;
      translate ([-x/2, y/2, 0]) cylinder (r=0.01,h=z,center=true, $fn=30) ;
      translate ([x/2-rad, -y/2+rad, 0]) cylinder (r=rad,h=z,center=true, $fn=30) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z,center=true, $fn=30) ;
    }
}

module round3cube (x, y, z, rad)
{
    hull() {
      translate ([0, -y/2+rad, -z/2+rad]) rotate([0,90,0]) cylinder (r=rad,h=x,center=true, $fn=30) ;
      translate ([0, y/2-rad, -z/2+rad]) rotate([0,90,0]) cylinder (r=rad,h=x,center=true, $fn=30) ;
      translate ([0, -y/2+rad, z/2-rad]) rotate([0,90,0]) cylinder (r=rad,h=x,center=true, $fn=30) ;
      translate ([0, y/2-rad, z/2-rad]) rotate([0,90,0]) cylinder (r=rad,h=x,center=true, $fn=30) ;
    }
}

module round4cube (x, y, z, rad)
{
    hull() {
      translate ([x/2, 0, z/2]) rotate([90,0,0]) cylinder (r=0.01,h=y,center=true, $fn=30) ;
      translate ([-x/2+rad, 0, z/2-rad]) rotate([90,0,0]) cylinder (r=rad,h=y,center=true, $fn=30) ;
      translate ([x/2, 0, -z/2]) rotate([90,0,0]) cylinder (r=0.01,h=y,center=true, $fn=30) ;
      translate ([-x/2+rad, 0, -z/2+rad]) rotate([90,0,0]) cylinder (r=rad,h=y,center=true, $fn=30) ;
    }
}

module roundcube_z (x, y, z, rad)
{
    hull() {
      translate ([-x/2+rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=40) ;
      translate ([-x/2+rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=40) ;
      translate ([x/2-rad, -y/2+rad, 0]) cylinder (r=rad,h=z, center=true, $fn=40) ;
      translate ([x/2-rad, y/2-rad, 0]) cylinder (r=rad,h=z, center=true, $fn=40) ;
    }
}

module roundcubexyz (x, y, z, rad)
{
    hull() {
      translate ([-x/2+rad, -y/2+rad, -z/2+rad]) sphere (r=rad, $fn=40) ;
      translate ([-x/2+rad, y/2-rad, -z/2+rad]) sphere (r=rad, $fn=40) ;
      translate ([x/2-rad, -y/2+rad, -z/2+rad]) sphere (r=rad, $fn=40) ;
      translate ([x/2-rad, y/2-rad, -z/2+rad]) sphere (r=rad, $fn=40) ;

      translate ([-x/2+rad, -y/2+rad, z/2-rad]) sphere (r=rad, $fn=40) ;
      translate ([-x/2+rad, y/2-rad, z/2-rad]) sphere (r=rad, $fn=40) ;
      translate ([x/2-rad, -y/2+rad, z/2-rad]) sphere (r=rad, $fn=40) ;
      translate ([x/2-rad, y/2-rad, z/2-rad]) sphere (r=rad, $fn=40) ;
    }
}

//******************************************
// Chamfered Cube Submodule
//******************************************
module cubecmf (x, y, z, cmfo, cmfu)
{
    hull() {
      translate ([0,0,-z/2]) cube ([x-2*cmfu, y-2*cmfu, 0.01], center=true) ;
      translate ([0,0,(-cmfo+cmfu)/2]) cube ([x, y, z-cmfo-cmfu], center=true) ;
      translate ([0,0,z/2]) cube ([x-2*cmfo, y-2*cmfo, 0.01], center=true) ;
    }
}

//******************************************
// Chamfered Cylinder Submodule (centered)
//******************************************
module cylchamf (rad, ht, rchamf)
{
    $fn = 50 ;
    translate ([0,0,-ht/2+rchamf/2]) cylinder (r2=rad, r1=rad-rchamf, h=rchamf, center=true) ;
    translate ([0,0,0]) cylinder (r=rad, h=ht-2*rchamf+0.01, center=true) ;
    translate ([0,0,ht/2-rchamf/2]) cylinder (r1=rad, r2=rad-rchamf, h=rchamf, center=true) ;
}

// Cylinder with 2 different chamfer heights
module cyl2cmf (rad, ht, cmfo, cmfu)
{
    $fn = 50 ;
    translate ([0,0,-ht/2+cmfu/2]) cylinder (r2=rad, r1=rad-cmfu, h=cmfu, center=true) ;
    translate ([0,0,(-cmfo+cmfu)/2]) cylinder (r=rad, h=ht-cmfo-cmfu+0.01, center=true) ;
    translate ([0,0,ht/2-cmfo/2]) cylinder (r1=rad, r2=rad-cmfo, h=cmfo, center=true) ;
}


// *************************************************
// Motor Boom (adapted for HK 1811-2000 motor)
// *************************************************
module boom_1811(support)
{
    // Hollow motor holder
    difference() {
       union() {
          // Rotor Bell with Top Chamfer
          translate ([0, 0, H_Rotfase])
			cylinder (r=R_Rotor+Wall_Rotor, h=H_Rotor+Wall_Sockel-H_Rotfase-H_Topfase, $fn=FNres) ;
          translate ([0, 0, H_Rotor+Wall_Sockel-H_Topfase]) 
			cylinder (r1=R_Rotor+Wall_Rotor, r2=R_Rotor+Wall_Rotor-H_Topfase, h=H_Topfase, $fn=FNres) ;

	    // Cone below rotor bell
          translate ([0,0,-H_Rotkegel/2-H_Rotfase/2]) 
          		cylinder (r2=R_Rotor+Wall_Rotor, r1=R_Naussen, h=H_Rotkegel, $fn=FNres) ;

          // Flange tube holder with chamfer
          translate ([0,0,-H_hold]) cylinder (r1=R_Naussen, r2=R_Naussen+1, h=H_hold-H_Rotfase, $fn=40) ;
          translate ([0,0,-H_hold-1]) cylinder (r1=R_Naussen-1, r2=R_Naussen, h=1, $fn=FNres) ;

	    // Cylinder for flange fix screws
          translate ([0,0,-H_hold/2+MFix_z]) rotate ([90,0,0]) scale ([1.4,1,1]) cylinder (r=2.3, h=2*R_Naussen+3, $fn=20, center=true) ;  

          // Oval boom
          scale ([1,Q_Arm/100,1]) translate ([0,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm, h=L_Arm, $fn=FNres) ;

          // Hinge block
          translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;

          // 3-Step chamfer between hinge and boom
          hull() {
             translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
             scale ([1,Q_ExtChamfer1/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.1, center=true, $fn=FNres) ;          
          } // hull

          hull() {
             scale ([1,Q_ExtChamfer1/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase, 0, R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
             scale ([1,Q_ExtChamfer2/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer1, 0, R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
          } // hull

          hull() {
            scale ([1,Q_ExtChamfer2/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer1,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
             scale ([1,Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer2,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
          } // hull

	     // Cable tube below motor holder (outside)
         translate ([9.5,0,+0.2]) rotate ([0,-110,0]) scale ([1.1,1.33*Q_Arm/112,1]) cylinder (r = R_cable+0.9, h=24, $fn=FNres, center=true) ;
          
         // Neopixel Support Frame Ring 
         if (NeoBoom == 1)
         {
             translate ([0,0,-H_Rotfase - NeoZPos - H_Neo/2]) cylinder (r=D_Neo/2, h=H_Neo, center=true, $fn=FNres) ;
             translate ([0,0,-H_Rotfase - NeoZPos - H_Neo-1/2]) cylinder (r2=D_Neo/2, r1=D_Neo/2-1,h=1, center=true, $fn=FNres) ;
          } // if Neo       
       } // union
      
       translate ([0,0,Wall_Sockel]) cylinder (r=R_Rotor, h=H_Rotor+0.05, $fn=FNres) ;			// Around rotor 
       translate ([0,0,-1.85]) cylinder (r2=R_Rotor, r1=R_Nabe-2, h=3.4, $fn=FNres) ;			// Below rotor, conic hole
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

	 // 50% wider hole in hinge block
      hull() 
      {
         scale ([1,1.50*Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2+stegbak,0,R_Arm]) rotate ([0,90,0])
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
         // Internal Chamfer in Hinge Block (adapted to outer chamfer)  
         scale ([1,Q_Arm/100,1]) 
           translate ([L_Arm-L_Hinge/2-H_HFase/4-L_ExtChamfer1, 0, R_Arm]) rotate ([0,90,0]) 	
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
       } // hull

       // M3 holes in hinge
       translate ([L_Arm-HingeM3Pos,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
    
       translate ([L_Arm-HingeM3Pos,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;

   	   // 4 Chamfers at hinge block
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 2*R_Arm]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 2*R_Arm]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 0]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 0]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;    

       // Cylindrical cutout at hinge base for less cable movement when folding
       translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=FNres) ;
       
      // Window cutouts for 3 Neopixel LEDs
      if (NeoBoom == 1)
      {
        for (i= [-55:55:55])
        {
           rotate ([0,0,i]) translate ([-D_Neo/2+0.1, 0, -0.1 -H_Rotfase - NeoZPos - H_Neo/2])
                round3cube (2.0, 4.8, 4.8,1.9) ; 
           rotate ([0,0,i]) translate ([-D_Neo/2+2.2, 0, 0.5-H_Rotfase - NeoZPos - H_Neo/2])
                round2cube (2.3, 5.7, 7, 0.8) ; 
           rotate ([0,0,i]) translate ([-D_Neo/2+1.9, 0, 0.1-H_Rotfase - NeoZPos - H_Neo/2]) 
                 %Neopixel() ;
        } // for

       for (i= [-40:12:170])
       {
          // Cable channel between Neopixel and boom
          hull()
          {
              rotate ([0,0,i-7]) translate ([-D_Neo/2+2.2, 0, 2.4 -H_Rotfase - NeoZPos - H_Neo/2]) 
                  scale([1,1,1.8]) sphere (r=0.6, center=true, $fn=20) ; 
              rotate ([0,0,i+7]) translate ([-D_Neo/2+2.2, 0, 2.4 -H_Rotfase - NeoZPos - H_Neo/2]) 
                  scale([1,1,1.8]) sphere (r=0.6, center=true, $fn=20) ; 
           } // hull
       } // for 
     } // if NeoBoom
      
    } // diff

    // Vertical bar with screw holes in hinge block
   difference() { 
     hull() {
       translate ([L_Arm-L_Hinge/2+stegbak/2+1, 0, R_Arm]) cube ([L_Hinge-stegbak-2.0, 1+2*R_Screw, 2*R_Arm-0.5], center=true) ;
       translate ([L_Arm-L_Hinge/2-stegovl, 0, R_Arm]) cube ([L_Hinge, 0.3, 2*R_Arm-0.5], center=true) ;
     }

     // Again 4 M3 screw holes incl chamfers
     translate ([L_Arm-HingeM3Pos,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

     translate ([L_Arm-HingeM3Pos,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
  
      // Again cylindrical cutout at hinge base for less cable movement
      translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=FNres) ;
  } // diff

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
} // module


// ****************************************************
//    Motor Boom for DYS BX1306 HK #66402 (optional)
// ****************************************************
module boom_bx1306()
{
    // Hollow Boom
    difference() 
    {
       union() {
          translate ([0,0,H_Rotfase]) 
			 cylinder (r=R_Rotor+Wall_Rotor, h=H_Rotor+Wall_Sockel-H_Rotfase, $fn=FNres) ;
          translate ([0,0,H_Rotfase+H_Rotor+0.5]) 
			 cylinder (r1=R_Rotor+Wall_Rotor, r2=R_Rotor+Wall_Rotor-0.6, h=0.6, $fn=FNres) ;
          cylinder (r1=R_Rotor+Wall_Rotor-H_Rotfase, r2=R_Rotor+Wall_Rotor, h=H_Rotfase, $fn=FNres) ;
 
         // Strengthening fin between boom and motor dome
         hull() {
            translate ([R_Rotor,0,H_Rotor+1]) rotate ([0,90+36,0]) cylinder (r=0.8, h=10, $fn=10) ;
            translate ([R_Rotor,0,3]) rotate ([0,90,0]) cylinder (r=1.5, h=10, $fn=10) ;
         }
          
        if (NeoBoom == 1)
       {
          translate ([0,0,H_Rotfase+1.5]) 
             cylinder (r=R_Neoring+R_Rotor+Wall_Rotor, h=H_Rotor+Wall_Sockel-H_Rotfase-2*1.6, $fn=FNres) ;
          translate ([0,0,H_Rotfase+H_Rotor-0.15-R_Neoring/2]) 
			 cylinder (r1=R_Neoring+R_Rotor+Wall_Rotor, r2=R_Rotor+Wall_Rotor-0.6, h=0.6+R_Neoring, $fn=FNres) ;
          cylinder (r1=R_Rotor+Wall_Rotor-H_Rotfase, r2=R_Rotor+Wall_Rotor+R_Neoring, h=H_Rotfase+1.5, $fn=FNres) ;           
       } // if 
        
       // Oval boom tube
       scale ([1,Q_Arm/100,1]) translate ([0,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm, h=L_Arm, $fn=FNres) ;

       // Motor side chamfer on boom tube 
       intersection()
       {
           translate ([0,0,20]) cube ([40, 40, 40], center=true) ;
           hull()
          {
              scale ([1,Q_Arm/100,1]) translate ([R_Rotor-0.7,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm+bmo_chamf, h=0.1, $fn=FNres) ;
              scale ([1,Q_Arm/100,1]) translate ([R_Rotor+0.3+Wall_Rotor,0,R_Arm]) rotate ([0,90,0]) cylinder (r=R_Arm, h=0.1, $fn=FNres) ;
          } // hull
       } // intersect 

       // Hinge block
       translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;

       // 3-Step chamfer between hinge and boom
       hull() {
             translate ([L_Arm-L_Hinge/2, 0, R_Arm]) cube ([L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
             scale ([1,Q_ExtChamfer1/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.1, center=true, $fn=FNres) ;          
       } // hull

       hull() {
             scale ([1,Q_ExtChamfer1/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase, 0, R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
             scale ([1,Q_ExtChamfer2/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer1, 0, R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
        } // hull

       hull() {
            scale ([1,Q_ExtChamfer2/100*Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer1,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
             scale ([1,Q_Arm/100,1]) 
                 translate ([L_Arm-L_Hinge-H_HFase-L_ExtChamfer2,0,R_Arm]) rotate ([0,90,0]) 
			        cylinder (r=R_Arm, h=0.05, center=true, $fn=FNres) ;          
        } // hull
      } // union
      
       translate ([0,0,H_Rotor/2+1.4+Wall_Sockel]) cylchamf (R_Rotor, H_Rotor+3, 1) ;    // rotor hole
       translate ([0,0,0.5]) cylinder (r1=2.5, r2=3.5, h=2, $fn=30) ;	                        // center hole for clip ring
       translate ([0,0,0.25]) cylinder (r1=1, r2=2, h=1, $fn=30) ;	                        // center hole for rotor shaft
       scale ([1,Q_Arm/100,1]) translate ([8,0,R_Arm]) rotate ([0,90,0]) 					// tube boom hole
			cylinder (r=R_Arm-Wall_Arm, h=L_Arm+0.1, $fn=30) ;
       scale ([1,Q_Arm/100,1]) translate ([8-6+0.1,0,R_Arm]) rotate ([0,90,0]) 			// tube boom hole
			cylinder (r2=R_Arm-Wall_Arm, r1=R_Arm-Wall_Arm-1.5, h=6, $fn=30) ;

       // 4 holes in boom bottom for motor fixing screws, with optional chamfers
       for (i= [0:90:360]) 
       {
           rotate ([0,0,45+i]) 
           {
             translate ([12/2, 0, -1]) cylinder (r=2.3/2, h=10, $fn=20) ;                         // screw hole
             if (Hole_chamfers == 1)
                 translate ([12/2, 0, -0.1]) cylinder (r2=2.3/2, r1=2.3/2+1, h=1, $fn=20) ;     // chamfer
           } // rotate
       } // for

      if (NeoBoom == 1)
      {
         // Inner Slot for Neopixel Wiring
         translate ([0,0,2+Wall_Sockel+1]) cylinder (r1=R_Rotor, r2=R_Rotor+1.59, h=1.0, center=true, $fn=FNres) ;
         translate ([0,0,2+Wall_Sockel+2.2]) cylinder (r=R_Rotor+1.6, h=1.41, center=true, $fn=FNres) ;
         translate ([0,0,2+Wall_Sockel+3.4]) cylinder (r1=R_Rotor+1.6, r2=R_Rotor, h=1.0, center=true, $fn=FNres) ;

         // Top cutout of motor dome in expanded dome diameter
          translate ([0,0,H_Rotfase+8.3]) 
			 cylinder (r=R_Rotor+1.6, h=H_Rotor-H_Rotfase-Wall_Rotor-7.0, $fn=FNres) ;
          translate ([0,0,H_Rotfase+H_Rotor-Wall_Rotor+0.2]) 
			 cylinder (r1=R_Rotor+1.6, r2=R_Rotor+Wall_Rotor-1.4, h=1.5, $fn=FNres) ;

         // 7 Neopixel cutouts
         for (i= [-135:45:135])
         {
             rotate ([0,0,i]) translate ([-R_Rotor-1.2, 0, 5.8]) cube ([2.0, 5.7, 5.7], center=true) ; 
             rotate ([0,0,i]) translate ([-R_Rotor+1.1, 0, 5.8]) cube ([5.7, 5.4, 5.4], center=true) ; 

             // Cable cutouts in intermediate floor above Neopixel
             hull()
             {
                 rotate ([0,0,i-7]) translate ([-R_Rotor-1.1, 0, 8.5]) cylinder (r=0.65, h=2, center=true, $fn=10) ; 
                 rotate ([0,0,i+7]) translate ([-R_Rotor-1.1, 0, 8.5]) cylinder (r=0.65, h=2, center=true, $fn=10) ; 
             }// hull
         } // for
         
         // Additional cable cutout in intermediate floor at the boom position
         hull()
         {
                 rotate ([0,0,-180-7]) translate ([-R_Rotor-1.1, 0, 8.5]) cylinder (r=0.65, h=2, center=true, $fn=10) ; 
                 rotate ([0,0,+180+7]) translate ([-R_Rotor-1.1, 0, 8.5]) cylinder (r=0.65, h=2, center=true, $fn=10) ; 
         }// hull
      } // if Neoboom

	 // 50% wider hole in hinge block
     hull() 
      {
         scale ([1,1.50*Q_Arm/100,1]) translate ([L_Arm-L_Hinge/2+stegbak,0,R_Arm]) rotate ([0,90,0])
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
         // Internal Chamfer in Hinge Block (adapted to outer chamfer)  
         scale ([1,Q_Arm/100,1]) 
           translate ([L_Arm-L_Hinge/2-H_HFase/4-L_ExtChamfer1, 0, R_Arm]) rotate ([0,90,0]) 	
			cylinder (r=R_Arm-Wall_Arm, h=L_Hinge, center=true, $fn=30) ;
       }

       // M3 holes
       translate ([L_Arm-HingeM3Pos,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

       // M3 chamfers
       translate ([L_Arm-HingeM3Pos,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
       translate ([L_Arm-HingeM3Pos+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;

  	   // 4 Hinge chamfers
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 2*R_Arm]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 2*R_Arm]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, B_Hinge/2, 0]) rotate ([45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       translate ([L_Arm-L_Hinge/2, -B_Hinge/2, 0]) rotate ([-45,0,0]) cube ([2*L_Hinge, B_Hinge/2, 1], center=true) ;
       
       // Cylindrical cutout at hinge base for less cable movement when folding
       translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=FNres) ;
    }

    // Vertical bar in hinge block
    difference() { 
      hull()
     {
        translate ([L_Arm-L_Hinge/2+stegbak/2+1, 0, R_Arm]) cube ([L_Hinge-stegbak-2, 1+2*R_Screw, 2*R_Arm-0.5], center=true) ;
        translate ([L_Arm-L_Hinge/2-stegovl, 0, R_Arm]) cube ([L_Hinge, 0.3, 2*R_Arm-0.5], center=true) ;
     }

     // Again M3 holes incl chamfers
     translate ([L_Arm-HingeM3Pos,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,R_Arm]) cylinder (r=R_Screw, h=30, center=true, $fn=20) ;

     translate ([L_Arm-HingeM3Pos,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,2*R_Arm]) cylinder (r1=R_Screw, r2=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
     translate ([L_Arm-HingeM3Pos+12,0,0]) cylinder (r2=R_Screw, r1=R_Screw+hcha, h=hcha, center=true, $fn=20) ;
    
      // Again cylindrical cutout at hinge base for less cable movement
      translate ([L_Arm+1.2*R_Arm-1.6,0,R_Arm]) rotate ([90,0,0])
           cylinder (r=1.2*R_Arm, h=20, center=true, $fn=FNres) ;
  } // diff
}

// *************************************************
// Boom with selected motor flange
// *************************************************
module boom()
{
   if (motor_type == "hk1811sup") boom_1811(1) ;
   if (motor_type == "hk1811") boom_1811(0) ;
   if (motor_type == "bx1306") boom_bx1306() ;
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
      } // for

      hull() {																			// Rest in long hole...
          rotate ([0,0,endw]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
          rotate ([0,0,endw-10]) translate ([0,12,0]) cylinder (r=R_Screw, h=10, center=true, $fn=20) ;
      }
}

// *************************************************
//   Frame Basis with Chamfers and all holes for motor Arms
//   Parameter: Plate Thickness, Chamfer height
// *************************************************
module framecmf_basis (plate_h, cmfu, cmfo)
{
    difference()
    {
        union()
        {
             cubecmf (Quad_L-Quad_red, Quad_B-Quad_red, plate_h, cmfo, cmfu) ;
             translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cyl2cmf (Mickey_r, plate_h, cmfo, cmfu) ;
             translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cyl2cmf (Mickey_r, plate_h, cmfo, cmfu) ;
             translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cyl2cmf (Mickey_r, plate_h, cmfo, cmfu) ;
             translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cyl2cmf (Mickey_r, plate_h, cmfo, cmfu) ;
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
//    Parameter: FC footprint hole distance
// *************************************************
module frame_lower(fps)
{
    escfp = 20 ;   // footprint for 4-in-1 ESC fixation
    
    difference ()
    {
       union()
       {
          framecmf_basis (FrBot_h, LowerCmf, 0.005) ;
 
          // Domes for 4-in-1 ESC with 20x20 footprint for M3 screws
          if (ESC_type == "20x20") 
            for (i = [0:90:359]) rotate ([0,0,i])
            {
              translate ([escfp/2,escfp/2,FrBot_h/2]) cylinder (d1=6, d2=5, h=ESC_domeh, $fn=20) ;
   	          translate ([escfp/2,0,FrBot_h/2+0.5]) cube ([1.5, escfp, 1], center=true) ; // 1mm bars betw ESC domes
            } // for if
      } // union

      if (ESC_type == "plush6")
      {
   	    // Cooling / weight reduction holes in the middle under the ESC's
        for (i = [-3:2:3])
          hull() {
            translate ([7, i*Quad_B/9.7, 0]) cylinder (r=3, h=10, center=true, $fn=25) ;
            translate ([-7,i*Quad_B/9.7, 0]) cylinder (r=3, h=10, center=true, $fn=25) ;
          } // hull for
    } // if ESC

   translate ([Quad_L/3.4,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ; // holes betw booms
   translate ([-Quad_L/3.4,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ; 

//      translate ([24,0,0]) cylinder (r=6, h=10, $fn=20, center=true) ;	// holes between booms
//     translate ([-24,0,0]) cylinder (r=6, h=10, $fn=20, center=true) ;

      // Holes for 4-in-1 ESC with 20x20 footprint
      if (ESC_type == "20x20")
      {
        for (i = [0:90:359]) rotate ([0,0,i])
           translate ([escfp/2,escfp/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;		// Holes for M3 threads
        
   	    // Cooling / weight reduction holes in the middle under the ESC
        for (i = [-1:1:1])
          hull() {
            translate ([5, i*Quad_B/3.5, 0]) cylinder (r=3.5, h=10, center=true, $fn=25) ;
            translate ([-5,i*Quad_B/3.5, 0]) cylinder (r=3.5, h=10, center=true, $fn=25) ;
          } // for
      } // if ESC

      // 4 arm flight position snap grooves
     translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, R_Arm+FrBot_h/2-BoomSnap]) 
          rotate ([0,0,Quad_W]) translate ([1+L_Hinge/3,0,0]) cube ([3+L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
      translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, R_Arm+FrBot_h/2-BoomSnap]) 
          rotate ([0,0,180-Quad_W]) translate ([1+L_Hinge/3,0,0]) cube ([3+L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
      translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, R_Arm+FrBot_h/2-BoomSnap]) 
          rotate ([0,0,-Quad_W]) translate ([1+L_Hinge/3,0,0]) cube ([3+L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
      translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, R_Arm+FrBot_h/2-BoomSnap]) 
          rotate ([0,0,-180+Quad_W]) translate ([1+L_Hinge/3,0,0]) cube ([3+L_Hinge, B_Hinge, 2*R_Arm], center=true) ;
    } // diff

   // Selectable Battery rubber bolts 
   if ((rub_orient == "X") || (rub_orient == "XY")) 
       for (i = [0:180:359]) rotate ([0,0,i]) 
          translate ([Quad_L/3.4-3,0,-FrBot_h/2+rub_d/2]) rotate ([0,90,0]) scale ([1,1.5,1]) cylchamf (rub_d/2, 10, 0.7);
   if ((rub_orient == "Y") || (rub_orient == "XY"))
       for (i = [90:180:359]) rotate ([0,0,i]) 
          translate ([Quad_B/3.8,0,-FrBot_h/2+rub_d/2]) rotate ([0,90,0]) scale ([1,1.5,1]) cylchamf (rub_d/2, 9, 0.7);
   
   // Side walls 
   difference ()
   {
     union()
     {
         translate ([0,(Quad_B-Quad_red-LowerWall)/2, FrBot_h/2+R_Arm-LowerSlot/2]) 
            cube ([Quad_L-36, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
        translate ([0,-(Quad_B-Quad_red-LowerWall)/2, FrBot_h/2+R_Arm-LowerSlot/2]) 
            cube ([Quad_L-36, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
     }

    // Subtract Arms stopper plates for flight position
    translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,-180+Quad_W]) translate ([-9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,-Quad_W]) translate ([9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
     rotate ([0,0,+Quad_W]) translate ([-9, -B_Hinge/2+10-StopperGap, 0])
     	 cube ([13, 20, 2*R_Arm], center=true) ;
    translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
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
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-180+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
                translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-Quad_W]) translate ([-15, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r-LowerWall, h=20, center=true, $fn=FNres) ;
           } // difference
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-180+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
                translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                rotate ([0,0,-Quad_W]) translate ([-15, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	            cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
              translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r-LowerWall, h=20, center=true, $fn=FNres) ;
           } // diff
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,-Quad_W]) translate ([15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r-LowerWall, h=20, center=true, $fn=FNres) ;
           } // diff
       } // intersection

       intersection() {
           hull() {
              translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,-Quad_W]) translate ([15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
                 rotate ([0,0,+Quad_W]) translate ([-15, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	             cube ([clen, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
           } // hull
           difference () {
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
              translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r-LowerWall, h=20, center=true, $fn=FNres) ;
           } // diff
       } // intersection
   } // if 

   if (ESC_type == "plush6")
   { 
      // Big wall in the middle with extension to the battery rubber bolts
      translate ([0,0, FrBot_h/2]) rotate ([45, 0, 0]) cube ([40, 1.8, 1.8], center=true) ;	// socket chamfer
      hull () {
         translate ([0,0, FrBot_h/2+R_Arm-LowerSlot/2]) cube ([22, 1.1, 2*R_Arm-LowerSlot], center=true) ;
         translate ([0,0, FrBot_h/2+3/2]) cube ([40, 1.4, 2], center=true) ;
      }

     // Two lower inner walls / bars only for ESC fixation
     translate ([0,Quad_B/4.8, FrBot_h/2]) rotate ([45, 0, 0]) cube ([30, 1.8, 1.8], center=true) ;	// socket chamfer
     hull () {
        translate ([0,Quad_B/4.8, FrBot_h/2+2/2]) cube ([30, 1.3, 2], center=true) ;
        translate ([0,Quad_B/4.8, FrBot_h/2+R_Arm]) cube ([22, 1.2, 1.3*R_Arm], center=true) ;
     }
     translate ([0,-Quad_B/4.8, FrBot_h/2]) rotate ([45, 0, 0]) cube ([30, 1.8, 1.8], center=true) ;	// socket chamfer
     hull () {
        translate ([0,-Quad_B/4.8, FrBot_h/2+2/2]) cube ([30, 1.4, 2], center=true) ;
        translate ([0,-Quad_B/4.8, FrBot_h/2+R_Arm]) cube ([22, 1.2, 1.3*R_Arm], center=true) ;
     }
   } // if ESC

   // Arms stopper plates for flight position
   translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-180+Quad_W]) translate ([-11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
   translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-Quad_W]) translate ([-11, B_Hinge/2+StopperWall/2+StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
   translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,-Quad_W]) translate ([11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
   translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, FrBot_h/2+R_Arm-LowerSlot/2]) 
      rotate ([0,0,+Quad_W]) translate ([-11, -B_Hinge/2-StopperWall/2-StopperGap, 0])
     	 cube ([9, StopperWall, 2*R_Arm-LowerSlot], center=true) ;
        
   // Arm stopper bars for storage position
   translate ([Quad_L/2-6,Quad_B/2-Armbord-B_Hinge/2-LowerWall, Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([Quad_L/2-6,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([-Quad_L/2+6,Quad_B/2-Armbord-B_Hinge/2-LowerWall, Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ; 
   translate ([-Quad_L/2+6,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), Stopper_H/2]) 
		cube ([6, LowerWall, Stopper_H], center=true) ;  

   // Front shield between legs with hole for LED
   if (front_cover == 1) 
   {
       intersection()
       {
          difference ()
          {
              union()
              {
                 translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
                 translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
                 cube ([Quad_L-Quad_red, Quad_B-Quad_red, 20], center=true) ;
              } // union

             translate ([Quad_L/2-Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r-ant_wall, h=21, center=true, $fn=FNres) ;
             translate ([Quad_L/2-Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r-ant_wall, h=21, center=true, $fn=FNres) ;

             // Drill optional hole into front cover
             if (frontcover_hole == 1)
             {
                // Round Center hole 
                translate ([Quad_L/2-5, 0, R_Arm+FrBot_h/2]) rotate ([0,90,0]) cylinder (d=6, h=5, $fn=20, center=true) ;
             }
             if (frontcover_hole == 2)
             {
                // Center hole for 1 Neopixel LED on round PCB
                translate ([Quad_L/2-5, 0, R_Arm+FrBot_h/2]) rotate ([0,90,0]) cylinder (d=5.5, h=10, $fn=4, center=true) ;
                translate ([Quad_L/2-9, 0, R_Arm+FrBot_h/2]) rotate ([0,90,0]) cylinder (d=8, h=5, $fn=20, center=true) ;
             } // if
         } // diff

         hull()
         {
            translate ([Quad_L/2-4,Quad_B/2-Armbord-B_Hinge/2-LowerWall, FrBot_h/2+R_Arm-LowerSlot/2])
		      cube ([7, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
            translate ([Quad_L/2-4,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), FrBot_h/2+R_Arm-LowerSlot/2])
		      cube ([7, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
         } // hull
      } // intersect
   } // if
      
   // Jeti RSAT antenna holder between legs
   if (ant_holder == 2) 
   {
       intersection()
       {
          difference ()
          {
              union()
              {
                 translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
                 translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r, h=20, center=true, $fn=FNres) ;
                 cube ([Quad_L-Quad_red, Quad_B-Quad_red, 20], center=true) ;
              } // union

             translate ([-Quad_L/2+Armbord, Quad_B/2-Armbord, 0]) cylinder (r=Mickey_r-ant_wall, h=21, center=true, $fn=FNres) ;
             translate ([-Quad_L/2+Armbord, -Quad_B/2+Armbord, 0]) cylinder (r=Mickey_r-ant_wall, h=21, center=true, $fn=FNres) ;

             // Create the holes for 2 antennas
             translate ([-(Quad_L-Quad_red)/2-2, 0, FrBot_h/2+3]) antenna_holder(0) ;
          } // diff

         hull()
         {
            translate ([-Quad_L/2+5,Quad_B/2-Armbord-B_Hinge/2-LowerWall, FrBot_h/2+R_Arm-LowerSlot/2])
		     cube ([8, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
            translate ([-Quad_L/2+5,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall), FrBot_h/2+R_Arm-LowerSlot/2])
		     cube ([8, LowerWall, 2*R_Arm-LowerSlot], center=true) ;
         } // hull
      } // intersect
   } // if
}

// *************************************************
//    Upper Frame Shell with 45x45 FC footprint
// *************************************************
module frame_upper_45x45()
{
    fps = 45/2 ;
    
    difference ()
    {
      framecmf_basis (FrTop_h, UpperCmf) ;

	 // Weight reduction holes in the middle
      hull() {
          translate ([ fps-12, 45/2-10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
          translate ([-fps+12,45/2-10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ fps-12, -45/2+10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
          translate ([-fps+12,-45/2+10, 0]) cylinder (r=8, h=20, center=true, $fn=25) ;
      }
 
      // Holes for M3 threads
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([fps, fps,0]) cylinder (r=R_M3core, h=20, $fn=20, center=true) ;
    } // difference

    // Holder for FC footprint 45x45 (e.g. Crius AIO V2)
   difference() {
      union() {
        for (i = [0:90:359]) rotate ([0,0,i])
           translate ([fps, fps,0]) cylinder (r1=3.2, r2=2.5, h=Dome_H, $fn=20) ;		// Domes for M3 screws

       // Bars betw FC domes
	    translate ([+fps+1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, 2*fps, QYbar_H], center=true) ;   // front
	    translate ([-fps-1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, 2*fps, QYbar_H], center=true) ;    // back
 	    translate ([0,+fps+2.2,QXbar_H/2]) rotate ([2,0,0]) cube ([2*fps, 1.5, QXbar_H], center=true) ;  // right
 	    translate ([0,-fps-2.2, QXbar_H/2]) rotate ([-2,0,0]) cube ([2*fps, 1.5, QXbar_H], center=true) ;  // left
      } // union

      for (i = [0:90:359]) rotate ([0,0,i])
        translate ([fps, fps,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;	// Dome holes for M3 threads
   }
}

// *************************************************
//    Upper Frame Shell w/o FC footprint
// *************************************************
module frame_upper_blanco()
{
    framecmf_basis (FrTop_h, 0.005, UpperCmf) ;
}

// *************************************************
//    Upper Frame Shell with 30.5 x 30.5 FC footprint
// *************************************************
module frame_upper_31x31()
{
    fps = 30.5 ;
    
    difference ()
    {
      framecmf_basis (FrTop_h, 0.005, UpperCmf) ;

	  // Holes for M3 threads
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([fps/2,fps/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;

	  // Cooling / weight reduction holes in the middle under the ESC's
      hull() {
          translate ([ 45/2-16, Quad_B/9, 0]) cylinder (r=r_wrhole, h=15, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/9, 0]) cylinder (r=r_wrhole, h=15, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/9, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/9, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, -Quad_B/3.2, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/3.2, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, Quad_B/3.2, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/3.2, 0]) cylinder (r=r_wrhole, h=20, center=true, $fn=25) ;
      }

      // Weight red holes between arms
      hull()
      {
        translate ([fps/2+9,0,0]) cylinder (r=5, h=10, $fn=30, center=true) ;	
        translate ([0.31*Quad_L,0,0]) cylinder (r=5, h=10, $fn=30, center=true) ;	
      }
      hull()
      {
        translate ([-fps/2-9,0,0]) cylinder (r=5, h=10, $fn=30, center=true) ;	
        translate ([-0.31*Quad_L,0,0]) cylinder (r=5, h=10, $fn=30, center=true) ;	
      }

    } // difference

    // Holder for FC footprint 30.5x30.5 (e.g. Naze32)
   difference() {
      union() {
        for (i = [0:90:359]) rotate ([0,0,i])
          translate ([fps/2,fps/2,0]) cylinder (r1=3.0, r2=2.9, h=Dome_H, $fn=40) ;		// Domes for M3 screws

        // Bars betw FC domes
	    translate ([+fps/2+1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, fps, QYbar_H], center=true) ;   // front
	    translate ([-fps/2-1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, fps, QYbar_H], center=true) ;    // back
 	    translate ([0,+fps/2+2.2,QXbar_H/2]) rotate ([2,0,0]) cube ([fps, 1.5, QXbar_H], center=true) ;  // right
 	    translate ([0,-fps/2-2.2, QXbar_H/2]) rotate ([-2,0,0]) cube ([fps, 1.5, QXbar_H], center=true) ;  // left
      } // union

      for (i = [0:90:359]) rotate ([0,0,i]) 
         translate ([fps/2,fps/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;		// Holes for M3 threads
   } // difference
}

// *************************************************
//    Upper Frame Shell with scaleable FC footprint (param = hole distance)
// *************************************************
module frame_upper_scale(fps)
{
    difference ()
    {
      framecmf_basis (FrTop_h, 0.005, UpperCmf) ;

	  // Holes for M3 threads
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([fps/2,fps/2,0]) cylinder (r=1.2, h=30, $fn=20, center=true) ;
 
      // Center hole below FC 
      cylinder (r=fps/3, h=10, $fn=20, center=true) ;
        
      // Weight red holes between arms
      hull()
      {
        translate ([0.28*Quad_L,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;	
        translate ([fps/2+10,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;	
      }
      hull()
      {
        translate ([-0.28*Quad_L,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;	
        translate ([-fps/2-10,0,0]) cylinder (r=6, h=10, $fn=30, center=true) ;	
      }
        
      // Weight reduction slots besides the FC
      hull() {
          translate ([ 45/2-16, -Quad_B/3.5, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,-Quad_B/3.5, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }
      hull() {
          translate ([ 45/2-16, Quad_B/3.5, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
          translate ([-45/2+16,Quad_B/3.5, 0]) cylinder (r=4.5, h=20, center=true, $fn=25) ;
      }        
    } // difference

    // Holder for scaleable FC footprint
   difference() {
      union() {
        for (i = [0:90:359]) rotate ([0,0,i])
           translate ([fps/2,fps/2,0]) cylinder (r1=3.4, r2=2.6, h=Dome_H, $fn=20) ; // Domes for M3 screws

       // Bars betw FC domes
	    translate ([+fps/2+1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, fps, QYbar_H], center=true) ;   // front
	    translate ([-fps/2-1,0,FrTop_h/2+QYbar_H/2]) cube ([1.5, fps, QYbar_H], center=true) ;    // back
 	    translate ([0,+fps/2+2.2,QXbar_H/2]) rotate ([2,0,0]) cube ([fps, 1.5, QXbar_H], center=true) ;  // right
 	    translate ([0,-fps/2-2.2, QXbar_H/2]) rotate ([-2,0,0]) cube ([fps, 1.5, QXbar_H], center=true) ;  // left
      } // union

      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([fps/2,fps/2,0]) cylinder (r=1.2, h=20, $fn=20, center=true) ;		// Holes for M3 threads
   } // difference
}

// *************************************************
//    Upper Frame Shell with selectable FC footprint
// *************************************************
module frame_upper ()
{
    if (FC_footprint == 0)  frame_upper_blanco() ;
    if (FC_footprint == 15) frame_upper_scale(15) ;
    if (FC_footprint == 16) frame_upper_scale(16) ;
    if (FC_footprint == 20) frame_upper_scale(20) ;
    if (FC_footprint == 30.5) frame_upper_31x31() ;
    if (FC_footprint == 45) frame_upper_45x45() ;
        
    // Jeti RSAT antenna holder on top
    if (ant_holder == 1) translate ([-(Quad_L-Quad_red)/2+anth_x/2+1, 0, FrTop_h/2+2.5]) antenna_holder(1) ;
}

// *************************************************
//   Variable Flat cover dome 
// *************************************************
module cover_dome(foot)
{
   // Holder for FC footprint
   difference() {
      union() {
        translate ([0,0,h_dome]) hull() {
          for (i = [0:90:359]) rotate ([0,0,i])
            translate ([foot/2,foot/2,0]) cylinder (r=radome, h=1.2, $fn=20) ;		// Top plate = Round cube
        } // hull

        for (i = [0:90:359]) rotate ([0,0,i])
        {
           translate ([foot/2,foot/2,0]) cylinder (r=radome, h=h_dome, $fn=20) ;  // Domes for M3 screws
           translate ([0,+foot/2+radome-1.2/2,h_dome-1.2/2]) cube ([foot, 1.2, kragen], center=true) ;	// Small side wall
        } // for
      } // union
      
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([foot/2,foot/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ;	// Holes for M3 bolts
   } // difference
}

module dome()
{
   cover_dome (FC_footprint) ;
}

//*****************************************************************
//    ROOF cover for FC with USB slot, e.g. for PICOBLX
//*****************************************************************
module roof_cover(base) 
{
    difference() {  union() {
    difference()
    {
        hull()
        {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2);          
             translate ([0, 0, roof_h]) rotate ([90, 0, 0]) cylinder (r=roof_r, h=roof_l, $fn=50, center=true) ;
        } // hull

        // Inner free space 
        hull()
        {
            translate ([0, 0, capsock_z/2-2+wallcor]) roundcube_z (base-2*wall, base-2*wall, 2+capsock_z, 0.9) ;
            translate ([0, 0, roof_h+wallcor]) rotate ([90, 30, 0]) cylinder (r=roof_r-wall, h=roof_l-2*wall, $fn=6, center=true) ;
        }
    } // diff

    // Screw domes in the corners
    intersection()
    {
        for (angle = [0: 90 : 360]) rotate ([0,0,angle]) 
           translate ([FC_footprint/2, FC_footprint/2, 10/2]) cylinder (r=1.9+dhole/2, h=10, $fn=40, center=true) ;

          hull()
          {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2); 
             translate ([0, 0, roof_h]) rotate ([90, 0, 0]) cylinder (r=roof_r, h=roof_l, $fn=30, center=true) ;
          } // hull
       } // intersection

    // USB connector hole
    if (USB_slot == 1) intersection()
    {
         hull()
         {
             translate ([0, 0, 2/2]) roundcube_z (base,  base, capsock_z, 2);
             translate ([0, 0, roof_h]) rotate ([90, 0, 0]) cylinder (r=roof_r, h=roof_l, $fn=30, center=true) ;
          } // hull
          
          // USB slot housing (Höhe nach innen verjüngend zur besseren Druckbarkeit)
         hull()
         {
            translate ([USBpos_x, -base/2+USBpos_y-2, USBpos_z]) roundcubexyz (2*wall+USBx, 2*wall+USBy-4, USBz+2*wall, 1.2) ;
            translate ([USBpos_x, -base/2+USBpos_y+2, USBpos_z]) roundcubexyz (2*wall+USBx, 2*wall+USBy-4, USBz+2*wall-2, 1.2) ;
         } // hull
      } // intersection if
   } // union
       
    // Screw holes and head sunk
    for (angle = [0: 90 : 360])  rotate ([0,0,angle])
    {
        translate ([FC_footprint/2, FC_footprint/2, capsock_z]) cylinder (r=dhole/2, h=20, $fn=20, center=true) ;
        translate ([FC_footprint/2, FC_footprint/2, 3.1+10/2]) cylinder (r=dhead/2, h=10, $fn=30, center=true) ;
        translate ([FC_footprint/2+0.5, FC_footprint/2+0.5, 3.1+10/2]) cylinder (r=dhead/2, h=10, $fn=30, center=true) ;
        
        // Seitliche Kabeldurchführungen
        translate ([0, FC_footprint/2, 0]) rotate ([90, 0, 0]) cylinder (r=2, h=10, $fn=20, center=true) ;
    }
 
    // USB connector slot cutout
    if (USB_slot == 1)
    {
       translate ([USBpos_x, -base/2+USBpos_y, USBpos_z]) roundcubexyz (slot_x, 20, slot_z, 1.1) ;
       translate ([USBpos_x, -base/2+USBpos_y+0.5, USBpos_z]) roundcubexyz (USBx, USBy, USBz, 
       1.2) ;
    } // if
    
    // Complete side cutout for USB
    if (USB_slot == 2)
    {
        translate ([0,-base/2,0]) rotate ([90,0,0]) cylinder (d=base*USBcut_d/100, h=base/3, $fn=50, center=true) ;
    }
   } // diff  

   // Support fins to enable print
   if (roof_fins == 1) intersection()
   {
         hull()
         {
              translate ([0, 0, 2/2]) roundcube_z (base, base, capsock_z, 2); 
              translate ([0, 0, roof_h]) rotate ([90, 0, 0]) cylinder (r=roof_r, h=roof_l, $fn=30, center=true) ;
          } // hull

          for (dy = [-roof_l/2:4:roof_l/2])
             difference()
             {
                translate ([0,base,10+capsock_z]) cube ([base, 1.0, 20], center=true) ;
                translate ([0,base,-roof_h*1.35]) rotate ([90,0,0]) cylinder (r=base/1.5, h=1.1, $fn=50, center=true) ;       
             } // diff
      } //intersection if
} // module

//*****************************************************************
//  Spherical cover dome for GPS
//*****************************************************************
module gps_cover(base) 
{
    sphere_zoffs = 2 ;
    
    difference() {  union() {
    difference()
    {
        intersection()
        {
           translate ([0, 0, 50/2]) roundcube_z (base, base, 50, 2);          
           hull()
           {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2);          
             translate ([0, 0, capsock_z-sphere_zoffs]) sphere (r=base/2-0.5, $fn=50) ;
           } // hull
       } // intersect

        // Inner free space 
        hull()
        {
            translate ([0, 0, capsock_z/2-2+wallcor]) roundcube_z (base-2*wall, base-2*wall, 2+capsock_z, 0.9) ;
            translate ([0, 0, capsock_z-sphere_zoffs]) sphere (r=base/2-0.5-wall, $fn=50) ;
        }
    } // diff

    // Screw domes in the corners
    intersection()
    {
        for (angle = [0: 90 : 360]) rotate ([0,0,angle]) 
           translate ([FC_footprint/2, FC_footprint/2, 10/2]) cylinder (r=1.9+dhole/2, h=10, $fn=40, center=true) ;

           hull()
           {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2);          
             translate ([0, 0, capsock_z-sphere_zoffs]) sphere (r=base/2-0.5, $fn=50) ;
           } // hull
       } // intersection

    // USB connector hole
    if (USB_slot == 1) intersection()
    {
         hull()
         {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2);          
             translate ([0, 0, capsock_z-sphere_zoffs]) sphere (r=base/2-0.5, $fn=50) ;
         } // hull
          
          // USB slot housing (Höhe nach innen verjüngend zur besseren Druckbarkeit)
         hull()
         {
            translate ([USBpos_x, -base/2+USBpos_y-2, USBpos_z]) roundcubexyz (2*wall+USBx, 2*wall+USBy-4, USBz+2*wall, 1.2) ;
            translate ([USBpos_x, -base/2+USBpos_y+2, USBpos_z]) roundcubexyz (2*wall+USBx, 2*wall+USBy-4, USBz+2*wall-2, 1.2) ;
         } // hull
      } // intersection if
   } // union
       
    // Screw holes and head sunk
    for (angle = [0: 90 : 360])  rotate ([0,0,angle])
    {
        translate ([FC_footprint/2, FC_footprint/2, capsock_z]) cylinder (r=dhole/2, h=20, $fn=20, center=true) ;
        translate ([FC_footprint/2, FC_footprint/2, 3.1+10/2]) cylinder (r=dhead/2, h=10, $fn=30, center=true) ;
        translate ([FC_footprint/2+0.5, FC_footprint/2+0.5, 3.1+10/2]) cylinder (r=dhead/2, h=10, $fn=30, center=true) ;
        
        // Seitliche Kabeldurchführungen
        translate ([0, FC_footprint/2, 0]) rotate ([90, 0, 0]) cylinder (r=2, h=10, $fn=20, center=true) ;
    }
 
    // USB connector slot cutout
    if (USB_slot == 1)
    {
       translate ([USBpos_x, -base/2+USBpos_y, USBpos_z]) roundcubexyz (slot_x, 20, slot_z, 1.1) ;
       translate ([USBpos_x, -base/2+USBpos_y+0.5, USBpos_z]) roundcubexyz (USBx, USBy, USBz, 
       1.2) ;
    } // if
    
    // Complete side cutout for USB
    if (USB_slot == 2)
    {
        translate ([0,-base/2,0]) rotate ([90,0,0]) cylinder (d=base*USBcut_d/100, h=base/3, $fn=50, center=true) ;
    }
   } // diff  

   // Support fins to enable print
   if (roof_fins == 1) intersection()
   {
          hull()
          {
             translate ([0, 0, capsock_z/2]) roundcube_z (base, base, capsock_z, 2);          
             translate ([0, 0, capsock_z-sphere_zoffs]) sphere (r=base/2-0.5, $fn=50) ;
          } // hull

          for (dy = [-roof_l/2:4:roof_l/2])
             difference()
             {
                translate ([0,base,10+capsock_z]) cube ([base, 1.0, 20], center=true) ;
                translate ([0,base,-roof_h*1.35]) rotate ([90,0,0]) cylinder (r=base/1.5, h=1.1, $fn=50, center=true) ;       
             } // diff
      } //intersection if
} // module


//***********************************************
//    Selection of Roof cover type
//************************************************
module vari_cover (fps)
{
   if (roof_type == "roof") roof_cover (fps) ;
   if (roof_type == "sphere") gps_cover (fps) ;
}


// *************************************************
//    4 spacers for scalable FC footprint
// *************************************************
module spacers (fps)
{
   h_spc = 2.5;
   kragen = 1.0 ;
    
   // Holder for FC footprint "fps x fps" (e.g. 30.5 for Naze32)
   difference() {
      union() {
         for (i = [0:90:359]) rotate ([0,0,i])
         {
            translate ([fps/2,fps/2,0]) cylinder (r=2.8, h=h_spc, $fn=20) ;		// Domes for M3 screws
            translate ([0,fps/2+2.8-1.2/2,h_spc-1.2/2]) cube ([fps, 1.2, kragen], center=true) ;	// Small side wall
         } // for
      } // union
      
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([fps/2,fps/2,0]) cylinder (r=1.7, h=30, $fn=20, center=true) ; // Holes for M3 bolts
   } // difference
}

// *************************************************
//         Leg with optional integrated M3 stop nut holder
// *************************************************
module leg()
{
   translate ([L_Arm-L_Hinge/2,0,-FrBot_h-H_leg/2]) rotate ([0, 180, 90]) difference() {
      union() {
         hull() {
	      intersection()
          {
              translate ([0,-7-W_leg/2+r_leg,0]) cylchamf (r_leg, H_leg, 0.6) ;
              translate ([0,-7,0]) cube ([2*W_leg/2, 30, H_leg], center=true) ;
          } // intersect
	      translate ([0,9,0]) rotate ([0,90,0]) cylchamf (H_leg/2, W_leg, 0.6) ;
	      translate ([0,4,0]) rotate ([0,90,0]) cylchamf (H_leg/2, W_leg, 0.6) ;
	      translate ([0,11,1]) rotate ([0,90,0]) cylchamf (H_leg/2+0.3, W_leg, 0.6) ;
	   }
         hull() {
	      translate ([0,11,1]) rotate ([0,90,0]) cylchamf (H_leg/2+0.3, W_leg, 0.6) ;
	      translate ([0,10,0.7]) rotate ([0,90,0]) cylchamf (H_leg/2+0.2, W_leg, 0.6) ;
	      translate ([0,13,2.5]) rotate ([0,90,0]) cylchamf (H_leg/2+0.3, W_leg, 0.6) ;
	   }
         hull() {
	      translate ([0,13,2.5]) rotate ([0,90,0]) cylchamf (H_leg/2+0.3, W_leg, 0.6) ;
	      translate ([0,15,4.5]) rotate ([0,90,0]) cylchamf (H_leg/2+0.2, W_leg, 0.6) ;
	   }
         hull() {
	      translate ([0,15,4.5]) rotate ([0,90,0]) cylchamf (H_leg/2+0.2, W_leg, 0.6) ;
	      translate ([0,17,7]) rotate ([0,90,0]) cylchamf (H_leg/2-0.0, W_leg, 0.6) ;
	   }
         hull() {
	      translate ([0,17,7]) rotate ([0,90,0]) cylchamf (H_leg/2-0.0, W_leg, 0.6) ;
	      translate ([0,22+0.9*L_leg,14+L_leg]) rotate ([0,90,0]) cylchamf (H_leg/2-0.2, W_leg, 0.8) ;
	   }

       // Thread threngthening cylinders for ECO, to drill M3 yourself
       if (legeco == 1) {
          translate ([0,-6,2.6]) cylinder (r2=2.3, r1=W_leg/2-0.1, h=2.1, center=true, $fn=30) ;		
          translate ([0,+6,2.6]) cylinder (r2=2.3, r1=W_leg/2-0.1, h=2.1, center=true, $fn=30) ;		
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
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([22.5,22.5,0]) cylinder (r=R_Screw, h=2, $fn=20) ;				// Hole for M3 screw
  }
}

// *************************************************
//         Flight Controller 30.5 x 30.5mm (e.g. TimeCop Naze32)
// *************************************************
module fc_31x31()
{
   difference() {
      cube ([35, 35, 1.6], center=true) ;										// PCB
      for (i = [0:90:359]) rotate ([0,0,i])
        translate ([30.5/2,30.5/2,0]) cylinder (r=R_Screw, h=2, $fn=20) ;			// Hole for M3 screw
  }
}

// *************************************************
//         Flight Controller 20 x 20mm (e.g. F1 / F3)
// *************************************************
module fc_20x20()
{
   dh = 20/2 ;
   difference() {
      cube ([25, 25, 1.2], center=true) ;										// PCB
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([dh,dh,0]) cylinder (r=R_Screw, h=2, $fn=20) ;			// Hole for M3 screw
  }
}


// *************************************************
//         Flight Controller 16 x 16mm (e.g. F1 / F3)
// *************************************************
module fc_16x16()
{
   dh = 16/2 ;
   difference() {
      cube ([22, 22, 1.0], center=true) ;										// PCB
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([dh,dh,0]) cylinder (r=R_Screw, h=2, $fn=20) ;			// Hole for M3 screw
  }
}

// *************************************************
//         Flight Controller 15 x 15mm (e.g. F1 / F3)
// *************************************************
module fc_15x15()
{
   dh = 15/2 ;
   difference() {
      cube ([20, 20, 1.0], center=true) ;										// PCB
      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([dh,dh,0]) cylinder (r=R_Screw, h=2, $fn=20) ;			// Hole for M3 screw
  }
}

// *************************************************
//        A single Neopixel LED (SMD 5050)
// *************************************************
module Neopixel()
{
    difference()
    {
        cube ([1.5, 5.0, 5.0], center=true) ;
        translate ([-0.7,0,0]) rotate ([0, 90, 0]) cylinder (r=1.9, h=0.5, $fn=30, center=true) ;
    }
    
}

// *************************************************
//         Flight Controller with adapted size
// *************************************************
module fc()
{
    if (FC_footprint == 15) fc_15x15() ;
    if (FC_footprint == 16) fc_16x16() ;
    if (FC_footprint == 20) fc_20x20() ;
    if (FC_footprint == 30.5) fc_31x31() ;
    if (FC_footprint == 45) fc_45x45() ;
}

// *************************************************
//      Adapter for Flight Controller Flip32 Mini to 30.5 x 30.5mm
//           (PCB of flip32 mini is 14.6 x 31.3 x 1.65)
// *************************************************
module adap_flip32mini()
{
   frame = 0.3 ;                                                                            // border around Flip32mini PCB
   mpcb_x = 15.0 ;                                                                        // Flip32 mini PCB dimensions
   mpcb_y = 31.7 ; 

   difference() {
      union() {
         roundcube_z (36, 36, 1.2, 2) ;										            // instead Naze32 PCB
         translate ([0,0,1]) roundcube_z (17, 33, 2, 1.5) ;			            // socket for Flip32 mini
      }
      translate ([0,0,1.8]) roundcube_z (mpcb_x, mpcb_y, 2, 0.5) ;			// PCB cutout for Flip32 mini 
      translate ([0,0,-1]) roundcube_z (mpcb_x-2*frame, mpcb_y-2*frame, 10, 1.0) ; // hole below PCB

      for (i = [0:90:359]) rotate ([0,0,i])
         translate ([30.5/2,30.5/2,-1]) cylinder (r=R_Screw, h=2, $fn=20) ;		// Holes for M3 screw
  }
}

// *************************************************
//    Variable Adapter for smaller Flight Controllers than 30.5 x 30.5mm
// *************************************************
module adap_var(x_sml)
{
   frame = 0.3 ;                                                                            // border around PICOBLX PCB
//   mpcb = 27.2 ;                                                                        // PICOBLX PCB dimensions
   pcb_z = 1.4 ;
   x_big = 30.5 ;       // outer footprint 
//   x_sml is inner foorprint

   $fn = 25 ;
 
   difference() 
   {
      union()
      {
         difference()
         {
            translate ([0,0,pcb_z/2]) roundcube_z (36.2, 36.2, pcb_z, 2.5) ;    // instead Naze32 PCB
            translate ([0,0,0]) roundcube_z (1+x_sml, 1+x_sml, 5, 2) ;          // PCB inner cutout 
         } // diff

         for (i = [0:90:359]) rotate ([0,0,i]) translate ([+x_sml/2,+x_sml/2,0]) 
            cylinder (r1=FC_rdome+FC_rdwall+0.4, r2=FC_rdome+FC_rdwall, h=FC_hdome) ; // inner 4 domes
      } // union
 
      for (i = [0:90:359]) rotate ([0,0,i])
      {
         translate ([x_big/2,x_big/2,-0.1]) cylinder (r=R_Screw, h=9) ;	 // Trough holes for 31x31 M3 screws
         translate ([x_sml/2,x_sml/2,-1]) cylinder (r=FC_rdome, h=9) ;	 // Thread holes for inner screws 
         translate ([1+x_sml/2, 0, -1]) cylinder (r=3.5, h=9) ;
      } // for
  } // diff 
}

// *************************************************
//   Receiver JETI Duplex RMK2 / RSAT2 w short antennas
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
//  diff = 0: Create only the holes / diff = 1: create complete cube
// *************************************************
module antenna_holder(diff)
{
   if (diff == 1)
   {
     difference() {
        hull() {                                                                                             // Fixing Block
            translate ([0,0,-2.2]) cube ([anth_x, anth_y, 1], center=true) ;
            translate ([0,0,2.2]) cube ([anth_x, anth_y-8, 0.1], center=true) ;
         }

        // Both Antenna holes
        translate ([0,-ant_dist/2,0]) rotate ([0,80,ant_angle/2]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;
        translate ([0,+ant_dist/2,0]) rotate ([0,80,-ant_angle/2]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;
       
        hull() {                                                                                          // Weight Reduction
           translate ([0,-ant_dist/5,0]) cylinder (r=anth_x/3, h=20, $fn=20, center=true) ;  
           translate ([0,ant_dist/5,0]) cylinder (r=anth_x/3, h=20, $fn=20, center=true) ;  
        } // hull
     } // diff
   } // if
   
   if (diff == 0)
   {
        // Both Antenna holes
        translate ([0,-ant_dist/2,0]) rotate ([0,80,25]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;
        translate ([0,+ant_dist/2,0]) rotate ([0,80,-25]) cylinder (r=r_antenna, h=20, $fn=10, center=true) ;
   } // if
}

// *************************************************
//    Holder for 2x SMD 5050 Neopixel, to be clipsed between front legs
//  interrupt print @z=3mm, place pre-wired LEDs into holder, then resume
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

// *************************************************
//  Holder for FPV Camera incl. TX module
//  place it between front legs instead of Neopixel holder
// *************************************************
module Liz95Cam_holder()
{
   difference() {
     union()
     {
         // Copter side to hold the thing
         translate ([(vtx_posx-10)/2,0,0]) cube ([vtx_posx-2, (Quad_B-Armbord-B_Hinge)/2-1, 2*R_Arm], center=true) ;
         
         // VTX cam box
         translate ([vtx_posx,0,0]) roundcubexyz (vtx_x+2*vtxwall, vtx_y+2*vtxwall, 2*R_Arm, 0.8) ;
      }
    
     // Subtract arm stopper bars in storage position
     translate ([0,Quad_B/2-Armbord-B_Hinge/2-LowerWall-0.2, -R_Arm+Stopper_H/2-0.01]) 
	  	 cube ([10, LowerWall, Stopper_H], center=true) ; 
     translate ([0,-(Quad_B/2-Armbord-B_Hinge/2-LowerWall-0.2), -R_Arm+Stopper_H/2-0.01]) 
		  cube ([10, LowerWall, Stopper_H], center=true) ;
       
      // Subtract cube for VTX cables
      translate ([3+(vtx_posx-10)/2,0,vtxwall+0.1]) 
         roundcube_z (vtx_posx-4, (Quad_B-Armbord-B_Hinge)/2-1-2*vtxwall, 2*R_Arm-2*vtxwall, 2) ;       
      // Inner space for cam
      translate ([vtx_posx,0,vtxwall]) cube ([vtx_x, vtx_y, 2*R_Arm], center=true) ;

      // Subtract cylinder for lens tube
      translate ([vtx_posx+0.5+vtx_x/2,0,vtxwall+2]) rotate ([0,90,0]) cylinder (d=10.5, h=5, $fn=40, center=true) ; 
     
     // Subtract thread holes for fixation screw(s)
     translate ([-1.5,0,-1]) cylinder (d=1.5, h=8, $fn=20, center=true) ; 
     translate ([-1.5,-4,-1]) cylinder (d=1.5, h=8, $fn=20, center=true) ; 
     translate ([-1.5,+4,-1]) cylinder (d=1.5, h=8, $fn=20, center=true) ; 
   } // difference
}

// ******************************************************
//      Complete Quadro, booms in flight, with optional ghost motors & props
// ******************************************************
module quadro(angle)
{
  frame_lower() ;
  translate ([0,0,2*R_Arm+1.6]) frame_upper() ;

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) {  boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  { boom() ; leg(); }

  // Place the FC adapter on top of the upper frame
  if (FC_adapter == 1) translate ([0, 0, Dome_H+2*R_Arm+1.6]) adap_var(FC_inner);
  
  // Place the 2 optional covers on top of each other, adapt z position automatically
  if (top_cover == 1) translate ([0, 0, Dome_H+2*R_Arm+1.5 + (FC_adapter*1.5)]) dome() ;
  
  if (roof_cover == 1) 
   {
      translate ([0,0, Dome_H+2*R_Arm+1.6 + (FC_adapter*1.4) + (top_cover*h_dome)])
        rotate ([0,0,-90]) 
        {
           if (FC_footprint == 16) vari_cover(20) ;
           if (FC_footprint == 20) vari_cover(25) ;
           if (FC_footprint == 30.5) vari_cover(36) ;
           if (FC_footprint == 45) vari_cover(52) ;
        }
   } // if
      
   // If selected, show electronic components as ghosts
   if (ghosts == 1)
   {
      // Motors and props 
      translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0])  { %motor_1811() ; %prop_5x3() ; }
      translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0])  {%motor_1811() ; %prop_5x3() ; }
      translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0])  {%motor_1811() ; %prop_5x3() ; }
      translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  {%motor_1811() ; %prop_5x3(); }

      // 4 ESCs PLUSH 6A between the frames
       if (ESC_type == "plush6")
       {    
         %translate ([1,20.5,3]) rotate ([0,0,180]) plush_6a() ;
         %translate ([2, 7,3]) rotate ([0,0,0]) plush_6a() ;
         %translate ([2,-7,3]) rotate ([0,0,0]) plush_6a() ;
         %translate ([1,-20.5,3]) rotate ([0,0,180]) plush_6a() ;
       }

       // 4-in-1 ESC with 20x20 footprint
       if (ESC_type == "20x20")
           %translate ([0, 0, -40]) fc_20x20() ;

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

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) 
	  { translate ([0,0,-20])  boom() ; if (ghosts == 1) %motor_1811() ; translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;   translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;   translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0]) 
	  { translate ([0,0,-20]) boom() ; if (ghosts == 1) %motor_1811() ;  translate ([0,0,20]) if (ghosts == 1) %prop_5x3() ; translate ([0,0,-80]) leg(); }

   if (FC_adapter == 1) translate ([0,0,40]) adap_var(FC_inner);
   if (top_cover == 1) translate ([0,0,46]) dome() ;
   if (roof_cover == 1) translate ([0,0,60]) rotate ([0,0,-90]) vari_cover(36) ;

   if (ghosts == 1)
   {
       if (ESC_type == "plush6")
       {    
          // 4 ESCs PLUSH 6A between the frames
          %translate ([1,20.5,3 -40]) rotate ([0,0,180]) plush_6a() ;
          %translate ([2, 7,3    -40]) rotate ([0,0,0]) plush_6a() ;
          %translate ([2,-7,3   -40]) rotate ([0,0,0]) plush_6a() ;
          %translate ([1,-20.5,3-40]) rotate ([0,0,180]) plush_6a() ;
       }
 
       // 4-in-1 ESC with 20x20 footprint
       if (ESC_type == "20x20")
           %translate ([0, 0, -40]) fc_20x20() ;

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

  translate ([Quad_L/2-Armbord-0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-180+angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
/*
  translate ([-Quad_L/2+Armbord+0.7, Quad_B/2-Armbord-0.7, FrBot_h/2]) rotate ([0,0,-angle]) translate ([-L_Arm+L_Hinge/6, 0, 0]) { boom() ; leg(); }
  translate ([Quad_L/2-Armbord-0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,180-angle]) translate ([-L_Arm+L_Hinge/6,0, 0]) {  boom() ; leg(); }
  translate ([-Quad_L/2+Armbord+0.7, -Quad_B/2+Armbord+0.7, FrBot_h/2]) rotate ([0,0,angle]) translate ([-L_Arm+L_Hinge/6,0,0])  { boom() ; leg(); }
*/
}


//******************************************************
//*  Select down here what objects to see / render / print
//*  Remark: Cutaway views ("difference ... ) only for debugging
//******************************************************
if (show == "all") quadro (Quad_W) ;            // 0 = booms in park / Quad_W = in flight
if (show == "exp") quadro_exploded (Quad_W) ;	   // optional: exploded view
if (show == "leg") leg() ;
if (show == "ant") translate ([-35,0,13.5]) antenna_holder() ;         // Jeti RSAT antenna holder
if (show == "neo") translate ([Quad_L/2-8,0,R_Arm]) rotate ([0,0,180]) neopixel_holder() ;
if (show == "cam") translate ([Quad_L/2-8,0,R_Arm]) rotate ([0,0,180]) Liz95Cam_holder() ;
if (show == "boom") boom();
if (show == "bot") frame_lower();
if (show == "top") frame_upper();
if (show == "cov") translate ([0,0,Dome_H+8]) dome();
if (show == "roof") translate ([0,0,Dome_H+8]) vari_cover(36);
if (show == "adap") translate ([0,0,Dome_H+8]) adap_var(FC_inner);
if (show == "debug") quadro_debug (Quad_W) ;
    
// quadro (0, ghosts) ;                                         // booms in storage position 

// !gps_cover(36) ;

// ******************************************************
//   Cutaway views, only for debugging and documentation purposes
// ******************************************************

//  translate ([0, 25, 0])  difference() {
//  boom (ghosts) ;                                                                       // Arm type depends on motor type
//  translate ([-20,0,0]) cube ([40, 200, 200 ], center=true) ;				// Debug: Motor Dome Vert Cut Y/Z plane
//  translate ([0,-20,0]) cube ([200, 40, 200 ], center=true) ;				// Debug: Motor Dome Vert Cut X/Z plane
//  translate ([0,0,R_Arm+10]) cube ([200, 200, 20 ], center=true) ;		// Debug: Complete Horiz Cut
// }
