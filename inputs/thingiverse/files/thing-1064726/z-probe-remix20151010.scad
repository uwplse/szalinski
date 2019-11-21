/* [Basic Settings] */

// What is the diameter of your sensor?
SensorDiameter = 18;

// How thick do you want the bracket arms to be?
BracketThickness = 6;

// Where should the bracket be? 0 is default, positive moves it forward, negative move it back
BracketPosition = 0; // [-25:30]

/* [Advanced Settings] */

// The thickness of the wooden panels of the carriage? Usually 6.35 for MakerFarm i3
PanelThickness=6.35;

// Cylinder resolution. set it to 10 if you're mucking about, about 120 if you're exporting STL's
CircleResolution = 60;

// Cut the arms if you're having trouble printing the tops of the clamps
ClampCut = false;


/* [Printer] */
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* [Hidden] */
// Jitter is used to prevent coincident-surface problems with CSG. Should be set to something small.
j = 0.01;

// Short-cuts used to make arrays easier to reference
x=0; y=1; z=2;

// Convenience values
SensorRadius = SensorDiameter/2;
$fn = CircleResolution;


use<utils/build_plate.scad>;

// Side panel with the various holes cut out
module XSidePlate(endstop_hole=false)
{
	translate([0, 0, PanelThickness])
	rotate([180, 0, 0])
	difference()
	{
		linear_extrude(height=PanelThickness) 
		polygon(points=[
			[0, 0],       // 0
			[12.2, 0],    // 1
			[12.2, -5.8], // 2
			[31.9, -5.8], // 3
			[31.9, 0],    // 4
			[45, 0],      // 5
			[45, 19],     // 6
			[25, 28.5],   // 7
			[0, 28.5],    // 8
			[0, 22.5],    // 9
			[-6, 22.5],   //10
			[-6, 16.5],   //11
			[0, 16.5]     //12
		]);

		// Main mounting bolt hole
		translate([22.05, -2.9, -j]) 
		cylinder(h=PanelThickness+j+j, r=2, $fn=30);

        // Rear mount screw hole and nut retainer 
        translate([-1,11,PanelThickness/2]) rotate([0,90,0]) cylinder(r=1.6, h=13);
        translate([9,11,PanelThickness/2]) cube([2.8,5.8,PanelThickness+2],center=true);
        }
}


module XSideProbeMountBracket(extend = 0)
{
	translate([-SensorRadius-BracketThickness, 0, 0])
	difference()
	{
		union()
		{
			// Lower squared off part of bracket
			translate([0, 0, -extend])
			cube([SensorDiameter+BracketThickness*2, BracketThickness, SensorRadius+BracketThickness+extend]);
			intersection() 
			{
				// Outer boundary of the whole bracket
				cube([SensorDiameter+BracketThickness*2, BracketThickness, SensorDiameter+BracketThickness*2]);
				
				// Upper rounded part of bracket
				translate([SensorRadius+BracketThickness, 0, SensorRadius+BracketThickness]) 
				rotate([-90, 0, 0]) 
				cylinder(r = SensorRadius+BracketThickness, h = BracketThickness);
			}
		}
		
		
		// Cut a slot in the top of the clamp?
		if(ClampCut)
		{
			translate([SensorRadius+BracketThickness, BracketThickness+j, 0])
			rotate([90, 0, 0])
			linear_extrude(height=PanelThickness+j*2) 
			polygon(points=[
				[-SensorDiameter, 2*SensorDiameter+BracketThickness*2],
				[SensorDiameter, 2*SensorDiameter+BracketThickness*2],
				[0, (SensorDiameter*0.75)+BracketThickness]
			]);
		}

		// Cut the hole for the sensor
		translate([SensorRadius+BracketThickness, -j, SensorRadius+BracketThickness]) 
		rotate([-90, 0, 0]) 
		cylinder(r = SensorRadius, h = BracketThickness+j*2);
	}
}


module XSideSensorMount()
{
	difference()
	{
		union()
		{
			// Main body
			scale([-1, 1, 1])
			XSidePlate();
			
			// Supports
			translate([-15-BracketPosition, -5, +j])
			{
				translate([0, -14, 0])
				rotate([0, 180, 180])
				XSideProbeMountBracket(extend = PanelThickness);

				translate([0, -1, 0])
				rotate([0, 180, 0])
				XSideProbeMountBracket(extend = PanelThickness);
			}
		}
		
	}
}


translate([20, -12, 6.35])
rotate([180, 0, 0])
XSideSensorMount();

%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
