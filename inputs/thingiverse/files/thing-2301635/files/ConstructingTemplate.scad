$fn = 30; // Resolution of Round Objects

// TODO:
// Gedanken:
// - Klammern mit dem man das Werkstück von Vorn befestigen kann

// Beim drucken aufgefallen:
// - Smooth Rods 12mm zu klein! kleine Tolleranz hinzufügen
// - Der zweite Teil des Schlittens verursacht Fehler in der STL Datei
// - Energy Chain Struktur muss etwas angepasst werden da Säge im Weg
// - Energy Chain Struktur (zum einhängen) sollte in der Vollansicht passend plaziert werden

// SCAD-Arbeiten
// - Motor Supply Strucutre im Printmode drehen
// - X-Axis Endstop im Printmode drehen
// - Y-Axis Endstop im Printmode drehen

// Alle mit TODO gekennzeichneten Stellen


//Workbench Size
wowp = 820; //Width of Workplace (TODO Actual Workbench is "gffs"-Value further, please consider this, its not fixed yet)
lowp = 620; //Length of Workplace (TODO Actual Workbench is "gffs"-Value further, plase consider this, its not fixed yet)
dbca = 120; //Distance between Cutting Area (defines the mounting hole spaces of X-Axis Carrier allocated to the threaded Rods)
spl = 150; //Saw Parting Lot ;-)
soc = 75; //Saw Over-Cut
wbph = 9; //Workbench-Plate-Height

//Simulation Sizes
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

  //Sumlated Movement
  mvya = 5; // Move "Y-Axis" (0-100%)
  mvxa = 85; // Move "X-Axis" (0-100%)

//Workspace Mounting-Solutions
wmss = 38; //Size of Mountingplates (on Top of the Inner-Frame)
wmst = 6; //Height of Mountingplates (on Top of the Inner-Frame)
wmsh = 6; //Diameter of the Hole in Mountingplates (4 Holes each Mountingplate)
wmwn = 9; //Width of Nut (for Nut-Trap)

//Global Size Definitions
dotr = 8; //Diameter of Threaded Rods of Groundframe
dotra = 0.5; //Additional Diameter of Threaded Rods of Groundframe and other Structures
aotr = 12; //Add of Threaded Rod at the ends for Nuts and Spacers

//Material Feeder Configurations 
trfebcdfo = 40; //Threaded Rod Feeder- Engine/Bearing Clamp - Distance of Feeder on the Threaded Rods from the Outside

  //Printmode (for Part-Export of Structure in STL e.c.t) (Watch out for the only two Models which need Support-Strucure, they're marked with: (!Support Structure Needed!))
  printmode = false;
  usemembran = false; //Needed for Printing difficult Areas (Do not Print without this Function = true)
  membranthick = 1; //Thickness of the Membran-Layer (1 - recommended)
  printgff = false; // Print Groundframe Feeds (Print 1x)
    printgffd = 10; //Print Groundframe Feeds Distance (Distances between Feeds to Print)
  printwa = false; // Print Workbench Attachments (Print 2x)
  printifc = false; // Print Inner-Frame Compounds (Print 1x)
    printifcd = 10; //Print Inner-Frame Compound Distance (Distances between Compounds to Print)
  printiff = false; // Print Inner-Frame Feeds (Print 1x)
    printiffd = 30; //Print Inner-Frame Feeds Distance (Distances between Feeds to Print)
  printiffs = false; // Print Inner-Frame Feeds Small (Print 1x) (The ones without Holes have to be glued with Acetone-ABS-Mix on the Workbench Attachments (printwa))
    printiffsd = 10; //Print Inner-Frame Feeds Small Distance (Distances between Feeds to Print)
  printxacb = false; // Print X-Axis Carrier
    printxacs = false; // Print X-Axis Carrier Side : (set printxacb to true first) - use "true" for Bearing-Side - use "false" for Engine-Side
    printxacbp = 1; // Print X-Axis Carrier Part : (set printxacb to true first) - Use "1" for Addon+Frame - use "2" for Frame Structure - use "3" for Addon Structure - use "4" for Endstopholder (Engine-Side) - use "5" for Motor Supply Structure
  printtrfebc = false; // Threaded Rod Feeder- Engine/Bearing Clamp
    printtrfebcn = "1"; // Threaded Rod Feeder - Use "1" for Engine - Use "2" for Bearing - Use "3" for Pusher (!Support Structure Needed!) - use "4" for Endstop-Holder
  printtc = false; // Print Toolcarrier
    printtcp = "4"; // Print Toolcarrier Part : (set printtc to true first) - Use "0" for Part 1/2 Together - use "1" for Printing just Part 1 - use "2" for Printing just Part 2 - use "3" for Saw/Energy-Chain Holder  - use "4" for Endstop-Flag (you can Super-Glue anything else instead, too) (!Support Structure Needed!)
  printwcl = true; // Print Workpiece Clamp
    printwclp = "5"; // Print Workpiece Clamp Part : (set printwcl to true first) - Use "0" for Engine-Side - use "1" for Bearing-Side - use "2" for Threded-Rod Clamps - use "3" for Workpiece Clamp itself (use your Slicer-Tool to Increase the Amount of Clamps you need) - use "4" for Energy-Chain Mount - use "5" for Energy-Chain Holder


  //Turn Structures ON/OFF
  showtrod = true; //Show Threaded Rods
  showsrod = true; //Show Smooth Rods
  showengines = true; //Show all Engines

//Size Definitions
//Groundframe Feed Sizes
gfshh = 25; //Start of the Groundframe Structures (Bearing-Supporters/Stepper Engine Structures) (Previous Smooth Rod Holder Size = yasrh + yahoc)
gfsh = 80; //End of the Groundframe Structures (Bearing-Supporters/Stepper Engine Structures)
gffh = 80; //Size of the Groundframe Feeds (Height of the whole Base-Structure) 
gffs = 15; //Diameter of the Groundframe Feeds
gfwaw = 7; //Width of the Workbench Attachments (Workbench Attachments = Attaching Workbench Plate in Saw-Parking-Lot and Overcut)
watrl = 0; //Additional Threaded Rod Length of the "Width" Groundframe Feeds, Warning: the aotr (Add of Threaded Rod for Nuts and Spacers) would be concidered!
latrl = 0; //Additional Threaded Rod Length of the "Length" Groundframe Feeds, Warning: the aotr (Add of Threaded Rod for Nuts and Spacers) would be concidered!
wsab = 15; //Width Space above Bottom, (Space between lower Threaded Rod of the "Width" Groundframe Feeds) Warning: Relatet to the center of the rod!
wsab2 = 40; //Width Space above Bottom 2, (Space between upper Threaded Rod of the "Width" Groundframe Feeds) Warning: Relatet to the center of the rod!
lsab = 25; //Length Space above Bottom, (Space between lower Threaded Rod of the "Length" Groundframe Feeds) Warning: Relatet to the center of the rod!
lsab2 = 50; //Length Space above Bottom, (Space between lower Threaded Rod of the "Length" Groundframe Feeds) Warning: Relatet to the center of the rod!

  //Inner Frame inside of the Groundframe (Workbench)
  ifcd = 140; //Inner Frame Corner Distance
  iffd = 15; //Inner Frame Feed Diameter
  iffhw = 7; //Inner Frame Feed Hover Width (Position of the Threaded-Rod Groundframe Mount-Slots above the Floor (Width Side))
  iffhl = 7; //Inner Frame Feed Hover Lenght (Position of the Threaded-Rod Groundframe Mount-Slots above the Floor (Lenght Side))
  iffc = 6; //Inner Frame Feed Count (How many Feeds for the "Workbench"?) 6 or 9

  //X-Axis Carrier
  xacw = 12; //X-Axis Carrier Width
  xach = 55; //X-Axis Carrier Height (additional)
  xacs = 15; //X-Axis Carrier Strenght (Material Width)
  xasrdb = 99; //X-Axis Carrier Smooth Rod Distance between IMPORTANT: usually its "bpw" + 2*"tcdolbtb" 
  xasrd = 12+0.3; //X-Axis Carrier Smooth Rod Diameter (Add some Tollerances)
  xasrmsd = 4; //X-Axis Smooth-Rod Mounting-Screw Diameter
  xasbd = 22+0.5; //X-Axis Spindle Bearing Diameter (Add some Tollerances) (Increase distance between Spindle and Smoothrod - tcsposr - if Bearing have no space)
  xasbw = 7; //X-Axis Spindle Bearing Width
  xaabm = 4; //X-Axis Additional Bearing Material
  xabpt = 5; //X-Axis Bearing Plate Thickness
  xabpmhd = 70; //X-Axis Bearing/Engine Plate Mounting Hole Distance
  xabpmhs = 6+0.3; //X-Axis Bearing/Engine Plate Mounting Hole Size (Add some Tollerances)

  xams = 56.4; // Motor Size (Nema 23)
  xamfs = 39; // Motor Flange Size
  xamfd = 2.5; // Motor Flange Depth
  xammpfs = 13; // Motor Mounting Plate Frame Size
  xasomp = 5; // Space on Mounting Plate
  xammpss = 4; // Motor Mounting Plate Screw Size
  xammpshd = 7; // Motor Mounting Plate Screw Head Diameter
  xammpsd = 47.1; // Motor Mounting Plate Screws Distance

  xamssw = 10; // Motor Supply Structure Width
  xamssl = 80; // Motor Supply Structure Lenght

  // Endstop Holder X-Axis
  xaesmshd = 19; // Endstop - Mounting Screw Hole Distance (Distance of Holes for mounting Endstop)
  xaesmshs = 3+0.4; // Endstop - Mounting Screw Hole Size (Add some Tollerances!)



  // Threaded Rod Feeder- Engine/Bearing Clamp
  trfebcbw = 0; // Threaded Rod Feeder bottom Structure Bracer Width (additional)
  trfebcbl = 48; // Threaded Rod Feeder bottom Structure Bracer Width
  trfebcbbpt = 9; // Threaded Rod Feeder bottom Structure Bracer Back Plate Thickness (additional)
  trfebcbfpt = 7.5; // Threaded Rod Feeder bottom Structure Bracer Front Plate Thickness (additional) (check Space for Engine Screws)
  trfebcbpps = 1; // Threaded Rod Feeder bottom Structure Bracer Pressure Plate Space
  trfebcbctrd = 8; // Threaded Rod Feeder bottom Structure Bracer Connector Threaded Rod Diameter //TODO falsche Beschreibung?
  trfebcbgd = 10; // Threaded Rod Feeder bottom Structure Bracer Groundframe-Feed Distance (allocate Bracer away from the Groundframe-Feeds)
  trfebccra = 42.8; // Threaded Rod Feeder bottom Structure Bracer Connector Rod Angle //TODO übrig geblieben
  trfebcss = 6.2; // Threaded Rod Feeder bottom Structure Screw Size
  trfebcns = 10; // Threaded Rod Feeder bottom Structure Nut Size //TODO übrig geblieben

  trfebcbd = 22+0.5; // Threaded Rod Feeder - Bearing Diameter (Add some Tollerances) (Increase "trfebcbpt" if Bearing wont fit underneath the Workbench-Plate)
  trfebcbw = 7; // Threaded Rod Feeder - Bearing Width
  trfebcabm = 7; // Threaded Rod Feeder - Additional Bearing Material
  trfebcbpt = 5; // Threaded Rod Feeder - Bearing Plate Additional Thickness (Increase to min. "trfebcbw" if Bearing wont fit underneath the Workbench-Plate)
  trfebcwpsd = 4; // Threaded Rod Feeder - Workbench Plate Screw Diameter (if you also want to fix the Feeder on Workbench-Plate, add a Value > 0)

  trfebcms = 43; // Threaded Rod Feeder - Motor Size
  trfebcmfs = 22.5; // Threaded Rod Feeder - Motor Flange Size
  trfebcmfd = 2.5; // Threaded Rod Feeder - Motor Flange Depth
  trfebcmmpfs = 10; // Threaded Rod Feeder - Motor Mounting Plate Frame Size
  trfebcmsomp = 0; // Threaded Rod Feeder - Space on Mounting Plate (!You need Support-Material if you Print this Value > 0!)
  trfebcmmpss = 4; // Threaded Rod Feeder - Motor Mounting Plate Screw Size 
  trfebcmmpshd = 7; // Threaded Rod Feeder - Motor Mounting Plate Screw Head Diameter
  trfebcmmpsd = 31; // Threaded Rod Feeder - Motor Mounting Plate Screws Distance
  trfebcdomsbwp = 13; // Threaded Rod Feeder - Distance of Motor Shaft below Workbench Plate, (IMPORTANT: Watch at the Engine, it should be below Workbench-Plate)

  trfebcpgwiwp = 4; // Threaded Rod Feeder - Pusher Gap Width in Workbench Plate
  trfebcsd = 10+0.5; // Threaded Rod Feeder - Spindle Diameter
  trfebcpsnw = 18+0.2; // Threaded Rod Feeder - Pusher Spindle-Nut Width (Add some Tollerances, related width "trfebcsd")
  trfebcpsnl = 15+0.2; // Threaded Rod Feeder - Pusher Spindle-Nur Lenght (Add some Tollerances, related width "trfebcsd")
  trfebcnhw = 4; // Threaded Rod Feeder - Nut Housing Width
  trfebcpttwp = 0.2; // Threaded Rod Feeder - Pusher Tollerance to Workbench Plate (Space between Feeder and Workbench Plate)
  trfebcpo = -40; // Threaded Rod Feeder - Pusher Offset (Offset Between Spindle-Nut and Material-Pusher)
  trfebcpw = 30; // Threaded Rod Feeder - Pusher Width
  trfebcpl = 15; // Threaded Rod Feeder - Pusher Lenght
  trfebcpl2 = 7.8; // Threaded Rod Feeder - Pusher Lenght Socket ("0" if not necessary)
  trfebcpshd = 2.7; // Threaded Rod Feeder - Pusher Screw Hole Diameter ("0" if not necessary)
  trfebcph = 7.2; // Threaded Rod Feeder - Pusher Height

  // Endstop Holder Y-Axis
  trfebcesbph = 3; // Threaded Rod Feeder - Endstop Baseplate Height
  trfebcesbpw = 11; // Threaded Rod Feeder - Endstop Baseplate Width
  trfebcesbpl = 36; // Threaded Rod Feeder - Endstop Baseplate Lenght (Check if Entstop won't hit the Workbench-Plate)
  trfebcesbpp = -2; // Threaded Rod Feeder - Endstop Baseplate Position (Origin is right inner Side of bottom Structure Bracer)
  trfebcesshd = 19; // Threaded Rod Feeder - Endstop Mounting Screw Hole Distance (First Hole is "(Enstop Baseplate Width)/2" below "Endstop Baseplate Lenght")
  trfebcesmshs = 2.2; // Endstop - Mounting Screw Hole Size

  //Tool Mounting Baseplate
  bpw = 59; // Baseplate Width (Total Width of Toolhead)
  bpl = 129; // Baseplate Lenght (Total Lenght of Toolhead)
  bph = 3; // Baseplate Height (Not to thick to lose Saw-Depht, nor to less for carrying the Total-Saw-Mass)

  fbph = 10; // Front Baseplate Height
  fbpw = 15; // Front Baseplate Width
    fbpco = 47.5; // Front Baseplate Cutout (Saw Pointer Triangle)
    fbpcol = 8; // Front Baseplate Cutout Lenght (Saw Pointer Lenght)
    fbpcow = 5; // Front Baseplate Cutout Width (Saw Pointer Width)

  bbph = 10; // Back Baseplate Height
  bbpw = 15; // Back Baseplate Width TODO Befestigungslöcher wurden an diesen Wert orientiert und Baseplate ist davon falsch abhängig
    bbpco = 47.5; // Back Baseplate Cutout (Saw Pointer Triangle)
    bbpcol = 10; // Back Baseplate Cutout Lenght (Saw Pointer Lenght)
    bbpcow = 11.5; // Back Baseplate Cutout Width (Saw Pointer Width)

  hd = 5; // Mounting Hole Height
  shw = 5; // Small Mounting Hole Width
  shl = 9; // Small Mounting Hole Lenght
  bhw = 5; // Big Mounting Hole Width
  bhl = 12; // Big Mounting Hole Lenght

  //Tool-Carrier Itself
  tcpoblbp = 122; // Tool Carrier - Position of Back Linear Bearing Pair (Origin Point: Front of Baseplate) TODO Dieser Wert wird von dem aufschraubbaren Aufbau negiert
  tclolb = 30.3; // Tool Carrier - Lenght of Linear Bearing (Add some Tollerances)
  tcwolb = 21.3; // Tool Carrier - Width of Linear Bearing (Add some Tollerances)
  tcdolbtb = 20; // Tool Carrier - Distance of Linear Bearing to Baseplate
  tcamflb = 5; // Tool Carrier - Additional Material for Linear Bearing
  tcsrd = 12.5; // Tool Carrier - Smooth-Rod Diameter (Add some Tollerances)
  tcwopj = 5; // Tool Carrier - Width of Part Junction
  tcasd = 6+0.3; // Tool Carrier - Addon Screw Diameter (Add some Tollerances) (To carry Energy-Chain, Saw-Holder on the Smooth-Rods)
  tcasnd = 10; // Tool Carrier - Addon Screw Nut Diameter (Diameter-Size of Wrench you would use for tightening)
  tcmcw = 9; // Tool Carrier - Mid Connection Width TODO Teil des Smooth-Rod Ausschnitts wird nicht herausgeschnitten wenn > 9
  tcsposr = 21; // Tool Carrier - Spindle Position over Smooth Rod (Case of Linear Bearing should not touch the Spindle Nut!) 
  tcsd = 10.5; // Tool Carrier - Spindle Diameter (Add some Tollerances)
  tcsnw = 18.2; // Tool Carrier - Spindle Nut Width (Add some Tollerances)
  tcsnl = 15.2; // Tool Carrier - Spindle Nut Lenght (Add some Tollerances)
  tceas = "auto"; // Tool Carrier - Engine Attachment Space ("auto" = Automatic; "0-x" Size of Cylinder; "0" Not Needed) (Space for mounting Engine on Spindle)

  tcthswoh = 20; // Tool Carrier - Tool Hold Structure - Width of Hinge
  tcthsdos = 8+0.5; // Tool Carrier - Tool Hold Structure - Diameter of Screw (Add some Tollerances)
  tcthsks = 13; // Tool Carrier - Tool Hold Structure - Key Size (for tightening the Hinge)
  tcecdtms = 0.2; // Tool Carrier - Energy Chain - Distance to Main Structure (tiny values)
  tcecwop = 7; // Tool Carrier - Energy Chain - Width of Plattform (mounting Energy-Chain on, should be min. twice as width as "tcecshw" - Screw Head Width
  tcecsd = 3.4; // Tool Carrier - Energy Chain - Screw Diameter
  tcecsnks = 0; // Tool Carrier - Energy Chain - Screw Nut Key Size ("0" if you Threading the Hole) //TODO - Noch nicht eingegliedert
  tcecfhd = 8; // Tool Carrier - Energy Chain - First Hole Distance
  tcecshd = 18; // Tool Carrier - Energy Chain - Second Hole Distance
  //TODO
  echoefb = 4; // Tool Carrier - Energy Chain - Height of Endstop-Flag Baseplate
  echoef = 16; // Tool Carrier - Energy Chain - Height of Endstop-Flag 
  ecwoef = 2; // Tool Carrier - Energy Chain - Width of Endstop-Flag

  // Workpiece - Clamp
  wclw = 18; // Workpiece Clamp - Width (Blocks)
  wcsw = 4; // Workpiece Clamp - Slider Width
  wcll = 15; // Workpiece Clamp - Lenght at Rear-End (Blocks)
  wcllb = 9; // Workpiece Clamp - Lenght Between (Blocks)
  wclhoms = 51.5; // Workpiece Clamp - Height of Mounting Structure (the Higher the Value, the Higher the Stability)
  wclhawp = 5; // Workpiece Clamp - Height above Workbench Plate (mid of "wclhat" (Adjustment Tollerance) - so you can adjust the height in the Range of "wclhat")
  wclhat = 10; // Workpiece Clamp - Height Adjustment Tollerance (Lenght of the Long-Holes for manual adjustment of Workpiece-Clamp in Height - "wclhoms" must min. be twice as higher than this )
  wclhasd = 6+0.2; // Workpiece Clamp - Height Adjustment Scew Diameter (Add Tollerances)
  wclsnw = 18; // Workpiece Clamp - Spindle Nut Width (just in Case you have to make it different) (Simulation Parameter)
  wclsnl = 14; // Workpiece Clamp - Spindle Nut Lenght (Simulation Parameter)
  wclsnhfc = 6; // Workpiece Clamp - Spindle Nut Hole from Center (Simulation Parameter)
  wcltrd = 8; // Workpiece Clamp - Threaded Rod Diameter
  wcldbtr = 40; // Workpiece Clamp - Distance between Threaded Rods
  wcldosh = 10+0.5; // Workpiece Clamp - Diameter of Spindle Hole (add some Tollerances / no contact to the structure)
  wclatrs = 10; // Workpiece Clamp - Additional Threaded Rod Structure 
  wcldoshfs = 10; // Workpiece Clamp - Distance of Slider-Holes from Spindle
  wclshd = 4; // Workpiece Clamp - Slider-Holes Diameter
  wclssbe = 0.5; // Workpiece Clamp - Slide Space between
  wclwd = 30; // Workpiece Clamp - Work Distance (the Longer the Distance, the Less the Friction)
  wclwh = 10; // Workpiece Clamp - Work Height (how many mm can be Archived by Turning the Spindle)
  wclrr = 1.9; // Workpiece Clamp - Slide Shaft Rounding Radius

  wclsonm = 43; // Workpiece Clamp - Size of Nema Motor
  wclnefs = 22.5; // Workpiece Clamp - Nema Engine Flange Size
  wclnefd = 2.5; // Workpiece Clamp - Nema Engine Flange Depht
  wclwomp = 7; // Workpiece Clamp - Width of Mounting Plate
  wclsomp = 0; // Workpiece Clamp - Space on Mounting Plate
  wclnmshd = 31; // Workpiece Clamp - Nema Motor Screw Hole Distance
  wclsosh = 4; // Workpiece Clamp - Size of Screw Holes
  wclwotrn = 13; // Workpiece Clamp - Width of Threaded Rod Nuts (Key-Span)
  wcldosb = 22+0.25; // Workpiece Clamp - Diameter of Spindle Bearing
  wclwosb = 7; // Workpiece Clamp - Width of Spindle Bearing
  wclaowc = 6; // Workpiece Clamp - Amount of Workpiece Clamps

  wclbpt = 9; // Workpiece Clamp - Back Plate Thickness (additional)
  wclfpt = 7.5; // Workpiece Clamp - Front Plate Thickness (additional)
  wclpps = 1; // Workpiece Clamp - Pressure Plate Space
  wclhas = 0.4; // Workpiece Clamp - Height Adjustment Space (Gap between Threaded-Rod-Clamp and upper Structure)
  wclmsd = 8+0.2; // Workpiece Clamp - Mounting Screw Diameter (Screw Diameter of Threaded-Rod Clamp
  wclmskw = 13; // Workpiece Clamp - Mounting Screw Key Size (Width of the Hexagon-Head of Screw)

  wclecssw = 6; // Workpiece Clamp - Energy Chain - Support-Structure Width
  wclechop = 85; // Workpiece Clamp - Energy Chain - Height of Plattform
  wclecdopfr = 25; // Workpiece Clamp - Energy Chain - Distance of Plattform from Block 
  wclectop = 7; // Workpiece Clamp - Energy Chain - Thickness of Plattform
  wcleclop = 22; // Workpiece Clamp - Energy Chain - Lenght of Plattform (Width of Energy-Chain)
  wclecwop = 27; // Workpiece Clamp - Energy Chain - Width of Plattform (Lenght of Energy-Chain)
  wclecwops = 7; // Workpiece Clamp - Energy Chain - Width of Plattform Support (Structure for just laying the Energy Chain on (only Part #5))
  // Endstop Holder Z-Axis
  wclesshd = 19; // Workpiece Clamp - Endstop Screw Hole Distance
  wclesmshs = 3; // Workpiece Clamp - Endstop Mounting Screw Hole Size
  wcletrlsd = 2.5; // Workpiece Clamp - Endstop Threaded Rod Lock Screws Diameter


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

    //Spindle Rod / length, rotationx, rotationy, rotationz 
    module sprod(length,rotationx,rotationy,rotationz, size) {
      if (showsrod == true) color ("BurlyWood") rotate (a=[rotationx,rotationy,rotationz]) cylinder (h = length, r = size/2);
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

    //Groundframe Feed / width, length, height, mount plate size, mount plate thickness, mount plate holes, width of nut for Nut-Trap, Small Sized (Boolean)
    module gfeed(width, length, height, mps, mpt, mph, mpwn, ss) {
    nutdia = mpwn/2/cos(180/6)+0.7;

	if (mps) {
          if (ss == "true") {
            cube (size = [width,length,height-mpt-mph]);
          } else {
	    cube (size = [width,length,height-mpt-mph]);
	  }
	    render () {
              if (ss == "true") {
                translate ([gffs/2-nutdia/2,-mph,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
                translate ([gffs/2-nutdia/2,length,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
	      } else {
                translate ([-mph,-mph,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
                translate ([width,-mph,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
                translate ([width,length,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
                translate ([-mph,length,height-mpt-mph/2-membranthick]) membran (nutdia,nutdia); //Membran
	      }
	      difference () {
                if (ss == "true") {
                    translate ([gffs/2,gffs/2,height-mpt/2-mph/2]) cube (center = true, size = [mps/2,mps,mpt+mph]);
                } else {
                    translate ([gffs/2,gffs/2,height-mpt/2-mph/2]) cube (center = true, size = [mps,mps,mpt+mph]);
                }
		union () {
		  if (ss == "true") {
                    translate ([gffs/2,-mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap
                        translate ([-mpwn-5,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([gffs/2,length+mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap Normal
                        translate ([0,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([gffs/2,-mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
                    translate ([gffs/2,length+mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
		  } else {
                    translate ([-mph/2,-mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap Normal
                        translate ([-mpwn-5,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([width+mph/2,-mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap Normal
                        translate ([0,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([width+mph/2,length+mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap Normal
                        translate ([0,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([-mph/2,length+mph/2,height-mpt-mph/2]) {
                        cylinder ($fn = 6, r = nutdia, h = (mph/2)+1); //Nut Trap Normal
                        translate ([-mpwn-5,-nutdia,0]) cube (size = [mpwn+5,nutdia*2,(mph/2)+1]);
                    }
                    translate ([-mph/2,-mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
                    translate ([width+mph/2,-mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
                    translate ([width+mph/2,length+mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
                    translate ([-mph/2,length+mph/2,height-mpt-1-mph]) cylinder (h = mpt+2+mph, r = mph/2); //Screw Shaft
		  }
		}
	      }
	    }
	} else {
	  cube (size = [width,length,height]);
	}
    }

    //Workbench Attachment
    module wattach (rax, ray, raz, width) {
        rotate ([90,0,0]) linear_extrude(height = gffs, convexity = 10, twist = 0) polygon(points=[[0,0],[0,gffs],[gffs,gffs],[dbca/5,wsab2-lsab+gffs/2],[dbca-dbca/5+gffs,wsab2-lsab+gffs/2],[dbca,gffs],[dbca+gffs,gffs],[dbca+gffs,0],[dbca,0],[dbca+gffs-dbca/5-width,wsab2-lsab+gffs/2-width],[dbca/5+width,wsab2-lsab+gffs/2-width],[gffs,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]); // Mounting Plate
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

    //Motormount V2 / flip (bolean) arround x, rotate arround x, size of nema motor, nema-engine flange size, nema-engine flange depth, width of mounting plate, space on mounting plate, nema motor screw hole distance, size of screw holes, single shaft engine simulation, override shaft diameter
    module mm(flipx, rotate, sonm, nefs, nefd, womp, somp, nmshd, sosh, sses, osd) {
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
	    if (osd > 0) {
                translate ([-1,(sonm/2)+(somp/2),(sonm/2)+(somp/2)]) rotate ([90,0,90]) cylinder (h = womp+2, r = osd/2); //Wave-Hole (Override)
            } else {
                translate ([-1,(sonm/2)+(somp/2),(sonm/2)+(somp/2)]) rotate ([90,0,90]) cylinder (h = womp+2, r = (sosh*2.5)/2); //Wave-Hole
	    }
	    translate ([womp-2-nefd,(sonm/2)+(somp/2),(sonm/2)+(somp/2)]) rotate ([90,0,90]) cylinder (h = nefd+1, r = nefs/2); //Flange of Nema-Engine
	  }
	}
	if (printmode == false) {
	  if (sses == true) {
	    translate ([wess+womp-2,somp/2,somp/2]) sengine (0, 0, 90, sonm, wess, wesss);
	  } else if (sses == false) {
	    translate ([weds+womp-2,somp/2,somp/2]) sengine (0, 0, 90, sonm, weds, wedss, wedse);
	  }
	}
      }
    }

    //Threaded Rod Hinge / flip (bolean) arround y, flip (bolean) arround y, rotate arround z, Width of Hinge, Lenght of Hinge, Support Structure, Diameter of Threaded Rod, Nut Size, Sharpening Threaded Rod Holder, Direction where threaded Rod is pointed to
    module trh (flipx, flipy, rotate, width, lenght, ss, dotr, ns, strh, direction) {
      mirror ([flipx,flipy,0]) rotate ([rotate,direction,0]) {
	difference () {
	  union () {
	    cylinder (h = width, r = tcthsdos+ss); //Bracer on Threaded Rod
	    linear_extrude(height = width, convexity = 10) polygon (points = [[0,-tcthsdos-ss],[0,tcthsdos+ss],[lenght,tcthsdos-strh],[lenght,-tcthsdos+strh]], paths = [[0,1,2,3]]); //Nut-Trap Baseplate
	  }
	  union () {
	    translate ([0,0,-1]) cylinder (h = width+2, r = tcthsdos/2+dotra/2); //Hole for Fixed Threaded Rod
	    translate ([0,0,width/2]) rotate ([0,90,0]) cylinder (h = lenght+1, r = dotr/2+dotra/2); //Threaded Rod Cylinder (Bracing)
	    translate ([tcthsdos,0,width/2]) rotate ([0,90,0]) cylinder ($fn = 6, r = ns/2/cos(180/6)+0.7, h = ns/2+1.5); //Nut-Trap
	    translate ([tcthsdos,-ns/2-0.6,width/2]) cube (size = [ns/2+1.5,ns+1.2,40]); 
	  }
	}
      }
    }



    //X-Axis Carrier back / Width of Structure, Height of Structure, Distance between cutting Area, Structure Width, smooth rod between distance, smooth rod diameter, double mount (bool), Smooth Rod Mounting Screw Diameter, Spindle Position over Smooth Rod, Spindle Bearing Diameter, Spindle Bearing Width, Additional Bearing Material, Bearing Plate Thickness, Bearing Plate Mounting Hole Distance, Bearing Plate Mounting Hole Size, Spindle Diameter, Motor Size, Motor Flange Size, Motor Flange Depth, Motor Flange Depth, Space on Mounting Plate, Motor Mounting Plate Screw Size, Motor Mounting Plate Screw Head Diameter, Motor Mounting Plate Screws Distance, print mode - 1 = Whole Structure; 2 = only Frame; 3 = only Bearing Plate; 4 = only Engine Plate, Endstop - Mounting Screw Hole Distance, Endstop - Mounting Screw Hole Size, Motor Supply Structure Width, Motor Supply Structure Lenght, Print-Mode
    module xacb(width, sh, dbca, stw, srbd, srd, dm, srmsd, sposr, sbd, sbw, abm, bpt, bpmhd, bpmhs, sd, ms, mfs, mfd, mmpfs, somp, mmpss, mmpshd, mmpsd, esmshd, esmshs, mssw, mssl, pm) {

      if (pm == 1 || pm == 3) { // Printmode of showing Bearing Plate
	if (dm) {
	  difference () {
	    union () {
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2+sposr,0]) cylinder ( r = sbd/2+abm, h = width+bpt); // Bearing Case
	      translate ([0,0,width]) linear_extrude(height = bpt, convexity = 10, twist = 0) polygon(points=[[0,stw],[0,0],[stw,0],[stw+dbca/2-srbd/2,sh],[bpmhd,sh],[bpmhd,sh+stw],[bpmhd*0.8,sh+stw],[stw/2+dbca/2-srbd/2-sbd/3,sh+stw/2+sposr+sbd/2]],paths=[[0,1,2,3,4,5,6,7]]); // Mounting Plate
	      translate ([0,0,0]) linear_extrude(height = width, convexity = 10, twist = 0) polygon(points=[[stw/2,sh+stw],[bpmhd*0.8,sh+stw],[stw/2+dbca/2-srbd/2-sbd/3,sh+stw/2+sposr+sbd/2]],paths=[[0,1,2]]); // Mounting Plate Ramp for Bearing Case
	    }
	    union () {
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2,width]) cylinder ( r = dotr*0.9+1, h = width/2 ); // Smooth Rod Support Material
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2+sposr,-1]) cylinder ( r = sbd/2, h = sbw+1); // Bearing Cutout
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2+sposr,sbw-1]) cylinder ( r = sd/2, h = width+bpt-sbw+2); // Spindle Cutout
	      translate ([0,0,-1]) linear_extrude(height = width+1, convexity = 10, twist = 0) polygon(points=[[0,stw],[stw+dbca,stw],[stw+dbca/2+srbd/2,sh+stw+0.2],[dbca/2-srbd/2,sh+stw+0.2]],paths=[[0,1,2,3]]); // CutOut
	      translate ([stw/2,stw/2,width-1]) cylinder ( r = dotr/2+dotra/2+1, h = bpt+2 ); // Threaded-Rod Hole 1
	      translate ([bpmhd-stw/2,sh+stw/2,width-1]) cylinder ( r = bpmhs/2, h = bpt+2 ); // Mounting Screw Hole 1
	    }
	  }
	}
      }

      if (pm == 1 || pm == 3) { // Printmode of showing Engine Plate -ms/2-mmpfs/2
	if (!dm) {
	  difference () {
	    union () {
	      translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2,width]) rotate ([0,90,0]) mm (1,0,ms, mfs, mfd, mmpfs, somp, mmpsd, mmpss, ""); // Motor Mounting Plate
	      translate ([0,0,width]) linear_extrude(height = bpt, convexity = 10, twist = 0) polygon(points=[[0,stw],[0,0],[stw,0],[stw+dbca/2-srbd/2,sh],[bpmhd,sh],[bpmhd,sh+stw],[bpmhd*0.8,sh+stw],[stw/2+dbca/2-srbd/2-sbd/3,sh+stw/2+sposr+sbd/2]],paths=[[0,1,2,3,4,5,6,7]]); // Complete Mounting Plate
	    }
	    union () {
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2,width]) cylinder ( r = dotr*0.9+1, h = width/2 ); // Smooth Rod Support Material
	      translate ([stw/2+dbca/2-srbd/2,sh+stw/2+sposr,sbw-1]) cylinder ( r = sd/2, h = width+bpt-sbw+2); // Spindle Cutout
	      translate ([0,0,-1]) linear_extrude(height = width+1, convexity = 10, twist = 0) polygon(points=[[0,stw],[stw+dbca,stw],[stw+dbca/2+srbd/2,sh+stw+0.2],[dbca/2-srbd/2,sh+stw+0.2]],paths=[[0,1,2,3]]); // CutOut
	      translate ([stw/2,stw/2,width-1]) cylinder ( r = dotr/2+dotra/2+1, h = bpt+2 ); // Threaded-Rod Hole 1
	      translate ([bpmhd-stw/2,sh+stw/2,width-1]) cylinder ( r = bpmhs/2, h = bpt*1.5+2 ); // Mounting Screw Hole 1
	    }
	  }
	}
      }

      if (pm == 1 || pm == 5) { // Printmode of showing Motor Supply Structure
	if (!dm) {
	    difference () {
		union () {
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2+ms+somp-mssw,width-mssw]) cube ( size = [ms+somp,mssw,mssw] ); // Engine Mount Side - Part 1
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2+ms+somp-mssw,width-mssw-ms/2]) cube ( size = [mssw,mssw,ms/2] ); // Engine Mount Side - Part 2
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2+ms+somp-mssw-ms/2,width-mssw]) cube ( size = [mssw,ms/2,mssw] ); // Engine Mount Side - Part 3
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,-lsab2+lsab,-mssl]) cube ( size = [mssw,gffh-lsab2+lsab-iffhw+gffs+mssw,gffs] ); // Threaded-Rod Mount Side - Part 1
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2+mssw,-lsab2+lsab,-mssl]) cube ( size = [gffs-(stw/2+dbca/2-srbd/2-(ms+somp)/2)-mssw,gffh-lsab2+lsab-iffhw+gffs,gffs]);
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,0,width]) rotate ([0,90,0]) linear_extrude(height = mssw, convexity = 10, twist = 0) polygon(points=[[0,sh+stw/2+sposr-(ms+somp)/2+ms+somp-mssw-ms/2],[0,sh+stw/2+sposr-(ms+somp)/2+ms+somp-ms/2+mssw],[mssl+mssw,mssw-lsab2+lsab],[mssl,-lsab2+lsab]],paths=[[0,1,2,3]]); // Connector Up/Down 1
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,0,width]) rotate ([0,90,0]) linear_extrude(height = mssw, convexity = 10, twist = 0) polygon(points=[[ms/2,sh+stw/2+sposr-(ms+somp)/2+ms+somp-mssw],[ms/2+mssw,sh+stw/2+sposr-(ms+somp)/2+ms+somp],[mssl+mssw,-lsab2*2+lsab*2+gffh-iffhw+gffs+mssw],[mssl,-lsab2*2+lsab*2+gffh-iffhw+gffs]],paths=[[0,1,2,3]]); // // Connector Up/Down 2
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2+ms+somp,width-mssw]) rotate([90,0,0]) linear_extrude(height = mssw, convexity = 10, twist = 0) polygon(points=[[0,-ms/2+mssw/2],[mssw,-ms/2],[ms+somp,0],[ms+somp-mssw,mssw/2]],paths=[[0,1,2,3]]); // Connector Up/Down 1
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2,width]) rotate([0,90,0]) {
                        translate ([0,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)+mmpsd/2]) rotate ([90,0,90]) cylinder (h = mssw, r = mmpss*1.4); //Screwhole Supply Material 1
                        translate ([0,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)-mmpsd/2]) rotate ([90,0,90]) cylinder (h = mssw+ms/2, r = mmpss*1.4); //Screwhole Supply Material 2
                    }
		}
		union () {
                    translate ([stw/2+dbca/2-srbd/2-(ms+somp)/2,sh+stw/2+sposr-(ms+somp)/2,width]) rotate([0,90,0]) {
                        translate ([-1,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)+mmpsd/2]) rotate ([90,0,90]) cylinder (h = mssw+2, r = mmpss/2); //Screwhole 1
                        translate ([-1,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)-mmpsd/2]) rotate ([90,0,90]) cylinder (h = ms/2+mssw+2, r = mmpss/2); //Screwhole 2
                        translate ([mssw,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)+mmpsd/2]) rotate ([90,0,90]) cylinder (h = mmpfs+5, r = mmpss*1.4); //Nut-Space 1
                        translate ([mssw,(ms/2)+(somp/2)+mmpsd/2-mmpss*1.4,(ms/2)+(somp/2)+mmpsd/2]) rotate ([90,0,90]) cube ( size = [mmpss*2.8,(ms+somp-mmpsd)/2+1,mmpfs+5]); //Cut-Off unprintable Area of Nut Space 1
                        translate ([ms/2+mssw,(ms/2)+(somp/2)+mmpsd/2,(ms/2)+(somp/2)-mmpsd/2]) rotate ([90,0,90]) cylinder (h = mmpfs+5, r = mmpss*1.4); //Nut-Space 2
                        translate ([ms/2+mssw,(ms/2)+(somp/2)+mmpsd/2-mmpss*1.4,(ms/2)+(somp/2)-mmpsd/2]) rotate ([90,0,90]) cube ( size = [mmpss*2.8,(ms+somp-mmpsd)/2+1,mmpfs+5]); //Cut-Off unprintable Area of Nut Space 2
                    }
		translate ([stw/2,stw/2,-mssl-1]) cylinder ( r = dotr/2+dotra/2+1, h = gffs+2 ); // Threaded-Rod Hole 1
		translate ([stw/2,stw/2-lsab2+lsab,-mssl-1]) cylinder ( r = dotr/2+dotra/2+1, h = gffs+2 ); // Threaded-Rod Hole 1
		cylinder ( r = mmpss/2, h = mmpfs/2+2 );
		}
	    }
	}
      }

      if (pm == 1 || pm == 2) { // Printmode of showing Frame
	difference () {
	  union() {
	    translate ([stw/2+dbca/2-srbd/2,sh+stw/2,width]) cylinder ( r = dotr*0.9, h = width/2 ); // Smooth Rod Support Material
	    translate ([stw/2+dbca/2-srbd/2-width-srd/3,sh+stw/2-width/2,0]) cube ( size = [width,width,width]); // Smooth Rod Mounting Screw Support Material
	    translate ([stw/2+dbca/2+srbd/2,sh+stw/2,width]) cylinder ( r = dotr*0.9, h = width/2 ); // Smooth Rod Support Material
	    translate ([stw/2+dbca/2+srbd/2-width/2,sh+stw/2,0]) cube ( size = [width,width,width]); // Smooth Rod Mounting Screw Support Material
	    if (dm) {
	      linear_extrude(height = width, convexity = 10, twist = 0) polygon(points=[[0,stw],[0,-lsab2+lsab],[stw,-lsab2+lsab],[stw,0],[stw+dbca/2-srbd/2,sh],[dbca/2+srbd/2,sh],[dbca,0],[dbca,-lsab2+lsab],[stw+dbca,-lsab2+lsab],[stw+dbca,stw],[stw+dbca/2+srbd/2,sh+stw],[dbca/2-srbd/2,sh+stw]],paths=[[0,1,2,3,4,5,6,7,8,9,10,11]]); // Double-Mount Modul
	    } else {
	      linear_extrude(height = width, convexity = 10, twist = 0) polygon(points=[[0,stw],[0,0],[stw,0],[stw+dbca/2-srbd/2,sh],[dbca/2+srbd/2,sh],[dbca,0],[stw+dbca,0],[stw+dbca,stw],[stw+dbca/2+srbd/2,sh+stw],[dbca/2-srbd/2,sh+stw]],paths=[[0,1,2,3,4,5,6,7,8,9]]); // Standard Modul
	    }
	  }
	  union () {
	    translate ([stw/2+dbca/2-srbd/2,sh+stw/2,width/2]) rotate ([90,0,270]) cylinder ( r = srmsd/2, h = width*2 ); //Smooth-Rod Mounting-Screw Hole 1
	    translate ([bpmhd-stw/2,sh+stw/2,-1]) cylinder ( r = (bpmhs-1.5)/2, h = width+2); // Bearing Plate Mounting Screw Hole 1
	    translate ([stw/2+dbca/2+srbd/2,sh+stw/2,width/2]) rotate ([90,0,180]) cylinder ( r = srmsd/2, h = width*2 ); //Smooth-Rod Mounting-Screw Hole 1
	    translate ([stw/2+dbca/2-srbd/2,sh+stw/2,-1]) cylinder ( r = srd/2, h = width*1.5+2 ); //Smooth-Rod Hole 1
	    translate ([stw/2+dbca/2+srbd/2,sh+stw/2,-1]) cylinder ( r = srd/2, h = width*1.5+2 ); //Smooth-Rod Hole 2
	    translate ([stw/2,stw/2,-1]) cylinder ( r = dotr/2+dotra/2, h = width+2 ); // Threaded-Rod Hole 1
	    translate ([stw/2+dbca,stw/2,-1]) cylinder ( r = dotr/2+dotra/2, h = width+2 ); // Threaded-Rod Hole 1
	    if (dm) {
	      translate ([stw/2,stw/2-lsab2+lsab,-1]) cylinder ( r = dotr/2+dotra/2, h = width+2 ); // Double-Mount Threaded-Rod Hole 1
	      translate ([stw/2+dbca,stw/2-lsab2+lsab,-1]) cylinder ( r = dotr/2+dotra/2, h = width+2 ); // Double-Mount Threaded-Rod Hole 2
	    }
	  }
	}
      }

      if (pm == 1 || pm == 4) { // Printmode of showing Endstopholder
        if (!dm) {
            difference () {
                union () {
                    translate ([bpmhd-stw,sh,width+bpt]) cube (size = [stw,stw,bpt/2]); // Mounting Side
                    translate ([bpmhd-stw,sh+stw,width]) cube (size = [stw,bpt/2,bpt*1.5]); // Top Side
                    translate ([bpmhd-stw-(esmshd*1.5)/4,sh+stw,0]) cube (size = [esmshd*1.5,bpt/2,width]); // Endstop Mounting Plate
                }
                union () {
                    translate ([bpmhd-stw/2,sh+stw/2,width+bpt/2]) cylinder ( r = bpmhs/2, h = bpt+2 ); // Mounting Screw Hole
                    translate ([bpmhd-stw/2+esmshd/2,sh+stw-1,width/2]) rotate ([-90,0,0]) cylinder ( r = esmshs/2, h = bpt/2+2 ); // Endstop Mounting Screw Hole 1
                    translate ([bpmhd-stw/2-esmshd/2,sh+stw-1,width/2]) rotate ([-90,0,0]) cylinder ( r = esmshs/2, h = bpt/2+2 ); // Endstop Mounting Screw Hole 2
                }
            }
        }
      }
    }


    //Threaded Rod Feeder- Engine/Bearing Clamp / flip (bolean) arround x, flip (bolean) arround y, rotate arround z, Width of the Lock Plate, Lenght of the Lock Plate, Back Plate Thickness, Front Plate Thickness, Pressure Plate Space, Connector Threaded Rod Diameter, Groundframe-Feeds Distance, connector rod angle , Structure Screw-Size, Structure Nut-Size, Motor Size, Flange Size, Flange Depth, Mounting Plate Frame Size, Space on Mounting Plate, Mounting Plate Screws Distance, Mounting Plate Screw Size, Simulate Engine (boolean), distance of motor shaft below workbench plate, Bearing Diameter (Add some Tollerances), Bearing Width, Additional Bearing Material, Bearing Plate Thickness, Workbench Plate Screw Diameter, Pusher Gap Width in Workbench Plate, Spindle Diameter, Pusher Spindle-Nut Width, Pusher Spindle-Nur Lenght, Nut Housing Width, Pusher Tollerance to Workbench Plate, Pusher Offset, Pusher Width, Pusher Lenght, Pusher Lenght Socket, Pusher Screw Hole Diameter, Pusher Height, Endstop Baseplate Height, Endstop Baseplate Width, Endstop Baseplate Lenght, Endstop Baseplate Position, Endstop Mounting Screw Hole Distance, Mounting Screw Hole Size, Threaded Rod Structure Type: "1" = Engine; "2" = Bearing; "3" = Pusher
    module trfebc (flipx, flipy, rotate, width, lenght, bpt, fpt, pps, ctrd, gd, cra, ss, ns, ms, fs, fd, mpfs, somp, mpsd, mpss, mpshd, se, domsbwp, bd, bw, abm, bbpt, wpsd, pgwiwp, sd, psnw, psnl, nhw, pttwp, po, pw, pl, pl2, pshd, ph, esbph, esbpw, esbpl, esbpp, esshd, esmshs, trs) {
      zpositionofmm = -lsab+dotr+gffh-ms/2-somp/2-domsbwp; // Declare Variable for Motor Y-Position
      xpositionofmm = lenght/2-ms/2-somp/2; // Declare Variable for Motor X-Position

      module pusher ( ) { // Pusher Itself
	difference () {
	    union () {
		translate ([-nhw,xpositionofmm+ms/2+somp/2-psnw/2-nhw,(lsab2-lsab+ctrd*2)]) cube ( size = [nhw*2+psnl,psnw+2*nhw,gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp]); // Bearing Material
		translate ([po+nhw,xpositionofmm+ms/2+somp/2-psnw/2+psnw/2-pgwiwp/2+pttwp,(lsab2-lsab+ctrd*2)+gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp]) cube ( size = [pl+pl2,pgwiwp-pttwp*2,wbph+pttwp*2]); // In-Slider
		translate ([-nhw-(-po-pl),xpositionofmm+ms/2+somp/2-psnw/2+psnw/2-pgwiwp/2+pttwp,(lsab2-lsab+ctrd*2)+gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp]) cube ( size = [nhw*2+psnl+(-po-pl),pgwiwp-pttwp*2,wbph+pttwp*2-pttwp]); // In-Slider 2
		translate ([nhw+psnl+po-pl,xpositionofmm+ms/2+somp/2-psnw/2+psnw/2-pgwiwp/2+pttwp,(lsab2-lsab+ctrd*2)+gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp+wbph+pttwp*2]) linear_extrude(height = ph, convexity = 10, twist = 0) polygon(points=[[0,0],[0,pgwiwp-pttwp*2],[pl-pl2,pw/2+pgwiwp/2],[pl,pw/2+pgwiwp/2],[pl,-pw/2+pgwiwp/2],[pl-pl2,-pw/2+pgwiwp/2]],paths=[[0,1,2,3,4,5]]); // Pusher above Workbench Plate
	    }
	    union () {
                if (pshd != "0") {
                    translate ([nhw+psnl+po-pl2/2,xpositionofmm+ms/2+somp/2-psnw/2+psnw/2-pgwiwp/2+pttwp+pgwiwp+pw/4,(lsab2-lsab+ctrd*2)+gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp+wbph+pttwp*2+1]) cylinder ( r = pshd/2, h = ph ); //Mounting Screw 1
                    translate ([nhw+psnl+po-pl2/2,xpositionofmm+ms/2+somp/2-psnw/2+psnw/2-pgwiwp/2+pttwp-pw/4,(lsab2-lsab+ctrd*2)+gffh-(lsab2-lsab+ctrd*2)-lsab+dotr-pttwp+wbph+pttwp*2+1]) cylinder ( r = pshd/2, h = ph ); // Mounting Screw 2
        	}
		translate ([0,xpositionofmm+ms/2+somp/2-psnw/2,zpositionofmm+ms/2+somp/2-psnw/2-1]) cube ( size = [psnl, psnw, psnw+1]); // Spindle Nut Slot
		translate ([-nhw-1,xpositionofmm+ms/2+somp/2,zpositionofmm+ms/2+somp/2]) rotate ([0,90,0]) cylinder ( r = sd/2, h = psnl+2+nhw*2); // Spindle Nut Slot
	    }
	}
      }

      module Endstopholder ( ) { // Endstop Holder Y-Axis
	difference () {
	    union () {
		translate ([fpt+bpt,0,ctrd+dotr*1.5-ss]) cube ( size = [esbph,lenght,ss*2]);
		translate ([fpt+bpt,lenght-esbpw+esbpp,ctrd+dotr*1.5-ss]) cube ( size = [esbph,esbpw,esbpl+ss*2]);
	    }
	    union () {
		translate ([fpt+bpt-1,dotr*1.5,ctrd+dotr*1.5]) rotate ([0,90,0]) cylinder (h = esbph+2, r = ss/2); //Screw Hole 1
		translate ([fpt+bpt-1,lenght-dotr*1.5,ctrd+dotr*1.5]) rotate ([0,90,0]) cylinder (h = esbph+2, r = ss/2); //Screw Hole 2
		translate ([fpt+bpt-1,lenght-esbpw/2+esbpp,ctrd+dotr*1.5+ss+esbpl-esbpw/2]) rotate ([0,90,0]) cylinder (h = esbph+2, r = esmshs/2); //Screw Hole 2
		translate ([fpt+bpt-1,lenght-esbpw/2+esbpp,ctrd+dotr*1.5+ss+esbpl-esbpw/2-esshd]) rotate ([0,90,0]) cylinder (h = esbph+2, r = esmshs/2); //Screw Hole 2
	    }
	}
      }

      mirror ([flipx,flipy,0]) rotate ([0,0,rotate]) {
	translate ([0,gd,lsab-dotr]) {
	    if (trs == "1") { // If 1 (Engine) 2 (Bearing)
	      translate ([0,xpositionofmm,zpositionofmm]) mm (1,0,ms, fs, fd, mpfs, somp, mpsd, mpss, se); // Engine Mount Modul
	    }
	
	if (trs == "1" && printmode == false) { // Just Show Pusher on Engine Side
	    translate ([(wowp-gffs)/100*mvya,0,0]) pusher (); // Simulate "Y" Axis (Pusher) Position
	} else if (trs == "3") {
	    pusher();
	}
	
	  difference () { // Threaded Rod Clamping Structures (Engine/Bearing)
	    union () {
	      if (trs == "1" || trs == "2") {
		cube (size = [fpt+bpt,lenght,lsab2-lsab+ctrd*2]); //Bottom Bracer Basis Block
	      }
	      if (trs == "1") { // If 1 (Engine) 2 (Bearing)
		translate ([0,xpositionofmm,0]) rotate ([-90,0,0]) linear_extrude(height = ms+somp, convexity = 10, twist = 0) polygon(points=[[0,0],[-mpfs+2,-zpositionofmm],[0,-zpositionofmm]],paths=[[0,1,2]]); // Double-Mount Modul (Engine Mount)
	      } else if (trs == "2") {
		translate ([0,lenght/2-(bd+abm*2)/2,0]) rotate ([-90,0,0]) linear_extrude(height = bd+abm*2, convexity = 10, twist = 0) polygon(points=[[0,0],[-bbpt,-zpositionofmm],[0,-zpositionofmm]],paths=[[0,1,2]]); // Double-Mount Modul (Bearing Mount)
		translate ([-bbpt,lenght/2-(bd+abm*2)/2,zpositionofmm]) cube ( size = [bbpt,bd+abm*2,gffh-lsab+dotr-zpositionofmm+wbph]); // Bearing Material
		translate ([0,lenght/2-(bd+abm*2)/2,(lsab2-lsab+ctrd*2)]) cube ( size = [fpt-pps/2,bd+abm*2,gffh-(lsab2-lsab+ctrd*2)-lsab+dotr]); // Bearing Material
	      }
	    }
	    union () {
	      if (trs == "1") { // If 1 (Engine) make Screwholes for Engine Fix
		translate ([1-fpt-pps/2,xpositionofmm+(ms/2)+(somp/2)+mpsd/2,zpositionofmm+(ms/2)+(somp/2)-mpsd/2]) rotate ([270,0,90]) cylinder (h = fpt-pps/2+2, r = mpss/2); //Screwhole
		translate ([-1+fpt-pps/2,xpositionofmm+(ms/2)+(somp/2)+mpsd/2,zpositionofmm+(ms/2)+(somp/2)-mpsd/2]) rotate ([270,0,90]) cylinder (h = fpt-pps/2, r = mpshd/2); //Screwhole
		
		translate ([-1,xpositionofmm+(ms/2)+(somp/2)-mpsd/2,zpositionofmm+(ms/2)+(somp/2)-mpsd/2]) rotate ([90,0,90]) cylinder (h = fpt-pps/2+2, r = mpss/2); //Screwhole
		translate ([-1,xpositionofmm+(ms/2)+(somp/2)-mpsd/2,zpositionofmm+(ms/2)+(somp/2)-mpsd/2]) rotate ([90,0,90]) cylinder (h = fpt-pps/2, r = mpshd/2); //Screwhole
	      } else if (trs == "2") {
		translate ([-bbpt-1,xpositionofmm+ms/2+somp/2,zpositionofmm+ms/2+somp/2]) rotate ([0,90,0]) cylinder ( r = sd/2, h = bbpt+fpt-pps/2+2); // Shaft Slot for Bearing
		translate ([-bbpt-1,xpositionofmm+ms/2+somp/2,zpositionofmm+ms/2+somp/2]) rotate ([0,90,0]) cylinder ( r = bd/2, h = bw+1); // Bearing Casing
	      }
	      if (trs == "1" || trs == "2") {
		translate ([fpt-pps/2,-1,-1]) cube (size = [pps,lenght+2,lsab2-lsab+ctrd*2+2]); //Pressure Plate Space (Space between Back/Front Plate for Pressing on the Threaded Rods)
		translate ([fpt,-1,ctrd]) rotate ([270,0,0]) cylinder (h = lenght+2, r = dotr/2); //Groundframe Threaded Rod 1
		translate ([fpt,-1,ctrd+lsab2-lsab]) rotate ([270,0,0]) cylinder (h = lenght+2, r = dotr/2); //Groundframe Threaded Rod 2
		translate ([-mpfs,dotr*1.5,ctrd+dotr*1.5]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = ss/2); //Screw Hole 1
		translate ([-mpfs,lenght-dotr*1.5,ctrd+dotr*1.5]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = ss/2); //Screw Hole 2
		translate ([pps,dotr*1.5,ctrd+dotr*1.5]) rotate ([180,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = ss/2+2); //Screw Hole 1 Screwhead
		translate ([pps,lenght-dotr*1.5,ctrd+dotr*1.5]) rotate ([180,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = ss/2+2); //Screw Hole 2 Screwhead
		if (wpsd > 0) {
		    translate ([-mpfs,dotr*1.5,zpositionofmm+gffh-lsab+dotr-zpositionofmm+wbph/2]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = wpsd/2); //Workbench Plate Screw 1
		    translate ([-mpfs,lenght-dotr*1.5,zpositionofmm+gffh-lsab+dotr-zpositionofmm+wbph/2]) rotate ([0,90,0]) cylinder (h = fpt+bpt+pps+mpfs, r = wpsd/2); //Screw Hole 2
		}
	      }
	    }
	  }
          if (trs == "4") { // Endstop Holder in Printmode
                Endstopholder ();
	  }
	  if (trs == "1" && printmode == false) { // Endstop Holder in Viewmode
		Endstopholder ();
	  }
	}
      }
    }


    // Case for Bearing - flip (X-Axis), flip (Y-Axis), rotate (Z-Axis), Lenght of linear bearing, width of linear bearing, distance of linear bearing to baseplate, additional material for linear bearing, smooth rod diameter, this Modul has spindle attachment, spindle position over smooth rod, spindle diameter, spindle nut width, spindle nut lenght, engine attachment space
    module bearingcase (flipx, flipy, rotate, lolb, wolb, dolbtb, amflb, srd, mcw, tmhsa, sposr, sd, snw, snl, eas) {
      mirror ([flipx,0,0]) mirror ([0,flipy,0]) rotate ([0,0,rotate]) {
	translate ([0,0,wolb/2]) {
	  translate ([0.0125,lolb+amflb*2+0.0125,-wolb/2]) rotate ([90,0,0]) linear_extrude(height = lolb+amflb*2, convexity = 10, twist = 0) polygon(points=[[0,0],[-dolbtb+wolb/2+amflb,0],[-dolbtb+wolb/2+amflb,wolb/2],[0,bph]],paths=[[0,1,2,3]]); // Bearing Ramp
	
	  difference () {
	    union () {
	      translate ([0,0,-wolb/2]) rotate ([0,0,0]) linear_extrude(height = fbph, convexity = 10, twist = 0) polygon(points=[[0,0],[-dolbtb-wolb/2-amflb,0],[-dolbtb,-bbpw],[0,-bbpw]],paths=[[0,1,2,3]]); // Front Baseplate Ramp
	      translate ([-dolbtb+wolb/2+amflb,lolb+amflb*2,-wolb/2]) linear_extrude(height = wolb/2, convexity = 10, twist = 0) polygon(points=[[0,0],[-amflb-wolb/2,0],[-mcw,(tcpoblbp-tclolb-tcamflb*2)*0.40],[0,(tcpoblbp-tclolb-tcamflb*2)*0.40]],paths=[[0,1,2,3]]); // Mid Connection
	      if (flipy == 1) {
		translate ([-dolbtb+wolb/2+amflb-mcw*0.25,lolb+amflb*2+(tcpoblbp-tclolb-tcamflb*2)*0.40,-wolb/2]) cube ( size = [mcw*0.25,(tcpoblbp-tclolb-tcamflb*2)*0.20,wolb/2] );
		translate ([-dolbtb+wolb/2+amflb-mcw,lolb+amflb*2+(tcpoblbp-tclolb-tcamflb*2)*0.40,-wolb/2]) cube ( size = [mcw*0.25,(tcpoblbp-tclolb-tcamflb*2)*0.20,wolb/2] );
	      } else {
		translate ([-dolbtb+wolb/2+amflb-mcw*0.75,lolb+amflb*2+(tcpoblbp-tclolb-tcamflb*2)*0.40,-wolb/2]) cube ( size = [mcw*0.5,(tcpoblbp-tclolb-tcamflb*2)*0.20,wolb/2] );
	      }
	      if (tmhsa == true) {
		translate ([-dolbtb,0,sposr]) rotate ([270,0,0]) cylinder ( h = lolb+amflb*2, r = wolb/2+amflb ); // Additional Material with Spindlemount
		translate ([-dolbtb-wolb/2-amflb,0,0.0125]) cube ( size = [wolb+amflb*2,lolb+amflb*2,sposr] ); // Additional Material Setup
	      } else {
		translate ([-dolbtb,0,0]) rotate ([270,0,0]) cylinder ( h = lolb+amflb*2, r = wolb/2+amflb ); // Additional Material
	      }
	      translate ([-dolbtb-wolb/2-amflb,0,-wolb/2-amflb/2]) cube ( size = [wolb+amflb*2,lolb+amflb*2,wolb/2+amflb/2] ); // Print Assistant
	    }
	    union () {
	      translate ([-dolbtb,amflb,0]) rotate ([270,0,0]) cylinder ( h = lolb, r = wolb/2 ); // Linear Bearing
	      translate ([-dolbtb-wolb/2,amflb,-wolb-1]) cube ( size = [wolb,lolb,wolb+1] ); // Linear Bearing Input Shaft
	      translate ([-dolbtb-wolb/2-amflb,-1,-wolb/2-amflb]) cube ( size = [wolb+amflb*2,lolb+amflb*2+2,amflb] ); // Cleanup
	      translate ([-dolbtb,-bbpw-1,0]) rotate ([270,0,0]) cylinder ( h = lolb+bbpw+amflb*2+(tcpoblbp-tclolb-tcamflb*2)*0.5+1, r = srd/2 ); // Smooth Rod

	      if (tmhsa == true) { // Check if Spindlemodul is activated
		translate ([-dolbtb,-bbpw-1,sposr]) rotate ([270,0,0]) cylinder ( h = lolb+bbpw+amflb*2+(tcpoblbp-tclolb-tcamflb*2)*0.5+1, r = sd/2 ); // Spindle Corridor
		translate ([-dolbtb-snw/2,(lolb+amflb*2)/2-snl/2,sposr-snw/2]) cube ( size = [snw,snl,snw+wolb/2] ); // Spindle Nut Suiter
	      }
	      if (eas == "auto") { // If Engine Attachment Space >0 = Automatic Use
		translate ([-dolbtb,-1,sposr]) rotate ([270,0,0]) cylinder ( h = lolb+amflb*2+2, r = wolb/2 ); // Engine Attachment Space
	      } else if (eas != "0") {
		translate ([-dolbtb,-1,sposr]) rotate ([270,0,0]) cylinder ( h = lolb+amflb*2+2, r = eas/2 ); // Additional Material with Spindlemount
	      }
	    }
	  }
	}
      }
    }

    // Tool-Carrier - Position of Back Linear Bearing Pair (Origin Point: Front of Baseplate, Lenght of Linear Bearing, Width of Linear Bearing, Distance of Linear Bearing to Baseplate, Additional Material for Linear, Smooth-Rod Diameter (Add some Tollerances), Width of Part Junction, Width of Part Junction Anchoring, Addon Screw Diameter (Add some Tollerances) (To carry maybe other Carrier on the Smooth-Rods), Addon Screw Nut Diameter (Diameter-Size of Wrench you would use for tightening), Mid Connection Width, Spindle Position over Smooth Rod (Case of Linear Bearing should not touch the Spindle Nut!) , Spindle Diameter (Add some Tollerances), Spindle Nut Width (Add some Tollerances), Spindle Nut Lenght (Add some Tollerances), Engine Attachment Space, show: 0 = all Parts; 1 = Part 1; 2 = Part 2, Tool Hold Structure - Width of Hinge, Tool Hold Structure - Diameter of Screw, Tool Hold Structure - Key Size, Energy Chain - Distance to Main Structure, Energy Chain - Width of Plattform, Energy Chain - Screw Diameter, Energy Chain - Screw Nut Key Size, Energy Chain - First Hole Distance, Energy Chain - Second Hole Distance
    module tc (poblbp, lolb, wolb, dolbtb, amflb, srd, wopj, asd, asnd, mcw, sposr, sd, snw, snl, eas, show, thswoh, thsdos, thsks, ecdtms, ecwop, ecsd, ecsnks, ecfhd, ecshd) {
      newbaseplateramplenght = (dolbtb-wolb/2-amflb);

      if (show == "0" || show == "2") {
	// // Part 2
	translate ([-0.0125,poblbp+lolb+amflb*2,0]) bearingcase (0, 1, 0, lolb, wolb, dolbtb, amflb, srd, mcw, false, sposr, sd, snw, snl, eas); // Bearingcase Right (With Engine Attachment Space)
	translate ([bpw+0.0125,poblbp+lolb+amflb*2,0]) bearingcase (1, 1, 0, lolb, wolb, dolbtb, amflb, srd, mcw, false, sposr, sd, snw, snl, "0"); // Bearingcase Left
	translate ([bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,asd*0.7+membranthick/2]) cube ( size = [asd,asd,membranthick], center = true); // Membran Addon Screw Hole 1
	translate ([bpw-bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,asd*0.7+membranthick/2]) cube ( size = [asd,asd,membranthick], center = true); // Membran Addon Screw Hole
	translate ([-newbaseplateramplenght+bpw/6,bpl+bbpw,0]) cube ( size = [newbaseplateramplenght*2+bpw-bpw/3,wopj,bbph/4-0.4] ); // "Membran" Anchoring Print Assistant
	
	difference () {
	  union () {
	    translate ([0,bpl+bbpw+0.2,0]) cube ( size = [bpw,lolb+amflb*2+bpl-poblbp-bbpw+0.8,bbph] ); // Part2 Anchoring 
	  }
	  union () {
	    translate ([-newbaseplateramplenght,bpl+bbpw,0]) cube ( size = [newbaseplateramplenght*2+bpw,wopj,bbph/4+0.2] ); // Back Baseplate Anchoring 1
	    translate ([-newbaseplateramplenght,-0.2+bpl+bbpw+wopj,0]) cube ( size = [newbaseplateramplenght*2+bpw,wopj+0.4,bbph/2+0.2] ); // Back Baseplate Anchoring 2
	    translate ([bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,-1]) cylinder ( h = bbph+2, r = asd/2 ); // Addon Screw Hole 1
	    translate ([bpw-bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,-1]) cylinder ( h = bbph+2, r = asd/2 ); // Addon Scew Hole 2
	    translate ([bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,-1]) cylinder ( $fn = 6, h = asd*0.7+1, r = asnd/2/cos(180/6)+0.7); // Addon Nuttrap Hole 1
	    translate ([bpw-bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,-1])  cylinder ( $fn = 6, h = asd*0.7+1, r = asnd/2/cos(180/6)+0.7); // Addon Nuttrap Hole 2
	  }
	}
      }

      if (show == "0" || show == "1") {
	// // Part 1
	translate ([-0.0125,0,0]) bearingcase (0, 0, 0, lolb, wolb, dolbtb, amflb, srd, mcw, true, sposr, sd, snw, snl, "0");
	translate ([bpw+0.0125,0,0]) bearingcase (1, 0, 0, lolb, wolb, dolbtb, amflb, srd, mcw, false, sposr, sd, snw, snl, "0");
	translate ([0,poblbp,0]) rotate ([90,0,0]) linear_extrude(height = poblbp-lolb-amflb*2, convexity = 10, twist = 0) polygon(points=[[0,0],[-dolbtb+wolb/2+amflb,0],[-dolbtb+wolb/2+amflb,wolb/2],[0,bph]],paths=[[0,1,2,3]]); // Additional Bearing Ramp Right
	translate ([bpw,poblbp,0]) rotate ([90,0,0]) mirror ([1,0,0]) linear_extrude(height = poblbp-lolb-amflb*2, convexity = 10, twist = 0) polygon(points=[[0,0],[-dolbtb+wolb/2+amflb,0],[-dolbtb+wolb/2+amflb,wolb/2],[0,bph]],paths=[[0,1,2,3]]); // Additional Bearing Ramp Left


	difference () {
	  union () {
	    translate ([0,0,0]) cube ( size = [bpw,bpl,bph] ); // Baseplate
	    translate ([0,0,0]) rotate ([90,0,90]) linear_extrude(height = bpw, convexity = 10, twist = 0) polygon(points=[[0,0],[0,bph],[-fbpw*0.75,fbph],[-fbpw*0.75,0]],paths=[[0,1,2,3]]); // Front Baseplate Ramp
	    translate ([0,-fbpw,0]) cube ( size = [bpw,fbpw*0.25,fbph]); // Front Baseplate Block

	    translate ([-newbaseplateramplenght,bpl+bbpw-bbpw*0.25,0]) rotate ([90,0,90]) linear_extrude(height = bpw+newbaseplateramplenght*2, convexity = 10, twist = 0) polygon(points=[[0,0],[0,bbph],[-bbpw*0.75,bph],[-bbpw*0.75,0]],paths=[[0,1,2,3]]); // Back Baseplate Ramp
	    translate ([-newbaseplateramplenght,bpl+bbpw*0.75,0]) cube ( size = [bpw+newbaseplateramplenght*2,fbpw*0.25,fbph]); // Back Baseplate Block

	    translate ([-newbaseplateramplenght,bpl+bbpw,0]) cube ( size = [newbaseplateramplenght*2+bpw,wopj,bbph/4] ); // Back Baseplate Anchoring 1
	    translate ([-newbaseplateramplenght,bpl+bbpw+wopj,0]) cube ( size = [newbaseplateramplenght*2+bpw,wopj,bbph/2] ); // Back Baseplate Anchoring 2

	  }
	  union () {
	    translate ([5.5,50,-1]) cube ( size = [shl,shw,hd] ); // Small Mounting Hole
	    translate ([5.5,84.5,-1]) cube ( size = [shl,shw,hd] ); // Small Mounting Hole

	    translate ([23.5,38,-1]) cube ( size = [bhl,bhw,hd] ); // Big Mounting Hole
	    translate ([23.5,84.5,-1]) cube ( size = [bhl,bhw,hd] ); // Big Mounting Hole

	    translate ([45,14,-1]) cube ( size = [5,90,hd] ); // Saw Slot

		translate ([fbpco+fbpcow/2,0,bph]) rotate ([0,0,180]) linear_extrude(height = fbph, convexity = 10, twist = 0) polygon(points=[[0,0],[fbpcow,0],[fbpcow/2,fbpcol]],paths=[[0,1,2]]); // Front Baseplate Cutout
		
		translate ([bbpco-bbpcow/2,bpl,bph]) rotate ([0,0,0]) linear_extrude(height = bbph, convexity = 10, twist = 0) polygon(points=[[0,0],[bbpcow,0],[bbpcow/2,bbpcol]],paths=[[0,1,2]]); // Back Baseplate Cutout

		translate ([-0.0125,poblbp+lolb+amflb*2+0.0125,0]) rotate ([90,0,0]) linear_extrude(height = lolb+amflb*2, convexity = 10, twist = 0) polygon(points=[[0,-0.1],[-dolbtb+wolb/2+amflb,-0.1],[-dolbtb+wolb/2+amflb,wolb/2],[0,bph]],paths=[[0,1,2,3]]); // Back Bearing Ramp Cutout 1
		
		translate ([bpw+0.0125,poblbp+lolb+amflb*2+0.0125,0]) mirror ([1,0,0]) rotate ([90,0,0]) linear_extrude(height = lolb+amflb*2, convexity = 10, twist = 0) polygon(points=[[0,-0.1],[-dolbtb+wolb/2+amflb,-0.1],[-dolbtb+wolb/2+amflb,wolb/2],[0,bph]],paths=[[0,1,2,3]]); // Back Bearing Ramp Cutout 2

	  }
	}
      }
      if (show == "0" || show == "3") {
	// // Part 3 - Tool Holder // TODO - Variablen optimieren // Montageinstrumente anpassen
	// flip (bolean) arround y, flip (bolean) arround y, rotate arround z, Width of Hinge, Lenght of Hinge, Support Structure, Diameter of Threaded Rod, Nut Size, Sharpening Threaded Rod Holder, Direction where threaded Rod is pointed to
// 	translate ([bpw-thswoh+0.5,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,bbph*2]) trh (0, 0, 0, thswoh, thswoh, 1.5, thsdos, thsks, 1, -90); //Left 1
// 	translate ([bpw-thswoh+0.5,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,70]) trh (0, 0, 180, thswoh, thswoh, 1.5, thsdos, thsks, 1.5, 90); //Left 1
	
	difference () {
	    union () {
		translate ([0,bpl+bbpw+0.2,bbph]) cube ( size = [bpw,lolb+amflb*2+bpl-poblbp-bbpw+0.8,bbph/2] ); // Baseplate
		translate ([bpw+dolbtb-wolb/2-amflb,poblbp,wolb/2+ecdtms]) cube ( size = [wolb+amflb*2,lolb+amflb*2+bbpw,wolb/2+amflb+ecwop]); // Energy-Chain Plattform
		translate ([bpw,bpl+bbpw+0.2+lolb+amflb*2+bpl-poblbp-bbpw+0.8,bbph]) rotate ([90,0,0]) linear_extrude(height = lolb+amflb*2+bpl-poblbp-bbpw+0.8, convexity = 10, twist = 0) polygon(points=[[0,0],[-(bbpw/1.5)/2,bbph/2],[dolbtb-wolb/2-amflb,wolb/2+ecdtms+wolb/2+amflb+ecwop-bbph],[dolbtb-wolb/2-amflb,0]],paths=[[0,1,2,3]]); //Right Connector
		translate ([bpw+dolbtb-wolb/2-amflb,bpl+bbpw+0.2,bbph]) rotate ([90,0,0]) linear_extrude(height = (lolb+amflb*2+bbpw)-(lolb+amflb*2+bpl-poblbp-bbpw+0.8), convexity = 10, twist = 0) polygon(points=[[0,0],[-(bbpw/1.5)/2,bbph/2],[dolbtb-wolb/2-amflb,wolb/2+ecdtms+wolb/2+amflb+ecwop-bbph],[dolbtb-wolb/2-amflb,0]],paths=[[0,1,2,3]]); //Right Connector 2. Stage
		translate ([bpw+dolbtb-wolb/2-amflb+wolb+amflb*2,bpl+bbpw+0.2+lolb+amflb*2+bpl-poblbp-bbpw+0.8,bbph]) mirror ([1,0,0]) rotate ([90,0,0]) linear_extrude(height = lolb+amflb*2+bbpw, convexity = 10, twist = 0) polygon(points=[[0,0],[-(bbpw/1.5)/2,bbph/2],[dolbtb-wolb/2-amflb,wolb/2+ecdtms+wolb/2+amflb+ecwop-bbph],[dolbtb-wolb/2-amflb,0]],paths=[[0,1,2,3]]); //Left Connector

		intersection () { // Hinge //TODO optimieren
		    union () {
			translate ([bpw/2-thswoh,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,bbph*2]) rotate ([0,90,0]) cylinder ( h = thswoh*2, r = (lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2);
			translate ([bpw/2-thswoh,bpl+bbpw+0.2,bbph]) cube ( size = [thswoh/2,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2] ); // Part2 Anchoring
			translate ([bpw/2+thswoh/2,bpl+bbpw+0.2,bbph]) cube ( size = [thswoh/2,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2] ); // Part2 Anchoring 
		    }
		    union () {
			translate ([bpw/2-thswoh,bpl+bbpw+0.2,bbph+bbph/2]) cube ( size = [thswoh/2,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8] ); // Part2 Anchoring 
			translate ([bpw/2+thswoh/2,bpl+bbpw+0.2,bbph+bbph/2]) cube ( size = [thswoh/2,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,lolb+amflb*2+bpl-poblbp-bbpw*2+0.8] ); // Part2 Anchoring 
		    }
		}
	    }
	    union () {
		translate ([bpw+0.0125+dolbtb,poblbp-1,wolb/2+ecdtms]) rotate ([270,0,0]) cylinder ( h = (bbpw+lolb+amflb*2)+2, r = wolb/2+amflb ); // Energy Chain Platform Cutout
		translate ([bpw+dolbtb-wolb/2-amflb+(wolb+amflb*2)/2,poblbp+ecfhd,wolb/2+ecdtms+1]) cylinder ( h = wolb/2+amflb+ecwop, r = ecsd/2 ); // Energy Chain Mounting Screw 1
		translate ([bpw+dolbtb-wolb/2-amflb+(wolb+amflb*2)/2,poblbp+ecshd,wolb/2+ecdtms+1]) cylinder ( h = wolb/2+amflb+ecwop, r = ecsd/2 ); // Energy Chain Mounting Screw 2
		
		translate ([bpw-thswoh*0.5,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,bbph*2]) rotate ([0,90,0]) cylinder ( h = (bpw-thswoh*2)/2+1, $fn = 6, r = thsks/2/cos(180/6)+0.3); // Nut-Trap
		translate ([-1,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,bbph*2]) rotate ([0,90,0]) cylinder ( h = (bpw-thswoh*2)/2+1, r = thsks*0.7+0.3); // Screw Head Shaft
		translate ([-1,bpl+bbpw+0.2+(lolb+amflb*2+bpl-poblbp-bbpw*2+0.8)/2,bbph*2]) rotate ([0,90,0]) cylinder ( h = bpw-thswoh/2+2, r = thsdos/2); // Screw Bolt Shaft
		translate ([bpw/2-thswoh/2,bpl+0.2-1,bbph]) cube ( size = [thswoh,lolb+amflb*2+bpl-poblbp-bbpw+0.8+1,bbph/2+1] ); // Space for Hinge
		translate ([bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,bbph-1]) cylinder ( h = bbph/2+2, r = asd/2 ); // Addon Screw Hole 1
		translate ([bpw-bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,bbph-1]) cylinder ( h = bbph/2+2, r = asd/2 ); // Addon Scew Hole 2
            }
        }
      }
      if (show == "0" || show == "4") { // Endstop Flag
        translate ([ecwoef/2+xabpmhd-xacw-wolb-amflb*2,bpl+bbpw+0.2+lolb+amflb*2+bpl-poblbp-bbpw*2+0.8+bbpw*0.75,bbph+bbph/2+echoefb]) rotate ([0,-90,0]) linear_extrude(height = ecwoef, convexity = 10, twist = 0) polygon(points=[[0,0],[echoef-2,0],[echoef,2],[echoef,bbpw-bbpw*0.75+xacw],[echoef-2,bbpw-bbpw*0.75+xacw],[echoef-2,bbpw-bbpw*0.75],[0,bbpw-bbpw*0.75]],paths=[[0,1,2,3,4,5,6]]); //Left Connector
        difference () {
            translate ([0,bpl+bbpw+0.2+lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,bbph+bbph/2]) cube ( size = [bpw-(bbpw/1.5)/2,bbpw,echoefb] );
            union () {
                translate ([bpw/2-thswoh/2,bpl+bbpw+0.2+lolb+amflb*2+bpl-poblbp-bbpw*2+0.8,bbph+bbph/2-1]) cube ( size = [thswoh,bbpw*0.75,echoefb+2] ); // Space for Hinge
                translate ([bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,bbph*1.5-1]) cylinder ( h = echoefb+2, r = asd/2 ); // Addon Screw Hole 1
		translate ([bpw-bbpw/1.5,bpl+bbpw+lolb+amflb*2+bpl-poblbp-bbpw*1.5+0.8,bbph*1.5-1]) cylinder ( h = echoefb+2, r = asd/2 ); // Addon Scew Hole 2
            }
        }
      }
    }

    // Workpiece Clamp - flip (X-Axis), flip (Y-Axis), rotate (Z-Axis), Width of Structure, Slider Width, Lenght of Structure, Lenght of Structure (Between), Height of Mounting Structure, Height above Workbench Plate, Height Adjustment Tollerance, Height Adjustment Scew Diameter, Spindle Nut Width, Spindle Nut Lenght, Spindle Nut Hole from Center, Threaded Rod Diameter, Distance between Threaded Rods, Diameter of Spindle Hole, Additional Threaded Rod Structure, Distance of Slider-Holes from Spindle, Slide Space Between, Work Distance, Work Height, Slide-Shaft Rounding Radius, Size of Nema Motor, Nema Engine Flange Size, Nema Engine Flange Depht, Width of Mounting Plate, Space on Mounting Plate, Nema Motor Screw Hole Distance,  Size of Screw Holes, Width of Threaded Rod Nuts, Diameter of Spindle Bearing, Amount of Workpiece Clamps, Back Plate Thickness, Front Plate Thickness, Pressure Plate Space, Height Adjustment Space, Mounting Screw Diameter, Mounting Screw Key Size, Energy Chain - Support-Structure Width, Energy Chain - Height of Plattform, Energy Chain - Distance of Plattform from Block, Energy Chain - Thickness of Plattform, Energy Chain - Lenght of Plattform (Width of Energy-Chain), Energy Chain - Width of Plattform (Lenght of Energy-Chain), Endstop Screw Hole Distance, Endstop Mounting Screw Hole Size, Endstop Threaded Rod Lock Screws Diameter, Printmode (Boolean), Print Workpiece Clamp Part (Numeric)
    module wcl (flipx, flipy, rotate, width, sw, lenght, lenghtb, homs, hawp, hat, hasd, snw, snl, snhfc, trd, dbtr, dosh, atrs, doshfs, ssb, shd, ssbe, wd, wh, rr, sonm, nefs, nefd, womp, somp, nmshd, sosh, wotrn, dosb, wosb, aowc, bpt, fpt, pps, has, msd, mskw, ecssw, echop, ecdopfr, ectop, eclop, ecwop, ecwops, esshd, esmshs, etrlsd, pm, pmn) {
        module block (width, lenght, height, dosh, doshfs, shd, trd, dbtr, atrs, dosb, wosb, wclp) {
            difference () {
                union () {
                    cube (size = [width, lenght, height]);
                    if (dosb > 0) {
                        translate ([width/2,lenght,height/2]) rotate ([90,0,0]) cylinder ( h = lenght, r = dosb/2+width/4 ); // Bearing Case
                    }
                }
                union () {
                    translate ([width/2,-1,atrs]) trod(lenght+2,-90,0,0,trd+dotra); // Threaded Rod Hole 1
                    translate ([width/2,-1,dbtr+atrs]) trod(lenght+2,-90,0,0,trd+dotra); // Threaded Rod Hole 2

                    translate([width/2,-1,height/2]) rotate ([-90,0,0]) cylinder ( h = lenght+2, r = dosh/2 ); // Spindle Hole
                    if (dosb > 0) {
                        translate ([width/2,wosb,height/2]) rotate ([90,0,0]) cylinder ( h = wosb+1, r = dosb/2 ); // Bearing Cutout
                    }
                    if (doshfs > 0) {
                        translate([width+1,lenght/2,height/2+doshfs]) rotate ([-90,0,90]) cylinder ( h = width+2, r = shd/2 ); // Slider-Hole 1
                        translate([width+1,lenght/2,height/2-doshfs]) rotate ([-90,0,90]) cylinder ( h = width+2, r = shd/2 ); // Slider-Hole 1
                    } else {
                    }
                }
            }
        }
        module mountingblock (width, lenght, height, hat, hasd, bpt, fpt, pps, msd, mskw, pmn) { // Mounting-Block Module to Fix Workpiece-Clamp on Threaded-Rod Frame
            zero = -gffh-wbph-ssbe-sw-hawp+iffhw;
            if (pmn == "" || pmn == "1") { // Show Only in Printmode
                translate ([0,0,-height]) {
                    difference () {
                        union () {
                            cube (size = [width, lenght, height]); // Block below Engine/Bearing Structure
                        }
                        union () {
                            translate ([-1,lenght/2,height/4-hat/2]) rotate ([0,90,0]) cylinder ( h = width+2, r = hasd/2 ); //Adjustment Scew-Hole 1 Part 1
                            translate ([-1,lenght/2,height/4+hat/2]) rotate ([0,90,0]) cylinder ( h = width+2, r = hasd/2 ); //Adjustment Scew-Hole 1 Part 2
                            translate ([-1,lenght/2,3*height/4-hat/2]) rotate ([0,90,0]) cylinder ( h = width+2, r = hasd/2 ); //Adjustment Scew-Hole 2 Part 1
                            translate ([-1,lenght/2,3*height/4+hat/2]) rotate ([0,90,0]) cylinder ( h = width+2, r = hasd/2 ); //Adjustment Scew-Hole 2 Part 2
                            translate ([-1,lenght/2-hasd/2,height/4-hat/2]) cube ( size = [width+2,hasd,hat] ); //Adjustment Scew-Hole 1 Part 3
                            translate ([-1,lenght/2-hasd/2,3*height/4-hat/2]) cube ( size = [width+2,hasd,hat] ); //Adjustment Scew-Hole 2 Part 3
                        }
                    }
                }
            }

            if (pmn == "" || pmn == "2") { // Hide Only in Printmode
                translate ([0,0,zero]) {
                    difference () {
                            union () {
                                translate ([-width/2,lenght+gffs/2-fpt,0]) cube ( size = [width*2,bpt+fpt,wsab2]); // Translate Threaded-Rod Mounting Block down to the Rods
                                translate ([width*1.5,lenght+gffs/2-fpt,0]) rotate([90,0,-90]) linear_extrude(height = width/2-has/2, convexity = 10, twist = 0) polygon(points=[[0,0],[0,wsab2+height],[lenght,wsab2+height],[lenght,wsab2]],paths=[[0,1,2,3]]); //tightening Structure Side A
                                translate ([0-has/2,lenght+gffs/2-fpt,0]) rotate([90,0,-90]) linear_extrude(height = width/2-has/2, convexity = 10, twist = 0) polygon(points=[[0,0],[0,wsab2+height],[lenght,wsab2+height],[lenght,wsab2]],paths=[[0,1,2,3]]); //tightening Structure Side B
                            }
                            union () {
                                translate ([-1-width/2,lenght+gffs/2-pps/2,-1]) cube ( size = [width*2+2,pps,wsab2+2]); // Block Devider
                                translate ([0,-1,wsab2-hat]) cube ( size = [width,lenght+2,hat+1]); // Cutout for Rearrangement
                                translate ([-1-width/2,lenght+gffs/2,-iffhw+wsab]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = (dotr)/2 ); // Threaded Rod Hole Bottom
                                translate ([-1-width/2,lenght+gffs/2,-iffhw+wsab2]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = (dotr)/2 ); // Threaded Rod Hole Top
                                translate ([width/2,lenght-1,wsab2/2]) rotate ([-90,0,0]) cylinder ( h = fpt+bpt+pps+2, r = msd/2 ); // Mounting Screw
                                translate ([width/2,lenght+fpt+pps+bpt-3,wsab2/2]) rotate ([-90,0,0]) cylinder ( h = 4, $fn = 6, r = mskw/2/cos(180/6)+0.7 ); // Mounting Screw Nut-Trap
                                translate ([-width/2,0,wsab2]) {
                                    translate ([-1,lenght/2,height/4-hat/2]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = hasd/2 ); //Adjustment Scew-Hole 1 Part 4
                                    translate ([-1,lenght/2,height/4+hat/2]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = hasd/2 ); //Adjustment Scew-Hole 1 Part 5
                                    translate ([-1,lenght/2,3*height/4-hat/2]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = hasd/2 ); //Adjustment Scew-Hole 2 Part 4
                                    translate ([-1,lenght/2,3*height/4+hat/2]) rotate ([0,90,0]) cylinder ( h = width*2+2, r = hasd/2 ); //Adjustment Scew-Hole 2 Part 5
                                    translate ([-1,lenght/2-hasd/2,height/4-hat/2]) cube ( size = [width*2+2,hasd,hat] ); //Adjustment Scew-Hole 1 Part 6
                                    translate ([-1,lenght/2-hasd/2,3*height/4-hat/2]) cube ( size = [width*2+2,hasd,hat] ); //Adjustment Scew-Hole 2 Part 6
                                }
                            }
                    }
                }
            }
        }

        module nut (width, lenght, snhfc, dosh, shd) { // Simulated Spindle-Nut
            difference () {
                color ("grey") cube (size = [width, lenght, width]); // Nut-Block
                union () {
                    translate([width+1,lenght/2,width/2+snhfc]) rotate ([-90,0,90]) cylinder ( h = width+2, r = shd/2 ); // Slider-Hole
                    translate([width/2, -1, width/2]) rotate ([-90,0,0]) cylinder ( h = lenght+2, r = dosh/2 ); // Spindle-Hole
                }
            }
        }

        module cage (width, sw, ssbe, lenghtb, height, wd, wh, snl, shd, snhfc, rr, doshfs) { // Cage which Pulled down by the Spindle-Nut
            difference () {
                union () {
                    translate ([-ssbe,lenghtb,0]) rotate([90,0,-90]) linear_extrude(height = sw, convexity = 10, twist = 0) polygon(points=[[0,-ssbe],[0,height],[lenghtb,height],[wd+lenghtb+5+snl/2-snhfc,height/2+snl/2],[wd+lenghtb+5+snl/2-snhfc,height/2-snl/2],[lenghtb,-ssbe]],paths=[[0,1,2,3,4,5]]);
                    translate ([width+sw+ssbe,lenghtb,0]) rotate([90,0,-90]) linear_extrude(height = sw, convexity = 10, twist = 0) polygon(points=[[0,-ssbe],[0,height],[lenghtb,height],[wd+lenghtb+5+snl/2-snhfc,height/2+snl/2],[wd+lenghtb+5+snl/2-snhfc,height/2-snl/2],[lenghtb,-ssbe]],paths=[[0,1,2,3,4,5]]);
                    translate ([-sw-ssbe,0,-ssbe-sw]) cube ( size = [width+2*sw+2*ssbe,lenghtb,sw+0.0125] );
                }
                union () {
                    translate([width+sw+1,lenghtb/2,height/2+doshfs]) rotate ([-90,0,90]) cylinder ( h = width+sw*2+2, r = shd/2 ); // Slider-Hole 1
                    translate([width+sw+1,lenghtb/2,height/2-doshfs]) rotate ([-90,0,90]) cylinder ( h = width+sw*2+2, r = shd/2 ); // Slider-Hole 1
                    translate([width+sw+1,lenghtb/2,height/2+doshfs+wh]) rotate ([-90,0,90]) cylinder ( h = width+sw*2+2, r = shd/2 ); // Slider-Hole 2
                    translate([width+sw+1,lenghtb/2,height/2-doshfs+wh]) rotate ([-90,0,90]) cylinder ( h = width+sw*2+2, r = shd/2 ); // Slider-Hole 2
                    translate([-sw-1,lenghtb/2-shd/2,height/2+doshfs]) cube ( size = [width+sw*2+2,shd,wh] ); // Slider-Hole Gap 1
                    translate([-sw-1,lenghtb/2-shd/2,height/2-doshfs]) cube ( size = [width+sw*2+2,shd,wh] ); // Slider-Hole Gap 2
                    translate([width+sw+1,-wd/3,height/4]) rotate ([-90,0,90]) cylinder ( h = width+sw*2+2, r = shd/2 ); // Alu T-Angle mounting Hole
                    minkowski () {
                        translate ([width+sw+1,0,0]) rotate([90,0,-90]) linear_extrude(height = width+sw*2+2, convexity = 10, twist = 0) polygon(points=[[snl/2-snhfc,height/2+wh+snhfc-shd/2+rr],[snl/2-snhfc,height/2+wh+snhfc+shd/2-rr],[wd+snl/2-snhfc,height/2+snhfc+shd/2-rr],[wd+snl/2-snhfc,height/2+snhfc-shd/2+rr]],paths=[[0,1,2,3]]); // Mounting Plate
                        rotate([90,0,-90]) cylinder (r=rr,h=1); // Pulling Down Corridor 
                    }
                }
            }
        }

	module cablemount (width, lenght, height, dosh, trd, dbtr, atrs, ssw, hop, dopfr, top, lop, esshd, esmshs) { // Structure for mounting Energy-Chain
		    difference () {
			    union () {
				cube (size = [width, lenght, height]); // Basisblock
				if (esshd > 0) { // If it is Z-Min-Endstop
                                            translate ([-dosh/2-1,0,height/2-(esshd*1.5)/2]) cube ( size = [esshd/2, lenght, esshd*1.5]); // Endstop-Block
                                            translate ([width*2,0,0]) cube ( size = [width*0.3,lenght,height/2-dosh]); // Endstop Threaded Rod Lock tightening Block
                                            translate ([width*1.5,0,(atrs-(trd+dotra)/2)]) cube ( size = [width/2,lenght,trd+dotra]); // Endstop Threaded Rod Clamp Block
                                }
				translate([width/2,0,height/2]) rotate ([-90,0,0]) cylinder ( h = lenght, r = dosh*1.5 ); // additional Spindle Material
				if (top > 0) { // Only Show Support Material if Platform have a Thickness
                                    translate ([0,0,0]) rotate([90,0,180]) linear_extrude(height = lenght, convexity = 10, twist = 0) polygon(points=[[0,0],[0,ssw],[dopfr,hop-top],[0,height-ssw],[0,height],[dopfr,hop],[dopfr+lop,hop],[dopfr+lop,hop-top],[dopfr+ssw,hop-top],[ssw/2,0]],paths=[[0,1,2,3,4,5,6,7,8,9,10]]); //tightening Structure Side A
				}
			    }
			    union () {
                                if (lenght != ecwops) { // Just make Mounting-Screw-Holes if Structure is for Energy-Chain Mount
                                    translate ([-dopfr-lop/2,tcecfhd,hop-top-1]) cylinder ( h = top+2, r = tcecsd/2 );
                                    translate ([-dopfr-lop/2,tcecshd,hop-top-1]) cylinder ( h = top+2, r = tcecsd/2 );
                                }
				translate ([width/2,-1,atrs]) trod(lenght+2,-90,0,0,trd+dotra); // Threaded Rod Hole 1
				translate ([width/2,-1,atrs-(trd+dotra)/2]) cube (size = [width/2+1, lenght+2, trd+dotra]); // Threaded Rod Hole 1 Corridor
				translate ([width/2,-1,dbtr+atrs]) trod(lenght+2,-90,0,0,trd+dotra); // Threaded Rod Hole 2
				translate ([width/2-(trd+dotra)/2,-1,height/2]) cube (size = [trd+dotra, lenght+2, height/2-atrs]); // Threaded Rod Hole 1 Corridor
				difference () {
                                    union () {
                                        translate([width/1.5,-1,height/2]) rotate ([-90,0,0]) cylinder ( h = lenght+2, r = dosh ); // Spindle Hole
                                        translate([width/1.5,-1,height/2-dosh]) cube (size = [width+1, lenght+2, dosh*2]); // Corridor Spindle Hole
                                        translate([width,-1,height/2-dbtr/2]) cube (size = [width/2, lenght+2, dbtr]); // Cut off Overlap
                                    }
                                        if (esshd > 0) { // If it is Z-Min-Endstop
                                            translate ([-dosh/2-1,0,height/2-(esshd*1.5)/2]) cube ( size = [esshd/2, lenght, esshd*1.5]); // Endstop-Block
                                        }
                                }
				if (esshd > 0) {
                                    translate ([-dosh/2+esshd/4,lenght+1,height/2-(esshd*1.5)/2+esshd*0.25]) rotate ([90,0,0]) cylinder ( h = lenght+2, r = esmshs/2 ); // Endstop Mounting Screw 1
                                    translate ([-dosh/2+esshd/4,lenght+1,height/2-(esshd*1.5)/2+esshd*1.25]) rotate ([90,0,0]) cylinder ( h = lenght+2, r = esmshs/2 ); // Endstop Mounting Screw 2

                                    translate ([1,lenght/2,(atrs-(trd+dotra)/2)/2]) rotate ([90,0,90]) cylinder ( h = width*2.3, r = esmshs/2 ); // Endstop Threaded Rod Lock Screw 1
                                    translate ([1,lenght/2,((atrs+(trd+dotra)/2)+(height/2-dosh))/2]) rotate ([90,0,90]) cylinder ( h = width*2.3, r = esmshs/2 ); // Endstop Threaded Rod Lock Screw 2
                                    translate ([width*1.5-dotra*2,-1,atrs]) trod(lenght+2,-90,0,0,trd+dotra); // Threaded Rod Clamp Hole
				}
			    }
		    }
	}


        if (pm == "False") { // Show Complete Structure in View-Mode
            translate ([0,0,gffh+wbph+sw+hawp+ssbe]) { // Lift whole Structure above Workbench plate and above with "hawp+ssbe"
                translate ([width/2,latrl,atrs]) trod(lowp+gffs+lenght*2+latrl+aotr,-90,0,0,trd); // Simulated Threaded Rod (lower)
                translate ([width/2,latrl,atrs+dbtr]) trod(lowp+gffs+lenght*2+latrl+aotr,-90,0,0,trd); // Simulated Threaded Rod (upper)
                translate ([width/2,lenght,(2*atrs+dbtr)/2]) rotate ([0,0,90]) sprod(lowp+gffs+lenght,0,90,0,dosh); // Spindle Set 1

                //Engine Mount
                difference () {
                    union () {
                        translate ([-sonm/2-somp/2+width/2,womp-2,(2*atrs+dbtr)/2-sonm/2-somp/2]) rotate ([0,0,-90]) mm (0, 0, sonm, nefs, nefd, womp, somp, nmshd, sosh, true ,dosh);
                        translate ([0,womp-2,0]) block (width, lenght-womp+2, 2*atrs+dbtr, dosh, "0", shd, trd, dbtr, atrs);
                        translate ([0,0,0]) cube ( size = [width, lenght-womp+2, (2*atrs+dbtr)/2-(sonm+somp)/2] );
                        translate ([0,0,(2*atrs+dbtr)/2+(sonm+somp)/2]) cube ( size = [width, lenght-womp+2, (2*atrs+dbtr)/2-(sonm+somp)/2] );
                    }
                    union () {
                        translate ([+width/2,wotrn/2,atrs]) rotate ([90,90,0]) cylinder ($fn = 6, r = wotrn/2/cos(180/6)+0.7, h = wotrn/2+2); //Nut-Trap 1
                        translate ([+width/2,wotrn/2,atrs+dbtr]) rotate ([90,90,0]) cylinder ($fn = 6, r = wotrn/2/cos(180/6)+0.7, h = wotrn/2+2); //Nut-Trap 2
                    }
                }
                translate ([0, 0, 0]) mountingblock(width, lenght, homs, hat, hasd, bpt, fpt, pps, msd, mskw, ""); // Threaded Rod Clamp Block Left
                translate ([0, lowp+gffs*2+lenght, 0]) mirror ([0,1,0]) mountingblock(width, lenght, homs, hat, hasd, bpt, fpt, pps, msd, mskw, ""); // Threaded Rod Clamp Block Right

                //Bearing Mount
                translate ([0,lowp+gffs+lenght,0]) block (width, lenght, 2*atrs+dbtr, dosh,  "0", shd, trd, dbtr, atrs, dosb, wosb);


                // Plate-Presser-Amount
                for (y = [lenght+wd+lenghtb+5+snl/2-snhfc:(lowp+gffs+lenght+lenghtb)/aowc:(lowp+gffs+lenght+lenghtb)-(wd+lenghtb+5+snl/2-snhfc)]) {

                    translate ([0,y-wd-snhfc-snw/2+lenghtb,atrs+dbtr/2-snw/2]) nut (snw, snl, snhfc, dosh, shd);
                    translate ([0,y,0]) block (width, lenghtb, 2*atrs+dbtr, dosh, doshfs, shd, trd, dbtr, atrs);
                    translate ([0,y,0]) cage (width, sw, ssbe, lenghtb, 2*atrs+dbtr, wd, wh, snl, shd, snhfc, rr, doshfs);

                }

                // Energy-Chain Mount
                translate ([0, 100, 0]) cablemount (width, ecwop, 2*atrs+dbtr, dosh, trd, dbtr, atrs, ecssw, echop, ecdopfr, ectop, eclop); //TODO Position
            }
        } else { // Show Complete Structure in Print-Mode width Printable Positions

            if (pmn == "0") { //Engine Mount
                rotate ([90,0,0]) {
                    mountingblock(width, lenght, homs, hat, hasd, bpt, fpt, pps, msd, mskw, "1"); // Threaded Rod Clamp Block Left
                    translate ([width/2,nefd+membranthick,(2*atrs+dbtr)/2]) rotate ([90,0,0]) membran (dosh+dotra, dosh+dotra, true); // Membran to Print Spindle-Hole
                    translate ([width/2,wotrn/2+membranthick,atrs]) rotate ([90,90,0]) membran (trd+dotra, trd+dotra, true); // Membran to Print Threded-Rod Hole 1
                    translate ([width/2,wotrn/2+membranthick,atrs+dbtr]) rotate ([90,90,0]) membran (trd+dotra, trd+dotra, true); // Membran to Print Threded-Rod Hole 1
                    difference () {
                        union () {
                            translate ([-sonm/2-somp/2+width/2,womp-2,(2*atrs+dbtr)/2-sonm/2-somp/2]) rotate ([0,0,-90]) mm (0, 0, sonm, nefs, nefd, womp, somp, nmshd, sosh, true ,dosh);
                            translate ([0,womp-2,0]) block (width, lenght-womp+2, 2*atrs+dbtr, dosh, "0", shd, trd, dbtr, atrs);
                            translate ([0,0,0]) cube ( size = [width, lenght-womp+2, (2*atrs+dbtr)/2-(sonm+somp)/2] );
                            translate ([0,0,(2*atrs+dbtr)/2+(sonm+somp)/2]) cube ( size = [width, lenght-womp+2, (2*atrs+dbtr)/2-(sonm+somp)/2] );
                        }
                        union () {
                            translate ([+width/2,wotrn/2,atrs]) rotate ([90,90,0]) cylinder ($fn = 6, r = wotrn/2/cos(180/6)+0.7, h = wotrn/2+2); //Nut-Trap 1
                            translate ([+width/2,wotrn/2,atrs+dbtr]) rotate ([90,90,0]) cylinder ($fn = 6, r = wotrn/2/cos(180/6)+0.7, h = wotrn/2+2); //Nut-Trap 2
                        }
                    }
                }
            } else if (pmn == "1") {
                rotate ([-90,0,0]) block (width, lenght, 2*atrs+dbtr, dosh,  "0", shd, trd, dbtr, atrs, dosb, wosb);
                rotate ([-90,0,0]) mountingblock(width, lenght, homs, hat, hasd, bpt, fpt, pps, msd, mskw, "1"); // Threaded Rod Clamp Block Left
            } else if (pmn == "2") {
                rotate ([0,0,0]) mountingblock(width, lenght, homs, hat, hasd, bpt, fpt, pps, msd, mskw, "2"); // Threaded Rod Clamp Block Left
            } else if (pmn == "3") {
                rotate ([-90,0,0]) {
                    translate ([width*1.5+sw,0,0]) block (width, lenghtb, 2*atrs+dbtr, dosh, doshfs, shd, trd, dbtr, atrs);
                    cage (width, sw, ssbe, lenghtb, 2*atrs+dbtr, wd, wh, snl, shd, snhfc, rr, doshfs);
                }
            } else if (pmn == "4") { // Printmode - Energy Chain Mount
		rotate ([90,0,0]) cablemount (width, ecwop, 2*atrs+dbtr, dosh, trd, dbtr, atrs, ecssw, echop, ecdopfr, ectop, eclop);
	    } else if (pmn == "5") { // Printmode - Energy Chain Holder
                rotate ([90,0,0]) cablemount (width, ecwops, 2*atrs+dbtr, dosh, trd, dbtr, atrs, ecssw, echop, ecdopfr, ectop, eclop);
            } else if (pmn == "6") { // Printmode - Endstop Holder
                rotate ([90,0,0]) cablemount (width, ecwops, 2*atrs+dbtr, dosh, trd, dbtr, atrs, ecssw, echop, ecdopfr, 0, eclop, esshd, esmshs);
            }
        }
    }


//Define MODULE END ###################################


//Generate mechanical Preview of whole Structure
if (printmode == false) { //Only if Printmode is OFF

  //Workbench-Plate
  difference () {
    translate ([0,0,gffh]) color ("white") cube ( size = [wowp+gffs,lowp+gffs,wbph] );
    union () {
        translate ([-1,trfebcdfo+trfebcbgd+trfebcbl/2-trfebcpgwiwp/2,gffh-1]) cube ( size = [wowp+gffs+2,trfebcpgwiwp,wbph+2]);
        translate ([-1,lowp-trfebcdfo+trfebcbgd-trfebcbl/2-trfebcpgwiwp/2,gffh-1]) cube ( size = [wowp+gffs+2,trfebcpgwiwp,wbph+2]);
    }
  }
//   translate ([90,15,gffh+wbph]) color ("silver") cube ( size = [610,610,2.7] ); //Simulate Material TODO - Automatische ausrichtung und Parameter


  difference() {
    union() {
      //Inner-Frame Feeds
      translate ([0,0,0]) gfeed(gffs,gffs,gffh); 
      translate ([wowp,0,0]) gfeed(gffs,gffs,gffh);
      translate ([wowp,lowp,0]) gfeed(gffs,gffs,gffh);
      translate ([0,lowp,0]) gfeed(gffs,gffs,gffh);

      translate ([0,lowp+gffs+xacw+spl,0]) gfeed(gffs,gffs,gffh); //Feed 1 at Parking Lot
      translate ([dbca,lowp+gffs+xacw+spl,0]) gfeed(gffs,gffs,gffh); //Feed 2 at Parking Lot

      translate ([dbca,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
      translate ([dbca,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

      translate ([wowp-ifcd,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
      translate ([wowp-ifcd,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

      translate ([wowp/2,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
      translate ([wowp/2,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

      translate ([0,ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn); 
      translate ([0,lowp-ifcd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

      if (iffc == 9) { //Place 9 Feeds if Configured
	translate ([ifcd,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	translate ([wowp/2,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn); 
	translate ([wowp-ifcd,lowp/2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn); 
      }

      translate ([dbca+gffs,trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part
      translate ([wowp/2+gffs,trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part
      translate ([wowp-ifcd+gffs,trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part

      translate ([dbca+gffs,lowp-trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part
      translate ([wowp/2+gffs,lowp-trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part
      translate ([wowp-ifcd+gffs,lowp-trfebcdfo/2,wsab2]) rotate ([0,0,90]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part

      //Groundframe / Inner-Frame Compound
      translate ([dbca,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
      translate ([wowp-ifcd,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
      translate ([wowp-ifcd,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
      translate ([dbca,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
      translate ([wowp/2,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side
      translate ([wowp/2,lowp,iffhw]) gfeed(gffs,gffs,gffh-iffhw); //Width Side

      translate ([wowp,ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side
      translate ([wowp,lowp-ifcd,iffhl]) gfeed(gffs,gffs,gffh-iffhl); //Lenght Side

      if (iffc == 9) { //Place Compound for 9 Feeds
	translate ([0,lowp/2,iffhl]) gfeed(gffs,gffs,gffh-iffhl);
	translate ([wowp,lowp/2,iffhl]) gfeed(gffs,gffs,gffh-iffhl);
      }

      //Workbench Attachment
      translate ([0,-soc/2+gffs/2,lsab-gffs/2]) wattach(0,0,0,gfwaw); //Overcut
      translate ([0,lowp+gffs*2+spl/2,lsab-gffs/2]) wattach(0,0,0,gfwaw); //Saw-Parking-Lot
    }
    union() {
      //Groundframe Difference Rod Width
      translate ([-aotr-watrl,gffs/2,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,gffs/2,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2,wsab]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      translate ([-aotr-watrl,lowp+gffs/2,wsab2]) drod(wowp+2*aotr+gffs+2*watrl,0,90,0);
      //Groundframe Difference Rod Length
      translate ([gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs*2+2*latrl+spl,-90,0,0); // Saw Paring Lot
      translate ([gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs*2+2*latrl+spl,-90,0,0); // Saw Parking Lot
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
      translate ([gffs/2+dbca,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs*2+2*latrl+spl,-90,0,0); // Saw Parking Lot
      translate ([gffs/2+dbca,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs*2+2*latrl+spl,-90,0,0); // Saw Parking Lot
      translate ([wowp/2+gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp/2+gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp-ifcd+gffs/2,-aotr-latrl,lsab]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
      translate ([wowp-ifcd+gffs/2,-aotr-latrl,lsab2]) drod(lowp+2*aotr+gffs+2*latrl,-90,0,0);
    }
  }

    //Threaded Rods
    //Groundframe Width
    translate ([-aotr-watrl,gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
    translate ([-aotr-watrl,gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
    translate ([-aotr-watrl,lowp+gffs/2,wsab]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
    translate ([-aotr-watrl,lowp+gffs/2,wsab2]) trod(wowp+2*aotr+gffs+2*watrl,0,90,0);
    //Groundframe Length
    translate ([gffs/2,-latrl-aotr-soc-xacw,lsab]) trod(lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw,-90,0,0); // Saw Parking Lot
    translate ([gffs/2,-aotr-latrl-xacw-soc,lsab2]) trod(lowp+2*aotr+gffs*3+2*latrl+spl+xacw*2+soc,-90,0,0); // Saw Parking Lot
    translate ([wowp+gffs/2,-aotr,lsab]) trod(lowp+2*aotr+gffs,-90,0,0);
    translate ([wowp+gffs/2,-aotr,lsab2]) trod(lowp+2*aotr+gffs,-90,0,0);
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
    translate ([gffs/2+dbca,-latrl-aotr-soc-xacw,lsab]) trod(lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw,-90,0,0); // Saw Parking Lot
    translate ([gffs/2+dbca,-latrl-aotr-xacw-soc,lsab2]) trod(lowp+2*aotr+gffs*3+2*latrl+spl+xacw*2+soc,-90,0,0); // Saw Parking Lot
    translate ([wowp/2+gffs/2,-latrl-aotr,lsab]) trod(lowp+gffs+aotr*2+latrl*2,-90,0,0);
    translate ([wowp/2+gffs/2,-latrl-aotr,lsab2]) trod(lowp+gffs+aotr*2+latrl*2,-90,0,0);
    translate ([wowp+gffs/2-ifcd,-latrl-aotr,lsab]) trod(lowp+gffs+aotr*2+latrl*2,-90,0,0);
    translate ([wowp+gffs/2-ifcd,-latrl-aotr,lsab2]) trod(lowp+gffs+aotr*2+latrl*2,-90,0,0);


    //X-Axis Carrier Back Structure
    translate([gffs/2-xacs/2,lowp+gffs*2+xacw+spl,lsab2-xacs/2]) mirror ([0,1,0]) rotate([90,0,0]) xacb(xacw, xach, dbca, xacs, xasrdb, xasrd, false, xasrmsd, tcsposr, xasbd, xasbw, xaabm, xabpt, xabpmhd, xabpmhs, tcsd, xams, xamfs, xamfd, xammpfs, xasomp, xammpss, xammpshd, xammpsd, xaesmshd, xaesmshs, xamssw, xamssl, 1);
    translate([gffs/2-xacs/2,-soc,lsab2-xacs/2]) rotate([90,0,0]) xacb(xacw, xach, dbca, xacs, xasrdb, xasrd, true, xasrmsd, tcsposr, xasbd, xasbw, xaabm, xabpt, xabpmhd, xabpmhs, tcsd, xams, xamfs, xamfd, xammpfs, xasomp, xammpss, xammpshd, xammpsd, xaesmshd, xaesmshs, xamssw, xamssl, 1);


    // Threaded Rod Bracer - Y-Axis Feeder
    translate ([0,trfebcdfo,0]) trfebc (0, 0, 0, trfebcbw, trfebcbl, trfebcbbpt, trfebcbfpt, trfebcbpps, trfebcbctrd, trfebcbgd, trfebccra, trfebcss, trfebcns, trfebcms, trfebcmfs, trfebcmfd, trfebcmmpfs, trfebcmsomp, trfebcmmpsd, trfebcmmpss, trfebcmmpshd, true, trfebcdomsbwp, trfebcbd, trfebcbw, trfebcabm, trfebcbpt, trfebcwpsd, trfebcpgwiwp, trfebcsd, trfebcpsnw, trfebcpsnl, trfebcnhw, trfebcpttwp, trfebcpo, trfebcpw, trfebcpl, trfebcpl2, trfebcpshd, trfebcph, trfebcesbph, trfebcesbpw, trfebcesbpl, trfebcesbpp, trfebcesshd, trfebcesmshs, "2"); //Frame - Bearing Bracer - Set 1
    translate ([wowp+gffs,trfebcdfo,0]) trfebc (1, 0, 0, trfebcbw, trfebcbl, trfebcbbpt, trfebcbfpt, trfebcbpps, trfebcbctrd, trfebcbgd, trfebccra, trfebcss, trfebcns, trfebcms, trfebcmfs, trfebcmfd, trfebcmmpfs, trfebcmsomp, trfebcmmpsd, trfebcmmpss, trfebcmmpshd, true, trfebcdomsbwp, trfebcbd, trfebcbw, trfebcabm, trfebcbpt, trfebcwpsd, trfebcpgwiwp, trfebcsd, trfebcpsnw, trfebcpsnl, trfebcnhw, trfebcpttwp, trfebcpo, trfebcpw, trfebcpl, trfebcpl2, trfebcpshd, trfebcph, trfebcesbph, trfebcesbpw, trfebcesbpl, trfebcesbpp, trfebcesshd, trfebcesmshs, "1"); //Frame - Engine Bracer - Set 1

    translate ([0,lowp-trfebcbl-trfebcdfo,0]) trfebc (0, 0, 0, trfebcbw, trfebcbl, trfebcbbpt, trfebcbfpt, trfebcbpps, trfebcbctrd, trfebcbgd, trfebccra, trfebcss, trfebcns, trfebcms, trfebcmfs, trfebcmfd, trfebcmmpfs, trfebcmsomp, trfebcmmpsd, trfebcmmpss, trfebcmmpshd, true, trfebcdomsbwp, trfebcbd, trfebcbw, trfebcabm, trfebcbpt, trfebcwpsd, trfebcpgwiwp, trfebcsd, trfebcpsnw, trfebcpsnl, trfebcnhw, trfebcpttwp, trfebcpo, trfebcpw, trfebcpl, trfebcpl2, trfebcpshd, trfebcph, trfebcesbph, trfebcesbpw, trfebcesbpl, trfebcesbpp, trfebcesshd, trfebcesmshs, "2"); //Frame - Bearing Bracer - Set 2
    translate ([wowp+gffs,lowp-trfebcbl-trfebcdfo,0]) trfebc (1, 0, 0, trfebcbw, trfebcbl, trfebcbbpt, trfebcbfpt, trfebcbpps, trfebcbctrd, trfebcbgd, trfebccra, trfebcss, trfebcns, trfebcms, trfebcmfs, trfebcmfd, trfebcmmpfs, trfebcmsomp, trfebcmmpsd, trfebcmmpss, trfebcmmpshd, true, trfebcdomsbwp, trfebcbd, trfebcbw, trfebcabm, trfebcbpt, trfebcwpsd, trfebcpgwiwp, trfebcsd, trfebcpsnw, trfebcpsnl, trfebcnhw, trfebcpttwp, trfebcpo, trfebcpw, trfebcpl, trfebcpl2, trfebcpshd, trfebcph, trfebcesbph, trfebcesbpw, trfebcesbpl, trfebcesbpp, trfebcesshd, trfebcesmshs, "1"); //Frame - Engine Bracer - Set 2

    //Spindle Rod - Y-Axis Feeder
    translate ([-trfebcbpt,trfebcdfo+trfebcbgd+trfebcbl/2,gffh-trfebcdomsbwp]) rotate ([0,0,0]) sprod(wowp+trfebcbpt,0,90,0,trfebcsd); // Spindle Set 1
    translate ([-trfebcbpt,lowp-trfebcdfo+trfebcbgd-trfebcbl/2,gffh-trfebcdomsbwp]) rotate ([0,0,0]) sprod(wowp+trfebcbpt,0,90,0,trfebcsd); // Spindle Set 2

    //Smooth Rods - X-Axis Carrier
    translate ([gffs/2-xacs/2+xacs/2+dbca/2-xasrdb/2,-soc-xacw*1.5,lsab2-xacs/2+xach+xacs/2]) srod(lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw+2,270,90,0,xasrd); //Left Top 
    translate ([gffs/2-xacs/2+xacs/2+dbca/2+xasrdb/2,-soc-xacw*1.5,lsab2-xacs/2+xach+xacs/2]) srod(lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw+2,270,90,0,xasrd); //Left Top 

    //Spindle Rod - X-Axis Carrier
    translate ([gffs/2-xacs/2+xacs/2+dbca/2-xasrdb/2,-soc-xacw*1.5,lsab2-xacs/2+xach+xacs/2+tcsposr]) sprod(lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw,270,90,0,tcsd); // Spindle X-Axis Carrier

    //Tool-Carrier
    translate ([gffs/2-xacs/2+tcdolbtb+xacs/2+dbca/2-xasrdb/2,(soc+wowp+spl-bpl-tclolb*2-xacs-gffs*2)/100*mvxa-soc,lsab2-xacs/2+xach+xacs/2-tcwolb/2]) tc (tcpoblbp, tclolb, tcwolb, tcdolbtb, tcamflb, tcsrd, tcwopj, tcasd, tcasnd, tcmcw, tcsposr, tcsd, tcsnw, tcsnl, tceas, "0", tcthswoh, tcthsdos, tcthsks, tcecdtms, tcecwop, tcecsd, tcecsnks, tcecfhd, tcecshd); // Tool-Carrier

    //Workpiece Clamp
    translate ([150,-wcll,0]) wcl (0,0,0, wclw, wcsw, wcll, wcllb, wclhoms, wclhawp, wclhat, wclhasd, wclsnw, wclsnl, wclsnhfc, wcltrd, wcldbtr, wcldosh, wclatrs, wcldoshfs, wclssb, wclshd, wclssbe, wclwd, wclwh, wclrr, wclsonm, wclnefs, wclnefd, wclwomp, wclsomp, wclnmshd, wclsosh, wclwotrn, wcldosb, wclwosb, wclaowc, wclbpt, wclfpt, wclpps, wclhas, wclmsd, wclmskw, wclecssw, wclechop, wclecdopfr, wclectop, wcleclop, wclecwop, wclesshd, wcletrlsd, wclesmshs, wclecwops, "False");

   }

  //###################################################################################################################################################################
  //Parts Output for Printing

  //Groundframe Feeds (Standing on the Floor)
    if (printgff == true && printmode == true) {
      difference () {
	union () {
	  translate ([0,0,0]) gfeed(gffs,gffs,gffh); 
	  translate ([gffs+printgffd,0,0]) gfeed(gffs,gffs,gffh);
	  translate ([gffs+printgffd,gffs+printgffd,0]) gfeed(gffs,gffs,gffh);
	  translate ([0,gffs+printgffd,0]) gfeed(gffs,gffs,gffh);
	  translate ([0,gffs*2+printgffd*2,0]) gfeed(gffs,gffs,gffh);
	  translate ([gffs+printgffd,gffs*2+printgffd*2,0]) gfeed(gffs,gffs,gffh);
	  translate ([0,gffs*3+printgffd*3,0]) gfeed(gffs,gffs,gffh);
	  translate ([gffs+printgffd,gffs*3+printgffd*3,0]) gfeed(gffs,gffs,gffh);
	}
	union () {
	  //Groundframe Difference Rod Width
	  translate ([-1,gffs/2,wsab]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs/2,wsab2]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs+printgffd+gffs/2,wsab]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs+printgffd+gffs/2,wsab2]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs*2+printgffd*2+gffs/2,wsab]) drod(gffs*2+2+printgffd,0,90,0);
	  translate ([-1,gffs*2+printgffd*2+gffs/2,wsab2]) drod(gffs*2+2+printgffd,0,90,0);
	  //Groundframe Difference Rod Length
	  translate ([gffs/2,-1,lsab]) drod(gffs*4+2+printgffd*3,-90,0,0);
	  translate ([gffs/2,-1,lsab2]) drod(gffs*4+2+printgffd*3,-90,0,0);
	  translate ([gffs+printgffd+gffs/2,-1,lsab]) drod(gffs*4+2+printgffd*3,-90,0,0);
	  translate ([gffs+printgffd+gffs/2,-1,lsab2]) drod(gffs*4+2+printgffd*3,-90,0,0);
	}
      }
    }

  //Workbench Attachment
    if (printwa == true && printmode == true) {
      rotate ([90,0,0]) {
        difference () {
            wattach(0,0,0,gfwaw);
	    union () {
		translate ([gffs/2,1,gffs/2]) drod(gffs+2,90,90,0);
		translate ([dbca+gffs/2,1,gffs/2]) drod(gffs+2,90,90,0);
            }
        }
      }
    }

  //Inner-Frame Compounds (No Contact to Floor)
    if (printifc == true && printmode == true) {
	rotate ([180,0,0]) {
	    difference () {
		union () {
		    //Inner-Frame Compound
		    translate ([0,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw);
		    translate ([gffs+printifcd,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw);  
		    translate ([gffs*2+printifcd*2,0,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 

		    translate ([0,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
		    translate ([gffs+printifcd,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 
		    translate ([gffs*2+printifcd*2,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhw); 

		    if (iffc == 9) { //Place Compound for 9 Feeds
			translate ([gffs*3+printifcd*3,0,iffhw]) gfeed(gffs,gffs,gffh-iffhl);
			translate ([gffs*3+printifcd*3,gffs+printifcd,iffhw]) gfeed(gffs,gffs,gffh-iffhl);
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
    }

  //Inner-Frame Feeds (Standing on the Floor)
    if (printiff == true && printmode == true) {
      rotate ([0,180,0]) {
	difference () {
	  union () {
	    translate ([0,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs+printiffd,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs*2+printiffd*2,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs*3+printiffd*3,0,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

	    translate ([0,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs+printiffd,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs*2+printiffd*2,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    translate ([gffs*3+printiffd*3,gffs+printiffd,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);

	    if (iffc == 9) { //Place 9 Feeds if Configured
	      translate ([0,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	      translate ([gffs+printiffd,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	      translate ([gffs*2+printiffd*2,gffs*2+printiffd*2,0]) gfeed(gffs,gffs,gffh,wmss,wmst,wmsh,wmwn);
	    }
	  }
	  union () {
	    //Inner-Frame Feeds Difference Rod Width
	    translate ([-1,gffs/2,wsab]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs/2,wsab2]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs+printiffd+gffs/2,wsab]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs+printiffd+gffs/2,wsab2]) drod(gffs*3+2+printiffd*6,0,90,0);
	    translate ([-1,gffs*2+printiffd*2+gffs/2,wsab]) drod(gffs*3+2+printiffd*3,0,90,0);
	    translate ([-1,gffs*2+printiffd*2+gffs/2,wsab2]) drod(gffs*3+2+printiffd*3,0,90,0);
	    //Inner-Frame Feeds Difference Rod Length
	    translate ([gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	    translate ([gffs+printiffd+gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs+printiffd+gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	    translate ([gffs*2+printiffd*2+gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs*2+printiffd*2+gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	    translate ([gffs*3+printiffd*3+gffs/2,-1,lsab]) drod(gffs*3+2+printiffd*3,-90,0,0);
	    translate ([gffs*3+printiffd*3+gffs/2,-1-wmss,lsab2]) drod(gffs*3+2+printiffd*3+wmss,-90,0,0);
	  }
	}
      }
    }

    if (printiffs == true && printmode == true) { // Print Inner-Frame Feeds Small
        rotate ([180,0,0]) {
            difference () {
                union () {
                    translate ([0,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 1
                    translate ([gffs+printiffsd,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 2
                    translate ([gffs*2+printiffsd*2,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 3
                    translate ([gffs*3+printiffsd*3,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 4
                    translate ([gffs*4+printiffsd*4,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 5
                    translate ([gffs*5+printiffsd*5,0,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part with Hole 6
                }
                union () {
                    translate ([-1,gffs/2,lsab2]) drod(gffs*6+2+printiffsd*6,0,90,0);
                }
            }
            translate ([0,wmss+printiffsd,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part 1
            translate ([gffs+printiffsd,wmss+printiffsd,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part 1
            translate ([gffs*2+printiffsd*2,wmss+printiffsd,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part 1
            translate ([gffs*3+printiffsd*3,wmss+printiffsd,wsab2]) gfeed(gffs,gffs,gffh-wsab2,wmss,wmst,wmsh,wmwn,"true"); // Workbench Mounting Part 1
        }
    }


  //"X-Axis" Carrier
  if (printxacb == true && printmode == true && printxacs == true) {
    xacb(xacw, xach, dbca, xacs, xasrdb, xasrd, printxacs, xasrmsd, tcsposr, xasbd, xasbw, xaabm, xabpt, xabpmhd, xabpmhs, tcsd, xams, xamfs, xamfd, xammpfs, xasomp, xammpss, xammpshd, xammpsd, xaesmshd, xaesmshs,  xamssw, xamssl, printxacbp); 
  } else if (printxacb == true && printmode == true && printxacs == false) {
    mirror ([1,0,0]) {
      xacb(xacw, xach, dbca, xacs, xasrdb, xasrd, printxacs, xasrmsd, tcsposr, xasbd, xasbw, xaabm, xabpt, xabpmhd, xabpmhs, tcsd, xams, xamfs, xamfd, xammpfs, xasomp, xammpss, xammpshd, xammpsd, xaesmshd, xaesmshs,  xamssw, xamssl, printxacbp);
    }
  }

  //"Y-Axis" Feeder
  if (printtrfebc  == true && printmode == true) {
    trfebc (0, 0, 0, trfebcbw, trfebcbl, trfebcbbpt, trfebcbfpt, trfebcbpps, trfebcbctrd, trfebcbgd, trfebccra, trfebcss, trfebcns, trfebcms, trfebcmfs, trfebcmfd, trfebcmmpfs, trfebcmsomp, trfebcmmpsd, trfebcmmpss, trfebcmmpshd, true, trfebcdomsbwp, trfebcbd, trfebcbw, trfebcabm, trfebcbpt, trfebcwpsd, trfebcpgwiwp, trfebcsd, trfebcpsnw, trfebcpsnl, trfebcnhw, trfebcpttwp, trfebcpo, trfebcpw, trfebcpl, trfebcpl2, trfebcpshd, trfebcph, trfebcesbph, trfebcesbpw, trfebcesbpl, trfebcesbpp, trfebcesshd, trfebcesmshs, printtrfebcn);
  }

  //Tool Carrier
  if (printtc == true && printmode == true) {
    tc (tcpoblbp, tclolb, tcwolb, tcdolbtb, tcamflb, tcsrd, tcwopj, tcasd, tcasnd, tcmcw, tcsposr, tcsd, tcsnw, tcsnl, tceas, printtcp, tcthswoh, tcthsdos, tcthsks, tcecdtms, tcecwop, tcecsd, tcecsnks, tcecfhd, tcecshd);
  }

  //Workpiece Clamp
  if (printwcl == true && printmode == true) {
    wcl (0,0,0, wclw, wcsw, wcll, wcllb, wclhoms, wclhawp, wclhat, wclhasd, wclsnw, wclsnl, wclsnhfc, wcltrd, wcldbtr, wcldosh, wclatrs, wcldoshfs, wclssb, wclshd, wclssbe, wclwd, wclwh, wclrr, wclsonm, wclnefs, wclnefd, wclwomp, wclsomp, wclnmshd, wclsosh, wclwotrn, wcldosb, wclwosb, wclaowc, wclbpt, wclfpt, wclpps, wclhas, wclmsd, wclmskw, wclecssw, wclechop, wclecdopfr, wclectop, wcleclop, wclecwop, wclecwops, wclesshd, wclesmshs, wcletrlsd, "True", printwclp);
  }

//Information Echos in Render-Terminal
echo ("################# SIZES OF UNPRINTABLE OBJECTS #################");
  //Threaded Rods
    //Groundframe
    echo ("##### THREADED RODS - GROUNFRAME #####");
    echo ("Pieces: 2, Groundframe/Inner-Frame: Lenght of the Length-Sized 'Saw Parking Lot (upper)' Threaded Rods:", lowp+2*aotr+gffs*3+2*latrl+spl+xacw*2+soc);
    echo ("Pieces: 2, Groundframe/Inner-Frame: Lenght of the Length-Sized 'Saw Parking Lot (lower)' Threaded Rods:", lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw);
    echo ("Pieces: 2, Groundframe: Lenght of the Length-Sized Threaded Rods:", lowp+gffs+aotr*2+latrl*2);
    echo ("Pieces: 4, Inner-Frame: Lenght of the Length-Sized Threaded Rods:", lowp+gffs+aotr*2+latrl*2);
    echo ("Pieces: 4, Groundframe: Lenght of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    if (iffc == 9) { //Place 9 Feeds if Configured
      echo ("Pieces: 6, Inner-Frame: Lenght of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    } else {
      echo ("Pieces: 4, Inner-Frame: Lenght of the Width-Sized Threaded Rods:", wowp+2*aotr+gffs+2*watrl);
    }
    //Workpiece Clamp
    echo ();
    echo ("##### THREADED RODS - WORKPIECE CLAMP #####");
    echo ("Pieces: 2, Workpiece-Clamp-Structure: Lenght of the Threaded Rods", lowp+gffs+wcll*2+latrl+aotr);

    //Spindle Rods
    echo ();
    echo ("##### SPINDLE RODS #####");
    echo ("Pieces: 1, Workpiece-Clamp-Structure: Lenght of the Spindle", lowp+gffs+wcll);
    echo ("Pieces: 1, X-Axis Carrier (Saw Mount): Lenght of the Spindle", lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw);
    echo ("Pieces: 2, Y-Axis Feeder: Lenght of the Spindle", wowp+trfebcbpt);

    //Smooth Rods
    echo ();
    echo ("##### SMOOTH RODS #####");
    echo ("Pieces: 2, X-Axis Carrier (Saw Mount): Lenght of the Smooth Rods", lowp+2*aotr*2+gffs+latrl*2+spl+soc+xacw+2);
