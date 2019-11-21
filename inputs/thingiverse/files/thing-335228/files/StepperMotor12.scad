// by Les Hall
// 3D Printed Stepper Motor
// started Sat May 17 2014
//
// 
// In an effort to make a nearly all plastic machines, 
// I am beginning with the stepper motors because these 
// are expensive parts that are currently purchased.  
// 
// Then I plan to make the rest of the mechanism out of
// plastic, the frame and everything that can be will be.  
// 
// An all plastic 3D printer has the potential to help
// people in impoverished countries enter the global
// economy.  Lets make the world a better place.  
//
//  	
// magnet from www.magnet4less.com
// magnet from www.GaussBoys.com
// 




/* [Motor] */

// selection of what to print (index)
selection = 0;  // [0:5]

// cross sectional view option (true/false)
crossSection = false;

// number of steps (steps)
numSteps = 4;

// amount of exploded view (mm), animation:  explode = 20*timeStepper($t);
explode = 20*timeStepper($t); 

// amount of rotation
rotation = 360*pow(sin(360*$t), 2);


/* [Magnet] */

// diameter of cylindrical magnet (mm)
magnetDiameter = 9.33;

// height of cylindrical magnet (mm)
magnetHeight = 3*7;


/* [Bobbins] */

// diameter of bobbins (mm)
bobbinDiameter = 15;

// length of bobbins (mm)
bobbinLength = 20;


/* [Stator] */

// length of drive axle (mm)
driveAxleLength = -0.25 * 25.4;

// diameter of axle (mm)
axleDiameter = 8;

// distance between bolt holes NEMA 17, 23, 34 (mm)
boltHoleDistance = [1.220*25.4, 47, 2.74*25.4];

// diameter of bolt hole NEMA 17, 23, 34 (mm)
boltHoleDiameter = [0.1285, 0.195, 0.218] * 25.4;

// clearance of axle (mm)
axleClearance = 3;

// end play between parts (mm)
play = 1;


/* [Lid] */

// skateboard bearing size (mm) 
bearingSize = [22, 22, 7];

// skateboard bearing inside diameter (mm)
bearingID = 8;


/* [Details] */

// round part smoothness (facets)
$fn = 64;

// thickness of walls (mm)
wallThickness = 2;




/* [Hidden] */

// oscilliatory motion due to time
function timeStepper(time) = (1 + sin(360*time) )/2;

// amount to merge shapes so they form clean output files
merge = 0.1;

// magnet parameters
magnetDiagonal = sqrt(pow(magnetHeight, 2) + 
	pow(magnetDiameter, 2));
magnetHolderDiameter = magnetDiagonal+wallThickness;
rotorBearingThickness = magnetHolderDiameter;

// spheroidal rotor size
rotorSize = [magnetHolderDiameter, magnetHolderDiameter, rotorBearingThickness];
rotorCradleSize = rotorSize + 2*play*[1, 1, 1];


// size of rotor plus play
rotorWidth = magnetHolderDiameter+2*play; 
rotorHeight = rotorBearingThickness+2*play; 

// size of stator
statorWidth = rotorWidth+2*wallThickness; 
statorHeight = rotorHeight+bearingSize[2]+2*wallThickness+play; 

// axle hole diameter
axleHoleDiameter = bearingSize[0];
axleLength = driveAxleLength+rotorHeight/2+magnetDiameter/2+play+wallThickness;

// size of outer lid
NEMAplateSize = 57;
	


// the magnet holder
module magnetHolder()
{
	difference()
	{
		// add a rotation bearing surface
		scale(rotorSize)
		sphere(r=0.5);

		// remove bottom half of rotation bearing surface
		translate([0, 0, -rotorBearingThickness/2])
		scale(rotorSize)
		cylinder(r=0.5, h=1, center=true);
	
		// the magnet itself
		for(t=[0:(numSteps-1)-1])
		rotate(360*t/(numSteps-1), [0, 0, 1])
		translate([magnetHeight/2-1.5, 0, 0])
		rotate(90, [0, 1, 0])
		cylinder(r=magnetDiameter/2, 
			h=magnetHeight/7, 
			center=true);
	}
}


// axle
module axle()
{
	axleOffset = bearingSize[2] + rotorHeight/2 - magnetDiameter/2;
	union()
	{
		// the main axle shaft
		translate([0, 0, -(axleLength-axleOffset)/2])
		cylinder(r=axleDiameter/2, 
			h=axleOffset, 
			center=true);

		// NEMA shaft diameter
		cylinder(r=boltHoleDiameter[1]/2, 
			h=axleLength, 
			center=true);
	}
}


// rotor half
module rotor(addAxle=true)
{
	union()
	{
		// magnet
		magnetHolder();
		
		// axle
		if (addAxle)
			translate([0, 0, axleLength/2+magnetDiameter/2])
			axle();
	}
}


// bobin (each)
module bobbin()
{
	translate([0, 0, bobbinLength/2])
	difference()
	{
		union()
		{
			// main bobbin shaft
			cylinder(r=bobbinDiameter/4, 
				h=bobbinLength-2*merge, 
				center=true);

			// bobbin body
			translate([0, 0, -bobbinLength/8])
			cylinder(r=bobbinDiameter/2, 
				h=3/4*bobbinLength, 
				center=true);
		}

		// torus chisel to cut out wire space
		translate([0, 0, -bobbinLength/8])
		rotate_extrude(convexity = 10)
		translate([bobbinDiameter/2, 0, 0])
		scale([bobbinDiameter, bobbinLength*3/4, 0])
		scale([0.75, 1])
		circle(r=3/8);

		// notch to catch wire
		for(side=[-1:2:1])
		rotate(-360/numSteps/4, [0, 0, 1])
		translate([0, side*bobbinDiameter/2, bobbinLength*1/4])
		cylinder(r=bobbinDiameter/8, 
			h = bobbinLength/2, 
			center=true);

		// holes for core metal
		// short hole
		translate([0, 0, -bobbinLength*(1/2-1/8)])
		cylinder(r1=bobbinDiameter/3, 
			r2=bobbinDiameter/6, 
			h=bobbinLength/4+merge, 
			center=true);
		// long hole
		cylinder(r=bobbinDiameter/6, 
			h=bobbinLength+merge, 
			center=true);
	}
}


// arrange radial bobbins on stator
module radialBobbins(motion=0, choice=true)
{
	// radial bobbin holes
	for(t=[0:numSteps-1])
	rotate(360*t/numSteps, [0, 0, 1])
	translate([-(motion+statorWidth/2-wallThickness/2), 0, 0])
	rotate(-90, [0, 1, 0])
	rotate(360/numSteps/4, [0, 0, 1])
	if (choice)
		bobbin();
	else
		translate([0, 0, wallThickness/2])
		rotate(0, [0, 0, 1])
		cylinder(r=bobbinDiameter/2+play, 
			h=wallThickness+merge, 
			center=true);
}


// stator
module stator(offset)
{
	height = rotorHeight/2+offset;
	union()
	{
		difference()
		{
			// outside cylinder
			translate([0, 0, height/2])
			scale([statorWidth, statorWidth, height])
			rotate(180/numSteps, [0, 0, 1])
			cylinder(r=1.0/sqrt(2), h=1, 
				center=true, $fn=numSteps);

			translate([0, 0, height])
			{
				// inside ellipse hole
				scale([rotorWidth, rotorWidth, rotorHeight])
				sphere(r=0.5);

				// bobbin attachment holes
				radialBobbins(0, false);
			}
		}
	}
}


module lid()
{
	union()
	{
		difference()
		{
			// positive material
			union()
			{
				// other half of stator
				stator(offset=bearingSize[2]);
	
				// NEMA mounting plate
				translate([0, 0, wallThickness/2])
				cube([NEMAplateSize, NEMAplateSize, wallThickness], 
					center=true);
			}
	
			// axle hole	
			translate([0, 0, bearingSize[2]+wallThickness])
			cylinder(r=axleHoleDiameter/2, 
				h=2*bearingSize[2], 
				center=true);
			cylinder(r=axleDiameter/2+play, 
				h=8+merge, 
				center=true);

			// NEMA bolts
			for(NEMA=[1:1])
			for(t=[0:3])
			rotate(360*t/4, [0, 0, 1])
			translate([boltHoleDistance[NEMA]/2, boltHoleDistance[NEMA]/2, 0])
			cylinder(r=boltHoleDiameter[NEMA]/2, h=2*wallThickness+merge, 
				center=true);
		}
	}
}


// stepper motor
module stepperMotor()
{
	// upper rotor
	translate([0, 0, explode/2])
	translate([0, 0, rotorHeight/2+bearingSize[2]])
	rotate(-rotation, [0, 0, 1])
	color([1, 0, 0])
	rotor(false);

	// lower rotor
	translate([0, 0, rotorHeight/2+bearingSize[2]])
	rotate(rotation, [0, 0, 1])
	rotate(180, [0, 1, 0])
	color([1, 0, 0])
	rotor(true);

	// stator
	translate([0, 0, statorHeight-wallThickness+explode])
	rotate(180, [1, 0, 0])
	color([0, 0, 1])
	stator(offset=play+wallThickness);

	// bobbins
	translate([0, 0, statorHeight/2+wallThickness/2])
	color([1, 0, 1])
	radialBobbins(explode);

	// lid
	translate([0, 0, -explode])
	color([0, 1, 0])
	lid();

	// bearing
	translate([-16.7, -14.65, 6.1+bearingSize[2]/2+wallThickness])
	color([0, 1, 1])
	import("H_06_Reduced.stl");
}


// make the thing!
intersection()
{
	if (selection == 0)
			stepperMotor();
	else if (selection == 1)
		rotor(false);
	else if (selection == 2)
		rotor(true);
	else if (selection == 3)
		stator(offset=play+wallThickness);
	else if (selection == 4)
		bobbin();
	else if (selection == 5)
		lid();

	if (crossSection)
	translate([0, -100, 0])
	cube(size=200, center=true);
}	

