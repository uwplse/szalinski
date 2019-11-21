/*
HardyGraph - Dynamical and Readjustable Frame to build an Engraver
Copyright (C) 2014  Benjamin Hirmer - hardy at virtoreal.net

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//#######TO-DO#######
// - Automatische anpassung der auszublendenden "Lower Rod-Support Structure" im "Groundframe Y-Axis MotorMount" je nach Ausrichtung des Pulleys
// - Der Druckbare Bereich wird nicht exakt bestimmt, sondern nur auf 97% geschätzt (bin zu faul)
// - Die Upper-Frame Belt-Position wird nicht automatisch bestimmt, der Belt-Tightener dazu wird auch nicht ausgerichtet (bin zu faul)
// - Die Sideway-Bracer werden nicht automatisch zur Hysterese ausgerichtet (bin zu faul)
// - ANSONSTEN -> Alle Positionen die mit //TODO gekennzeichnet sind 


$fn = 80; //Whole Resolution of the Models
use <Thread_Library.scad> //Import a Thread-Thread_Library // Only needed for Dremel Holder

//Modifieable
//Viewable Definition
  //Printmode (for Part-Export of Structure in STL e.c.t)
  printmode = false;
  usemembran = true; //Needed for Printing difficult Areas (Do not Print without this Function = true)
  membranthick = 1; //Thickness of the Membran-Layer (1 - recommended)

  //Turn Structures ON/OFF
  showtrod = true; //Show Threaded Rods
  showsrod = true; //Show Smooth Rods
  showbearing = true; //Show all Bearing
  showbelts = true; //Show all Belts
  showpulleys = true; //Show all Pulleys
  showengines = true; //Show all Engines
  showgfeed = true; //Show Groundframe Feeds
  showzcarrier = true; //Show Z Carrier
  showxcarrier = true; //Show X Carrier
  showxtoolcarrier = true; //Show X Tool-Carrier
  showupperframe = true; //Show Upper-Frame Structures
  
  //Siumulation Sizes
  //Size for simulated Pulley on X-Axis Engine
  spoxaw = 7; //Width
  spoxad = 15; //Diameter
  spoxah = 5; //Hole in Pulley
  //Width for simulated Engines
  weds = 48; //Width for simulated Engine Dual Shaft
    wedss = 24; //Lenght of Front Shaft
    wedse = 24; //Lenght of Back Shaft
  wess = 48; //Width for simulated Engine Single Shaft
    wesss = 24; //Shaft Lenght
  
  //Simulation Parameter
  drivex = 50; //Drive X (Value 0-100)
  drivey = 50; //Drive Y (Value 0-100)
  drivez = 50; //Drive Z (Value 0-100)

//Layout Y-Axis
usetwosmoothrods = true;

//Global Size Definitions
dotr = 8; //Diameter of Threaded Rods of Groundframe
dotra = 0.5; //Additional Diameter of Threaded Rods of Groundframe and other Structures
aotr = 12; //Add of Threaded Rod at the ends for Nuts and Spacers

//Size Definitions
//Groundframe Feed Sizes
gfshh = 25; //Start of the Groundframe Structures (Bearing-Supporters/Stepper Engine Structures) (Previous Smooth Rod Holder Size = yasrh + yahoc)
gfsh = 80; //End of the Groundframe Structures (Bearing-Supporters/Stepper Engine Structures)
gffh = 80; //Size of the Groundframe Feeds (Height of the whole Base-Structure) 
gffs = 15; //Diameter of the Groundframe Feeds
watrl = 00; //Additional Threaded Rod Length of the "Width" Groundframe Feeds, Warning: the aotr (Add of Threaded Rod for Nuts and Spacers) would be concidered!
latrl = 40; //Additional Threaded Rod Length of the "Length" Groundframe Feeds, Warning: the aotr (Add of Threaded Rod for Nuts and Spacers) would be concidered!
wsab = 20; //Width Space above Bottom, (Space between lower Threaded Rod of the "Width" Groundframe Feeds) Warning: Relatet to the center of the rod!
wsab2 = 55; //Width Space above Bottom 2, (Space between upper Threaded Rod of the "Width" Groundframe Feeds) Warning: Relatet to the center of the rod!
lsab = 35; //Length Space above Bottom, (Space between lower Threaded Rod of the "Length" Groundframe Feeds) Warning: Relatet to the center of the rod!
lsab2 = 70; //Length Space above Bottom, (Space between lower Threaded Rod of the "Length" Groundframe Feeds) Warning: Relatet to the center of the rod!

//Groundframe Y-Axis Threaded Rod Supporters
dbgf = 8.7;//Distance Between Groundframe Feed for Bearing-Supporters (Simulated Smooth Rods Stick to that Parameter)
dbge = 8.5;//Distance Between Groundframe Feed for Engine-Structures

  //Inner Frame inside of the Groundframe (Workbench)
  ifcd = 80; //Inner Frame Corner Distance
  iffd = 15; //Inner Frame Feed Diameter
  iffhw = 10; //Inner Frame Feed Hover Width (Position of the Threaded-Rod Groundframe Mount-Slots above the Floor (Width Side))
  iffhl = 10; //Inner Frame Feed Hover Lenght (Position of the Threaded-Rod Groundframe Mount-Slots above the Floor (Lenght Side))
  iffc = 6; //Inner Frame Feed Count (How many Feeds for the "Workbench"?) 6 or 9

    //Y-Axis Bearing Supporters
    yass = 30;//Y-Axis Supporters Size
    ybgd = 22; //Y-Axis Bearing Groundframe Diameter (Bearing Diameter for the Y-Belt)
    ybgw = 7; //Y-Axis Bearing Groundframe Width (Bearing Width for the Y-Belt)
    ybgs = 2; //Y-Axis Bearing Groundframe Slippage (Sum-Space for Spacers e.c.t)
    ybga = 27.5; //Y-Axis Bearing Groundframe Hole Place (Space from Top to Buttom for the Bearing Screw to Mount Bearing on Structure) Warning: Relatet to the center of the Screw!
    ybgh = 8; //Y-Axis Bearing Groundframe Hole Diameter (Diameter of the Bearing Screw Hole)
    yabh = 1.38; //Y-Axis Belt Hight
    
    //Y-Axis Stepper-Engine Structures
    yess = 10; //Y-Axis Engine Structure, Space between the two ThreadedRod Holders (Space for the Belt)
    yesw = 10; //Y-Axis Engine Structure, Width of ThreadedRod Holder (Normaly like "gffs") (two parts entirely)
    yesl = 15; //Y-Axis Engine Structure, Length of ThreadedRod Holder (Normaly like "gffs")
    yese = 43; //Y-Axis Engine Structure, NEMA-Motor Size
    yesfs = 22.5; //Y-Axis Engine Structure; NEMA-Motor Flange Size
    yesfd = 2.5; //Y-Axis Engine Structure; NEMA-Motor Flange Depth
    yeset = 7.7; //Y-Axis Engine Structure, Distance between the Top and the Stepper-Engine Mounting Spot
    yeseh = 4; //Y-Axis Engine Structure, Diameter of the Stepper-Engine Screw Holes
    yesehs = 31; //Y-Axis Engine Structure, Distance between the Scew-Holes Warning: Relatet to the center of the Screws!
    
    //Y-Axis Smooth-Rod Holder (Y-Axis Smooth Rods are fixed here)
    yasrh = 10; //Hight of Smooth-Rod above the Size of the Groundframe Feeds (Height of the whole Base-Structure) (usualy gffh)
    yahoc = 10; //Hight of Smooth-Rod Clip (for tightening)
    yadbc = 1; //Distance between Base and Clip of the Smooth-Rod tightener
    yasosr = 10; //Size of Smooth-Rod
    yasosh = 4; //Size of Screw-Hole
    yadbsrant = 10; //Distance between Smooth-Rod and Nut Trap, Warning: Relatet to the center of the rod!
    
      //Z-Axis Structure
      zasw = 110; //Z-Axis Structure Width
      zasl = 40; //Z-Axis Structure Length
      zauph = 64; //Z-Axis upper Body Hight
      yawolb = 19.1; //Y-Axis Width of Linear Bearing
      yalolb = 29.2; //Y-Axis Length of Linear Bearing
      xadobtho = 14.5; //Z-Axis Distance of Bearings to the Outside
      xarsr = 2; //Z-Axis Relocate Smooth-Rods (Rearrange the Clips of Bearing-Holders, Distance of Bearings keep Track)
      xazs = 4; //Z-Axis Zipper Size (Width, Height would be the half-value)
      xasrt = 0.5; //Z-Axis Smooth Rod Tollerance (Space between Smooth Rod and Structure (Sum))
      xadbsr = 75; //Z-Axis Distance Between Smooth Rods, Warning: Relatet to the center of the Rods!
      xalbh = 30; //Z-Axis Lower Block Hight (Usually: 30!)
      xanes = 42.3; //Z-Axis Nema Engine Size 
      xanefs = 22.5; //Z-Axis Nema Engine Flange Size
      xanefd = 2.5; //Z-Axis Nema Engine Flange Depth
      xaness = 6; //Z-Axis Nema Engine Support Structure
      xawobp = 10; //Z-Axis Width of Engine Mounting-Base-Plate (-2 of Nema Engine)
      xaneshd = 31; //Z-Axis Nema Engine Screw-Hole-Distance (Between two Holes for Mounting on Plate)
      xaneshs = 4; //Z-Axis Nema Engine Screw-Hole-Size
      xadozsr = 9; //Z-Axis Distance of Z-Axis Smooth Rods to the Outside
      xazasrd = 10; //Z-Axis Smooth Rods Diameter
      xazsrd = 11; //Z-Axis Smooth Rods Difference
      xabw = 7; //Y-Axis Belt Width
      xabh = 1.38; //Y-Axis Belt Hight
      xabp = 1.5; //Y-Axis Belt Position 
      yatfb = 2; //Y-Axis Belt Tollerance for Belt-Corridor (Sum)
      yabtfe = 45.5; //Y-Axis Belt Tightener from Engine (From Top to Bottom)
      yabtfb = 37; //Y-Axis Belt Tightener from Bearing (From Top to Bottom)
      yabtl = 50; //Y-Axis Belt Tightener Lenght
      yabtsw = 4; //Y-Axis Belt Tightener Scew-Width (for Tightening the Belt)
      yabtass = 2.4; //Y-Axis Belt Tightener Allen Screw Size
      
	//X-Axis Structure
	xacsh = 20; //X-Axis Carrier Structure Hight
	zawolb = 19.6; //Z-Axis Width of Linear Bearing
	zalolb = 29.7; //Z-Axis Lenght of Linear Bearing
	zawolbss = 10; //Z-Axis Width of Linear Bearing Support Structure
	zapoflb = 5-0.25; //Z-Axis Position of first Linear Bearing from Bottom
	zasbtlb = 20; //Z-Axis Space between two Linear Bearings
	xadosr = 60; //X-Axis Distance of Smooth Rods
	xasrs = 8; //X-Axis Smooth Rod Size
	xaasrfb = 15; //X-Axis Adjust Smooth Rods from Bottom
	xasrss = 10; //X-Axis Support Structure
	xasrms = 4; //X-Axis Smooth Rods mounting Screw
	xasrmsd = -15; //X-Axis Smooth Rod mounting Screw Difference
	xaamm = 13; //X-Axis adjust Motor Mount
	xaamh = 20; //X-Axis adjust Motor Hight
	xaabh = 24; //X-Axis adjust Bearing Hight
	xammpt = 10; //X-Axis Motor Mounting Plate thickness
	xams = 43; //X-Axis Motor Size
	xamfs = 22.5; //X-Axis Motor Flange Size
	xamfd = 2.5; //X-Axis Motor Flange Depth
	xammpfs = 5; //X-Axis Motor Mounting Plate Frame Size
	xammpss = 4; //X-Axis Motor Mounting Plate Screw Size 
	xammpsd = 31; //X-Axis Motor Mounting Plate Screws Distance
	xatrs = 8+0.5; //X-Axis Threaded Rod Size (Add Some Tollerance Space)
	zantfr = 60; //Z-Axis Nut-Trap Feather Range
	zawon = 13; //Z-Axis Width of Nut
	zantss = 6; //Z-Axis Nut Trap Support Structure
	xahosb = 5; //X-Axis Height of Support Bridge
	xadob = 22; //X-Axis Diameter of Bearing (Belt)
	xawob = 7+3.15; //X-Axis Width of Bearing (Belt)
	xahib = 8; //X-Axis Hole in Bearing (Belt)
	xawwt = 3.5; //X-Axis Bearing Width Tollerance (Belt // Additional Space for Spacers)
	
	//X-Axis Tool-Carrier
	xawotc = 110;//   Width of Tool-Carrier
	xalotc = 100;//   Lenght of Tool-Carrier
	xahotc = 20;//   Height of Tool-Carrier
	xawolbh = 25;//   Width of Linear Bearing Holder
	xaholbh = 15;//   Hight of Linear Bearing Holder
	xaposrfb = 15;//   Position of Smooth-Rod from Bottom
	xadbttsr = 60;//   Diameter between the two Smooth-Rods
	xawolb = 15;//   Width of Linear Bearing
	xalolb = 25;//   Lenght of Linear Bearing
	xadolbttre = 3;//   Distance of Linear Bearing to the Rear Ends
	xalbt = 4;//   Linear Bearing Tightener
	xampt = 10;//   Gap-Size in Mounting-Plate (for Tools to Fit in) / Position Sticks to the linear Bearings (because of the Tightener)
	xagsimp = 30;//   Hole in Mounting-Plate for Primary-Tool
	xathsimp = 4;//   Screw-Hole-Sizes for Tools in Mounting-Plate
	xashdpt = 27;//   Screw-Hole-Distance Primary Tool
	xasdst = 30;//   Screwhole Distance Sek. Tools
	xastshd = 5;//   secondary tool screw hole distance to the gap
	xaatmps = 5;//   additional tools mounting plug size
	xaatmpd = 20;//   additional tools mounting plug distance
	xaatmpp = 10;//   additional tools mounting plug position from the outside
//      xabspfto = 70;//   Belt Stretcher position from the outside / Position of Belt / (For Automatic, Command this out and Rearrange xapob under "Define Automatic Variables")
	xabspd = 20;//   Belt Stretcher plug distance
	//>>>>
	  //Belt Tightener
	  xawobt = 6.5;//   Width of Belt    
	  xahob = 1.3;//   Height of Belt
//   	  xapob = 4;//	Position of Belt / (For Automatic Command this out and Rearrange xapob under "Define Automatic Variables"
	  xashd = 3.2;//   screw hole diameter
	  xappt = 5;//   Press-Plate Thickness
	  xaap = 0;//   Adjust Printable
	  //Auto-Bed-Leveling
 	  xasw = 11; // Servo-Width
	  xasl = 31.8; // Servo-Lenght
	  xaslws = 21.8 ; // Servo-Lenght Widhout Screwholes
	  xasfd = 13.9; // Servo-Flange Depht (Dept of Servo beneath the Mounting-Flange)
	  xaspos = 22.49; // Position of Drive-Shaft
	  xasst = 7; // Servo Structure Thickness
	  xaspo = 42; // Servo Position Offset (Position of Servo-Engine beneath Tool-Carrier Surface)
	  xasdods = 7; // Diameter of Drive-Shaft (Width Tightener on Top)
	  xasdoss = 2; // Distance of Servo Screws (from the Outside)
	  xasdossh = 1.5; //Diameter of Servo Screw Holes (For Fix Servo)  
	  xatfl = 40; // Trigger-Flag Lenght
	  xatfw = 4; // Trigger-Flag Width
	  xatw = 8.2; // Trigger Width
	  xath = 6.15; // Trigger Height
	  xatmhd = 4; // Trigger Mounting Holes Distance
	  xatmhs = 1.2; // Trigger Mounting Holes Size (For Fix Trigger)
	  xatmhpfp = 1.6; // Trigger Mounting Holes Position from Pins 
	//<<<<
	
	//Upper-Frame Structure (ufs)
	ufh = 10; // Upper-Frame Hight
	ufaw = 20; // Upper-Frame Additional Width
	ufwob = 7; // Width of Bearing
	ufdob = 22+0.25; // Diameter of Bearing (Add Some Tollerance Space)
	ufhib = 8; // Hole in Bearing
	ufsfb = 7; // Support for Bearing (Sum!)
	uflolbc = 130; // Lenght of Linear Bearing Carrier
	ufwolbc = 26; // Width of Linear Bearing Carrier
	ufholbc = 12; // Hight of Linear Bearing Carrier
	ufwolb = 19.1; // Width of Linear Bearing
	uflolb = 29.3; // Lenght of Linear Bearing
	ufdobtre = 30; // Distance of Bearings to Rear Ends
	ufabtho = -0.7; //allocate Bearings to the Outside
	ufsrs = 10; // Smooth-Rod Size
	uflbt = 4; // Size of Linear Bearing Tightener
	ufsrfs = 4; // Smooth Rod Fixing
	ufsras = 0.2; // Smooth Rod additional Space (For Adjust Smooth-Rod)
	uftrbd = 8+0.5; // Threaded Rod Bracing Diameter (Add Some Tollerance Space)
	ufdotrb = 9; // Distance of Threaded Rod Bracing to the Ends
	ufdotrbb = 8; // Distance of Threaded Rod Bracing to the Bottom
	ufalotrbb = 10; // Additional Lenght of Threaded Rod Bracing Block (for Tightening-Nuts)
	ufabp = 40; // Upper-Frame Adjust Belt Position
	ufdobb = 22; // Diameter of Belt-Bearing
	ufwobb = 7; // Width of Belt-Bearing
	
	//Upper-Frame Belt Tightener (ufbt)
	ufbtl = 15; //Lenght of Belt Tightener 
	ufbtpafbb = 27.5; // Belt Tightener Position away from Bracing Block (Just for Simulation)
	ufbts = 60; //Belt Tightener Span
	ufbtsp = 0; //Belt Tightener Span Position
	ufbtbw = 7; //Belt-Width
	ufbtbp = 30; //Belt Position (Adjust 0-100)
	ufbtass = 2.4; //Y-Axis Belt Tightener Allen Screw Size
	ufbtss = 3.2; //Y-Axis Belt Tightener Screw Size
	ufbtd = 2; //Y-Axis Belt Tooth Distance
	ufbtsa = 10; //Belt Tightener Stability Assistant
	
	//Upper-Frame Deflektion Pulley (ufdp)
	ufdpsa = 225; //Simulated Angle
	ufdpwol = 8; //Width of Legs
	ufdpadbb = 0; //Additional Distrance between Bearings
	ufdpdhsp = 6.4; //Diameter Hole of second Plate (for threading / Fix Bearing Screw)
	
	//Upper-Frame bottom Structure (Bearing-Side)
	ufbssto = 6.8; // Upper-Frame bottom Support Structure Thickness Outside
	ufbssti = 8.7; // Upper-Frame bottom Support Structure Thickness Inside (should not be bigger than "dbgf")
	ufbstrd = 10; // Upper-Frame bottom Support Threaded-Rod Diameter
	ufbsdotra = 0.5; // Upper-Frame bottom Support Threaded-Rod additional Diameter
	ufbstrs = 10; // Upper-Frame bottom Support Threaded Rod Support (Width)
	ufbstrsh = 50; // Upper-Frame bottom Support Threaded Rod Support (Height)
	uftrnd = 17; // Upper-Frame bottom Support Threaded Rod Nut Diameter
	uftrss = 10; // Upper-Frame bottom Support Screw Space
	ufbshtrd = 8; // Upper-Frame bottom Support Horizontal Threaded Rod Diameter
	
	//Upper-Frame bottom Structure Bracer
	ufbsbw = 0; // Upper-Frame bottom Structure Bracer Width (additional)
	ufbsbl = 48; // Upper-Frame bottom Structure Bracer Width
	ufbsbbpt = 10; // Upper-Frame bottom Structure Bracer Back Plate Thickness (additional)
	ufbsbfpt = gffs/2; // Upper-Frame bottom Structure Bracer Front Plate Thickness (additional)
	ufbsbpps = 1; // Upper-Frame bottom Structure Bracer Pressure Plate Space
	ufbsbctrd = 8; // Upper-Frame bottom Structure Bracer Connector Threaded Rod Diameter
	ufbsbgd = 10; // Upper-Frame bottom Structure Bracer Groundframe-Feed Distance (allocate Bracer away from the Groundframe-Feeds)
	ufbscra = 42.8; // Upper-Frame bottom Structure Bracer Connector Rod Angle
	ufbsrl = 50; // Upper-Frame bottom Structure Bracer Rotated Lenght (Lenght of Rotated Threaded Rod Holder)
	ufbsss = 6.2; // Upper-Frame bottom Structure Screw Size
	ufbsns = 10; // Upper-Frame bottom Structure Nut Size
	ufusbw = 0; // Upper-Frame upper Structure Bracer Width (additional)
	ufusbl = 39; // Upper-Frame upper Structure Bracer Lenght 
	ufusrl = 36.4; // Upper-Frame upper Structure Rotated-Lenght 
	ufusrlp = 18.5; // Upper-Frame upper Structure Rotated-Lenght Position
	
	//Upper Frame bottom Structure Bracer Sideways
	ufbsbsw = 15; //Upper-Frame bottom Structure Sidways Width (whole thickness of Structure)
	ufbsbsl = 40; //Upper-Frame bottom Structure Sidways Lenght
	ufbsbsss = 3; //Upper-Frame bottom Structure 
	usbsbstd = 8; //Upper-Frame bottom Structure Threaded-Rod Diameter (Bracing of Frame)
	usbsbsns = 13; //Upper-Frame bottom Structure Nut Size (Threaded Rod of Bracing the Frame)
	usbsbsstrh = 0.5; //Upper-Frame bottom Structure Sharpening Threaded Rod Holder (just for look)
	usbsbstra = 31; //Upper-Frame bottom Structure Threaded Rod Angle (Just for Simulation) ( echo(asin(1/(872.837/493.4))) )
	
	//Cable Claps
	cccs = 10; // Cable Claps Cable Size
	cccd = 10; // Cable Claps Cable Diameter
	cczs = 4; // Cable Claps Zipper Size

//Workpiece Size
wowp = 760; //Width of Workplace
lowp = 460; //Length of Workplace
howp = 304; //Height of Workplace

//Workspace Mounting-Solutions
wmss = 33; //Size of Mountingplates (on Top of the Inner-Frame)
wmst = 6; //Height of Mountingplates (on Top of the Inner-Frame)
wmsh = 6; //Diameter of the Hole in Mountingplates (4 Holes each Mountingplate)

//Define Automatic Variables

//X-Axis - Adjust Belt-Tightener Height/Position to the Belt
xapob = (gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)+xams/2+xammpfs/2+xaabh-xadob/2-xahob)-(gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)+xaposrfb+xaholbh); //Hight
xabspfto = (-(xawotc-xadbttsr-xawolbh)/2-xawobt/2)+(zasw-xammpt-xaamm-xawwt/2-(xawob-xawobt)/2); //Position

//Y-Axis - Adjust Belt-Corridor (DO NOT WORK CORRECTLY AT THE MOMENT)
// xabp = +(gfshh+yasrh-zauph-xalbh+xarsr+xalbh)+(xams/2+xammpfs/2+xaabh-xadob/2-xahob);

//#################################################################
//Dont touch Code below



//Print Parts Logic
//These Commands will be used outside of this File //TODO - Not ready jet

//Calibration Tool
printtestsizes = true; // Print Test-Sizes (Test Linear-Bearing/Smooth-Rod, Smooth-Rod Clamp, Threaded Rod Fitting, Nut-Trap)
printtestsizesh = 10; // Print Test-Sizes Hight
printtestsizesd = 10; // Print Test-Sizes Distances

//HardyGraph 
printgff = false; // Print Groundframe Feeds (Print 1x)
printgffd = 10; //Print Groundframe Feeds Distance (Distances between Feeds to Print)
printifc = false; // Print Inner-Frame Compounds (Print 1x)
printifcd = 10; //Print Inner-Frame Compound Distance (Distances between Compounds to Print)
printiff = false; // Print Inner-Frame Feeds (Print 1x)
printiffd = 30; //Print Inner-Frame Feeds Distance (Distances between Feeds to Print)
printyab = false; // Print Y-Axis Bearing Structure (Print 2x (carefully, be sure Bearings - off))
printyae1 = false; // Print Y-Axis Engine Structure left (Print 1x (carefully, be sure Engines - off))
printyae2 = false; // Print Y-Axis Engine Structure right (Print 1x (carefully, be sure Engines - off))
printzas1 = false; // Print Z-Axis Structure left (Print 1x (carefully, be sure Engines - off))
printzas2 = false; // Print Z-Axis Structure right (Print 1x (carefully, be sure Engines - off))
printxas1 = false; // Print X-Axis Structure left (Print 1x (carefully, be sure Engines/Pulleys/Bearings - off, Membran - on))
printxas2 = false; // Print X-Axis Structure right (Print 1x (carefully, be sure Engines/Pulleys/Bearings - off, Membran - on))
printxcarrier = false; // Print X-Axis Tool-Carrier (Print 1x)
printtightenery = false; // Print Y-Axis Belt-Tightener (Print 1x)
printtightenerx = false; // Print X-Axis Belt-Tightener (Print 1x)
printdremelh = false; // Print Dremel Holder (Print 1x for Engraving)
  printdremelhp1 = 2.0; //Dremel Holder Thread-Pitch (Standard)
printdremelht = false; // Print Dremel Holder Test-Threads (3. Threads printdremelhp1/2/3) (Print 1x for Testing)
  printdremelhp2 = 2.0; //Test Thread-Pitch 2
  printdremelhp3 = 2.1; //Test Thread-Pitch 3
printpenh = false; // Print Pen Holder (Print 1x for Drawing)
  printpend = 10.4; // Pen Hole Diameter
  printpendh = 30; // Pen Dome Height
printautoblvl = false; //Print Auto-Bed-Leveling Structure
printufs1 = false; //Print Upper-Frame left (Print 1x)
printufs2 = false; //Print Upper-Frame right (Print 1x)
printufbt = false; //Print Upper-Frame Belt Tightener (Print Methods on Display: true, false, all, slot) (Print 2x)
printufdp = false; //Print Upper-Frame Deflektion Pulley (Print 2x)
printufbs1 = false; //Print Upper-Frame bottom Structure (low) 1 (Print 1x)
printufbs2 = false; //Print Upper-Frame bottom Structure (low) 2 (Print 1x)
printufbs3 = false; //Print Upper-Frame bottom Structure (low) 3 (Print 1x)
printufbs4 = false; //Print Upper-Frame bottom Structure (low) 4 (Print 1x)
printufbs5 = false; //Print Upper-Frame bottom Structure (hight) 5 (Print 2x)
printufbs6 = false; //Print Upper-Frame bottom Structure (hight) 6 (Print 2x)
printufbses = false; //Print Upper-Frame bottom Emergency-Stop Structure (Print 2x, if Emergency-Stop needed)
printufb1 = false; //Print Upper-Frame Bracer 1 (Print 1x)
printufb2 = false; //Print Upper-Frame Bracer 2 (Print 2x)
printufb3 = false; //Print Upper-Frame Bracer 3 (Print 1x)
printufb4 = false; //Print Upper-Frame Bracer 4 (Print 1x)
printufb5 = false; //Print Upper-Frame Bracer Sideways 1 (Print 8x)
printcc1 = false; //Print Cable Clamps 1 (on Nema-Engine) (Print 2x)

//Define MODULE
    //Threaded Rod / length, rotationx, rotationy, rotationz
    module trod(length,rotationx,rotationy,rotationz, diameter) {
      trodd = diameter == empty ? dotr : diameter;
      if (showtrod == true) color ("Aqua") rotate (a=[rotationx,rotationy,rotationz]) cylinder (h = length, r = trodd/2);
    }
    
    //Smooth Rod / length, rotationx, rotationy, rotationz 
    module srod(length,rotationx,rotationy,rotationz, size) {
      if (showsrod == true) color ("Gainsboro") rotate (a=[rotationx,rotationy,rotationz]) cylinder (h = length, r = size/2);
    }
    
    //Difference Rod, just to make holes in structures / length, rotationx, rotationy, rotationz
    module drod(length,rotationx,rotationy,rotationz) {
      rotate (a=[rotationx,rotationy,rotationz]) cylinder (h = length, r = dotr/2+dotra/2);
    }
    
    //Membran, place in difficult Areas for printing / width, lenght, center? 
    module membran(width,lenght,center) {
      if (printmode == true) {
	if (usemembran == true) {
	  if (center == true) color ("red") translate ([0,0,+membranthick/2]) cube (size = [width,lenght,membranthick], center = true);
	  else color ("red") cube (size = [width,lenght,membranthick]);
	}
      }
    }
    
    //Groundframe Feed / width, length, height, mount plate size, mount plate thickness, mount plate holes
    module gfeed(width, length, height, mps, mpt, mph) {
      if (showgfeed == true) {
	cube (size = [width,length,height]);
	if (mps) {
	  difference () {
	    translate ([gffs/2,gffs/2,height-mpt/2]) cube (center = true, size = [mps,mps,mpt]);
	    union () {
	      translate ([-mph/2,-mph/2,height-mpt-1]) cylinder (h = mpt+2, r = mph/2);
	      translate ([width+mph/2,-mph/2,height-mpt-1]) cylinder (h = mpt+2, r = mph/2);
	      translate ([width+mph/2,length+mph/2,height-mpt-1]) cylinder (h = mpt+2, r = mph/2);
	      translate ([-mph/2,length+mph/2,height-mpt-1]) cylinder (h = mpt+2, r = mph/2);
	    }
	  }
	}
      }
    }
    
    //Motormount / flip (bolean) arround x, rotate arround x, size of nema motor, nema-engine flange size, nema-engine flange depth, width of mounting plate, space on mounting plate, nema motor screw hole distance, size of screw holes, single shaft engine simulation
    module mm(flipx, rotate, sonm, nefs, nefd, womp, somp, nmshd, sosh, sses) {
      mirror ([flipx,0,0]) rotate ([rotate,0,0]) {
	difference () {
	  cube (size = [womp,sonm+somp,sonm+somp]);
	  union() {
	    //Difference of NemaPlace
	    translate ([womp-2,somp/2,somp/2]) cube (size = [3,sonm,sonm]);
	    //Screwholes
	    translate ([-1,(sonm/2)+(somp/2)+nmshd/2,(sonm/2)+(somp/2)+nmshd/2]) rotate ([90,0,90]) cylinder (h = womp+2, r = sosh/2); //Screwhole
	    translate ([-1,(sonm/2)+(somp/2)+nmshd/2,(sonm/2)+(somp/2)-nmshd/2]) rotate ([90,0,90]) cylinder (h = womp+2, r = sosh/2); //Screwhole
	    translate ([-1,(sonm/2)+(somp/2)-nmshd/2,(sonm/2)+(somp/2)+nmshd/2]) rotate ([90,0,90]) cylinder (h = womp+2, r = sosh/2); //Screwhole
	    translate ([-1,(sonm/2)+(somp/2)-nmshd/2,(sonm/2)+(somp/2)-nmshd/2]) rotate ([90,0,90]) cylinder (h = womp+2, r = sosh/2); //Screwhole
	    translate ([-1,(sonm/2)+(somp/2),(sonm/2)+(somp/2)]) rotate ([90,0,90]) cylinder (h = womp+2, r = (sosh*2.5)/2); //Wave-Hole
	    translate ([womp-2-nefd,(sonm/2)+(somp/2),(sonm/2)+(somp/2)]) rotate ([90,0,90]) cylinder (h = nefd+1, r = nefs/2); //Flange of Nema-Engine
	  }
	}
	if (sses == true) {
	  translate ([wess+womp-2,somp/2,somp/2]) sengine (0, 0, 90, sonm, wess, wesss);
	} else {
	  translate ([weds+womp-2,somp/2,somp/2]) sengine (0, 0, 90, sonm, weds, wedss, wedse);
	}
      }
    }
    
    //Stepper Engine / rotate arround x, rotate arround y, rotate arround z, width, lenght, front shaft lenght, bach shaft lenght
    module sengine (rax, ray, raz, width, lenght, fsl, bsl) {
      if (showengines == true) {
	rotate ([rax,ray,raz]) {
	  color("DimGray") {
	    cube (size = [width,lenght,width]);
	  }
	  color("Silver") {
	    translate ([width/2,lenght+fsl,width/2]) rotate ([90,0,0]) cylinder (h = fsl, r = 5/2);
	    if (bsl > 0) translate ([width/2,0,width/2]) rotate ([90,0,0]) cylinder (h = bsl, r = 5/2);
	  }
	}
      }
    }
    
    //ZZ-Bearing / rotate arround z, diameter of bearing, width of bearing, hole in bearing
    module zzb(flipx, rotate, dob, wob, hib) {
      if (showbearing == true) {
	rotate ([90,0,rotate]) {
	  color("Cyan") {
	    difference () {
		cylinder (h = wob, r = dob/2);
		translate ([0,0,-1]) cylinder (h = wob+2, r = hib/2);
	    }
	  }
	}
      }
    }
    
    //Pulley / rotate arround z, diameter of pulley, width of pulley, hole in pulley
    module pulley(flipx, rotate, dop, wop, hip) {
      if (showpulleys == true) {
	rotate ([90,0,rotate]) {
	  color("WhiteSmoke") {
	    difference () {
		cylinder (h = wop, r = dop/2);
		translate ([0,0,-1]) cylinder (h = wop+2, r = hip/2);
	    }
	  }
	}
      }
    }
      
    //Belt / rotate arround z, Lenght of belt, width of belt, height of belt
    module belt(rotate, lob, wob, hob) {
      if (showbelts) {
	rotate ([0,0,rotate]) {
	  color("DarkViolet") {
	    cube (size = [wob,lob,hob]);
	  }
	}
      }
    }
    
    //Groundframe Y-Axis Supporter / width, length, height, flip (bolean) arround x, rotate arround z, Size of Bearing, Diameter of Bearing, Space Add of Bearing Width, Hole Diameter for Bearing-Screw
    module yasup(width, length, height, flipx, rotate, bearingdia, bearingwidth, bearingschlupf, bearingholefromtop, bearingholedia) {
      if (showgfeed == true) {
	mirror ([flipx,0,0]) rotate ([0,0,rotate]) {
	  translate ([width+(bearingdia/2+2),length/2+bearingwidth/2,height-bearingholefromtop]) zzb (0,0,bearingdia,bearingwidth,bearingholedia); //Simulate ZZ-Bearing
	  difference () {
	    union () {
	      cube (size = [width,length,height]); //Ground-Block
 	      translate ([width,(length-(bearingwidth+20))/2,0]) cube (size = [bearingdia/2+22,bearingwidth+20,height]); //Bearing-Holding Structure
	    }
	    translate ([width,(length-bearingwidth-bearingschlupf)/2,-1]) cube (size = [bearingdia/2+22+1,bearingwidth+bearingschlupf,height+2]); //Space for Bearing to fix in
	    translate ([-1,(length-bearingwidth-bearingschlupf)/2,height-bearingdia/2-bearingholefromtop-2.5]) cube (size = [width+2,bearingwidth+bearingschlupf,bearingdia+5]); //Hole for Belts
	    translate ([width+(bearingdia/2+22)-bearingholefromtop,-1,height]) rotate ([0,45,0]) cube (size = [bearingdia+height,length+2,height]); //Clip Edges Top
	    translate ([width+(bearingdia/2+22)-(height-bearingholefromtop),-1,0]) mirror ([1,0,0]) rotate ([0,-135,0]) cube (size = [bearingdia+height,length+2,height]); //Clip Edges Bottom
	    translate ([width+(bearingdia/2+2),(length-bearingwidth-20-2)/2,height-bearingholefromtop]) rotate ([90,0,180]) cylinder ( h = bearingwidth+20+2, r = bearingholedia/2 ); //Bearing Fix-Hole
	  }
	}
      }
    }
    //Groundframe Y-Axis MotorMount / width, length, height, flip (bolean) arround x, rotate z, space between the two threadedrod holder, size of stepper-engine, nema-engine flange size, nema-engine flange depth, space between top and stepper engine, size of nema screws, distance between engine-mounting-holes
    module yamm(width, length, height, flipx, rotate, spacebtw, nemasize, nefs, nefd, nemaspacefromtop, nemascrewhole, nemascrewholedistance) {
      if (showgfeed == true) {
	mirror ([flipx,0,0]) rotate ([0,0,rotate]) {
	  cube (size = [width,length,height]);
	  translate ([width+spacebtw,0,0]) cube (size = [width,length,height]);
	  translate ([width,0,0]) cube (size = [spacebtw,length,5]);
	  //MotorMount Plate
	  difference () {
	    union () {
	      translate ([width,0,height-nemasize-5-nemaspacefromtop]) cube (size = [spacebtw+width,length+nemasize+5,5]); //Bottom Support Structure
	      translate ([width,0,height-5-nemaspacefromtop]) cube (size = [spacebtw+width,length+nemasize+5,5]); //Top Support Structure
	    }
	      translate ([0,0,-2]) linear_extrude(height = height+3, convexity = 10, twist = 0) polygon(points=[[width+spacebtw+width,length],[width+spacebtw+width+0.1,length+nemasize+5.1],[width,length+nemasize+5.1]], paths=[[0,1,2]]);
	  }
	  
// 	  translate ([width,0,lsab-gfshh-(dotr/2+dotra/2)-1.5]) cube (size = [spacebtw,length,dotr+dotra+3]); //Lower Rod-Support Structure
	  translate ([width,0,lsab2-gfshh-(dotr/2+dotra/2)-1.5]) cube (size = [spacebtw,length,dotr+dotra+3]); //Upper Rod-Support Structure

	    translate ([width,length,height-nemasize-5-nemaspacefromtop]) mm (1,0,nemasize, nefs, nefd, 10, 5, nemascrewholedistance, nemascrewhole, false); //Motor-Mounting-Plate
	    translate ([width,length+(nemasize+5)/2,height-(nemasize+5)/2-nemaspacefromtop]) pulley (0,90,spoxad,spoxaw,spoxah); //Simulate Pulley

	}
      }
    }
    //Groundframe Y-Axis Smooth-Rod Mount / width, length, height, flip (bolean) arround z, rotate arround Z, height of clip, distance between clip and base, size of smooth-rod, size of screw hole, distance between smooth-rod and nut trap
    module yasrm(width, length, height, flipz, rotate, hoc, dbc, sosr, sosh, dbsrant) {
      if (showgfeed == true) {
	mirror ([0,0,flipz]) rotate ([0,0,rotate]) {
	  difference () {
	    union() {
	      cube (size = [width,length,height]); //Lower Body
	      translate ([0,0,height+dbc]) cube (size = [width,length,hoc]); //Upper Body
	    }
	      translate ([-1,length/2,height+(dbc/2)]) rotate ([0,90,0]) cylinder (h = width+2, r = sosr/2); //SmootRod
	      translate ([width/2,length/2-(sosr/2)-5,-1]) cylinder (h = height+hoc+dbc+2, r = sosh/2); //Screw Hole
	      translate ([width/2,length/2+(sosr/2)+5,-1]) cylinder (h = height+hoc+dbc+2, r = sosh/2); //Screw Hole
	      translate ([width/2-sosh,-1,height+(dbc/2)-dbsrant]) cube (size = [sosh*2,length/2-(sosr/2)-4+sosh,sosh]); //Nut Trap
	      translate ([width/2-sosh,length/2+(sosr/2)+5-sosh,height+(dbc/2)-dbsrant]) cube (size = [sosh*2,length/2-(sosr/2)-4+sosh,sosh]); //Nut Trap
	  }
	}
      }
    }
    
    //Z-Axis Carrier (Round) / width, length, height, flip (bolean) arround z, rotate arround x, width of linear bearing, length of linear bearing, distance of bearing to the rear ends, allocate bearing to the outside, size of tightener, size of smooth rod, additional space of smooth rod, width of belt, height of belt, tollerance for Belt
    module zacr(width, length, height, flipx, rotate, wolb, lolb, dobtre, abtho, sot, sosr, asosr, wob, hob, pob, tfb) {
      mirror ([0,0,flipx]) rotate ([0,0,rotate]) {
	difference () {
	  union() {
	    cube (size = [width,length,height/2]);
	    translate ([0,length/2,height/2]) rotate ([0,90,0]) cylinder (h = width, r = length/2);
	  }
	  union() {
	    translate ([-1,0,-10]) cube (size = [width+2,length,10]); //Cut of the Cylinder-Overhang
	    translate ([dobtre,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = lolb, r = wolb/2); //Linear Bearing 1. Hold
	    translate ([dobtre+lolb/2-(sot/2),-1,height-abtho-wolb/2-3]) cube (size = [sot,length+2,sot/2]); //Tightener for 1. Hold
	    translate ([width-lolb-dobtre,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = lolb, r = wolb/2); //Linear Bearing 2. Hold
	    translate ([width-dobtre-lolb/2-(sot/2),-1,height-abtho-wolb/2-3]) cube (size = [sot,length+2,sot/2]); //Tightener for 2. Hold
	    translate ([-1,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = width+2, r = sosr/2+asosr); //Smooth Rod
	    translate ([width-dobtre-lolb,-1,height-abtho-wolb/2]) cube (size = [0.5,length+2,wolb]); //1. Clip-Cut Bearing 2. Hold
	    translate ([width-dobtre-0.5,-1,height-abtho-wolb/2]) cube (size = [0.5,length+2,wolb]); //2. Clip-Cut Bearing 2. Hold
	    translate ([dobtre+lolb-0.5,-1,height-abtho-wolb/2]) cube (size = [0.5,length+2,wolb]); //1. Clip-Cut Bearing 1. Hold
	    translate ([dobtre,-1,height-abtho-wolb/2]) cube (size = [0.5,length+2,wolb]); //2. Clip-Cut Bearing 1. Hold
	    if (wob != 0) translate ([-1,length/2-wob/2-tfb/2,pob-tfb/2]) cube (size = [width+2,wob+tfb,hob+tfb]); //Belt Corridor
	  }
	}
      }
    }
    //Z-Axis Carrier (Closed) / width, length, height, flip (bolean) arround z, rotate arround x, width of linear bearing, length of linear bearing, distance of bearing to the rear ends, allocate bearing to the outside, size of tightener, size of smooth rod, additional space of smooth rod, distance of z-smooth-rods to the rear ends, z-smooth-rod width, z-smooth-rod pair difference, width of belt,  tightener from engine (position from top), belt tightener from bearing (position from top), belt tightener length, belt tightener screw width, belt-tightener allen screw size, printmode
    module zacc(width, length, height, flipx, rotate, wolb, lolb, dobtre, abtho, sot, sosr, asosr, dozsr, zsrw, zsrpd, wob, btfe, btfb, btl, btsw, btass, pm) {
      mirror ([0,0,flipx]) rotate ([rotate,0,0]) {
	if (pm == 2 || printmode == false) {
	    translate ([width-btl,length/2-wob/2-1.75,btfe+0.25]) { //Belt Tightener Structure (Belt from Engine)
	      difference () {
		cube (size = [btl/3*2,wob+3.5,wob+3.5]); //Belt Tightener
		union () {
		  translate ([btl/3*2-((btl/3*2-10)/3*0.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		  translate ([btl/3*2-((btl/3*2-10)/3*1.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		  translate ([btl/3*2-((btl/3*2-10)/3*2.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		  translate ([9,1.25,wob/2+xabh-0.5]) cube ( size = [btl,wob+1,xabh+1]); //Belt Corridor
		  translate ([3,1.75,1.5]) cube ( size = [7,wob+3,wob+3.5-3]); //Nut Rotate Chamber
		  translate ([-1,(wob+3.5)/2,(wob+3.5)/2]) rotate ([0,90,0]) cylinder (h = 5, r = btsw/2); //Belt Tightener Slot Scew Shaft
		}
	      }
	    }
	    if (pm ==2) {
	      translate ([btl,length/2-wob/2-1.75,btfe+0.25]) { //Belt Tightener Structure (Belt from Bearing)
		mirror ([1,0,0]) {
		  difference () {
		    cube (size = [btl/3*2,wob+3.5,wob+3.5]); //Belt Tightener
		    union () {
		      translate ([btl/3*2-((btl/3*2-10)/3*0.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([btl/3*2-((btl/3*2-10)/3*1.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([btl/3*2-((btl/3*2-10)/3*2.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([9,1.25,wob/2+xabh-0.5]) cube ( size = [btl,wob+1,xabh+1]); //Belt Corridor
		      translate ([3,1.75,1.5]) cube ( size = [7,wob+3,wob+3.5-3]); //Nut Rotate Chamber
		      translate ([-1,(wob+3.5)/2,(wob+3.5)/2]) rotate ([0,90,0]) cylinder (h = 5, r = btsw/2); //Belt Tightener Slot Scew Shaft
		    }
		  }
		}
	      }
	    } else {
	      translate ([btl,length/2-wob/2-1.75,btfb+0.25]) { //Belt Tightener Structure (Belt from Bearing)
		mirror ([1,0,0]) {
		  difference () {
		    cube (size = [btl,wob+3.5,wob+3.5]); //Belt Tightener
		    union () {
		      translate ([btl-((btl-10)/3*0.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([btl-((btl-10)/3*1.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([btl-((btl-10)/3*2.5),(wob+3.5)/2,-1]) cylinder ( h = wob+3.5+2, r = btass/2); //Belt fix Screw 1
		      translate ([9,1.25,wob/2+xabh-0.5]) cube ( size = [btl,wob+1,xabh+1]); //Belt Corridor
		      translate ([3,1.75,1.5]) cube ( size = [7,wob+3,wob+3.5-3]); //Nut Rotate Chamber
		      translate ([-1,(wob+3.5)/2,(wob+3.5)/2]) rotate ([0,90,0]) cylinder (h = 5, r = btsw/2); //Belt Tightener Slot Scew Shaft
		    }
		  }
		}
	      }
	    }
	  }
	if (pm == 1 || printmode == false) {
	  translate ([0,0,height-0.025]) cube (size = [width,length,0.025]); //Renderhelp #1 (Body to "Z-Axis Carrier Round")
	  
	  difference () {
	    union() {
	      cube (size = [width,length,height-0.025]); //Block for Drilling :-)
	    }
	      translate ([dobtre,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = lolb, r = wolb/2); //Linear Bearing 1. Hold
	      translate ([dobtre,-1,height-abtho-(wolb/2)]) cube (size = [lolb,length/2+1,wolb]); //Linear Bearing 1. Input-Slot
	      translate ([dobtre+lolb/2-(sot/2),-1,height-abtho-wolb/2-sot/2]) cube (size = [sot,length+2,sot/2+0.025]); //Tightener1 for 1. Hold
	      translate ([dobtre+lolb/2-(sot/2),-1,height-abtho+wolb/2-0.025]) cube (size = [sot,length+2,sot/2]); //Tightener2 for 1. Hold
	      translate ([dobtre+lolb/2-(sot/2),-1,height-abtho+wolb/2-0.025]) membran (sot,length/2+1); //Membran for Tightener1 for 1. Hold
	      translate ([width-lolb-dobtre,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = lolb, r = wolb/2); //Linear Bearing 2. Hold
	      translate ([width-dobtre-lolb,-1,height-abtho-(wolb/2)]) cube (size = [lolb,length/2+1,wolb]); //Linear Bearing 2. Input-Slot
	      translate ([width-dobtre-lolb/2-(sot/2),-1,height-abtho-wolb/2-sot/2]) cube (size = [sot,length+2,sot/2+0.025]); //Tightener1 for 2. Hold
	      translate ([width-dobtre-lolb/2-(sot/2),-1,height-abtho+wolb/2-0.025]) cube (size = [sot,length+2,sot/2]); //Tightener2 for 2. Hold
	      translate ([-1,length/2,height-abtho]) rotate ([0,90,0]) cylinder (h = width+2, r = sosr/2+asosr); //Smooth Rod
	      translate ([dozsr,length/2+zsrpd,-1]) cylinder (h = height, r = zsrw/2); //1. Z - Smooth Rod
	      translate ([width-dozsr,length/2-zsrpd,-1]) cylinder (h = height, r = zsrw/2); //2. Z - Smooth Rod
	      translate ([width-btl,length/2-wob/2-2,btfe]) cube (size = [btl+1,wob+4,wob+4]); //Belt Tightener Slot for Engine-Sided-Belt
	      translate ([-1,length/2,btfe+wob/2+2]) rotate ([0,90,0]) cylinder (h = width-btl+2, r = btsw/2); //Belt Tightener Slot Scew Shaft for Engine-Sided-Belt
	      translate ([-1,length/2-wob/2-2,btfb]) cube (size = [btl+1,wob+4,wob+4]); //Belt Tightener Slot for Engine-Sided-Belt
	      translate ([btl-1,length/2,btfb+wob/2+2]) rotate ([0,90,0]) cylinder (h = width-btl+2, r = btsw/2); //Belt Tightener Slot Scew Shaft for Engine-Sided-Belt
	  }
	}
	//Place Membran for unprintable Sections
	if (printtightenery == false) {
	  translate ([dobtre+lolb/2-(sot/2),0,height-abtho+wolb/2-0.025]) membran (sot,length/2); //Membran for Tightener2 for 1. Hold
	  translate ([width-dobtre-lolb/2-(sot/2),0,height-abtho+wolb/2-0.025]) membran (sot,length/2); //Membran for Tightener2 for 2. Hold
	}
      }
    }
    //Z-Axis Structure / width, length, hight of structure (lbh (lower block hight) added!), flip (bolean) arround z, rotate arround x, width of linear bearing, length of linear bearing, distance of bearing to the rear ends, allocate bearing to the outside, size of tightener, size of smooth rod, additional space of smooth rod, distance between upper to lower smooth rod, lower block height (usually 30), size of nema motor, nema-engine flange size, nema-engine flange depth, width of engine support structure (sum), width of engine base plate (-2 for engine), distance of nema screw holes, size of nema screw holes, distance of z-smooth-rods to the rear ends, z-smooth-rod width, width of belt, hight of belt, position of belt, z-smooth-rod pair difference, Tollerance for Belt, Belt Tightener from Engine (Position from Top), Tollerance for Belt, Belt Tightener from Engine (Position from Top), Belt Tightener Lenght, Belt-Tightener Allen Screw Size, Printmode
    module zas (width, length, height, flipx, rotate, wolb, lolb, dobtre, abtho, sot, sosr, asosr, dblsr, lbh, sonm, nefs, nefd, woess, woebp, donsh, sonsh, dozsr, zsrw, wob, hob, pob, zsrpd, tfb, btfe, btfb, btl, btsw, btass, pm) {
       zacc (width,length,height,flipx,rotate,wolb,lolb,dobtre,dblsr-lbh+abtho,sot,sosr,asosr,dozsr,zsrw,zsrpd,wob,btfe,btfb,btl,btsw,btass,pm); //Z-Axis Carrier (Closed)
       translate ([0,0,-height]) zacr (width,length,lbh,flipx,rotate,wolb,lolb,dobtre,abtho,sot,sosr,asosr,wob,hob,pob,tfb); //Z-Axis Carrier (Round)
       translate ([width/2+(sonm/2)+(woess/2),length+0.05,+0.05]) rotate ([0,90,90]) mm (0,0,sonm,nefs,nefd,woebp,woess,donsh,sonsh,true); //MotorMount
       translate ([width/2-sonm/2-woess/2,length+sonm+0.025,-woebp]) rotate ([270,0,-90]) linear_extrude(height = woess/2, convexity = 10, twist = 0) polygon(points=[[sonm,0],[0,0],[sonm,sonm]], paths=[[0,1,2]]); // MotorMount Support Structure
       translate ([width/2+sonm/2,length+sonm+0.025,-woebp]) rotate ([270,0,-90]) linear_extrude(height = woess/2, convexity = 10, twist = 0) polygon(points=[[0,0],[sonm,0],[sonm,sonm]], paths=[[0,1,2]]); //MotorMount Support Structure
       translate ([width/2-(sonm/2)-(woess/2),length,-sonm-woebp]) cube (size = [sonm+woess,0.025,sonm+woebp]);
    }
    
    //X-Axis Motor/Bearingmount / flip (bolean) arround x, flip (bolean) arround y, rotate arround x, Use Engine (Bolean!), X-Axis Carrier Width, X-Axis Carrier Lenght, X-Axis Carrier Height, Smooth Rod Size, Distance of Smooth Rods to the Outside, Smooth Rods Difference, Width of Linear Bearing, Lenght of Linear Bearing, Width of Linear Bearing Support Structure, position of first linear bearing, space between two linear bearings, distance of the x smooth rods, x-axis smooth rod size, adjust x-axis smooth rod from bottom, X-Axis Smooth Rod Support Structure, X-Axis Smooth Rod Mount Scew Size, X-Axis Smooth Rod Mount Screw Difference, adjust motor mount (0 = Mid), adjust motor hight, adjust bearing hight, motor mounting plate thickness, motor size, motor flange size, motor flange depth, mounting plate frame size, motor mounting plate screw size, motor mounting plate screws distance, Z-Axis Size of Nema Motor, Z-Axis Width of Engine Support Structure, Z-Axis Threaded Rod Size, Z-Axis Nut-Trap Feather-Range, Z-Axis Width of Nut, Z-Axis Nut Trap Support Structure, hight of support bridge, width of bearing, diameter of bearing, hole in bearing, bearing width tollerance
    module xac(flipx, flipy, rotate, ue, xcw, xcl, xch, srs, dozsr, zsrd, wolb, lolb, wolbss, poflb, sbtlb, dotxsr, xasrs, axasrfb, xasrss, xasrmss, xasrmssd, amm, amh, abh, mmpt, ms, mfs, mfd, mmpfs, mmpss, mmpsd, zasonm, zawoess, zatrs, zafr, zawon, zantss, hosb, wob, dob, hib, wwt) {
      mirror ([flipx,flipy,0]) rotate ([rotate,0,0]) {
	difference () { //Difference Section
	  union() {
	    cube (size = [xcw,xcl,xch]);
	    translate ([dozsr,xcl/2-zsrd,0]) cylinder (h = lolb+poflb+sbtlb+lolb+poflb, r = wolb/2+wolbss); //Support Structure 1
	    translate ([dozsr-wolb/2-wolbss,xcl/2-zsrd-wolb/2-wolbss/4,0]) cube (size = [wolbss,wolb+wolbss/2,lolb+poflb+wolbss/4]); //Support Input Shaft Linear Bearing 1
	    translate ([xcw-dozsr,xcl/2+zsrd,0]) cylinder (h = lolb+poflb+sbtlb+lolb+poflb, r = wolb/2+wolbss); //Support Structure 2
	    translate ([dozsr+wolb/2,xcl/2-zsrd-wolb/2-wolbss/4,0]) cube (size = [wolbss,wolb+wolbss/2,lolb+poflb+sbtlb+lolb+poflb]); //Support Input Shaft Linear Bearing 2
	    translate ([xcw-dozsr+wolb/2,xcl/2+zsrd-wolb/2-wolbss/4,0]) cube (size = [wolbss,wolb+wolbss/2,lolb+poflb+wolbss/4]); //Support Input Shaft Linear Bearing 3
	    translate ([xcw/2+dotxsr/2,xcl/2+zsrd+wolb/2+wolbss,axasrfb]) rotate ([90,0,0]) cylinder (h = (zsrd+wolb/2+wolbss)*2, r = xasrs/2+xasrss/2); //X Axis Smooth Rod 1 Support
	    translate ([xcw/2-dotxsr/2,xcl/2+zsrd+wolb/2+wolbss,axasrfb]) rotate ([90,0,0]) cylinder (h = (zsrd+wolb/2+wolbss)*2, r = xasrs/2+xasrss/2); //X Axis Smooth Rod 2 Support
	    if (printmode == true) { //Place Support for X Axis Smooth Rod Support in Printmode
	      translate ([xcw/2-dotxsr/2-xasrs/2,xcl/2+zsrd+wolb/2+wolbss-xasrs,0]) color ("red") cube (size = [xasrs,xasrs,axasrfb-xasrs/2-xasrss/2-0.4]); //Left Support
	      difference () {
		translate ([xcw/2+dotxsr/2-xasrs/2,xcl/2+zsrd+wolb/2+wolbss-xasrs,0]) color ("red") cube (size = [xasrs,xasrs,axasrfb-xasrs/2-xasrss/2-0.4]); //Right Support
		translate ([xcw-dozsr,xcl/2+zsrd,-1]) cylinder (h = axasrfb-xasrs/2-xasrss/2-0.4+2, r = wolb/2+wolbss+1); //Simulated Support Structure 2
	      }
	    }
	    translate ([xcw/2-dotxsr/2,xcl/2-xasrmssd,axasrfb+xasrs/2]) cylinder (h = 7, r = xasrmss); //X Axis Mounting Screw Support
	    translate ([xcw/2+dotxsr/2,xcl/2+xasrmssd,axasrfb+xasrs/2]) cylinder (h = 7, r = xasrmss); //X Axis Mounting Screw Support
	    if (ue==1) {
		translate ([xcw-mmpt-amm,0,amh]) mm (0,90,ms,mfs,mfd,mmpt,mmpfs,mmpsd,mmpss,true); //Motormount
		translate ([xcw-mmpt-amm-spoxaw-1,-ms/2-mmpfs/2,ms/2+mmpfs/2+amh]) pulley (0,90,spoxad,spoxaw,spoxah); //Simulate Pulley
	    } else {
		translate ([xcw-mmpt-amm,-zawoess/2-zasonm/2,abh]) cube (size = [poflb*2,zawoess/2+zasonm/2,ms+mmpfs]); //Bearingmount
		if (showbearing == true) translate ([xcw-mmpt-amm-wob-wwt/2,-(zawoess/2+zasonm/2)/2,(ms/2)+(mmpfs/2)+abh]) zzb (0,90,dob,wob,hib); //Simulation of a ZZ-Bearing
		translate ([xcw-mmpt-amm-wob-poflb*2-wwt,-zawoess/2-zasonm/2,abh]) cube (size = [poflb*2,zawoess/2+zasonm/2,ms+mmpfs]); //Bearingmount
	      }
	    if (ue==1) translate ([xcw-mmpt-amm,-ms-mmpfs,amh]) rotate ([0,90,0]) linear_extrude(height = poflb*2, convexity = 10) polygon (points = [[0,0],[amh,ms/3],[amh,ms+mmpfs],[0,ms+mmpfs]], paths = [[0,1,2,3]]); //Motormount Bottom Support
	      else {
		translate ([xcw-mmpt-amm,-zawoess/2-zasonm/2,abh]) rotate ([0,90,0]) linear_extrude(height = poflb*2, convexity = 10) polygon (points = [[0,0],[abh,(zawoess/2+zasonm/2)/3],[amh,zawoess/2+zasonm/2],[0,zawoess/2+zasonm/2]], paths = [[0,1,2,3]]); //Bearing Bottom Support
		translate ([xcw-mmpt-amm-wob-poflb*2-wwt,-zawoess/2-zasonm/2,abh]) rotate ([0,90,0]) linear_extrude(height = poflb*2, convexity = 10) polygon (points = [[0,0],[abh,(zawoess/2+zasonm/2)/3],[amh,zawoess/2+zasonm/2],[0,zawoess/2+zasonm/2]], paths = [[0,1,2,3]]); //Bearing Bottom Support
	      }
	    translate ([xcw-mmpt-amm,0,xch]) cube (size = [mmpt,xcl/2+zsrd,-xch+amh+ms+mmpfs]); //Motormount Right Support 
	    translate ([xcw/2,-zawoess/2-zasonm/2,0]) cylinder (h = poflb+zafr, r = zatrs+zantss/2); //Z-Axis Threaded Rod Nut-Trap Support
	    linear_extrude(height = poflb*2, convexity = 10) polygon (points = [[0,0],[xcw/2,-zawoess/2-zasonm/2-zatrs/2-zantss],[xcw,0]], paths = [[0,1,2]]); //Nut-Trap Baseplate
	    translate ([xcw/2-zantss/2,0,poflb+zafr]) rotate ([0,90,0]) linear_extrude(height = zantss, convexity = 10) polygon (points = [[0,-zawoess/2-zasonm/2+zatrs],[poflb+zafr,-zawoess/2-zasonm/2+zatrs],[poflb+zafr,xcl]], paths = [[0,1,2]]); //Nut-Trap Support Structure
	    translate ([xcw/2,-zawoess/2-zasonm/2,poflb+zafr-hosb]) cube (size = [xcw-mmpt-amm-xcw/2,zatrs,hosb]); //Support Bridge
	  }
	  union() {
	    translate ([dozsr,xcl/2-zsrd,-1]) cylinder (h = xch+2+poflb+lolb+sbtlb+lolb+poflb, r = srs/2+0.25); //Z-Axis Smooth Rod 1
	    translate ([xcw-dozsr,xcl/2+zsrd,-1]) cylinder (h = xch+2+poflb+lolb+sbtlb+lolb+poflb, r = srs/2+0.25); //Z-Axis Smooth Rod 2
	    translate ([dozsr,xcl/2-zsrd,poflb]) cylinder (h = lolb, r = wolb/2); //Bottom  Bearing 1
	    translate ([dozsr,xcl/2-zsrd,poflb+lolb+sbtlb]) cylinder (h = lolb, r = wolb/2); //Top  Bearing 2
	    translate ([dozsr-wolb/2-wolbss-1,xcl/2-zsrd-wolb/2,poflb]) cube (size = [(wolb/2)+wolbss+1,wolb,lolb]); //Input Shaft Linear Bearing 1
	    translate ([dozsr,xcl/2-zsrd-wolb/2,poflb+lolb+sbtlb]) cube (size = [(wolb/2)+wolbss+1,wolb,lolb]); //Input Shaft Linear Bearing 2
	    
	    translate ([xcw-dozsr,xcl/2+zsrd,poflb]) cylinder (h = lolb, r = wolb/2); //Bottom  Bearing 3
	    translate ([xcw-dozsr,xcl/2+zsrd,poflb+lolb+sbtlb]) cylinder (h = lolb, r = wolb/2); //Top  Bearing 4
	    translate ([xcw-dozsr,xcl/2+zsrd-wolb/2,poflb]) cube (size = [(wolb/2)+wolbss+1,wolb,lolb]); //Input Shaft Linear Bearing 3
	    translate ([xcw-dozsr-wolb/2-wolbss-1,xcl/2+zsrd-wolb/2,poflb+lolb+sbtlb]) cube (size = [(wolb/2)+wolbss+1,wolb,lolb]); //Input Shaft Linear Bearing 4
	    
	    translate ([xcw/2-dotxsr/2,xcl/2+zsrd+wolb/2+wolbss+1,axasrfb]) rotate ([90,0,0]) cylinder (h = (zsrd+wolb/2+wolbss)*2+2, r = xasrs/2); //X Axis Smooth Rod 1
 	    translate ([xcw/2+dotxsr/2,xcl/2+zsrd+wolb/2+wolbss+1,axasrfb]) rotate ([90,0,0]) cylinder (h = (zsrd+wolb/2+wolbss)*2+2+ms, r = xasrs/2); //X Axis Smooth Rod 2
	    
	    translate ([xcw/2-dotxsr/2,xcl/2-xasrmssd,axasrfb+xasrs/2+1]) cylinder (h = 10, r = xasrmss/2); //X Axis Mounting Screw (Placed above Smooth-Rod for printing)
	    rotate ([0,0,0]) translate ([xcw/2+dotxsr/2,xcl/2+xasrmssd,axasrfb+xasrs/2+1]) cylinder (h = 10, r = xasrmss/2); //X Axis Mounting Screw (Placed above Smooth-Rod for printing)
	    
	    if (ue==1) translate ([xcw-mmpt-amm-mmpt,xcl/2+zsrd-mmpsd/2,axasrfb+xasrs/2+7]) cube (size = [wolbss,mmpsd,lolb+poflb+sbtlb+lolb+poflb]); //Belt Place after Engine
	      else {
		translate ([xcw-mmpt-amm-mmpt,xcl/2+zsrd-mmpsd/2,axasrfb+xasrs/2+7]) cube (size = [wolbss,mmpsd,lolb+poflb+sbtlb+lolb+poflb]); //Belt Place after Bearing
		translate ([xcw-mmpt-amm-wob-poflb*2-wwt-1,-(zawoess/2+zasonm/2)/2,(ms/2)+(mmpfs/2)+abh]) rotate ([90,0,90]) cylinder (h = mmpt+2+wob+poflb*2+wwt, r = hib/2); //Bearing-Mount Hole
	      }
	    
	    translate ([xcw/2,-zawoess/2-zasonm/2,-1]) cylinder (h = poflb+zafr, r = zatrs/2); //Z-Axis Threaded Rod
	    translate ([xcw/2,-zawoess/2-zasonm/2,-1]) cylinder ($fn = 6, r = zawon/2/cos(180/6)+0.7, h = (zatrs*2/2.5)+1); //Bottom Nut-Trap
	    translate ([xcw/2,-zawoess/2-zasonm/2,(zatrs*2/2.5)+3]) cylinder ($fn = 6, r = zawon/2/cos(180/6)+0.7, h = poflb+zafr-(zatrs*2/2.5)+3); //Top Nut-Trap
	  }
	}
	//Place Membran-Layer inside of unprintable Areas
	translate ([dozsr,xcl/2-zsrd,poflb+lolb]) membran (srs,srs,true); //Bottom Membran in Support Structure 1
	translate ([dozsr,xcl/2-zsrd,poflb+lolb+sbtlb+lolb]) membran (srs,srs,true); //Top Membran in Support Structure 1
	translate ([xcw-dozsr,xcl/2+zsrd,poflb+lolb]) membran (srs,srs,true); //Bottom Membran in Support Structure 2
	translate ([xcw-dozsr,xcl/2+zsrd,poflb+lolb+sbtlb+lolb]) membran (srs,srs,true); //Top Membran in Support Structure 2
	translate ([xcw/2,-zawoess/2-zasonm/2,(zatrs*2/2.5)]) membran (zatrs,zatrs,true); //Membran Nut-Trap 
      }
    }
    
    //X-Toolcarrier / Width of Tool-Carrier, Lenght of Tool-Carrier, Height of Tool-Carrier, Width of Linear Bearing Holder, Hight of Linear Bearing Holder, Position of Smooth-Rod from Bottom, Diameter between the two Smooth-Rods, Width of Linear Bearing, Lenght of Linear Bearing, Distance of Linear Bearing to the Rear Ends, Linear Bearing Tightener, Smooth-Rod Size, Mounting-Plate Thickness, Gap-Size in Mounting-Plate, Tool-Hole-Size in Mounting-Plate, Screwhole Size Sek. Tools, Screwhole Distance Sek. Tools , secondary tool screw hole distance to the gap, additional tools mounting plug size, additional tools mounting plug additional tools mounting plug position from the outside, belt stretcher position from the outside, belt stretcher plug distance
    module xtc(wotc, lotc, hotc, wolbh, holbh, posrfb, dbttsr, wolb, lolb, dobtre, lbt, srs, gsimp, thsimp, shsst, ssdst, stshd, stshdttg, atmps, atmpd, atmppfto, bspfto, bspd) {
	translate ([(wotc-dbttsr-wolbh)/2,0,0]) {
	  translate ([wolbh,0,posrfb+holbh/2]) cube (size = [0.025,dobtre+lolb/2-gsimp/2,holbh/2]); //Renderhelp #1
	  translate ([wolbh,dobtre+lolb/2-gsimp/2+gsimp,posrfb+holbh/2]) cube (size = [0.025,lotc-((dobtre+lolb/2-gsimp/2)*2+gsimp*2),holbh/2]); //Renderhelp #2
	  translate ([wolbh,lotc-(dobtre+lolb/2-gsimp/2),posrfb+holbh/2]) cube (size = [0.025,dobtre+lolb/2-gsimp/2,holbh/2]); //Renderhelp #3
	  translate ([dbttsr-0.025,0,posrfb+holbh/2]) cube (size = [0.025,dobtre+lolb/2-gsimp/2,holbh/2]); //Renderhelp #1
	  translate ([dbttsr-0.025,dobtre+lolb/2-gsimp/2+gsimp,posrfb+holbh/2]) cube (size = [0.025,lotc-((dobtre+lolb/2-gsimp/2)*2+gsimp*2),holbh/2]); //Renderhelp #2
	  translate ([dbttsr-0.025,lotc-(dobtre+lolb/2-gsimp/2),posrfb+holbh/2]) cube (size = [0.025,dobtre+lolb/2-gsimp/2,holbh/2]); //Renderhelp #3
	  
	  difference () {
	    union() {
	      translate ([wolbh,0,holbh+posrfb]) zacr(lotc,wolbh,holbh,1,90,wolb,lolb,dobtre,0,lbt,srs,0.3,0,0,0); //Linear-Bearing Holder Left
	      translate ([dbttsr+wolbh,0,holbh+posrfb]) zacr(lotc,wolbh,holbh,1,90,wolb,lolb,dobtre,0,lbt,srs,0.3,0,0,0); //Linear-Bearing Holder Right
	      translate ([wolbh+0.025,0,posrfb+holbh/2]) cube(size = [dbttsr-wolbh-0.05,lotc,holbh/2]); //Mounting Plate
	    }
	    union() {
	      //Difference of Mounting-Plate
	      translate ([wolbh,dobtre+lolb/2-gsimp/2,posrfb+holbh/2-1]) cube (size = [dbttsr-wolbh,gsimp,holbh/2+2]); //Gap1
	      translate ([wolbh,lotc-dobtre-lolb/2-gsimp/2,posrfb+holbh/2-1]) cube (size = [dbttsr-wolbh,gsimp,holbh/2+2]); //Gap2
	      translate ([(wolbh+dbttsr)/2,lotc/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = thsimp/2); //Main-Tool Hole
	      translate ([(wolbh+dbttsr)/2-ssdst/2,lotc/2+ssdst/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Main-Tool 
	      translate ([(wolbh+dbttsr)/2+ssdst/2,lotc/2+ssdst/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Main-Tool
	      translate ([(wolbh+dbttsr)/2-ssdst/2,lotc/2-ssdst/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Main-Tool
	      translate ([(wolbh+dbttsr)/2+ssdst/2,lotc/2-ssdst/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Main-Tool
	      translate ([wolbh+(dbttsr-wolbh)/2-stshd/2,dobtre+lolb/2-gsimp/2-stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 1
	      translate ([wolbh+(dbttsr-wolbh)/2+stshd/2,dobtre+lolb/2-gsimp/2-stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 1
	      translate ([wolbh+(dbttsr-wolbh)/2-stshd/2,dobtre+lolb/2+gsimp/2+stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 1
	      translate ([wolbh+(dbttsr-wolbh)/2+stshd/2,dobtre+lolb/2+gsimp/2+stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 1
	      translate ([wolbh+(dbttsr-wolbh)/2-stshd/2,lotc-dobtre-lolb/2-gsimp/2-stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 2
	      translate ([wolbh+(dbttsr-wolbh)/2+stshd/2,lotc-dobtre-lolb/2-gsimp/2-stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 2
	      translate ([wolbh+(dbttsr-wolbh)/2-stshd/2,lotc-dobtre-lolb/2+gsimp/2+stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 2
	      translate ([wolbh+(dbttsr-wolbh)/2+stshd/2,lotc-dobtre-lolb/2+gsimp/2+stshdttg,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = shsst/2); //Screw Hole for Sek.-Tool 2
	      translate ([atmppfto,lotc/2+atmpd/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = atmps/2); //Mounting Plug additional Tool 1
	      translate ([atmppfto,lotc/2-atmpd/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = atmps/2); //Mounting Plug additional Tool 1
	      translate ([dbttsr+wolbh-atmppfto,lotc/2+atmpd/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = atmps/2); //Mounting Plug additional Tool 2
	      translate ([dbttsr+wolbh-atmppfto,lotc/2-atmpd/2,posrfb+holbh/2-1]) rotate ([0,0,90]) cylinder (h = holbh/2+2, r = atmps/2); //Mounting Plug additional Tool 2
	      translate ([bspfto,atmps,posrfb+holbh/2+3]) rotate ([0,0,90]) cylinder (h = holbh/2+1, r = atmps/2); //Belt-Stretcher 1 Plug 1
	      translate ([bspfto,atmps+bspd,posrfb+holbh/2+3]) rotate ([0,0,90]) cylinder (h = holbh/2+1, r = atmps/2); //Belt-Stretcher 1 Plug 2
	      translate ([bspfto,lotc-atmps,posrfb+holbh/2+3]) rotate ([0,0,90]) cylinder (h = holbh/2+1, r = atmps/2); //Belt-Stretcher 2 Plug 1
	      translate ([bspfto,lotc-atmps-bspd,posrfb+holbh/2+3]) rotate ([0,0,90]) cylinder (h = holbh/2+1, r = atmps/2); //Belt-Stretcher 2 Plug 2
	    }
	  }
	}
      }

    //X-Toolcarrier Belt Tightener / Width of Belt, Height of Belt, Belt Position, additional Tools Mounting Plate Distance, additional Tools Mounting Plate Size, screw hole diameter, Press-Plate Thickness, Adjust Printable
    module xtcbt(flipx, rotate, wob, hob, bp, atmpd, atmps, shd, ppt, ap) {
      rotate ([0,0,rotate]) {
	difference () { //Base Structure
	  union () {
	    cube (size = [wob,atmpd+atmps*2,bp-1]); //Base
 	    translate ([0,0,bp+hob])cube (size = [wob,atmpd+atmps*2,ppt]); //Pressure Plate Base
 	    translate ([-2,0,0]) cube (size = [2,atmpd+atmps*2,bp+ppt+hob+1]); //Wall left
	    translate ([wob,0,0]) cube (size = [2,atmpd+atmps*2,bp+ppt+hob+1]); //Wall right
	    translate ([-wob,(atmpd+atmps*2)/2-wob/2,0]) cube (size = [wob,wob,bp+ppt+hob+1]); //Screw Supporter left
	    translate ([wob,(atmpd+atmps*2)/2-wob/2,0]) cube (size = [wob,wob,bp+ppt+hob+1]); //Screw Supporter right
 	    translate ([wob/2,atmps,-5]) cylinder (h = 5, r = atmps/2); //Mounting Plug Cylinder 1
	    translate ([wob/2,atmpd+atmps,-5]) cylinder (h = 5, r = atmps/2); //Mounting Plug Cylinder 2
	  }
	  union () {
	    translate ([-wob/2,(atmpd+atmps*2)/2,-1]) cylinder (h = bp+ppt+hob+3, r = shd/2);
	    translate ([wob*1.5,(atmpd+atmps*2)/2,-1]) cylinder (h = bp+ppt+hob+3, r = shd/2);
	    translate ([wob/2,atmpd+atmps*2+1,bp+hob+ppt/2]) rotate ([90,0,0]) cylinder (h = atmpd+atmps*2+2, r = shd/2); //Belt Stretcher
	  } 
	}
      if (ap == 0) { //Place Pressure Plate where it belongs
	difference () { //Pressure Pate
	  union () {
	    translate ([-2,0,bp+hob+ppt+4]) cube (size = [wob+4,atmpd+atmps*2,ppt]); //Base
	    translate ([-wob,(atmpd+atmps*2)/2-wob/2,bp+hob+ppt+4]) cube (size = [wob,wob,ppt]); //Screw Supporter left
	    translate ([wob,(atmpd+atmps*2)/2-wob/2,bp+hob+ppt+4]) cube (size = [wob,wob,ppt]); //Screw Supporter right
	  }
	  union () {
	    translate ([-wob/2,(atmpd+atmps*2)/2,bp+hob+ppt+3]) cylinder (h = ppt+2, r = shd/2+0.25); //Screwhole left
	    translate ([wob*1.5,(atmpd+atmps*2)/2,bp+hob+ppt+3]) cylinder (h = ppt+2, r = shd/2+0.25); //Screwhole right
	    translate ([wob*1.5,(atmpd+atmps*2)/2,bp+hob+ppt+3]) cylinder (h = ppt+2, r = shd/2+0.25); //Screwhole right
	  }
	}
      } else { //Pace Pressure Plate on a printable position
	translate ([-wob*3-4,0,-3-ppt]) {
	  difference () { //Pressure Pate
	    union () {
	      translate ([-2,0,bp+hob+ppt+4]) cube (size = [wob+4,atmpd+atmps*2,ppt]); //Base
	      translate ([-wob,(atmpd+atmps*2)/2-wob/2,bp+hob+ppt+4]) cube (size = [wob,wob,ppt]); //Screw Supporter left
	      translate ([wob,(atmpd+atmps*2)/2-wob/2,bp+hob+ppt+4]) cube (size = [wob,wob,ppt]); //Screw Supporter right
	    }
	    union () {
	      translate ([-wob/2,(atmpd+atmps*2)/2,bp+hob+ppt+3]) cylinder (h = ppt+2, r = shd/2+0.25); //Screwhole left
	      translate ([wob*1.5,(atmpd+atmps*2)/2,bp+hob+ppt+3]) cylinder (h = ppt+2, r = shd/2+0.25); //Screwhole right
	    }
	  }
	} 
      }
    }
  }
  
    //Tooldremel
    module tooldremel(trp, testprint) { //Tool - Plate to Mount a Dremel on it // Threaded Rod Pitch, Test-Print
	  difference() {
		  union() {
			translate([-48, -12, 1]) minkowski() {
				cube([xashdpt+10,xashdpt+10,2], center = true);
				translate([48,12,1]) cylinder(r=2, h=2, center = true, $fn=30);
			}
			translate([0,0,-xaholbh/2]) cylinder(r=12, h=xaholbh/2, $fn=100);
		  }
		  union() {
		  translate([0,0,-xaholbh/2]) trapezoidThreadNegativeSpace( 
			  length=xaholbh/2+4, 			// axial length of the threaded rod
			  pitch=trp,			// axial distance from crest to crest
			  pitchRadius=19.05/2, 		// radial distance from center to mid-profile
			  threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch
							// std value for Acme or metric lead screw is 0.5
			  profileRatio=0.5,		// ratio between the lengths of the raised part of the profile and the pitch
							// std value for Acme or metric lead screw is 0.5
			  threadAngle=29, 		// angle between the two faces of the thread
							// std value for Acme is 29 or for metric lead screw is 30
			  RH=true, 			// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
			  countersunk=0.5, 		// depth of 45 degree chamfered entries, normalized to pitch
			  clearance=0.1, 		// radial clearance, normalized to thread height
			  backlash=0.1, 		// axial clearance, normalized to pitch
			  stepsPerTurn=35 		// number of slices to create per turn
			  );
		      if (testprint == "false") { //Exclude Screw-Holes while Testing
			  translate ([xashdpt/2,xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			  translate ([xashdpt/2,-xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			  translate ([-xashdpt/2,xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			  translate ([-xashdpt/2,-xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
		      }
		  }
	  }
    }
    
    //Toolpen
    module toolpen(pendomedia, pendomeheight) { //Tool - Plate to Mount a Dremel on it // Pen Diameter, Pen-Dome-Hight, Test-Print
	  difference() {
		  union() {
			translate([-48, -12, 1]) minkowski() {
				cube([xashdpt+10,xashdpt+10,2], center = true);
				translate([48,12,1]) cylinder(r=2, h=2, center = true, $fn=30);
			}
			translate([0,0,0]) cylinder(r=12, h=pendomeheight, $fn=100);
			translate([0,-12,0]) cube ( size = [10,10,10]);
		  }
		  union() {
			translate([0,0,-1]) cylinder (h = pendomeheight+2, r = pendomedia/2);
			translate ([xashdpt/2,xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			translate ([xashdpt/2,-xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			translate ([-xashdpt/2,xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
			translate ([-xashdpt/2,-xashdpt/2,-1]) rotate ([0,0,90]) cylinder (h = 7, r = xathsimp/2+0.25); //Screw Hole for Sek.-Tool 2
		  }
	  }
    }
    
    //X-Axis Tool Carrier Servo Holder / flip (bolean) arround x, rotate arround x, Servo-Width, Servo-Lenght, Servo-Lenght Widhout Screwholes, Servo-Flange Depht (Dept of Servo beneath the Mounting-Flange), Position of Drive-Shaft, Servo Structure Thickness, Servo Position Offset (Position of Servo-Engine beneath Tool-Carrier Surface), Diameter of Drive-Shaft (Width Tightener on Top), Distance of Servo Screws (from the Outside), Diameter of Servo Screw Holes (For Fix Servo), additional tools mounting plug size, additional tools mounting plug distance, additional tools mounting plug position from the outside, Trigger-Flag Lenght, Trigger-Flag Width, Trigger Width, Trigger Height, Trigger Mounting Holes Distance, Trigger Mounting Holes Size (For Fix Trigger), Trigger Mounting Holes Position from Pins, Printmode (1 = Just Servo-Engine-Holder; 2 = Just Flag)
    module xtcsh(flipx, rotate, sw, sl, slws, sfd, spos, sst, spo, sdods, sdoss, sdossh, atmps, atmpd, atmpp, tfl, tfw, tw, th, tmhd, tmhs, tmhpfp, pm) {
      mirror ([flipx,0,0]) rotate ([rotate,0,0]) {
	if (pm != 2) {
	  difference() { //Servo-Engine Holder
	    union() {
	      translate ([-sfd,0,-spo]) cube (size = [atmpp+atmps*1.25+sfd,sl,sst+spo]); //Base Structure
	    }
	    union() {
	      translate ([atmpp,(sl-atmpd)/2,-1]) cylinder (h = sst+2, r = atmps/2+0.5); //Screw Hole 1 Servo-Holder
	      translate ([atmpp,(sl-atmpd)/2+atmpd,-1]) cylinder (h = sst+2, r = atmps/2+0.5); //Screw Hole 2 Servo-Holder
	      translate ([0,-1,-spo-1]) cube (size = [atmpp+atmps*1.25+1,sl+2,spo+1]); //Cut-Out of Base
	      translate ([-sfd-1,(sl-slws)/2,-spo-1]) cube (size = [sfd+2,slws,sw+1]); //Cut-Out of Engine
	      translate ([1,sdoss,-spo+sw/2]) rotate ([0,-90,0]) cylinder (h = sfd+2, r = sdossh/2); //Screw Hole 1 Servo-Engine
	      translate ([1,sl-sdoss,-spo+sw/2]) rotate ([0,-90,0]) cylinder (h = sfd+2, r = sdossh/2); //Screw Hole 2 Servo-Engine
	    }
	  }
	} if (pm != 1) {
	  //Position of the Trigger-Flag (for Simulation)
	  difference() {
	    union() {
	      translate ([-sfd*2,spos-tw/2,-spo+sw/2-tfl/2]) cube (size = [1.5,tw,th]); //Base of Trigger
	      translate ([-sfd*2,spos-tw/2,-spo+sw/2-tfl/2+tfl]) rotate ([0,90,0]) linear_extrude(height = 2.5, convexity = 10) polygon (points = [[0,(tw-tfw)/2],[0,tw-(tw-tfw)/2],[tfl-th,tw],[tfl-th,0]], paths = [[0,1,2,3]]); //Flag itself
	    }
	    union() {
	      translate ([-sfd*2+2,spos-tw/2+tw-tmhd/2,-spo+sw/2-tfl/2+th-tmhpfp]) rotate ([0,-90,0]) cylinder (h = 1+2, r = tmhs/2); //Screw Hole 1 Trigger
	      translate ([-sfd*2+2,spos-tw/2+tmhd/2,-spo+sw/2-tfl/2+th-tmhpfp]) rotate ([0,-90,0]) cylinder (h = 1+2, r = tmhs/2); //Screw Hole 2 Trigger
	      translate ([-sfd*2+3,spos,-spo+sw/2]) rotate ([0,-90,0]) cylinder (h = 2+2, r = 4/2); //Servo-Engine Screw Hole for Flag
	    }
	  }
	}
      }
    }
  
    //Upper Frame / flip (bolean) arround x, flip (bolean) arround y, rotate arround x, X-Axis Carrier Width, X-Axis Additional Width, X-Axis Carrier Lenght, X-Axis Carrier Height, Smooth Rod Size, Distance of Smooth Rods to the Outside, Smooth Rods Difference, Lenght of Linear Bearing,  position of first linear bearing, space between two linear bearings, Z-Axis Size of Nema Motor, Z-Axis Width of Engine Support Structure, Z-Axis Threaded Rod Size, Z-Axis Nut-Trap Feather-Range, Z-Axis Width of Nut, Z-Axis Nut Trap Support Structure, width of bearing, diameter of bearing, hole in bearing, support for bearing, lenght of Linear Bearing Carrier, Width of Linear Bearing Carrier, width of Linear Bearing, lenght of Linear Bearing, Distance Between the Rear Ends, Distance of Threaded Rod Bracing to the Bottom, allocate Bearing to the Outside, Smooth Rod Size (Additional Y-Axis Smooth Rod, Smooth Rod Fixing-Screw Size), Smooth-Rod additional Space, Threaded-Rod Bracing Diameter, Distance of Threaded Rod Bracing to the Ends, Additional Lenght of Threaded-Rod Bracing Block
    module ufs(flipx, flipy, rotate, xcw, xcaw, xcl, ufh, srs, dozsr, zsrd, lolb, poflb, sbtlb, zasonm, zawoess, zatrs, zafr, zawon, zantss, wob, dob, hib, sfb, lolbc, wolbc, holbc, wolb, lolb2, dobtre, abtho, lbt, srs2, srfs , sras, trbd, dotrb, dotrbb, alotrbb, dobb, wobb) {
      mirror ([flipx,flipy,0]) rotate ([rotate,0,0]) {
	difference () { //Difference Section
	  union() {
	    translate ([-xcaw/2,0,0]) cube (size = [xcw+xcaw,xcl,ufh]);
	  //Linear Bearing Carrier (Round) / width, length, height, flip (bolean) arround z, rotate arround x, width of linear bearing, length of linear bearing, distance of bearing to the rear ends, allocate bearing to the outside, size of tightener, size of smooth rod, additional space of smooth rod, width of belt, height of belt, tollerance for Belt
	    translate ([(xcw-lolbc)/2,xcl/2-wolbc/2,ufh]) zacr(lolbc,wolbc,holbc,0,0,wolb,lolb2,dobtre,abtho,lbt,srs2,0.3,0,0,0); //Linear-Bearing Holder 
	    translate ([xcw/2,-zawoess/2-zasonm/2,-(lolb*2+poflb*2+sbtlb)+(poflb+zafr)]) cylinder (h = (lolb*2+poflb*2+sbtlb)-(poflb+zafr)+ufh, r = dob/2+sfb/2); //Z-Axis Threaded Rod discharge Support
	    linear_extrude(height = ufh, convexity = 10) polygon (points = [[-xcaw/2,0],[xcw/2,-zawoess/2-zasonm/2-zatrs/2-zantss],[xcw+xcaw/2,0]], paths = [[0,1,2]]); //Nut-Trap Baseplate
	    translate ([xcw/2+ufh/2,-zawoess/2-zasonm/2-zatrs/2-zantss,0]) rotate ([-90,0,75]) linear_extrude(height = ufh, convexity = 10) polygon (points = [[0,0],[0,(lolb*2+poflb*2+sbtlb)-(poflb+zafr)],[zawoess/2+zasonm/2+zatrs/2+zantss+xcl-5,0]], paths = [[0,1,2]]); //Nut-Trap Support Structure 1
	    translate ([xcw/2+ufh/2,-zawoess/2-zasonm/2-zatrs/2-zantss,0]) rotate ([-90,0,90]) linear_extrude(height = ufh, convexity = 10) polygon (points = [[0,0],[0,(lolb*2+poflb*2+sbtlb)-(poflb+zafr)],[zawoess/2+zasonm/2+zatrs/2+zantss+xcl,0]], paths = [[0,1,2]]); //Nut-Trap Support Structure 2 
	    mirror ([1,0,0]) translate ([-xcw/2+ufh/2,-zawoess/2-zasonm/2-zatrs/2-zantss,0]) rotate ([-90,0,75]) linear_extrude(height = ufh, convexity = 10) polygon (points = [[0,0],[0,(lolb*2+poflb*2+sbtlb)-(poflb+zafr)],[zawoess/2+zasonm/2+zatrs/2+zantss+xcl-5,0]], paths = [[0,1,2]]); //Nut-Trap Support Structure 3
	    translate ([-xcaw/2+dotrb-trbd*0.875,-alotrbb,0]) cube (size = [trbd*1.75,xcl+alotrbb,ufh+trbd*0.875]); //Bracing Threaded-Rod - Nut-Tightener Block 1
	    translate ([xcaw/2+xcw-dotrb-trbd*0.875,-alotrbb,0]) cube (size = [trbd*1.75,xcl+alotrbb,ufh+trbd*0.875]); //Bracing Threaded-Rod - Nut-Tightener Block 2

	  }
	  union() {
	    translate ([dozsr,xcl/2-zsrd,-1]) cylinder (h = ufh+2+poflb+lolb+sbtlb+lolb+poflb, r = srs/2+sras/2); //Z-Axis Smooth Rod 1
	    translate ([xcw-dozsr,xcl/2+zsrd,-1]) cylinder (h = ufh+2+poflb+lolb+sbtlb+lolb+poflb, r = srs/2+sras/2); //Z-Axis Smooth Rod 2
	    translate ([dozsr,xcl/2-zsrd,ufh/2])  rotate ([0,90,90]) cylinder (h = xcl, r = srfs/2); //Z-Axis Smooth Rod 1 Fixing Screw
	    translate ([xcw-dozsr,xcl/2+zsrd,ufh/2]) rotate ([0,90,-90]) cylinder (h = xcl, r = srfs/2); //Z-Axis Smooth Rod 2 Fixing Screw
	    translate ([xcw-dozsr+(srfs*1.8/2),0,ufh/2-(srfs*1.8/2)]) rotate ([0,0,180]) cube (size = [srfs*1.8,xcl/2,srfs*1.8]); //Z-Axis Smooth Rod 2 Fixing Screw Shaft
	    translate ([xcw/2,-zawoess/2-zasonm/2,-(lolb*2+poflb*2+sbtlb)+(poflb+zafr)-1]) cylinder (h = poflb+zafr, r = zatrs/2); //Z-Axis Threaded Rod
	    translate ([xcw/2,-zawoess/2-zasonm/2,-(lolb*2+poflb*2+sbtlb)+(poflb+zafr)-1+6.5]) cylinder (h = poflb+zafr, r = dob/2); //Z-Axis Threaded Rod Bearing
	    translate ([-xcaw/2+dotrb,xcl+1,dotrbb]) rotate ([90,0,0]) cylinder (h = zawoess/2+zasonm/2+zatrs/2+zantss+xcl+alotrbb, r = trbd/2); //Bracing Threaded-Rod 1
	    translate ([xcaw/2+xcw-dotrb,xcl+1,dotrbb]) rotate ([90,0,0]) cylinder (h = zawoess/2+zasonm/2+zatrs/2+zantss+xcl+alotrbb, r = trbd/2); //Bracing Threaded-Rod 2
	  }
	}
      }
    }
    
    //Upper Frame Belt Tightener / flip (bolean) arround x, flip (bolean) arround y, rotate arround x, Belt Tightener Width, X-Axis Carrier Width, X-Axis Additional Width, X-Axis Carrier Lenght, X-Axis Carrier Height, Threaded Rod Bracing Diameter, Distance of Threaded Rod Bracing to the Ends, Distance of Threaded Rod Bracing to the Bottom, Upper-Frame X-Axis Smooth Rod, Belt Tightener Span, Belt Tightener Span Position, Belt Width, Belt Position, Y-Axis Belt Tightener Allen Screw Size, Belt Tightener Screw Size, Belt Tooth Distance, Belt Tightener Stability Assistant, Only Belt-Clamp
    module ufbt (flipx, flipy, rotate, btl, xcw, xcaw, xcl, ufh, trbd, dotrb, dotrbb, srs, bts, btsp, bw, bp, btass, btss, btd, btsa, obc) {
      mirror ([flipx,flipy,0]) rotate ([rotate,0,0]) {
	if (obc == "false" || obc == "all") { //Display Belt-Tightener Base
	  difference () { //Base Structure
	    union () {
	      translate ([-xcaw/2,0,0]) cube (size = [dotrb+trbd*0.875,btl,ufh+trbd*0.875]); //Bracing Blank Block left
	      translate ([-xcaw/2+dotrb+trbd*0.875,0,ufh]) cube (size = [xcw+xcaw-dotrb*2-trbd*1.75,btl,ufh+trbd*0.875-ufh]); //Bracing Blank Block Center
	      translate ([xcw+xcaw/2-dotrb-trbd*0.875,0,0]) cube (size = [dotrb+trbd*0.875,btl,ufh+trbd*0.875]); //Bracing Blank Block right
	      translate ([-xcaw/2,0,ufh+trbd*0.875]) cube (size = [bts,btl,srs*0.75+btsp]); //Belt Tightener Block
	      translate ([-xcaw/2+bts,(btl-btss*2)/2,ufh+trbd*0.875+0.025]) rotate ([90,0,0]) linear_extrude(height = (btl-btss*2)/2, convexity = 10) polygon (points = [[0,0],[0,srs*0.75+btsp],[30,0]], paths = [[0,1,2]]); //Support Structure 1
	      translate ([-xcaw/2+bts,btl,ufh+trbd*0.875+0.025]) rotate ([90,0,0]) linear_extrude(height = (btl-btss*2)/2, convexity = 10) polygon (points = [[0,0],[0,srs*0.75+btsp],[30,0]], paths = [[0,1,2]]); //Support Structure 2
	      translate ([-xcaw/2+dotrb+trbd*0.875,btl,0]) rotate ([90,0,0]) linear_extrude(height = btl, convexity = 10) polygon (points = [[0,0],[0,ufh],[btsa,ufh]], paths = [[0,1,2]]); //Stability Assistant left
	      translate ([xcw+xcaw/2-dotrb-trbd*0.875-btsa,btl,0]) rotate ([90,0,0]) linear_extrude(height = btl, convexity = 10) polygon (points = [[0,ufh],[btsa,0],[btsa,ufh]], paths = [[0,1,2]]); //Stability Assistant right
	      }
	    union () {
	      translate ([-xcaw/2+dotrb,btl+1,dotrbb]) rotate ([90,0,0]) cylinder (h = btl+2, r = trbd/2); //Bracing Threaded-Rod 1
	      translate ([xcaw/2+xcw-dotrb,btl+1,dotrbb]) rotate ([90,0,0]) cylinder (h = btl+2, r = trbd/2); //Bracing Threaded-Rod 2
	      translate ([-xcaw/2-1,btl/2-(bw+4)/2,dotrbb+trbd*0.5+btsp]) cube (size = [bts-5,bw+4,bw+3.5+0.5]); //Belt Tightener Span Shaft
	      translate ([-xcaw/2+bts,btl/2+btss,dotrbb+trbd*0.5+btsp+0.25]) rotate ([90,0,0]) linear_extrude(height = btss*2, convexity = 10) polygon (points = [[0,0],[0,dotrbb+trbd*0.5+btsp+0.25],[30,dotrbb+trbd*0.5+btsp+0.25],[15,0]], paths = [[0,1,2,3]]); //Shaft for the Belt-Tightening Screw
	      translate ([-xcaw/2+bts-7,btl/2,dotrbb+trbd*0.5+btsp+(bw+3.5+0.5)/2]) rotate ([0,90,0]) cylinder (h = 8, r = btss/2); // Belt Tightening Screw
	      translate ([-xcaw/2+bts+30,btl/2-(bw+1)/2,dotrbb+trbd*0.5+btsp+0.25+((bw+3.5)/100*ufbtbp)-yabh+1]) cube ( size = [xcw+xcaw-bts-30+1,bw+1,yabh+1]); //Belt Fix Corridor
	      translate ([-xcaw/2+bts+30,0,-1]) {
		translate ([(xcw+xcaw-bts-30)/3*0.5,btl/2,0]) cylinder ( h = ufh+trbd*0.875+2, r = btss/2); //Belt fix Screw 4 Down
		translate ([(xcw+xcaw-bts-30)/3*0.5,btl/2,0]) cylinder (h = ufh+2, $fn = 6, r = btss/2+0.75/cos(180/6)+0.7); //Belt fix Nut 4 Down
		translate ([(xcw+xcaw-bts-30)/3*1.1,btl/2,0]) cylinder ( h = ufh+trbd*0.875+2, r = btss/2); //Belt fix Screw 5 Down
		translate ([(xcw+xcaw-bts-30)/3*1.1,btl/2,0]) cylinder (h = ufh+1.025, $fn = 6, r = btss/2+0.75/cos(180/6)+0.7); //Belt fix Nut 5 Down
		translate ([(xcw+xcaw-bts-30)/3*1.7,btl/2,0]) cylinder ( h = ufh+trbd*0.875+2, r = btss/2); //Belt fix Screw 6 Down
		translate ([(xcw+xcaw-bts-30)/3*1.7,btl/2,0]) cylinder (h = ufh+1.025, $fn = 6, r = btss/2+0.75/cos(180/6)+0.7); //Belt fix Nut 6 Down
	      }
	    }
	  }
	  translate ([-xcaw/2+bts+30,btl/2-(bw+1)/2,dotrbb+trbd*0.5+btsp+0.25+((bw+3.5)/100*ufbtbp)-yabh/2]) { //Belt-Fix Surface
	    for ( i = [0 : btd : xcw+xcaw-bts-30-1] )
	      {
		  translate([i, 0, 0])
		  cube (size = [btd/2,bw+1,yabh/2]);
	      }
	  }
	 } if (obc == "slot" || obc == "all") { //Display Tightener Slot
	    translate ([-xcaw/2+bts/3*2,btl/2-(bw+3.5)/2,dotrbb+trbd*0.5+btsp+0.25]) mirror ([1,0,0]) {
	      difference () { //Belt Tightener Itself
		cube (size = [bts/3*2,bw+3.5,bw+3.5]); //Belt Tightener
		union () {
		  translate ([bts/3*2-((bts/3*2-10)/3*0.5),(bw+3.5)/2,-1]) cylinder ( h = bw+3.5+2, r = btass/2); //Belt fix Screw 1
		  translate ([bts/3*2-((bts/3*2-10)/3*1.5),(bw+3.5)/2,-1]) cylinder ( h = bw+3.5+2, r = btass/2); //Belt fix Screw 2
		  translate ([bts/3*2-((bts/3*2-10)/3*2.5),(bw+3.5)/2,-1]) cylinder ( h = bw+3.5+2, r = btass/2); //Belt fix Screw 3
		  translate ([9,1.25,((bw+3.5)/100*ufbtbp)-yabh+1]) cube ( size = [bts,bw+1,yabh+1]); //Belt Corridor
		  translate ([3,1.75,1.5]) cube ( size = [7,bw+3,bw+3.5-3]); //Nut Rotate Chamber
		  translate ([-1,(bw+3.5)/2,(bw+3.5)/2]) rotate ([0,90,0]) cylinder (h = 5, r = btss/2); //Belt Tightener Slot Scew Shaft
		}
	      }
	    }
	} if (obc == "true" || obc == "all") { //Display Belt Fix Clamp
	  translate ([-xcaw/2+bts+30,0,dotrbb+trbd*0.5+btsp+0.25+((bw+3.5)/100*ufbtbp)+5]) {
	    difference () {
	      union () {
		translate ([0,btl/2-(bw+1)/2+0.25,0]) cube (size = [xcw+xcaw-bts-30,bw+0.5,yabh]);
		translate ([0,0,yabh]) cube (size = [xcw+xcaw-bts-30,btl,yabh*2]);
	      }
	      union () {
		translate ([(xcw+xcaw-bts-30)/3*0.5,btl/2,-1]) cylinder ( h = yabh*3+2, r = btss/2); //Belt fix Screw 4 Up
		translate ([(xcw+xcaw-bts-30)/3*1.1,btl/2,-1]) cylinder ( h = yabh*3+2, r = btss/2); //Belt fix Screw 5 Up
		translate ([(xcw+xcaw-bts-30)/3*1.7,btl/2,-1]) cylinder ( h = yabh*3+2, r = btss/2); //Belt fix Screw 6 Up
	      }
	    }
	  }
	}
      }
    }
    
    //Upper Frame Deflektion Pulley Part / rotate arround x, simulated angle, simulate bearings, width of legs, lenght of legs, Additional Distance between the Bearings, Diameter of Hole for second Plate, Print Mode
    module ufdpp (rotate, sa, wol, adbb, dhsp) {
      sfb = dhsp < 1 ? ufbshtrd+dotra : dhsp; //Generate Hole Sizes
      rotate ([rotate,sa,0]) {
	translate ([-ufbshtrd-dotra,0,-ufbshtrd-dotra]) { 
	  difference () {
	    union () {
	      translate ([0,0,0]) cube (size = [ufbshtrd*2+dotra*2,wol,ufdobb+4+ufbshtrd*2+dotra*2+adbb]); //Plane Block
	      translate ([ufbshtrd+dotra,0,0]) rotate ([270,0,0]) cylinder ( h = wol, r = ufbshtrd+dotra); //Rounded End 1
	      translate ([ufbshtrd+dotra,0,ufdobb+3+ufbshtrd*2+dotra*2+adbb]) rotate ([270,0,0]) cylinder ( h = wol, r = ufbshtrd+dotra); //Rounded End 2
	    }
	    union () {
	      translate ([ufbshtrd+dotra,-1,ufbshtrd+dotra]) rotate ([270,0,0]) cylinder ( h = wol+2, r = (ufbshtrd+dotra)/2); //Screw for Bearing 1
	      translate ([ufbshtrd+dotra,-1,ufbshtrd+dotra+ufdobb+3+adbb]) rotate ([270,0,0]) cylinder ( h = wol+2, r = sfb/2); //Screw for Bearing 2
	    }
	  }
	}
      }
    }
      //Upper Frame Deflektion Pulley Structure / rotate arround x, simmulated angle, simulate bearings, width of legs, lenght of legs, Additional Distance between the Bearings, Diameter of Hole for second Plate, Print Mode
      module ufdp (rotate, sa, sb, wol, adbb, dhsp, pm) {
	ufdpp (0,sa,wol,adbb,0); //Left
	translate ([0,ufwobb+wol,0]) ufdpp (0,sa,wol,adbb,dhsp); //Right
    	if (sb == "true" && pm == "false") { //Show Bearings?
	  rotate ([rotate,sa,0]) {
	    translate ([0,wol+ufwobb,0]) zzb (0,0,ufdobb,ufwobb,ufbshtrd); //Simulated Bearing 1
	    translate ([0,wol+ufwobb,ufdobb+3+adbb]) zzb (0,0,ufdobb,ufwobb,ufbshtrd); //Simulated Bearing 2
	  }
	}
      }
    
    
    //Upper Frame bottom Structure / flip (bolean) arround x, flip (bolean) arround y, rotate arround x, Support-Structure Thickness Outside, Support-Structure Thickness Inside, Threaded Rod Diameter, Threaded Rod additional Diameter, Threaded Rod Support, Threaded Rod Support Hight, Threaded Rod Nut Diameter, Smooth Rod Screw Space (for Smooth-Rod Tightener, Horizontal Threaded Rod Diameter, engine-side (bolean), top-position (bolean)
    module ufbs (flipx, flipy, rotate, ssto, ssti, trd, tra, trs, trsh, trnd, srss, htrd, es, tp) {
      mirror ([flipx,flipy,0]) rotate ([rotate,0,0]) {
	difference () { //Difference Section
	  union () {
	    if (tp == 1) {
	      translate ([0,0,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2]) cube (size = [yass-10,yass+ssto+ssti,htrd*2]); //Base Structure (for Threaded Rod Horizontaly)
	      translate ([0,ssto,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Place Smooth-Rod Tightener
	    } else {
	      cube (size = [yass-10,yass+ssto+ssti,lsab2-lsab+dotr*4+yasrh+yahoc]); //Base Structure
	    }
	      translate ([yass-10+0.0125,0,lsab2-lsab+dotr*4+yasrh+yahoc]) rotate ([0,-90,0]) linear_extrude (height = yass-10, convexity = 10) polygon (points = [[0,0],[trsh,(yass+ssto+ssti)/2-trd/2-tra/2-trs/2],[trsh,(yass+ssto+ssti)/2+trd/2+tra/2+trs/2],[0,yass+ssto+ssti]], paths = [[0,1,2,3]]); //Threaded Rod Dom
	    }
	  union () {
	    if (tp == 1) {
	      translate ([(yass-10)/2,-1,lsab2-lsab+dotr*4+yasrh+yahoc-htrd]) rotate ([270,0,0]) cylinder (h = yass+ssto+ssti+2, r = htrd/2+tra/2); //Horizontaly Threaded Rod 
	    } else {
	      translate ([-1,ssto-0.15,-1]) cube (size = [yass-10+2,yass+0.3,lsab2-lsab+dotr*2+yasrh+yahoc+yadbc+srss]); //Cut out Bearing-Structure TODO Anpassen Namen
		translate ([gffs/2,-1,dotr]) rotate ([270,0,0]) cylinder (h = yass+ssto+ssti+2, r = dotr/2+dotra/2); //Groundframe Threaded Rod 1
		translate ([gffs/2,-1,dotr+(lsab2-lsab)]) rotate ([270,0,0]) cylinder (h = yass+ssto+ssti+2, r = dotr/2+dotra/2); //Groundframe Threaded Rod 2
 		if (es) translate ([yesl+5/2,-1,-1]) cube (size = [yass-10-yesw-5/2+1,ssto+2,dotr*2+lsab2-lsab-yeset+1]); //Place cut for Nema-Engine
	    }
	    translate ([(yass-10)/2,(yass+ssto+ssti)/2,lsab2-lsab+dotr*4+yasrh+yahoc]) cylinder (h = trsh+1, r = trd/2+tra/2); //Threaded Rod Shaft for Upper Structure
	    translate ([(yass-10)/2,(yass+ssto+ssti)/2,lsab2-lsab+dotr*4+yasrh+yahoc+(trsh/5)*1]) cylinder ($fn = 6, r = trnd/2/cos(180/6)+0.7, h = (trd*2/1.5)+1); //Nut Trap
	    if (!es) translate ([-1,(yass+ssto+ssti)/2-trnd/2-1.5/2,lsab2-lsab+dotr*4+yasrh+yahoc+(trsh/5)*1]) cube ( size = [((yass-10)/2)+1,trnd+1.5,(trd*2/1.5)+1]); //Place Shaft for Enter Nut-Trap Outside
	    else translate ([(yass-10)/2,(yass+ssto+ssti)/2-trnd/2-1.5/2,lsab2-lsab+dotr*4+yasrh+yahoc+(trsh/5)*1]) cube ( size = [((yass-10)/2)+1,trnd+1.5,(trd*2/1.5)+1]); //Place Shaft for Enter Nut-Trap Inside
	  }
	}
      }
    }
    
    //Upper Frame bottom Structure Emergency-Stop / flip (bolean) arround x, flip (bolean) arround y, rotate arround x, Support-Structure Thickness Outside, Support-Structure Thickness Inside, Threaded Rod Diameter, Threaded Rod additional Diameter, Threaded Rod Support, Emergency-Stop Width, Emergency-Stop Mounting Hole, //TODO Eine Gigantische Baustelle, nix passt hier wirklich
    module ufbses (flipx, flipy, rotate, ssto, ssti, trd, tra, trs, trsh, htrd, esw, esmh) {
      mirror ([flipx,flipy,0]) rotate ([rotate,0,0]) {
	difference () {
	  union () {
	    translate ([0,0,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2+0.025]) cube (size = [esw,yass+ssto+ssti,htrd*2]); //Base Structure (for Threaded Rod Horizontaly)
	    translate ([esw,0,lsab2-lsab+dotr*4+yasrh+yahoc]) rotate ([0,-90,0]) linear_extrude (height = esw, convexity = 10) polygon (points = [[0,0],[trsh,(yass+ssto+ssti)/2-trd/2-tra/2-trs/2],[trsh,(yass+ssto+ssti)/2+trd/2+tra/2+trs/2],[0,yass+ssto+ssti]], paths = [[0,1,2,3]]); //Threaded Rod Dom
	  }
	  union () {
	    translate ([-20,-1,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2-esw+htrd*1.7]) rotate ([0,17,0]) cube ( size = [esw*2,yass+ssto+ssti+2,esw]); 
	    translate ([esw/2.5,(yass+ssto+ssti)/2,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2]) rotate ([0,17,0]) cylinder (h = esw/2, r = esmh/2); 
	    translate ([esw/2.2,(yass+ssto+ssti)/2,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2+6]) rotate ([0,17,0]) cylinder (h = esw/1.5, r = esmh/2+2); 
	    translate ([esw,(yass+ssto+ssti)/2,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2+10]) cylinder (h = esw*2, r = esmh/3); 
	    translate ([-esw*1.4,-1,lsab2-lsab+dotr*4+yasrh+yahoc-htrd*2]) rotate ([0,28,0]) cube ( size = [esw,yass+ssto+ssti+2,esw*3]); 
	  }
	}
      }
    }
    
    //Upper Frame bottom Structure Bracer / flip (bolean) arround x, flip (bolean) arround y, rotate arround z, Width of the Lock Plate, Lenght of the Lock Plate, Back Plate Thickness, Front Plate Thickness, Pressure Plate Space, Connector Threaded Rod Diameter, Groundframe-Feeds Distance, connector rod angle ,Rotatet Lenght, upper structure width (additional), upper structure lenght, upper rotatet structure lenght, upper rotatet structure lenght position, second row (Bolean), Simulation Mode (Bolean, shows Connector Threaded Rods), vs 1 = just show bottom Structure, 2 = just show upper Structure
    module ufbsb (flipx, flipy, rotate, width, lenght, bpt, fpt, pps, ctrd, gd, cra, rl, usw, usl, ursl, rlp, ss, ns, sr, sim, vs) {
      mirror ([flipx,flipy,0]) rotate ([0,0,rotate]) {
	translate ([0,gd,lsab-dotr]) {
	  difference () {
	    union () {
	      if (vs == empty || vs == 1) { //Sort out for Bottom Structure for Printing
		cube (size = [fpt+bpt,lenght,lsab2-lsab+ctrd*2]); //Bottom Bracer Basis Block
		intersection () {
		  translate ([-dotr*3,0,0]) cube (size = [dotr*3,lenght,lsab2-lsab+dotr*2]);
		  union () {
		    if (sr) {
		      translate ([-dotr,lenght/2,(lsab2-lsab+dotr*2)/2]) rotate ([-cra,0,0]) cube (size = [dotr*2,dotr*2,sqrt(pow(lenght-dotr,2)+pow(lsab2-lsab+dotr,2))], center = true); //Rod-Holder Part 1
		      translate ([-dotr*2,dotr/2,dotr/2]) rotate ([-cra,0,0]) cylinder (h = sqrt(pow(lenght-dotr,2)+pow(lsab2-lsab+dotr,2)), r = dotr); //Rod-Holder Part 2
		    } else {
		      translate ([-dotr/2,lenght/2,(lsab2-lsab+dotr*2)/2]) rotate ([-cra,0,0]) cube (size = [dotr,dotr*2,sqrt(pow(lenght-dotr,2)+pow(lsab2-lsab+dotr,2))], center = true); //Rod-Holder Part 1
		      translate ([-dotr-0.0125,dotr/2,dotr/2]) rotate ([-cra,0,0]) cylinder (h = sqrt(pow(lenght-dotr,2)+pow(lsab2-lsab+dotr,2)), r = dotr); //Rod-Holder Part 2
		    }
		  }
		}
	      }
	      if (vs == empty || vs == 2) { // Sort out for Upper Structure for Printing
		translate ([0,lowp-ufbssti-ufusbl,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-ctrd-yadbc/2]) cube (size = [yass-10+usw,usl,ctrd*2]); //Upper Bracer Basis Block
		if (sr) {
		  translate ([0-usw+yass-10-(yass-10+usw+ctrd*2)/2,lowp-ufbssti-ufusbl+rlp,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2]) rotate ([90-cra,0,0]) cube (size = [yass-10+usw+ctrd*2,ursl,ctrd*2], center = true); //Upper Rotated Basis Block
		  translate ([0-usw+yass-10-(yass-10+usw+ctrd*2),lowp-ufbssti-ufusbl+rlp,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2]) rotate ([-cra,0,0]) cylinder (h = ursl, r = ctrd, center = true); //Upper Rotated Basis Cylinder
		} else {
		  translate ([0-usw+yass-10-(yass-10+usw+ctrd)/2,lowp-ufbssti-ufusbl+rlp,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2]) rotate ([90-cra,0,0]) cube (size = [yass-10+usw+ctrd,ursl,ctrd*2], center = true); //Upper Rotated Basis Bloc
		  translate ([0-usw+yass-10-(yass-10+usw+ctrd),lowp-ufbssti-ufusbl+rlp,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2]) rotate ([-cra,0,0]) cylinder (h = ursl, r = ctrd, center = true); //Upper Rotated Basis Cylinder
		}
	      }
	    }
	    union () {
	      translate ([fpt-pps/2,-1,-1]) cube (size = [pps,lenght+2,lsab2-lsab+ctrd*2+2]); //Pressure Plate Space (Space between Back/Front Plate for Pressing on the Threaded Rods)
	      translate ([fpt,-1,ctrd]) rotate ([270,0,0]) cylinder (h = lenght+2, r = dotr/2); //Groundframe Threaded Rod 1
	      translate ([fpt,-1,ctrd+lsab2-lsab]) rotate ([270,0,0]) cylinder (h = lenght+2, r = dotr/2); //Groundframe Threaded Rod 2
	      translate ([-1,dotr,ctrd+lsab2-lsab-dotr]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+2, r = ss/2); //Screw Hole 1
	      translate ([-1,lenght-dotr,ctrd+dotr]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+2, r = ss/2); //Screw Hole 2
	      translate ([(yass-10+usw)/2,lowp-ufbssti+1,gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-ctrd-yadbc/2+ctrd]) rotate ([90,0,0]) cylinder (h = usl+2, r = ufbshtrd/2+dotra/2); //Upper Bracer Threaded Rod Hole
	      if (sr) {
		translate ([-ctrd*2,0,0]) rotate ([-cra,0,0]) cylinder (h = 660, r = ctrd/2+dotra/2); //Get Holes inside the Structures for the Threaded Rod
	      } else {
		translate ([-ctrd,0,0]) rotate ([-cra,0,0]) cylinder (h = 660, r = ctrd/2+dotra/2); //Get Holes inside the Structures for the Threaded Rod
	      }
	    }
	  }
	  if (sim == true) {
	    if (sr) {
	    translate ([-ctrd*2,0,0]) rotate ([-cra,0,0]) trod(sqrt(pow(lowp-ufbssti-ufusbl+rlp,2)+pow(gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2+ursl/2+aotr,2)),0,0,0); //Simulated Threaded Rod
	    } else {
	    translate ([-ctrd,0,0]) rotate ([-cra,0,0]) trod(sqrt(pow(lowp-ufbssti-ufusbl+rlp,2)+pow(gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2+ursl/2+aotr,2)),0,0,0); //Simulated Threaded Rod
	    }
	
	  }
	}
      }
    }
    //Upper Frame bottom Structure Bracer Sideways / flip (bolean) arround y, flip (bolean) arround y, rotate arround z, Width of Bracer, Lenght of Bracer, Support Structure, Diameter of Threaded Rod, Nut Size, Sharpening Threaded Rod Holder, Direction where threaded Rod is pointed to
    module ufbss (flipx, flipy, rotate, width, lenght, ss, dotr, ns, strh, direction) { 
      mirror ([flipx,flipy,0]) rotate ([rotate,direction,0]) {
	difference () {
	  union () {
	    cylinder (h = width, r = ufbshtrd+ss); //Bracer on Threaded Rod
	    linear_extrude(height = width, convexity = 10) polygon (points = [[0,-ufbshtrd-ss],[0,ufbshtrd+ss],[lenght,ufbshtrd-strh],[lenght,-ufbshtrd+strh]], paths = [[0,1,2,3]]); //Nut-Trap Baseplate
	  }
	  union () {
	    translate ([0,0,-1]) cylinder (h = width+2, r = ufbshtrd/2+dotra/2); //Hole for Fixed Threaded Rod
	    translate ([0,0,width/2]) rotate ([0,90,0]) cylinder (h = lenght+1, r = dotr/2+dotra/2); //Threaded Rod Cylinder (Bracing)
	    translate ([ufbshtrd,0,width/2]) rotate ([0,90,0]) cylinder ($fn = 6, r = ns/2/cos(180/6)+0.7, h = ns/2+1.5); //Nut-Trap
	    translate ([ufbshtrd,-ns/2-0.6,width/2]) cube (size = [ns/2+1.5,ns+1.2,40]); 
	    
	  }
	}
      }
    }
		  
		  
    //Cable Clamps on Nema-Engine-Screws
    module cc (type) {
      if (type == 1) {
	difference () {
	  cube (size = [xanes+xaness,cccs,7]);
	  union () {
	    translate ([(xanes+xaness)/2-xaneshd/2,cccs/2,-1]) rotate ([0,0,0]) cylinder (h = 10, r = xaneshs/2); //Screw Hole 1
	    translate ([(xanes+xaness)/2+xaneshd/2,cccs/2,-1]) rotate ([0,0,0]) cylinder (h = 10, r = xaneshs/2); //Screw Hole 2
	    translate ([(xanes+xaness)/2-xaneshd/2,cccs/2,2]) rotate ([0,0,0]) cylinder (h = 10, r = xaneshs/1.3); //Screw Had Hole 1
	    translate ([(xanes+xaness)/2+xaneshd/2,cccs/2,2]) rotate ([0,0,0]) cylinder (h = 10, r = xaneshs/1.3); //Screw Had Hole 2
	    translate ([-1,cccs/2,4+cccd/2]) rotate ([90,0,90]) cylinder (h = xanes+xaness+2, r = cccd/2); //Cable Placer
	    translate ([1,-1,-1]) cube (size = [cczs,cccs+2,cczs/2+1]); //Tightener Corridor 1
	    translate ([(xanes+xaness)/2-cczs/2,-1,-1]) cube (size = [cczs,cccs+2,cczs/2+1]); //Tightener Corridor 2
	    translate ([(xanes+xaness)-cczs-1,-1,-1]) cube (size = [cczs,cccs+2,cczs/2+1]); //Tightener Corridor 2
	  }
	}
      }
    }
    
    
//Define MODULE END ###################################
    
//Generate Groundframe/Innerframe Feed Structure including Y-Axis
if (printmode == false) { //Only if Printmode is OFF

  //Feeds && Y-Axis-Structures
  difference() {
    union() {
      //Groundframe Feed Structures get Holes
      translate ([0,0,0]) gfeed(gffs,gffs,gffh); 
      translate ([wowp,0,0]) gfeed(gffs,gffs,gffh);
      translate ([wowp,lowp,0]) gfeed(gffs,gffs,gffh);
      translate ([0,lowp,0]) gfeed(gffs,gffs,gffh);
      //Inner-Frame Structures get Holes
	//Inner-Frame Feeds
	translate ([ifcd,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	translate ([wowp-ifcd,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	translate ([wowp-ifcd,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	translate ([ifcd,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	translate ([wowp/2,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	translate ([wowp/2,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	
	if (iffc == 9) { //Place 9 Feeds if Configured
	  translate ([ifcd,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	  translate ([wowp/2,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	  translate ([wowp-ifcd,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	}

	//Groundframe / Inner-Frame Compound
	translate ([ifcd,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	translate ([wowp-ifcd,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	translate ([wowp-ifcd,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	translate ([ifcd,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	translate ([wowp/2,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	translate ([wowp/2,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
	
	translate ([0,ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side
	translate ([0,lowp-ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side 
	translate ([wowp,ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side
	translate ([wowp,lowp-ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side
	
	if (iffc == 9) { //Place Compound for 9 Feeds
	  translate ([0,lowp/2,iffhl]) gfeed(gffs,gffs,gffh-iffhl);
	  translate ([wowp,lowp/2,iffhl]) gfeed(gffs,gffs,gffh-iffhl);
	}
	
      //Y-Axis Supporters
      translate ([yass-10,-dbgf-yass,gfshh]) yasup(yass-10,yass,gfsh-gfshh,1,0,ybgd,ybgw,ybgs,ybga,ybgh); //Y-Axis Bearing Structure Left
      translate ([yass-10,lowp+dbgf+gffs,gfshh]) yasup(yass-10,yass,gfsh-gfshh,1,0,ybgd,ybgw,ybgs,ybga,ybgh); //Y-Axis Bearing Structure Right
      translate ([0,-dbgf-yass,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of left Bearing Assistant
      translate ([0,lowp+gffs+dbgf,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of right Bearing Assistant
      if (usetwosmoothrods == true) translate ([0,-dbgf-yass,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of left Bearing Assistant
      if (usetwosmoothrods == true) translate ([0,lowp+gffs+dbgf,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of right Bearing Structure
      //Y-Axis Stepper Motors Structures
      translate ([wowp,-yess-(2*yesw)-dbge,gfshh]) yamm (yesw,yesl,gfsh-gfshh,1,90,yess,yese,yesfs,yesfd,yeset,yeseh,yesehs); //Y-Axis Engine Structure Left
      translate ([wowp,lowp+yess+(2*yesw)+dbge+gffs,gfshh]) yamm (yesw,yesl,gfsh-gfshh,0,270,yess,yese,yesfs,yesfd,yeset,yeseh,yesehs); //Y-Axis Engine Structure Right
      translate ([wowp,-dbge-yass,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of left Engine Structure
      translate ([wowp,lowp+gffs+dbge,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of right Engine Structure
      if (usetwosmoothrods == true) translate ([wowp,-dbge-yass,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of left Engine Structure
      if (usetwosmoothrods == true) translate ([wowp,lowp+gffs+dbge,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of right Engine Structure
    }
    union() {
      //Groundframe Difference Rod Width
      translate ([-aotr-watrl,gffs/2,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,gffs/2,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      //Groundframe Difference Rod Length
      translate ([gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp+gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp+gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      //Inner-Frame Difference Rod Width
      translate ([-aotr-watrl,gffs/2+ifcd,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,gffs/2+ifcd,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2-ifcd,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2-ifcd,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      if (iffc == 9) { //Place Threaded Rods for 9 Feeds
	translate ([-aotr-watrl,lowp/2+gffs/2,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
	translate ([-aotr-watrl,lowp/2+gffs/2,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      }
      //Inner-Frame Difference Rod Length
      translate ([gffs/2+ifcd,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([gffs/2+ifcd,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp/2+gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp/2+gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp-ifcd+gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp-ifcd+gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
    }
  }
  
  //Z-Axis Carrier Structure
  if (showzcarrier) translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,-dbgf-gffs+zasl/2,gfshh-yasrh+zauph+xalbh-xarsr]) mirror ([0,1,0]) zas (zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xarsr,xazs,yasosr,xasrt,xadbsr,xalbh,xanes,xanefs,xanefd,xaness,xawobp,xaneshd,xaneshs,xadozsr,xazasrd,xabw,xabh,xabp,xazsrd,yatfb,yabtfe,yabtfb,yabtl,yabtsw,yabtass); //Left Z-Axis Carrier
    //Cable Clamp on left Z-Axis Carrier
    if (showzcarrier) translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2-xanes/2-xaness/2,-dbgf-gffs+zasl/2-zasl-xanes-xaness/2,gfshh-yasrh+zauph+xalbh-xarsr]) cc (1);
  if (showzcarrier) translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,dbgf+gffs+lowp+(yass-zasl)/2,gfshh-yasrh+zauph+xalbh-xarsr]) zas (zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xarsr,xazs,yasosr,xasrt,xadbsr,xalbh,xanes,xanefs,xanefd,xaness,xawobp,xaneshd,xaneshs,xadozsr,xazasrd,xabw,xabh,xabp,xazsrd,yatfb,yabtfe,yabtfb,yabtl,yabtsw,yabtass); //Right Z-Axis Carrier
    //Cable Clamp on right Z-Axis Carrier
    if (showzcarrier) translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2-xanes/2-xaness/2,dbgf+gffs+lowp+(yass-zasl)/2+zasl+xanes+xaness/2-cccs,gfshh-yasrh+zauph+xalbh-xarsr]) cc (1);
  
  //X-Axis Carrier Structure
  if (showxcarrier) {
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,-dbgf-gffs-zasl/2,gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)]) xac (0,0,0,1,zasw,zasl,xacsh,xazasrd,xadozsr,xazsrd,zawolb,zalolb,zawolbss,zapoflb,zasbtlb,xadosr,xasrs,xaasrfb,xasrss,xasrms,xasrmsd,xaamm,xaamh,xaabh,xammpt,xams,xamfs,xamfd,xammpfs,xammpss,xammpsd,xanes,xaness,xatrs,zantfr,zawon,zantss,xahosb,xawob,xadob,xahib,xawwt); //X-Axis Carrier with Motormount
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,lowp+dbgf+gffs+(yass+zasl)/2,gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)]) {
      xac (0,1,0,0,zasw,zasl,xacsh,xazasrd,xadozsr,xazsrd,zawolb,zalolb,zawolbss,zapoflb,zasbtlb,xadosr,xasrs,xaasrfb,xasrss,xasrms,xasrmsd,xaamm,xaamh,xaabh,xammpt,xams,xamfs,xamfd,xammpfs,xammpss,xammpsd,xanes,xaness,xatrs,zantfr,zawon,zantss,xahosb,xawob,xadob,xahib,xawwt); //X-Axis Carrier with Bearingmount
       translate ([zasw-xammpt-xaamm-xawwt/2-(xawob-xawobt)/2,(xaness/2+xanes/2)/2,xams/2+xammpfs/2+xaabh-xadob/2-xahob]) belt (180,(xaness/2+xanes/2)/2+zasl*2+gffs+dbgf+lowp+xams/2+xammpfs/2,xawobt, xahob); //Place Belt for Simulating
    }
  }
      //X-Axis Tool-Carrier on Carrier Structure
      if (showxtoolcarrier) {
	translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,(lowp-xalotc+gffs)/100*drivex,gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)]) {	  xtc(xawotc,xalotc,xahotc,xawolbh,xaholbh,xaposrfb,xadbttsr,xawolb,xalolb,xadolbttre,xalbt,xasrs,xampt,xagsimp,xathsimp,xashdpt,xasdst,xastshd,xaatmps,xaatmpd,xaatmpp,xabspfto,xabspd); //Place X-Axis Tool-Carrier
	  translate ([(xawotc-xadbttsr-xawolbh)/2+(xadbttsr+xawolbh)/2,xalotc/2,xaposrfb+xaholbh])tooldremel(printdremelhp1); //Plate Tool on X-Axis Tool-Carrier
	  translate ([(xawotc-xadbttsr-xawolbh)/2+xabspfto-xawobt/2,0,xaposrfb+xaholbh]) xtcbt(0,0,xawobt,xahob,xapob,xaatmpd,xaatmps,xashd,xappt,xaap); //Place left Belt-Tightener
	  translate ([(xawotc-xadbttsr-xawolbh)/2+xabspfto-xawobt/2,xalotc-xaatmpd-xaatmps*2,xaposrfb+xaholbh]) xtcbt(0,0,xawobt,xahob,xapob,xaatmpd,xaatmps,xashd,xappt,xaap); //Place right Belt-
	  translate ([xalotc-xaatmps/2,xalotc/2+xasl/2,xaposrfb+xaholbh]) rotate ([0,0,180]) xtcsh(0, 0, xasw, xasl, xaslws, xasfd, xaspos, xasst, xaspo, xasdods, xasdoss, xasdossh, xaatmps, xaatmpd, xaatmpp, xatfl, xatfw, xatw, xath, xatmhd, xatmhs, xatmhpfp); //Place Auto-Bed-Leveling Structure
	}
      }
          
  //Upper-Frame
  if (showupperframe) {
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,-dbgf-gffs-zasl/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh]) ufs        
    (0,0,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufdotrbb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure left
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,lowp+dbgf+gffs+(yass+zasl)/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh]) ufs        
    (0,1,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufdotrbb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure right
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,-dbgf-gffs-zasl/2-ufbtl-ufalotrbb-ufbtpafbb,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh]) ufbt (0,0,0,ufbtl,zasw,ufaw,zasl,ufh,uftrbd,ufdotrb,ufdotrbb,ufsrs,ufbts,ufbtsp,ufbtbw,ufbtbp,ufbtass,ufbtss,ufbtd,ufbtsa,"all");   //Upper Frame Belt Tightener left
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,lowp+dbgf+gffs+(yass+zasl)/2+ufalotrbb+ufbtpafbb,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh]) ufbt (0,0,0,ufbtl,zasw,ufaw,zasl,ufh,uftrbd,ufdotrb,ufdotrbb,ufsrs,ufbts,ufbtsp,ufbtbw,ufbtbp,ufbtass,ufbtss,ufbtd,ufbtsa,"all");   //Upper Frame Belt Tightener right
  }
    //Simulate ZZ-Bearing for Left/Right Structures
    translate ([(yass-10)/2,-dbgf-yass-ufbssto-ufabp,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) zzb (0,0,ufdobb,ufwobb,ufbshtrd); //Simulate ZZ-Bearing 2 Left
    translate ([(yass-10)/2,lowp+gffs+aotr+latrl+ufabp,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) zzb (0,0,ufdobb,ufwobb,ufbshtrd); //Simulate ZZ-Bearing 2 Right
      //Display ZZ-Bearing Deflektion Pulley Structure
      translate ([wowp+(yass-10)/2,-dbgf-yass-ufbssto-ufabp-ufdpwol-ufwobb,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufdp (0,ufdpsa,"true",ufdpwol,ufdpadbb,ufdpdhsp,"false"); //Left
      translate ([wowp+(yass-10)/2,lowp+gffs+aotr+latrl+ufabp-ufdpwol-ufwobb,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufdp (0,ufdpsa,"true",ufdpwol,ufdpadbb,ufdpdhsp,"false"); //Right
  
  translate ([0,-dbgf-yass-ufbssto,lsab-dotr]) ufbs (0,0,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,0);
  translate ([0,-dbgf-yass-ufbssto,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc+lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*2-yasrh-yadbc/2]) ufbs (0,1,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1); //Upper Frame bottom Structure - Front Left
  translate ([-35,-dbgf-yass-ufbssto,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc+lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*2-yasrh-yadbc/2]) ufbses (0,1,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,ufbshtrd,35,22.6);
  translate ([0,dbgf+yass+ufbssto+lowp+gffs,lsab-dotr]) ufbs (0,1,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,0);
  translate ([0,dbgf+yass+ufbssto+lowp+gffs,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc+lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*2-yasrh-yadbc/2]) ufbs (0,0,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1); //Upper Frame bottom Structure - Front Right
  translate ([wowp,-dbgf-yass-ufbssto,lsab-dotr]) ufbs (0,0,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,1,0);
  translate ([wowp,-dbgf-yass-ufbssto,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc+lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*2-yasrh-yadbc/2]) ufbs (0,1,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1); //Upper Frame bottom Structure - Back Left
  translate ([wowp,lowp+dbgf+yass+ufbssto+gffs,lsab-dotr]) ufbs (0,1,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,1,0);
  translate ([wowp,dbgf+yass+ufbssto+lowp+gffs,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc+lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*2-yasrh-yadbc/2]) ufbs (0,0,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1); //Upper Frame bottom Structure - Back Right
  translate ([0,gffs,0]) ufbsb (0, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, true); //Upper Frame bottom Structure Bracer - Front Left
  translate ([0,lowp,0]) ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, true); //Upper Frame bottom Structure Bracer - Front Right
  translate ([wowp+yass-10,gffs,0]) ufbsb (1, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, true); //Upper Frame bottom Structure Bracer - Back Left
  translate ([wowp+yass-10,lowp,0]) mirror ([1,0,0]) ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, true); //Upper Frame bottom Structure Bracer - Back Right
  //Upper Frame bottom Structure Bracer Sideways 
  translate ([gffs/2,-aotr-latrl-xanes-xaness,lsab]) ufbss (0, 0, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, 0-usbsbstra); //Left 1
  translate ([(yass-10)/2,-aotr-latrl-xanes-xaness-usbsbstd,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufbss (0, 0, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, 0+usbsbstra); //Left 2 
  translate ([wowp+gffs/2,-aotr-latrl-xanes-xaness-usbsbstd,lsab]) ufbss (0, 0, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, -180+usbsbstra); //Left 3
  translate ([wowp+(yass-10)/2,-aotr-latrl-xanes-xaness,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufbss (0, 0, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, -180-usbsbstra); //Left 4
  translate ([gffs/2,lowp+gffs+aotr+latrl+xanes+xaness,lsab]) ufbss (0, 1, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, 0-usbsbstra); //Right 1
  translate ([(yass-10)/2,lowp+gffs+aotr+latrl+xanes+xaness+usbsbstd,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufbss (0, 1, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, 0+usbsbstra); //Right 2
  translate ([wowp+gffs/2,lowp+gffs+aotr+latrl+xanes+xaness+gffs/2,lsab]) ufbss (0, 1, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, -180+usbsbstra); //Right 3
  translate ([wowp+(yass-10)/2,lowp+gffs+aotr+latrl+xanes+xaness,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) ufbss (0, 1, 90, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh, -180-usbsbstra); //Right 4
  
  //Threaded Rods
  //Groundframe Width
  translate ([-aotr-watrl,gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,lowp+gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,lowp+gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  //Groundframe Length
  translate ([gffs/2,-aotr-latrl,lsab]) trod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
  translate ([gffs/2,-aotr-latrl,lsab2]) trod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
  translate ([wowp+gffs/2,-aotr-latrl,lsab]) trod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
  translate ([wowp+gffs/2,-aotr-latrl,lsab2]) trod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
  //Inner-Frame Width
  translate ([-aotr-watrl,ifcd+gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,ifcd+gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,lowp+gffs/2-ifcd,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  translate ([-aotr-watrl,lowp+gffs/2-ifcd,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  if (iffc == 9) { //Place Threaded Rods for 9 Feeds
    translate ([-aotr-watrl,lowp/2+gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
    translate ([-aotr-watrl,lowp/2+gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
  }
  //Inner-Frame Length
  translate ([gffs/2+ifcd,0,lsab]) trod(lowp+gffs,-90,0,0);
  translate ([gffs/2+ifcd,0,lsab2]) trod(lowp+gffs,-90,0,0);
  translate ([wowp/2+gffs/2,0,lsab]) trod(lowp+gffs,-90,0,0);
  translate ([wowp/2+gffs/2,0,lsab2]) trod(lowp+gffs,-90,0,0);
  translate ([wowp+gffs/2-ifcd,0,lsab]) trod(lowp+gffs,-90,0,0);
  translate ([wowp+gffs/2-ifcd,0,lsab2]) trod(lowp+gffs,-90,0,0);
  //Z-Axis 
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2,-dbgf-gffs-zasl/2-xaness/2-xanes/2,gfshh-yasrh+zauph+xalbh-xarsr]) trod(zapoflb+zantfr+howp+aotr,0,0,0); //Left
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2,dbgf+gffs+lowp+(yass-zasl)/2+zasl+xaness/2+xanes/2,gfshh-yasrh+zauph+xalbh-xarsr]) trod(zapoflb+zantfr+howp+aotr,0,0,0); //Right
  //Upper-Frame 
  translate ([(yass-10)/2,-(ufbssto+ufbssti+yass)/2,lsab-dotr+lsab2-lsab+dotr*4+yasrh+yahoc]) trod (gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-ufbshtrd*2-yasrh-lsab-dotr-lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*3,0,0,0,10); // Front Left
  translate ([(yass-10)/2,lowp+gffs+(ufbssto+ufbssti+yass)/2,lsab-dotr+lsab2-lsab+dotr*4+yasrh+yahoc]) trod (gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-ufbshtrd*2-yasrh-lsab-dotr-lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*3,0,0,0,10); // Front Right
  translate ([(yass-10)/2+wowp,-(ufbssto+ufbssti+yass)/2,lsab-dotr+lsab2-lsab+dotr*4+yasrh+yahoc]) trod (gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-ufbshtrd*2-yasrh-lsab-dotr-lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*3,0,0,0,10); // Back Left
  translate ([(yass-10)/2+wowp,lowp+gffs+(ufbssto+ufbssti+yass)/2,lsab-dotr+lsab2-lsab+dotr*4+yasrh+yahoc]) trod (gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-ufbshtrd*2-yasrh-lsab-dotr-lsab2-lsab+dotr*4+yasrh+yahoc-ufbshtrd*3,0,0,0,10); // Back Right
    //Upper-Frame Horizontal
    translate ([(yass-10)/2,-dbgf-yass/2-(ufbssto+ufbssti+yass)/2-aotr/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (lowp+2*aotr+gffs+2*latrl,270,0,0); //Front
    translate ([(yass-10)/2+wowp,-dbgf-yass/2-(ufbssto+ufbssti+yass)/2-aotr/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (lowp+2*aotr+gffs+2*latrl,270,0,0); //Back
    //Upper-Frame X-Axis Horizontal
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey,(-xazsrd-zawolb/2-zawolbss)*2-ufbtpafbb-ufbtl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh+ufdotrbb]) trod ((aotr+ufbtl+ufbtpafbb+zasl)*2+lowp+dbgf+gffs+(yass)/2,270,0,0); //Front
    translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw,(-xazsrd-zawolb/2-zawolbss)*2-ufbtpafbb-ufbtl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb-ufh+ufdotrbb]) trod ((aotr+ufbtl+ufbtpafbb+zasl)*2+lowp+dbgf+gffs+(yass)/2,270,0,0); //Back
    //Upper-Frame Sideways Bracing
    translate ([gffs/2,-aotr-latrl-xanes-xaness-ufbsbsw/2,lsab]) trod (sqrt(pow(wowp-yass-10,2)+pow(gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra,2)),90-usbsbstra,0,90); //Left 1
    translate ([gffs/2,-aotr-latrl-xanes-xaness-ufbsbsw/2-usbsbstd,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (sqrt(pow(wowp-yass-10,2)+pow(gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra,2)),90+usbsbstra,0,90); //Left 2
    translate ([gffs/2,lowp+gffs+aotr+latrl+xanes+xaness+ufbsbsw/2,lsab]) trod (sqrt(pow(wowp-yass-10,2)+pow(gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra,2)),90-usbsbstra,0,90); //Right 1
    translate ([gffs/2,lowp+gffs+aotr+latrl+xanes+xaness+ufbsbsw/2+usbsbstd,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (sqrt(pow(wowp-yass-10,2)+pow(gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra,2)),90+usbsbstra,0,90); //Right 2
      //Additional Threaded Rods
      translate ([gffs/2,-aotr-latrl,lsab]) trod (xanes+xaness+ufbsbsw+aotr,90,0,0); //Left 1
      translate ([(yass-10)/2,-aotr-latrl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (xanes+xaness+ufbsbsw+aotr+usbsbstd,90,0,0); //Left 2
      translate ([wowp+gffs/2,-aotr-latrl,lsab]) trod (xanes+xaness+ufbsbsw+aotr+usbsbstd,90,0,0); //Left 3
      translate ([wowp+(yass-10)/2,-aotr-latrl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (xanes+xaness+ufbsbsw+aotr,90,0,0); //Left 4
      translate ([gffs/2,lowp+gffs+aotr+latrl,lsab]) trod (xanes+xaness+ufbsbsw+aotr,90,0,180); //Right 1
      translate ([(yass-10)/2,lowp+gffs+aotr+latrl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (xanes+xaness+ufbsbsw+aotr+usbsbstd,90,0,180); //Right 2
      translate ([wowp+gffs/2,lowp+gffs+aotr+latrl,lsab]) trod (xanes+xaness+ufbsbsw+aotr+usbsbstd,90,0,180); //Right 3
      translate ([wowp+(yass-10)/2,lowp+gffs+aotr+latrl,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra]) trod (xanes+xaness+ufbsbsw+aotr,90,0,180); //Right 4
  
  //Smooth Rods
  //Y-Axis (Sticks to dbgf)
  translate ([0,-dbgf-yass/2,gfsh+yasrh]) srod(wowp+yass-10,0,90,0,yasosr); //Left Top 
  translate ([0,lowp+gffs+dbgf+yass/2,gfsh+yasrh]) srod(wowp+yass-10,0,90,0,yasosr); //Right Top
  if (usetwosmoothrods == true) translate ([0,-dbgf-yass/2,gfshh-yasrh]) srod(wowp+yass-10,0,90,0,yasosr); //Left Bottom
  if (usetwosmoothrods == true) translate ([0,lowp+gffs+dbgf+yass/2,gfshh-yasrh]) srod(wowp+yass-10,0,90,0,yasosr); //Right Bottom
  translate ([0,-dbgf-yass/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc]) srod(wowp+yass-10,0,90,0,yasosr); //Upper-Frame Left
  translate ([0,lowp+gffs+dbgf+yass/2,gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc]) srod(wowp+yass-10,0,90,0,yasosr); //Upper-Frame right
  //Z-Axis
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+xadozsr,-dbgf-yass/2-xazsrd,gfshh-yasrh+xalbh-xarsr]) srod(zapoflb+zalolb+zasbtlb+zalolb+zapoflb+howp+zauph,0,0,0,xazasrd); //Left Upper
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw-xadozsr,-dbgf-yass/2+xazsrd,gfshh-yasrh+xalbh-xarsr]) srod(zapoflb+zalolb+zasbtlb+zalolb+zapoflb+howp+zauph,0,0,0,xazasrd); //Left Lower
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+xadozsr,lowp+gffs+dbgf+yass/2+xazsrd,gfshh-yasrh+xalbh-xarsr]) srod(zapoflb+zalolb+zasbtlb+zalolb+zapoflb+howp+zauph,0,0,0,xazasrd); //Right Upper
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw-xadozsr,lowp+gffs+dbgf+yass/2-xazsrd,gfshh-yasrh+xalbh-xarsr]) srod(zapoflb+zalolb+zasbtlb+zalolb+zapoflb+howp+zauph,0,0,0,xazasrd); //Right Lower
  //X-Axis
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2-xadosr/2,(-xazsrd-zawolb/2-zawolbss)*2,gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)+xaasrfb]) srod((xazsrd+zawolb/2+zawolbss)*2+lowp+gffs+dbgf+zasl/2+(xazsrd+zawolb/2+zawolbss),270,0,0,xasrs); //Back Smooth Rod
  translate ([yass-10+(wowp-zasw-yass+10)/100*drivey+zasw/2+xadosr/2,(-xazsrd-zawolb/2-zawolbss)*2,gfshh-yasrh+zauph+xalbh-xarsr+(howp/100*drivez)+xaasrfb]) srod((xazsrd+zawolb/2+zawolbss)*2+lowp+gffs+dbgf+zasl/2+(xazsrd+zawolb/2+zawolbss),270,0,0,xasrs); //Front Smooth Rod
  

  //Simulate the Belts for Y-Axis
  //Left Side
  translate ([yass-10-(ybgd/2+20+2),-dbgf-yass/2+xabw/2,gfshh+gfsh-gfshh-xabh-ybga-ybgd/2]) belt (270,ybgd/2+20+2+wowp+yese/2-5/2,xabw, xabh); //Belt between Bearing and Engine
  translate ([wowp+yesl+yese/2+5/2,-dbgf-yass/2+xabw/2-xabw,gfshh+gfsh-gfshh-xabh-ybga-ybgd/2+spoxad]) belt (90,(yesl+yese/2+5/2)+yass-10+wowp-((wowp)/100*drivey),xabw, xabh); //Belt between Engine and Y-Structure
  translate ([yass-10-(ybgd/2+20+2),-dbgf-yass/2+xabw/2,gfshh+gfsh-gfshh-xabh-ybga+ybgd/2+xabh]) belt (270,ybgd/2+20+2+((wowp)/100*drivey)+yese/2-5/2,xabw, xabh); //Belt between Bearing and Y-Structure
  //Right Side
  translate ([yass-10-(ybgd/2+20+2),lowp+gffs+dbgf+yass/2+xabw/2,gfshh+gfsh-gfshh-xabh-ybga-ybgd/2]) belt (270,ybgd/2+20+2+wowp+yese/2-5/2,xabw, xabh); //Belt between Bearing and Engine
  translate ([wowp+yesl+yese/2+5/2,lowp+gffs+dbgf+yass/2+xabw/2-xabw,gfshh+gfsh-gfshh-xabh-ybga-ybgd/2+spoxad]) belt (90,(yesl+yese/2+5/2)+yass-10+wowp-((wowp)/100*drivey),xabw, xabh); //Belt between Engine and Y-Structure
  translate ([yass-10-(ybgd/2+20+2),lowp+gffs+dbgf+yass/2+xabw/2,gfshh+gfsh-gfshh-xabh-ybga+ybgd/2+xabh]) belt (270,ybgd/2+20+2+((wowp)/100*drivey)+yese/2-5/2,xabw, xabh); //Belt between Bearing and Y-Structure

} 

//###################################################################################################################################################################
//Parts Output for Printing
  //Groundframe Feeds
    if (printgff == true && printmode == true) {
      difference () {
	union () {
	  translate ([0,0,0]) gfeed(gffs,gffs,gffh); 
	  translate ([gffs+printgffd,0,0]) gfeed(gffs,gffs,gffh);
	  translate ([gffs+printgffd,gffs+printgffd,0]) gfeed(gffs,gffs,gffh);
	  translate ([0,gffs+printgffd,0]) gfeed(gffs,gffs,gffh);
	}
	union () {
	  //Groundframe Difference Rod Width
	  translate ([-1,gffs/2,wsab]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs/2,wsab2]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs+printgffd+gffs/2,wsab]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs+printgffd+gffs/2,wsab2]) drod(gffs*2+2+printgffd,0,90,0);
	  //Groundframe Difference Rod Length
	  translate ([gffs/2,-1,lsab]) drod(gffs*2+2+printgffd,-90,0,0);
	  translate ([gffs/2,-1,lsab2]) drod(gffs*2+2+printgffd,-90,0,0);
	  translate ([gffs+printgffd+gffs/2,-1,lsab]) drod(gffs*2+2+printgffd,-90,0,0);
	  translate ([gffs+printgffd+gffs/2,-1,lsab2]) drod(gffs*2+2+printgffd,-90,0,0);
	}
      }
    }
    
  //Inner-Frame Compounds
    if (printifc == true && printmode == true) {
      difference () {
	union () {
	  //Inner-Frame Compound
	  translate ([0,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw);
	  translate ([gffs+printifcd,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw);  
 	  translate ([gffs*2+printifcd*2,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
 	  translate ([gffs*3+printifcd*3,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
 	  translate ([gffs*4+printifcd*4,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
 	  
	  translate ([0,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
	  translate ([gffs+printifcd,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
	  translate ([gffs*2+printifcd*2,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
	  translate ([gffs*3+printifcd*3,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
	  translate ([gffs*4+printifcd*4,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 

	  if (iffc == 9) { //Place Compound for 9 Feeds
	    translate ([gffs*5+printifcd*5,0,iffhw]) gfeed(gffs,gffs,gffh-iffhl);
	    translate ([gffs*5+printifcd*5,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhl);
	  }
	}
	union () {
	  //Inner-Frame Compound Difference Rod Width
	  translate ([-1,gffs/2,wsab]) drod(gffs*6+2+printifcd*6,0,90,0);
	  translate ([-1,gffs/2,wsab2]) drod(gffs*6+2+printifcd*6,0,90,0);
	  translate ([-1,gffs+printifcd+gffs/2,wsab]) drod(gffs*6+2+printifcd*6,0,90,0);
	  translate ([-1,gffs+printifcd+gffs/2,wsab2]) drod(gffs*6+2+printifcd*6,0,90,0);
	  //Inner-Frame Compound Difference Rod Length
	  translate ([gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs+printifcd+gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs+printifcd+gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*2+printifcd*2+gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*2+printifcd*2+gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*3+printifcd*3+gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*3+printifcd*3+gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*4+printifcd*4+gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*4+printifcd*4+gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*5+printifcd*5+gffs/2,-1,lsab]) drod(gffs*2+2+printifcd,-90,0,0);
	  translate ([gffs*5+printifcd*5+gffs/2,-1,lsab2]) drod(gffs*2+2+printifcd,-90,0,0);
	}
      }
    }
  
  //Inner-Frame Feeds
    if (printiff == true && printmode == true) {
      rotate ([0,180,0]) {
	difference () {
	  union () {
	    translate ([0,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	    translate ([gffs+printiffd,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	    translate ([gffs*2+printiffd*2,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	    
	    translate ([0,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	    translate ([gffs+printiffd,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	    translate ([gffs*2+printiffd*2,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	    
	    if (iffc == 9) { //Place 9 Feeds if Configured
	      translate ([0,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	      translate ([gffs+printiffd,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh);
	      translate ([gffs*2+printiffd*2,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh); 
	    }
	  }
	  union () {
	    //Inner-Frame Feeds Difference Rod Width
	    translate ([-1,gffs/2,wsab]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs/2,wsab2]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs+printiffd+gffs/2,wsab]) drod(gffs*3+2+printiffd*3,0,90,0);
	    translate ([-1,gffs+printiffd+gffs/2,wsab2]) drod(gffs*3+2+printiffd*3,0,90,0);
	    translate ([-1,gffs*2+printiffd*2+gffs/2,wsab]) drod(gffs*3+2+printiffd*3,0,90,0);
	    translate ([-1,gffs*2+printiffd*2+gffs/2,wsab2]) drod(gffs*3+2+printiffd*3,0,90,0);
	    //Inner-Frame Feeds Difference Rod Length
	    translate ([gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	    translate ([gffs+printiffd+gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs+printiffd+gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	    translate ([gffs*2+printiffd*2+gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs*2+printiffd*2+gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	  }
	}
      }
    }
  
  //Y-Axis Smooth Rod Holder + Bearing Assistant
    if (printyab == true && printmode == true) {
      rotate ([0,90,0]) {
	difference () {
	  union () {
	    translate ([+yass-10,0,gfshh]) yasup(yass-10,yass,gfsh-gfshh,1,0,ybgd,ybgw,ybgs,ybga,ybgh); //Y-Axis Bearing Asisstant
	    translate ([0,0,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of Bearing Assistant
	    if (usetwosmoothrods == true) translate ([0,0,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of Bearing Structure
	  }
	  union () {
	    translate ([gffs/2,-1,lsab]) drod(yass+2,-90,0,0);
	    translate ([gffs/2,-1,lsab2]) drod(yass+2,-90,0,0);
	  }
	}
      }
  }
  
  //Y-Axis Smooth Rod Holder + Bearing Assistant
    if (printyae1 == true && printmode == true) {
      rotate ([0,270,0]) {
	difference () {
	  union () {
	    translate ([0,0,gfshh]) yamm (yesw,yesl,gfsh-gfshh,1,90,yess,yese,yesfs,yesfd,yeset,yeseh,yesehs); //Engine Structure
	    translate ([0,0,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of left Engine Structure      
	    if (usetwosmoothrods == true) translate ([0,0,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of left Engine Structure
	  }
	  union () {
	    translate ([gffs/2,-1,lsab]) drod(yass+2,-90,0,0);
	    translate ([gffs/2,-1,lsab2]) drod(yass+2,-90,0,0);
	  }
	}
      }
    }
  //Y-Axis Smooth Rod Holder + Engine Assistant
    if (printyae2 == true && printmode == true) {
      rotate ([0,270,0]) {
	difference () {
	  union () {
	    translate ([0,yess+(2*yesw),gfshh]) yamm (yesw,yesl,gfsh-gfshh,0,270,yess,yese,yesfs,yesfd,yeset,yeseh,yesehs); //Engine Structure
	    translate ([0,0,gfsh]) yasrm (yass-10,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Top of right Engine Structure
	    if (usetwosmoothrods == true) translate ([0,0,gfshh]) yasrm (yass-10,yass,yasrh,1,0,yahoc,yadbc,yasosr,yasosh,yadbsrant); //Y-Axis Smooth-Rod Holder On Bottom of right Engine Structure
	  }
	  union () {
	    translate ([gffs/2,-1,lsab]) drod(yass+2,-90,0,0);
	    translate ([gffs/2,-1,lsab2]) drod(yass+2,-90,0,0);
	  }
	}
      }
    }
    //Z-Axis Structure left
    if (printzas1 == true && printmode == true) {
      rotate ([180,0,0]) {
	mirror ([0,1,0]) zas (zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xarsr,xazs,yasosr,xasrt,xadbsr,xalbh,xanes,xanefs,xanefd,xaness,xawobp,xaneshd,xaneshs,xadozsr,xazasrd,xabw,xabh,xabp,xazsrd,yatfb,yabtfe,yabtfb,yabtl,yabtsw,yabtass,1); //Left Z-Axis Carrier
      }
    }
    
    //Z-Axis Structure right
    if (printzas2 == true && printmode == true) {
      rotate ([180,0,0]) {
        zas (zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xarsr,xazs,yasosr,xasrt,xadbsr,xalbh,xanes,xanefs,xanefd,xaness,xawobp,xaneshd,xaneshs,xadozsr,xazasrd,xabw,xabh,xabp,xazsrd,yatfb,yabtfe,yabtfb,yabtl,yabtsw,yabtass,1); //Right Z-Axis Carrier
      }
    }
    
    //X-Axis Structure left
    if (printxas1 == true && printmode == true) {
        xac (0,0,0,1,zasw,zasl,xacsh,xazasrd,xadozsr,xazsrd,zawolb,zalolb,zawolbss,zapoflb,zasbtlb,xadosr,xasrs,xaasrfb,xasrss,xasrms,xasrmsd,xaamm,xaamh,xaabh,xammpt,xams,xamfs,xamfd,xammpfs,xammpss,xammpsd,xanes,xaness,xatrs,zantfr,zawon,zantss,xahosb,xawob,xadob,xahib,xawwt); //X-Axis Carrier with Motormount
    }
    
    //X-Axis Structure right
    if (printxas2 == true && printmode == true) {
        xac (0,1,0,0,zasw,zasl,xacsh,xazasrd,xadozsr,xazsrd,zawolb,zalolb,zawolbss,zapoflb,zasbtlb,xadosr,xasrs,xaasrfb,xasrss,xasrms,xasrmsd,xaamm,xaamh,xaabh,xammpt,xams,xamfs,xamfd,xammpfs,xammpss,xammpsd,xanes,xaness,xatrs,zantfr,zawon,zantss,xahosb,xawob,xadob,xahib,xawwt); //X-Axis Carrier with Bearingmount
    }
    
    //X-Axis Tool-Carrier
    if (printxcarrier == true && printmode == true) {
      /*rotate ([180,0,0]) {*/	xtc(xawotc,xalotc,xahotc,xawolbh,xaholbh,xaposrfb,xadbttsr,xawolb,xalolb,xadolbttre,xalbt,xasrs,xampt,xagsimp,xathsimp,xashdpt,xasdst,xastshd,xaatmps,xaatmpd,xaatmpp,xabspfto,xabspd); //Tool Carrier Structure
//       }
    }
    
    //Belt Tightener Y-Axis Structure
    if (printtightenery == true && printmode == true) {
      
      rotate ([90,0,0]) zacc(zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xadbsr-xalbh+xarsr,xazs,yasosr,xasrt,xadozsr,xazasrd,xazsrd,xabw,yabtfe,yabtfb,yabtl,yabtsw,yabtass,2);
      translate ([0,zasw/4,0]) rotate ([90,0,0]) zacc(zasw,zasl,zauph,1,0,yawolb,yalolb,xadobtho,xadbsr-xalbh+xarsr,xazs,yasosr,xasrt,xadozsr,xazasrd,xazsrd,xabw,yabtfe,yabtfb,yabtl,yabtsw,yabtass,2); //4x Belt-Tightener Y-Axis Structure
    }
    
    //Belt Tightener X-Axis Structure
    if (printtightenerx == true && printmode == true) {
      rotate ([180,0,0]) {
	translate ([0,0,0]) xtcbt(0,0,xawobt,xahob,xapob,xaatmpd,xaatmps,xashd,xappt,1); //Place left Belt-Tightener
	translate ([0,xaatmpd+xaatmps+20,0]) xtcbt(0,0,xawobt,xahob,xapob,xaatmpd,xaatmps,xashd,xappt,1); //Place right Belt-Tightener
      }
    }
    
    //Dremel Holder
    if (printdremelh == true && printmode == true) {
      rotate([180,0,0]) tooldremel(printdremelhp1, "false");
    }
    
    //Dremel Holder Test-Objects
    if (printdremelht == true && printmode == true) {
      tooldremel(printdremelhp1, "true");
      translate ([30,0,0]) tooldremel(printdremelhp2, "true");
      translate ([60,0,0]) tooldremel(printdremelhp3, "true");
    }
    
    //Pen Holder
    if (printpenh == true && printmode == true) {
      toolpen(printpend, printpendh, "false");
    }
    
    //Auto-Bed-Leveling Structure
    if (printautoblvl == true && printmode == true) {
      rotate ([0,180,0]) xtcsh(0, 0, xasw, xasl, xaslws, xasfd, xaspos, xasst, xaspo, xasdods, xasdoss, xasdossh, xaatmps, xaatmpd, xaatmpp, xatfl, xatfw, xatw, xath, xatmhd, xatmhs, xatmhpfp, 1); //Place Auto-Bed-Leveling Structure
      translate ([-xasl/2,0,xasfd*2-xasst]) rotate ([0,270,90]) xtcsh(0, 0, xasw, xasl, xaslws, xasfd, xaspos, xasst, xaspo, xasdods, xasdoss, xasdossh, xaatmps, xaatmpd, xaatmpp, xatfl, xatfw, xatw, xath, xatmhd, xatmhs, xatmhpfp, 2); //Place Auto-Bed-Leveling Flag
    }
    
    //Upper Frame Structure left
    if (printufs1 == true && printmode == true) {
      rotate ([180,0,0]) {
	intersection () {
	  translate ([-ufaw/2,-zantss/2-xams/2-xatrs/2-zantss-ufsfb,-zapoflb-zantfr]) cube (size = [zasw+ufaw,zasl+zantss/2+xams/2+xatrs/2+zantss+ufsfb,zantfr+zapoflb+ufh]);
	  ufs        (0,0,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure left
	} //Cut Upper-Frame-Structure Left in a Printable Piece #1
	translate ([(zasw)/2,-xaness/2-xams/2,-(zalolb*2+zapoflb*2+zasbtlb)+(zapoflb+zantfr+4.5)]) membran(10,10,true); //Insert Membran for Printable Dom
      }
      translate ([0,-zasl*2-5,-ufh*2]) {
	intersection () {
	    translate ([-ufaw/2,-zantss/2-xams/2-xatrs/2-zantss-ufsfb,ufh+0.0025]) cube (size = [zasw+ufaw,zasl+zantss/2+xams/2+xatrs/2+zantss+ufsfb,ufholbc*2]);
	    ufs        (0,0,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure left
	} //Cut Upper-Frame-Structure Left in a Printable Piece #2
      }
    }
    
    //Upper Frame Structure right
    if (printufs2 == true && printmode == true) {
      rotate ([180,0,0]) {
	intersection () {
	  translate ([-ufaw/2,-zantss/2-xams/2-xatrs/2-zantss-ufsfb,-zapoflb-zantfr]) cube (size = [zasw+ufaw,zasl+zantss/2+xams/2+xatrs/2+zantss+ufsfb,zantfr+zapoflb+ufh]);
	  ufs        (0,1,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure left
	} //Cut Upper-Frame-Structure Left in a Printable Piece #1
	translate ([(zasw)/2,+xaness/2+xams/2,-(zalolb*2+zapoflb*2+zasbtlb)+(zapoflb+zantfr+4.5)]) membran(10,10,true); //Insert Membran for Printable Dom
      }
      translate ([0,+zasl*2+5,-ufh*2]) {
	intersection () {
	    translate ([-ufaw/2,-zantss/2-xams/2-xatrs/2-zantss-ufsfb,ufh+0.0025]) cube (size = [zasw+ufaw,zasl+zantss/2+xams/2+xatrs/2+zantss+ufsfb,ufholbc*2]);
	    ufs        (0,1,0,zasw,ufaw,zasl,ufh,xazasrd,xadozsr,xazsrd,zalolb,zapoflb,zasbtlb,xams,xaness,xatrs,zantfr,zawon,zantss,ufwob,ufdob,ufhib,ufsfb,uflolbc,ufwolbc,ufholbc,ufwolb,uflolb,ufdobtre,ufabtho,uflbt,ufsrs,ufsrfs,ufsras,uftrbd,ufdotrb,ufalotrbb,ufdobb,ufwobb); //Upper Frame Structure left
	} //Cut Upper-Frame-Structure Left in a Printable Piece #2
      }
    }
    
    //Upper Frame Belt Tightener
    if (printufbt == true && printmode == true) {
      translate ([0,ufh*2.5,yabh*3+ufdotrbb+uftrbd*0.5+ufbtsp+0.25+((ufbtbw+3.5)/100*ufbtbp)+5]) rotate ([180,0,0]) ufbt (0,0,0,ufbtl,zasw,ufaw,zasl,ufh,uftrbd,ufdotrb,ufdotrbb,ufsrs,ufbts,ufbtsp,ufbtbw,ufbtbp,ufbtass,ufbtss,ufbtd,ufbtsa,"true"); 
      rotate ([90,0,0]) ufbt (0,0,0,ufbtl,zasw,ufaw,zasl,ufh,uftrbd,ufdotrb,ufdotrbb,ufsrs,ufbts,ufbtsp,ufbtbw,ufbtbp,ufbtass,ufbtss,ufbtd,ufbtsa,"false"); 
      translate ([0,ufh*3.5,-ufbtl/2+(ufbtbw+3.5)/2]) rotate ([90,0,0]) ufbt (0,0,0,ufbtl,zasw,ufaw,zasl,ufh,uftrbd,ufdotrb,ufdotrbb,ufsrs,ufbts,ufbtsp,ufbtbw,ufbtbp,ufbtass,ufbtss,ufbtd,ufbtsa,"slot"); 
    }
    
    //Upper Frame Deflektion Pulley Structure
    if (printufdp == true && printmode == true) {
      rotate([90,0,0]) {
	ufdpp (0,0,ufdpwol,ufdpadbb,ufdpdhsp); //Part 1
	translate ([ufbshtrd*4,0,0]) ufdpp (0,0,ufdpwol,ufdpadbb,0); //Part 2
      }
    }
    
    //Upper Frame bottom Structure (low) 1 
    if (printufbs1 == true && printmode == true) {
      rotate([0,90,0]) ufbs (0,0,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,0);
    }
    //Upper Frame bottom Structure (low) 2 
    if (printufbs2 == true && printmode == true) {
      rotate([0,90,0]) ufbs (0,1,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,0);
    }
    //Upper Frame bottom Structure (low) 3
    if (printufbs3 == true && printmode == true) {
      rotate([0,270,0]) ufbs (0,0,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,1,0);
    }
    //Upper Frame bottom Structure (low) 4
    if (printufbs4 == true && printmode == true) {
      rotate([0,270,0]) ufbs (0,1,0,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,1,0);
    }
    //Upper Frame bottom Structure (hight) 5
    if (printufbs5 == true && printmode == true) {
      rotate([0,90,0]) ufbs (0,1,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1);
    }
    //Upper Frame bottom Structure (hight) 6
    if (printufbs6 == true && printmode == true) {
      rotate([0,90,0]) ufbs (0,0,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,uftrnd,uftrss,ufbshtrd,0,1);
    }
    
    //Upper Frame bottom Emergency Stop
    if (printufbses == true && printmode == true) {
      rotate([0,90,0]) ufbses (0,0,180,ufbssto,ufbssti,ufbstrd,ufbsdotra,ufbstrs,ufbstrsh,ufbshtrd,35,22.6);
    }
    
    //Upper-Frame upper Bracer Structures (Count 4x)
    if (printufb1 == true && printmode == true) {
      rotate ([0,90,0]) {
	ufbsb (0, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, false, 2); //Upper Frame Upper Structure Bracer - Front Left
	translate ([0,lowp*2+ufusrl*0.2,0]) ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, false, 2); //Upper Frame Upper Structure Bracer - Front Right
	rotate ([0,0,180]) translate ([0,0,ufusrl*1.5]) {
	  translate ([0,-lowp*2-ufusrl*0.2,0]) ufbsb (1, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, false, 2); //Upper Frame Upper Structure Bracer - Back Left
	  mirror ([1,0,0]) ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, false, 2); //Upper Frame Upper Structure Bracer - Back Right
	}
      }
    }
    //Upper-Frame bottom Bracer Structures Backplates (Print 2x)
    if (printufb2 == true && printmode == true) {
      rotate ([0,90,0]) {
	intersection () { //Cut out the Backplate
	  translate ([ufbsbfpt,ufbsbgd,lsab-dotr]) cube (size = [ufbsbbpt,ufbsbl,lsab2-lsab+dotr*2]);
	  ufbsb (0, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, false, 1); //Upper Frame Bottom Structure Bracer - Set 1
	}
	translate ([0,ufbsbgd/0.6,0]) {
	  intersection () { //Cut out the Backplate
	    translate ([ufbsbfpt,-ufbsbgd-ufbsbl,lsab-dotr]) cube (size = [ufbsbbpt,ufbsbl,lsab2-lsab+dotr*2]);
	    ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, false, 1); //Upper Frame Upper Structure Bracer - Set 2
	  }
	}
      }
    }
    //Upper-Frame bottom Bracer Structure Frontplates 1
    if (printufb3 == true && printmode == true) {
      rotate ([0,90,0]) {
	intersection () { //Cut out the Backplate
	  translate ([ufbsbfpt-100,ufbsbgd,lsab-dotr]) cube (size = [100,ufbsbl,lsab2-lsab+dotr*2]);
	  ufbsb (0, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, false, 1); //Upper Frame Bottom Structure Bracer - Set Part 1
	}
	translate ([0,ufbsbgd/0.6,0]) {
	  intersection () { //Cut out the Backplate
	    translate ([ufbsbfpt-100,-ufbsbgd-ufbsbl,lsab-dotr]) cube (size = [100,ufbsbl,lsab2-lsab+dotr*2]);
	    ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt, ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, false, 1); //Upper Frame Upper Structure Bracer - Set Part 2
	  }
	}
      }
    }
    //Upper-Frame bottom Bracer Structure Frontplates 2
    if (printufb4 == true && printmode == true) {
      rotate ([0,-90,0]) {
	translate ([0,ufbsbgd/0.6,0]) {
	  intersection () { //Cut out the Backplate
	    translate ([-(ufbsbfpt+(yass-10-gffs)),ufbsbgd,lsab-dotr]) cube (size = [100,ufbsbl,lsab2-lsab+dotr*2]);
	    ufbsb (1, 0, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, false, false, 1); //Upper Frame Bottom Structure Bracer - Set Part 1
	  }
	}
	translate ([0,ufbsbgd*3,0]) {
	  intersection () { //Cut out the Backplate
	    translate ([-(ufbsbfpt+(yass-10-gffs)),-ufbsbgd-ufbsbl,lsab-dotr]) cube (size = [100,ufbsbl,lsab2-lsab+dotr*2]);
	    mirror ([1,0,0]) ufbsb (0, 1, 0, ufbsbw, ufbsbl, ufbsbbpt, ufbsbfpt+(yass-10-gffs), ufbsbpps, ufbsbctrd, ufbsbgd, ufbscra, ufbsrl, ufusbw, ufusbl, ufusrl, ufusrlp, ufbsss, ufbsns, true, false, 1); //Upper Frame Bottom Structure Bracer - Set Part 2
	  }
	}
      }
    }
   //Upper-Frame bottom Bracer Structure Sideways 1
   if (printufb5 == true && printmode == true) {
      ufbss (0, 0, 0, ufbsbsw, ufbsbsl, ufbsbsss, usbsbstd, usbsbsns, usbsbsstrh);
   }
   
   //Cable-Clamps 1
   if (printcc1 == true && printmode == true) {
      cc (1);
   }
    
    //Test-Print for compareing Sizes gffs
    if (printtestsizes == true && printmode == true) {
      translate ([0,0,0]) { //Print Nut-Trap Z-Axis Threaded Rod
	difference () { 
	  cube (size = [zawon*2,zawon*2,printtestsizesh]);
	  translate ([zawon,zawon,-1]) cylinder ($fn = 6, r = zawon/2/cos(180/6)+0.7, h = printtestsizesh+2); //Nut-Trap
	}
      }
      translate ([zawon*2+printtestsizesd,0,0]) { //Print Threaded Rod Shaft (Groundframe Feeds for example)
	difference () { 
	  cube (size = [gffs,gffs,printtestsizesh]);
	  translate ([gffs/2,gffs/2,-1]) cylinder (r = dotr/2+dotra/2, h = printtestsizesh+2); //Nut-Trap
	}
      }
      translate ([zawon*2+gffs+printtestsizesd*2,0,printtestsizesd]) { //Print Threaded Rod Shaft (Groundframe Feeds for example)
	rotate ([0,90,0]) {
	  yasrm (printtestsizesd,yass,yasrh,0,0,yahoc,yadbc,yasosr,yasosh,yadbsrant);
	}
      }
      translate ([0,zawon*2+printtestsizesd,0]) { //Print Linear-Bearing Clip with Tightener
	rotate ([0,0,0]) {
	  zacr((xalotc/100)*70,xawolbh,xaholbh,0,0,xawolb,xalolb,xadolbttre,0,xalbt,xasrs,0.10,0,0,0);
	}
      }
    }
    
//Information Echos in Render-Terminal
echo ("################# SIZES OF UNPRINTABLE OBJECTS #################");
  //Threaded Rods
    //Groundframe
    echo ("Pieces: 4, Groundframe: Size of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    echo ("Pieces: 4, Groundframe: Size of the Length-Sized Threaded Rods:", lowp+2*aotr+gffs+2*latrl);
    if (iffc == 9) { //Place 9 Feeds if Configured
      echo ("Pieces: 6, Inner-Frame: Size of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    } else {
      echo ("Pieces: 4, Inner-Frame: Size of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    }
    echo ("Pieces: 6, Inner-Frame: Size of the Length-Sized Threaded Rods:", lowp+gffs);
    //Z-Axis
    echo ("Pieces: 2, Z-Axis: Size of the Two Threaded Rods of the Z-Axis:", zapoflb+zantfr+howp+aotr);
    //Bracing
    echo ("Pieces: 2, Upper-Frame Horizontal Bracing:", lowp+2*aotr+gffs+2*latrl);
    echo ("Pieces: 4, Upper-Frame Diagonal Bracing:", sqrt(pow(lowp-ufbssti-ufusbl+ufusrlp,2)+pow(gfshh-yasrh*2+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-lsab-yadbc/2+ufusrl/2+aotr,2)));
    echo ("Pieces: 4, Upper-Frame Diagonal Bracing Sideways:", sqrt(pow(wowp-yass-10,2)+pow(gfshh-yasrh+zauph+xalbh-xarsr+howp+zalolb*2+zapoflb*2+zasbtlb+ufholbc-yasrh-ufbshtrd-ufbsdotra,2)));
    echo ("Pieces: 4, Upper-Frame Diagonal Bracing Sideways (Addition):", xanes+xaness+ufbsbsw+aotr);
    echo ("Pieces: 4, Upper-Frame Diagonal Bracing Sideways (Addition):", xanes+xaness+ufbsbsw+aotr+usbsbstd);
    //X-Axis
    echo ("Pieces: 2, X-Axis: Size of the Two Threaded Rods of the X-Axis:", (aotr+ufbtl+ufbtpafbb+zasl)*2+lowp+dbgf+gffs+(yass)/2);
  //Smooth Rods
    //Differend Axes
    echo ("Pieces: 4, Y-Axis: Size of the Two Smooth Rods of the Y-Axis:", wowp+yass-10);
    echo ("Pieces: 4, Z-Axis: Size of the Four Smooth Rods of the Z-Axis:", zapoflb+zalolb+zasbtlb+zalolb+zapoflb+howp+zauph);
    echo ("Pieces: 2, X-Axis: Size of the Two Smooth Rods of the X-Axis:", (xazsrd+zawolb/2+zawolbss)*2+lowp+gffs+dbgf+zasl/2+(xazsrd+zawolb/2+zawolbss));
    
echo ("########### REACHABLE AREA WIDTHIN THE WORKPIECE PLACE (not 100% reliable jet ;-) ###########");
echo ("LENGHT:", lowp-20-xalotc);
echo ("WIDTH:", wowp-20-zasw);
echo ("HEIGHT:", howp-zauph-xalolb*2-zapoflb*2-zasbtlb);
    