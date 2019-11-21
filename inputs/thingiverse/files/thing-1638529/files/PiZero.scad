//  Pi Zero model for checking other models
//  0,0,0 is centre of PCB, bottom face
//  This model is for V1.2, 1.3, W1.1 & WH

// By misterC @ thingiverse

// Pi Zero version
PiZeroVer = "W";        // [1.2/1.3/W/WH] for version of Pi

// visibility options
ShowPiZero = true;
//ShowPiZero = false;
ShowTestPads = true;
//ShowTestPads = false;
ShowGPIOheader = 1;     // 0 = dont' show, 1 = show above, -1 = show below (version WH overrides this)
ShowGPIOsound = true;
//ShowGPIOsound = false;
ShowGPIOcolour = true;
//ShowGPIOcolour = false;

//
// Loads of variables
//

// PCB size values
PiSizeX = 65;
PiSizeY = 30;
PiSizeZ = 1.6;
PiCornerRad = 3.0;
PiHoleEdge = 3.5;       // Mount holes are 3.5mm from each edge
PiHoleDia = 2.75;
PiHoleClearRad = 3.0;    // Mount holes have 6 Dia clear on PCB

//  GPIO part sizes
PiHdrX = 2.5;
PiHdrY = 2.5;
PiHdrZ = 2.5;
PinX = 0.7;
PinY = 0.7;
PinZ = 11.75;
PiPinZOff = 3;   // measured, pins aren't symmetrical

//  Calculated size values
PiHoleRad = PiHoleDia / 2;

//  Mount hole dims from centre lines
PiHoleX = PiSizeX/2 - PiHoleEdge;
PiHoleY = PiSizeY/2 - PiHoleEdge;
//  Half thickness of PCB, used for internal sums
PiHalfZ = PiSizeZ/2;
//  Offset to centre of GPIO Pin header pad
PiPadOffset = PiHalfZ + PiHdrZ/2;
//  Offset for centre of GPIO Pin
PiPinOffset = PiHalfZ + PinZ/2 - PiPinZOff;

//  Pi system components
//  all Pi### [ Xctr, Yctr, Xsize, Ysize, Zsize, <color> ]
//  Component connector centrelines from Pi centreline

PiSD = [-24.5,1.9,11.5,12.0,1.3,"Silver"];		// SD holder
PiUSB = [8.9,-13,7.5,5.0,2.5,"Silver"];			// Data (USB)
PiOTG = [21.5,-13,7.5,5.0,2.5,"Silver"];		// Power (OTG)
PiHDMI = [-20.1,-11.4,11.25,7.25,3.3,"Silver"];	// HDMI
// Camera header in two parts
PiCAMw = [30,0,3,17,1.3,"Ivory"];
PiCAMb = [32,0,1.6,17,1.3,"DimGray"];
//  "Act" LED - position changes after 1.2
PiACT = (PiZeroVer=="1.2") ? ([30.9,-7.2,1,2.3,1,"GreenYellow"]) : ([26.5,-8,2.3,1,1,"GreenYellow"]);
//  SOC - position changes for W versions
PiSOCx = (isitPiW()) ? -7.1 : -2.5;
PiSOC = [PiSOCx,-2,12,12,1.2,"Black"];			// SOC
PiWiFi = [[-6.5,-11.4],[1.5,-11.4],[-1.5,-13.5],[-4,-13.5],[-6.5,-11.4]];	// WiFi / BT antenna shape

//  PP pads (on underside) centres from Pi centreline
//  all PiPP [ padno, <function>, Xctr, Yctr, Dia, <color> ]
//  elements 0 & 1 are for info only at present, element 5 chosen to match wire colour
//  JTAG etc not included at the moment

PiPP = [
	[1,"+5V",21.0,-8.7,2.25,"Red"],		// PP1 X varies slightly but only about 0.5mm
	[6,"GND",21.25,-11.1,2.25,"Black"],
	[22,"Data +",9.4,-13,1.75,"White"],
	[23,"Data -",7.4,-13,1.75,"SpringGreen"]
	];

//  GPIO easy reference colours
GPIOcolour = [
	["Orange","Red"],
	["Cyan","Red"],
	["Cyan","Black"],
	["DarkGreen","PaleGreen"],
	["Black","PaleGreen"],
	["DarkGreen","DarkGreen"],
	["DarkGreen","Black"],
	["DarkGreen","DarkGreen"],
	["Orange","DarkGreen"],
	["Magenta","Black"],
	["Magenta","DarkGreen"],
	["Magenta","Magenta"],
	["Black","Magenta"],
	["Yellow","Yellow"],
	["DarkGreen","Black"],
	["DarkGreen","DarkGreen"],
	["DarkGreen","Black"],
	["DarkGreen","DarkGreen"],
	["DarkGreen","DarkGreen"],
	["Black","DarkGreen"],
	];
	
// Overall definition
$fn=60;

/*
Program from here
*/

// Model the Zero if required
if(ShowPiZero) PiZeroBody();

// Model the test pads if required
if (ShowTestPads) PiZeroTestPads();
    
// Model the GPIO headers if required (always show for WH)
if (PiZeroVer=="WH") PiGPIO(1);
	else if (ShowGPIOheader) PiGPIO(ShowGPIOheader);


/*
Modules
*/

//
//  This is the main routine and can be called from outside
//
module PiZeroBody() // Models the Pi.
{
	color("LimeGreen") difference()
	{
		// PCB shape
		hull() for (Xcount=[-PiHoleX,PiHoleX],Ycount=[-PiHoleY,PiHoleY]) translate([Xcount,Ycount,PiHalfZ]) cylinder(r=PiCornerRad,h=PiSizeZ,center=true);

		// Corner screw holes
		for (Xcount=[-PiHoleX,PiHoleX],Ycount=[-PiHoleY,PiHoleY]) PiPCBhole(Xcount,Ycount,PiHoleDia);
		// GPIO holes
		for (Xcount=[0:19],Ycount=[0,1]) PiPCBhole(XPinPos(Xcount),YPinPos(Ycount),1.2);
		// The sound and vision holes (loop list cheat for simplicity)
		for (Xcount=[18,19],Ycount=[-1,-2]) PiPCBhole(XPinPos(Xcount),YPinPos(Ycount),1.2);
    }

	// Now show the components    
	PiComponent(PiSOC);		// Processor
	PiComponent(PiSD);		// SD card holder
	PiComponent(PiHDMI);	// HDMI
	PiComponent(PiUSB);		// USB
	PiComponent(PiOTG);		// Power
	PiComponent(PiACT);		// Active LED
	if (PiZeroVer != "1.2")	// Only 1.2 doesn't have camera header
	{
		PiComponent(PiCAMw);
		PiComponent(PiCAMb);
	}
	if (isitPiW) color("DarkGreen") translate([0,0,0.1]) linear_extrude(height=PiSizeZ) polygon(points=PiWiFi);		// Antenna
}

//
//  These routines can also be called separately from outside
//
module PiZeroTestPads()   // Show test pads for debugging connectors
{
	for(count=PiPP) PiDrawPad(count);
}

module PiGPIO(switch)   // Show GPIO pins, plus sound & vision
{
	PiZPad = PiHalfZ + switch*PiPadOffset;
	PiZPin = PiHalfZ + switch*PiPinOffset;
	for (Xcount = [0:19], Ycount = [0,1])
	{
		colour = ShowGPIOcolour ? GPIOcolour[Xcount][Ycount] : "Gold";
		PiPCBPin(XPinPos(Xcount),YPinPos(Ycount),PiZPad,PiZPin,colour);
	}
	if (ShowGPIOsound) for (Xcount = [18,19], Ycount = [-1,-2]) PiPCBPin(XPinPos(Xcount),YPinPos(Ycount),PiZPad,PiZPin,"Gold");
}

//
// Modules and Functions used for Pi model
//
module PiDrawPad(PiVect)	// Places a spot at test pad point, coloured to show pad function
{
	translate([PiVect[2],PiVect[3],PiSizeZ/4]) color(PiVect[5]) cylinder(h=PiSizeZ*2/3,d=PiVect[4],center=true);
}

module PiPCBhole(Xpos,Ypos,Dia)	// Cuts a hole through PCB
{
	translate([Xpos,Ypos,PiHalfZ]) cylinder(h=2*PiSizeZ,d=Dia,center=true);
}

module PiComponent(PiData)	// Makes a block to represent a component on the upper face
{
	translate([PiData[0],PiData[1],PiSizeZ + PiData[4]/2]) color(PiData[5]) cube([PiData[2],PiData[3],PiData[4]], center=true);
}

module PiPCBPin(Xpos,Ypos,Zpad,Zpin,colour)	//  PCB headers, pin by pin
{
	translate([Xpos,Ypos,Zpad]) color("Black") cube([PiHdrX,PiHdrY,PiHdrZ],center=true);
	translate([Xpos,Ypos,Zpin]) color(colour) cube([PinX,PinY,PinZ],center=true);
}

// X & Y co-ord calcs for header pin positions
function XPinPos(Xval) = -(19*1.27)+Xval*2.54;
function YPinPos(Yval) = PiHoleY-1.27+Yval*2.54;

function isitPiW() = (search("W",PiZeroVer)==[0]) ? "True" : "False";	// Returns true if first character of version is W
