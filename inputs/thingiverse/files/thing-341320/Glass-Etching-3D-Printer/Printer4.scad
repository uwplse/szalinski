// by Les Hall
// started Fri May 23 2014
// 
// Asssembly drawing for 3D printer LesterBot
// (an xy table for plate glass etching)
// 




/* [Base] */

// size of base (mm)
baseSize = 12 * 25.4;

// thickness of base (mm)
baseHeight = 1/4 * 25.4;

// distance between work surfaces (mm)
workSurfaceHeight = 2 * 25.4;

// height of lid (mm)
lidHeight = 6 * 25.4;

// offset of origin (mm)
originOffset = 0 * 25.4;

// distance between bolt holes NEMA 17, 23 (mm)
boltHoleDistance = [1.220, 1.856, 2.74] * 25.4;

// diameter of bolt hole NEMA 17, 23, (mm)
boltHoleDiameter = [0.1285, 0.195, 0.218] * 25.4;

// thickness of walls (mm)
wallThickness = 1/8 * 25.4;

/* [Rollers] */

// height of roller axle (mm)
rollerHeight = 3 * 25.4;

// vertical offset between rollers (mm)
rollerOffset = 0.75 * 25.4;

// separation of rollers (mm)
rollerSeparation = 7.5 * 25.4;

// length of roller (mm) 
rollerLength = 12 * 25.4;

// diameter of roller (mm)
rollerDiameter = 0.5 * 25.4;

// diameter of roller end cap (mm)
rollerEndCapDiameter = 1 * 25.4;

// number of sides on roller (faces)
numSides = 4;

// offset of motors from shaft (mm)
motorOffset = 20;

// diameter of Stepper Motor mount hole (mm)
stepperMotorDiameter = 14;

// diameter of axle (mm)
axleDiameter = 0.1968 * 25.4;


/* [Components] */

// width of PCB
PCBwidth = 2 * 25.4;

// height of PCB
PCBheight = 3 * 25.4;

// depth of PCB
PCBdepth = 1/8 * 25.4;


/* [Hidden] */ 

$fn=32;
merge = 0.01;
baseDimensions = [baseSize, baseSize, baseHeight];
breadboardDimensions = [PCBwidth, PCBheight, PCBdepth]; 
PCBDimensions = [7/8, 5/4, 1/16] * 25.4; 
penHolderDimensions = [25.4, 25.4, 1*rollerOffset]; 
workSurfaceDimensions = [rollerLength, rollerLength, workSurfaceHeight];


// base
module base()
{
	color([0, 0, 1])
	difference()
	{
		cube(baseDimensions, center=true);

		translate([0.28*baseDimensions[0], 0, 0])
		cube(baseDimensions+[0, 1, 1], center=true);
	}
}


// work surface
module workSurface()
{
	translate([0, 0, workSurfaceDimensions[2]/2])
	color([1, 1, 0])
	cube(workSurfaceDimensions, center=true);
}


// breadboard
module breadboard()
{
	color([1, 0, 1])
	cube(breadboardDimensions, center=true);
}


// PCB
module PCB()
{
	color([1, 0, 1])
	cube(PCBDimensions, center=true);
}


// Power Charger
module powerCharger()
{
	translate([0, 0, 6])
	color([1, 0, 1])
	cube([65, 115, 12], center=true);
}


// Audio breakout
module AudioBreakout()
{
	color([1, 0, 1])
	cube([1, 0.75, 1/8]*25.4, center=true);
}


// USB breakout
module USBbreakout()
{
	color([1, 0, 1])
	cube([1, 0.75, 1/8]*25.4, center=true);
}


// roller
module roller()
{
	difference()
	{
		// the roller itself
		cylinder(r=rollerDiameter/2, 
			h=rollerLength, 
			$fn=numSides, 
			center=true);

		// holes in end of rotor
		for (side=[-1:2:1])
		translate([0, 0, rollerLength/2])
		cylinder(r=axleDiameter/2, h=20, center=true);
	}
}



// roller assembly
module rollerAssembly()
{
	// roller
	rotate(90, [1, 0, 0])
	rotate(90, [0, 1, 0])
	color([0, 1, 0])
	roller();

	// motor
	for(side=[-1:2:1])
	translate([side*(rollerLength/2+motorOffset-4), 0, 0])
	rotate(90, [0, 1, 0])
	rotate(90+side*90, [0, 1, 0])
	color([1, 0, 0])
	import("StepperMotorAssembly.stl");
}


// pen
module pen()
{
	cylinder(r=1/8*25.4, 
		h=2*25.4, 
		center=true);
}


// pen assembly
module penAssembly()
{
	penOffset = [0, 0, 0] * 25.4;
	union()
	{
		// pen
		translate(penOffset)
		color([0, 0, 0])
		pen();
	
		// pen holder
		difference()
		{
			color([0, 1, 1])
			cube(penHolderDimensions, center=true);
	
			translate(penOffset)
			pen();
		}
	}
}


// motor mount chassis
module motorMount()
{
	union()
	{
		difference()
		//union()
		{
			// main plate
			cube([rollerLength-25.4/4, wallThickness, 6*25.4], center=true);
			
			// axle holes
			for(side=[-1:2:1])
			translate([side*rollerSeparation/2, 0, 0])
			rotate(90, [1, 0, 0])
			cylinder(r=stepperMotorDiameter/2, 
				h=25.4/2, center=true);
	
			// NEMA bolts
			for(side=[-1:2:1])
			translate([side*rollerSeparation/2, 0, -rollerOffset/2])
			rotate(90, [1, 0, 0])
			rotate(90, [0, 0, 1])
			for(NEMA=[0:2])
			for(t=[0:3])
			rotate(360*t/4, [0, 0, 1])
			translate([boltHoleDistance[NEMA]/2, boltHoleDistance[NEMA]/2, 0])
			color([1, 0.5, 0])
			cylinder(r=boltHoleDiameter[NEMA]/2, h=8*wallThickness+merge, 
				center=true);		}
	}
}


// motor mount chassis
module motorChassis()
{
	union()
	{
		difference()
		{
			// motor mounts
			for(t=[0:3])
			rotate(360*t/4, [0, 0, 1])
			translate([0, rollerLength/2+wallThickness/2, rollerHeight])
			rotate(90+90*pow(-1, t), [1, 0, 0])
			motorMount();
		}

		// cylindrical supports
		/*
		for(t=[0:3])
		rotate(360*t/4, [0, 0, 1])
		translate([rollerLength/2, rollerLength/2, rollerHeight/2+rollerOffset/2+25.4*6/8])
		cylinder(r=25.4*3/8, h=rollerHeight+rollerOffset+25.4, center=true);
		*/
	}
}


// the whole printer
module printer()
{
	// working surface
	// rollers with motors
	for(i=[-1:2:2])
	translate([0, i*rollerSeparation/2, rollerHeight-rollerOffset/2])
	rollerAssembly();  // X roller
	for(i=[-1:2:2])
	rotate(90, [0, 0, 1])
	translate([0, i*rollerSeparation/2, rollerHeight+rollerOffset/2])
	rollerAssembly();  // X roller
	
	// motor mount chassis
	motorChassis();

	// pen assembly
	translate([0, 0, rollerHeight])
	penAssembly();

	// electronics shelf
	translate([0, 0, lidHeight])
	{
		// base board
		base();
	
		// PCBs
		// breadboard
		translate([-0.38*baseSize, -0.25*baseSize, 0.25*25.4])
		breadboard();

		// audio
		translate([-0.43*baseSize, -0.44*baseSize, 0.25*25.4])
		AudioBreakout();

		// power charger
		translate([-0.36*baseSize, baseSize/4, 0])
		powerCharger();

		// USB
		translate([-0.43*baseSize, -0.05*baseSize, 0.25*25.4])
		USBbreakout();
	}

	// driver boards
	for(t=[0:3])
	rotate(360*t/4, [0, 0, 1])
	for(side=[-1:2:1])
	for(phase=[-1:2:1])
	translate([side*25.4, rollerLength/2+25.4*3/16, rollerHeight+phase*1.5/2*25.4])
	rotate(90, [1, 0, 0])
	//rotate(90, [0, 0, 1])
	PCB();

	// working surface
	workSurface();

	// rubber bands
	translate([0, 0, rollerHeight])
	for(roller=[-1:2:1])
	for(side=[-1:2:1])
	for(vert=[-1:2:1])
	rotate(45-roller*45, [0, 0, 1])
	translate([0, side*25.4/4, roller*rollerOffset/2+vert*rollerDiameter/2])
	rotate(90, [0, 1, 0])
	color([0, 0, 0])
	cylinder(r=25.4/16, h=rollerSeparation, 
		center=true);
}


// make the thing!  
printer();





