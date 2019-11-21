// Parametric Battery Power Supply
// Designed by Mike Creuzer thingiverse@creuzer.com 20130308




// The Width of the side that the contacts go on
BatteryWidth = 44;
// This very well may be the shorter side...
BatteryLength = 65;
// How thick the battery is
BatteryThickness = 5.4;

// How wide the nail shaft being used for the contact point is
PinThickness = 2;
// How wide the nail head being used for the contact point is
PinHeadThickness = 4;
// How thick the head of the nail being used for the contact point is
PinHeadDepth = .5;

// Center of pin to edge of battery block
Pin1DistanceFromEdge = 4;
// Center of pin to edge of battery block
Pin2DistanceFromEdge = 8;

// Size of hole to allow wire through the side of the battery
WireWidth = 2;
//WireDistanceFromEdge = 6;



// Build the box
difference()
{
	cube(size = [BatteryWidth, BatteryLength, BatteryThickness], center=true);
	cube(size = [BatteryWidth - BatteryThickness * 2, BatteryLength - BatteryThickness * 2, BatteryThickness + 1], center=true);
	WireHarness();
	InterfaceConnection();
}



module InterfaceConnection()
{
		translate([BatteryWidth * .5 - Pin1DistanceFromEdge, BatteryLength * .5,  0]) Pin();
		translate([BatteryWidth * .5 - Pin2DistanceFromEdge, BatteryLength * .5,  0]) Pin();
		
		hull() // Make sure this is room to solder the wires.
		{
			translate([BatteryWidth * .5 - Pin1DistanceFromEdge, BatteryLength * .5,  0]) PinElbowRoom();
			translate([BatteryWidth * .5 - Pin2DistanceFromEdge, BatteryLength * .5,  0]) PinElbowRoom();
		}
}


module Pin()
{
	translate([0, - (PinHeadDepth + BatteryThickness) * .5,  0]) union()
	{
	rotate([90,90,0]) cylinder(r = PinThickness * .5, h=BatteryThickness, center=true);
	translate([0, BatteryThickness * .5,  0]) rotate([90,90,0]) cylinder(r = PinHeadThickness * .5, h=PinHeadDepth, $fn=90, center=true);
	}
}

module PinElbowRoom()
{
	translate([0, - (BatteryLength- BatteryThickness) * .5,  0]) union()
	{
		translate([0, - BatteryThickness * .5,  0]) rotate([90,90,0]) cylinder(r = BatteryThickness * .5, h=BatteryLength - (2 * BatteryThickness ), center=true);
	}
}

module WireHarness()
{
	union() {
		rotate([90,0,0]) cylinder(r = WireWidth * .5, h=BatteryWidth + BatteryLength, center=true);
		rotate([0,90,0]) cylinder(r = WireWidth * .5, h=BatteryWidth + BatteryLength, center=true);
	}
}

