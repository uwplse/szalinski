// MakerBot Thingiverse Customizer template 
// with build chamber limiter, 
// Replicator model selection, 
// and cross section option.  
// 
// by Les Hall
// 
// started 3-19-2014
// All dimensions are in millimeters 
// unless otherwise specified.  
// This template works in Customizer.  
// 
// used as starting point for
// Electric Circuit Elements
// started 4-1-2014
// 



/* [General] */

// MakerBot Replicator Model
buildVolume = 4; // [0:Replicator 2X, 1:Replicator 2, 2:Replicator Z18, 3:Replicator Mini, 4:Replicator]

// Make whole thing or half thing
crossSection = 0; // [0:whole thing, 1: positive x half, 2:negative x half, 3:positive y half, 4:negative y half, 5:positive z half, 6:negative z half]

// part
part = 7;  // [0:node, 1:wire, 2:resistor, 3:inductor, 4:capacitor, 5:LED T1-3/4, 6:8 pin DIP IC, 7:LED resonator]

// Thickness (mm)
wallThickness = 6; // [1:256]

// smoothness Exponent
detail = 5; // [2:10]





/* [Details] */

// number of turns
n = 16; // [1:1000]
// outer diameter (microns)
outerDiameter = 10000; // [1000:50000]

// element length (microns)
elementLength = 10000;  // [500:50000]

// end cap thickness (microns)
endCapThickness = 500;  // [0:1000]

// wire diameter (microns)
wireDiameter = 1000;  // [500:10000]

// socket pin diameter (mils)
socketPinDiameter = 20; // [5:100]




// convert from microns (um) to millimeters (mm)
outerDiametermm = outerDiameter / 1000;
elementLengthmm = elementLength / 1000;
endCapThicknessmm = endCapThickness / 1000;
wireDiametermm = (wireDiameter / 1000) * 25.4;

// calculate lengths of inductor
totalLengthmm = 2 * endCapThicknessmm + elementLengthmm;

// socket pin variables
socketPinDiametermm = (socketPinDiameter / 1000) * 25.4;
socketLengthmm = 10*socketPinDiametermm;
pinSpacingmm = 0.1 * 25.4;  // thru-hole spacing


// size of build volume in millimeters
buildSize = [
	[246, 152, 155], 
	[285, 153, 155], 
	[305, 305, 457], 
	[100, 100, 125],
	[252, 199, 150], 
];

// select the build volume by model
MakerBotSize = buildSize[buildVolume];

// determine offset and size of cross section eraser
xs = 2*MakerBotSize[0];
ys = 2*MakerBotSize[1];
zs = 2*MakerBotSize[2];
crossSectionOffsets = [
	[ 0,   0,   0], 
	[-xs,  0,   0], 
	[ xs,  0,   0], 
	[ 0,  -ys,  0], 
	[ 0,   ys,  0], 
	[ 0,   0, -zs], 
	[ 0,   0,  zs]
];
crossSectionOffset = crossSectionOffsets[crossSection];
crossSectionSize = 4*MakerBotSize;

// set level of detail for round shapes
$fn = pow(2, detail);


// make it!
difference()
{
	// use intersection to ensure evertything fits in build chamber
	intersection()
	{
		if (part == 0)  // node
		{
			sphere(r = wireDiammeter);
		}
		else if (part == 1)  // wire
		{
			cylinder(r = wireDiameter/2, 
				h = totalLength, 
				center = true);
		}
		else if (part == 2)  // resistor
		{
			resistor();
		}
		else if (part == 3)  // inductor
		{
			inductor();
		}
		else if (part == 4)  // capacitor
		{
			capacitor();
		}
		else if (part == 5)  // LED T1-3/4
		{
			led();
		}
		else if (part == 6)  // 8 pin DIP IC
		{
			dip8();
		}
		else if (part == 7)  // example circuit
		{
			// inductively coupled LED
			inductivelyCoupledLED();
		}
	}
	// cross-section option
	if (crossSection > 0)
		translate(crossSectionOffset)
			cube(crossSectionSize, center = true);
}



// draw a resistor
module resistor()
{
	union()
	{
		// bottom end cap
		translate([0, 0, -totalLengthmm/2 + endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	
		// winding below
		translate([0, 0, -elementLengthmm/4])
		linear_extrude(height = elementLengthmm/2, 
			center = true, convexity = 10, twist = 360 * (n/2) )
		translate([outerDiametermm*(1/2-1/8), 0, 0])
		circle(r = outerDiametermm/8, center = true);
	
		// winding above
		translate([0, 0, elementLengthmm/4])
		linear_extrude(height = elementLengthmm/2, 
			center = true, convexity = 10, twist = -360 * (n/2) )
		translate([outerDiametermm*(1/2-1/8), 0, 0])
		circle(r = outerDiametermm/8, center = true);
	
		// top end cap
		translate([0, 0, totalLengthmm/2 - endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	}
}




// draw an inductor
module inductor()
{
	union()
	{
		// bottom end cap
		translate([0, 0, -totalLengthmm/2 + endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	
		// winding
		linear_extrude(height = elementLengthmm, 
			center = true, convexity = 10, twist = 360 * n)
		translate([outerDiametermm*(1/2-1/8), 0, 0])
		circle(r = outerDiametermm/8, center = true);
	
		// top end cap
		translate([0, 0, totalLengthmm/2 - endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	}
}




// draw a capacitor
module capacitor()
{
	union()
	{
		// bottom end cap
		translate([0, 0, -totalLengthmm/2 + endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	
		// plates
		for (i = [0:(n-1)])
		{
			difference()
			{
				// outer cylinder
				translate([0, 0, 0.1 * pow(-1, i) * elementLengthmm])
				cylinder(r = ( (i + 1) / n ) * outerDiametermm/2, 
					h = elementLengthmm,
					center = true);

				// hollow of cylinder
				translate([0, 0, 0.1 * pow(-1, i) * elementLengthmm])
				cylinder(r = ( (i + 0.5)  / n ) * outerDiametermm/2, 
					h = 1.1 * elementLengthmm,
					center = true);
			}
		}

		// top end cap
		translate([0, 0, totalLengthmm/2 - endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	}
}





// draw an LED
module led()
{
	union()
	{
		// pin 1
		translate([-pinSpacingmm/2, 0, 0])
		socketPin();

		// pin 2
		translate([pinSpacingmm/2, 0, 0])
		socketPin();
	}
}




// draw an 8-pin DIP socket
module dip8()
{
	union()
	{
		for(col = [0:1], row = [0:3])
			translate([3 * (2*col-1) * pinSpacingmm/2, 
				(row - 1.5) * pinSpacingmm, 0])
			socketPin();
	}
}




// draw a socket pin
module socketPin()
{
	difference()
	{
		// positive material
		union()
		{
			// cylinder body
			translate([0, 0, socketLengthmm/2 + endCapThicknessmm/2])
			cylinder(r = socketPinDiametermm, 
				h = socketLengthmm, 
				center = true);
		
			// bottom end cap
			cylinder(r = 2*socketPinDiametermm, 
				h = endCapThicknessmm, 
				center = true);
		}	

		// negative material
		// cylinder hollow
			translate([0, 0, socketLengthmm/2 + endCapThicknessmm/2])
		translate([0, 0, 0.1 * socketLengthmm])
		cylinder(r2 = 1.25 * socketPinDiametermm/2,
			r1 = 0.75 * socketPinDiametermm/2,  
			h = socketLengthmm,
			center = true);
	}
}





// inductively coupled LED
module inductivelyCoupledLED()
{
	union()
	{
		RLCresonator();
	}
}




// make a resonant structure
module RLCresonator()
{
	union()
	{
		// top end cap
		translate([0, 0, totalLengthmm/2 - endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);

		// winding 1
		translate([0, 0, elementLengthmm*0.05])
		linear_extrude(height = elementLengthmm, 
			center = true, convexity = 10, twist = 360 * n)
		translate([outerDiametermm*(1/2-0.2), 0, 0])
		circle(r = outerDiametermm*0.2, center = true);
	

		// winding 2
		translate([0, 0, -elementLengthmm*0.05])
		linear_extrude(height = elementLengthmm, 
			center = true, convexity = 10, twist = 360 * n)
		translate([outerDiametermm*(1/2- 0.2), 0, 0])
		circle(r = outerDiametermm*0.2, center = true);

		// bottom end cap
		translate([0, 0, -totalLengthmm/2 + endCapThicknessmm/2])
		cylinder(r = outerDiametermm/2, h = endCapThicknessmm, 
			center = true);
	
		// led

		// wires
	}
}







