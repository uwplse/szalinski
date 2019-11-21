//http://www.bcae1.com/spboxad2.htm
//http://www.mh-audio.nl/ReflexBoxCalculator.asp
//http://tara.mmto.org/speakers/theory/Closed-Box-Loudspeaker-Systems-Part-I-Analysis.pdf


//Test case
//http://www.madisound.com/store/manuals/aurasound/ns3-193-4a.pdf
//These are nice inexpensive drivers - very good bass - but drop off a little on the high end (benefit from turning up the treble)
//1.7 liter box
//tuned to 70hz / 66hz f3

//This script is intended to help design small single driver speakers (using full range drivers).  

//Advantages of single-driver designs:
//No cross-over network / no cancellation between drivers
//Inexpensive full-range drivers are available that produce surprisingly good bass and high-end response

//Advantages of 3d printing your speaker box
//No issues with adhesives 
//Box can be printed with bass port

//https://www.parts-express.com/

//design notes
//test case for very small (0.5 liter) enclosure produced reasonable results with 7mm wall thickness / 2 shells and 10% infill at 300 micron.  Cabinet walls definitely resonated - but sound quality didn't seem to suffer noticeably.  Higher infill is probably good idea for all but smallest cabinets.

//Stuff I've read on speaker design:
//avoid two or more identical dimensions - as this can lend to reflections.  Some people say "golden ratio" of .62 : 1 : 1.62 is optimal
//stuffing box with poly-fil (fabric store) can effectively increase box volume by around 20%
//If using a bass port - it's diameter should be at least 1/3rd of your driver's diamter (I've violated this a bit without apparent issue)
 
//calculators to help determine box / port size and performance
//http://www.mh-audio.nl/ReflexBoxCalculator.asp
//http://www.mh-audio.nl/ClosedBoxCalculator.asp

use<write/Write.scad>;

// preview[view:south, tilt:top diagonal]

/* [General] */
//Display box specs (disable before export)
showSpecs = "yes"; //[yes,no]
//Box size in -liters- (closed box calc overrides)
manualBoxVolume = 1.68;
//thickness of box walls in mm (independant of volume)
boxThickness = 7; 
boxHeightRatio = 1.1;
boxWidthRatio = .9;
boxDepthRatio = 1.7;

/* [Speaker Hole] */
//make a few mm larger than actually needed to assure fit
speakerHoleDiameter = 80;
//diagonally opposing holes this distance apart (mm)
speakerScrewHoleSpacing = 94; 
numberOfSpeakerScrewHoles = 4; 
//3.25mm seems good for #6 wood screw (screw in slowly / don't overtighten to avoid cracking) - chase with drill bit if needed
speakerScrewHoleDiameter = 3.25;  

/* [Closed Box Calc] */
//Automatically calculate box size for desired Q (needs driver parameters)
enableClosedBoxCalc = "no"; //[yes,no]
//Qtc for box - (must be larger than Driver Qts)
boxQ = 0.9; 
//Qts for driver
driverQts = 0.68;
//Resonance frequency for driver
driverFS = 73;
//Vas in liters (*28.3 to convert from cubic feet)
driverVas = 1.132;  

/* [Bass Port] */
//Manual config only (Closed box calc must be off!)
makePort = "no"; //[yes,no] 
portLocation = "back"; //[front,back]
//Use a tool like www.mh-audio.nl/ReflexBoxCalculator.asp to calculate (mm)
portInternalDiameter = 20;
//Use a tool like www.mh-audio.nl/ReflexBoxCalculator.asp to calculate (mm)
portLength = 100;
portWallThickness = 5;
portXOffset = 0;
//May need to manually added supports for values besides 0
portYOffset = 0;  

/* [Terminal] */
terminalType = "dual wire holes"; //[dual wire holes, single wire hole, terminal cutout, none]
//about 2.2mm for 22 gauge solid core wire (use silicone seal / chase with drill bit if needed)
wireDiameter = 2.2;	
//make a bit larger than needed to assure fit (mm)
terminalHoleDiameter = 40;
//diagonally opposing holes this distance apart (mm)
terminalScrewHoleSpacing = 50;
numberOfTerminalScrewHoles = 4;
//3.25 seems good for #6 wood screw (screw in slowly / don't overtighten to avoid cracking) - chase with drill bit if needed
terminalScrewHoleDiameter = 3.25;


/* [Hidden] */

alpha = pow((boxQ / driverQts), 2) - 1;
desiredBoxVolume = (enableClosedBoxCalc == "yes") ? driverVas / alpha : manualBoxVolume;
fc = sqrt(alpha+1)*driverFS;

a1 = (1/boxQ/boxQ)-2;
f3 = fc*sqrt(a1/2+sqrt(a1*a1/4+1));

boxRatioFactor = (pow(boxHeightRatio * boxWidthRatio * boxDepthRatio, 1/3));
boxIntHeight = (pow(desiredBoxVolume * 1000000, 1/3)) * (boxHeightRatio / boxRatioFactor);
boxIntWidth =  (pow(desiredBoxVolume * 1000000, 1/3)) * (boxWidthRatio / boxRatioFactor);
boxIntDepth = (pow(desiredBoxVolume * 1000000, 1/3)) * (boxDepthRatio / boxRatioFactor);


f3String = str("F3:",round(f3),"hz");
qString = str("Qtc:",round(boxQ * 100) / 100);
volString = str("Vol:", round((boxIntWidth * boxIntHeight * boxIntDepth) / 10000) / 100, "L");
intDimString = str("Int dim:", round(boxIntWidth), "x", round(boxIntHeight), "x", round(boxIntDepth),"mm");
extDimString = str("Ext dim:", round(boxIntWidth + boxThickness * 2), "x",
	  round(boxIntHeight + boxThickness * 2), "x", round(boxIntDepth + boxThickness * 2),"mm");


makeBox();
if (showSpecs == "yes") renderSpecs();


module makeBox()
{
	difference()
	{
		boxExterior();
		boxInterior();
		
		circleCutOut(90, speakerHoleDiameter);
		screwCutOuts(90, speakerScrewHoleSpacing, numberOfSpeakerScrewHoles, speakerScrewHoleDiameter);
			
		makeTerminal();

		if (makePort == "yes" && enableClosedBoxCalc != "yes") {
			if (portLocation == "back") portHole();
			if (portLocation == "front") rotate ([0,0,180]) portHole();
		}
	}

	if (makePort == "yes" && enableClosedBoxCalc != "yes") {
		if (portLocation == "back") port();
		if (portLocation == "front") rotate ([0,0,180]) port();
	}
}

module renderSpecs() {
	rotate([90,0,0]) {
	if (enableClosedBoxCalc == "yes") {
	translate ([(boxIntWidth + boxThickness) / 1.25,50,boxIntDepth / 2]) write(f3String ,h=14,t=1); 
	translate ([(boxIntWidth + boxThickness) / 1.25,25,boxIntDepth / 2]) write(qString ,h=14,t=1);
	translate ([(boxIntWidth + boxThickness) / 1.25,0,boxIntDepth / 2])  write(volString ,h=14,t=1);}

	translate ([(boxIntWidth + boxThickness) / 1.25,-25,boxIntDepth / 2]) write(intDimString ,h=14,t=1); 
	translate ([(boxIntWidth + boxThickness) / 1.25,-50,boxIntDepth / 2]) write(extDimString ,h=14,t=1);}
}

module boxExterior()
{
		cube([boxIntWidth + boxThickness * 2, 
		boxIntDepth + boxThickness * 2,
		boxIntHeight + boxThickness * 2], center = true);
}

module boxInterior()
{
	cube([boxIntWidth, 
		boxIntDepth,
		boxIntHeight], center = true);
}


module circleCutOut(rotation, holeDiameter)
{
	rotate ([rotation,0,0]) translate([0, 0, (boxIntDepth  / 2) - 1]) 
	{
		cylinder(r = holeDiameter / 2, h = boxThickness * 2);
	}
}


module screwCutOuts(rotation, distance, numberOfHoles, holeDiameter)
{
	rotate ([rotation,0,0]) translate([0, 0, (boxIntDepth  / 2) - 1]) 
	{
		for (i = [0 : 360 / numberOfHoles : 360])
		{
			rotate([0,0,i + 45])
				translate([0, distance / 2, 0])
					cylinder(r = holeDiameter / 2, h = boxThickness * 2);
		}
	}
}

module makeTerminal()
{
	if (terminalType == "single wire hole") {
		rotate ([270,0,0]) translate([0, 0, (boxIntDepth  / 2) - 1]) 
			cylinder(r = wireDiameter / 2, h = boxThickness * 2);
	}

	if (terminalType == "dual wire holes") {
		rotate ([270,0,0]) translate([0, 0, (boxIntDepth  / 2) - 1]) {
			translate ([wireDiameter * -2,0,0])
				cylinder(r = wireDiameter / 2, h = boxThickness * 2);
			translate ([wireDiameter * 2,0,0])
				cylinder(r = wireDiameter / 2, h = boxThickness * 2);
		}
	}

	if (terminalType == "terminal cutout") {
		circleCutOut(270, terminalHoleDiameter);
		screwCutOuts(270, terminalScrewHoleSpacing, numberOfTerminalScrewHoles, terminalScrewHoleDiameter);
	}

}

module port()
{
	difference()
	{
		rotate([90,0,0])
		translate([(boxIntWidth / -2) - portInternalDiameter / -2,
			(boxIntHeight / -2) - portInternalDiameter / -2 ,
			(boxIntDepth / -2) - boxThickness])
		translate([portXOffset,portYOffset,0])
		cylinder(r = (portInternalDiameter + portWallThickness) / 2,
			 h = portLength);
		portHole();
	}

}

module portHole()
{
	rotate([90,0,0])
		translate([(boxIntWidth / -2) - portInternalDiameter / -2,
			(boxIntHeight / -2) - portInternalDiameter / -2 ,
			(boxIntDepth / -2) - boxThickness])
	translate([portXOffset,portYOffset,-0.5])
	cylinder(r = (portInternalDiameter) / 2,
		 h = portLength + 1);
}
