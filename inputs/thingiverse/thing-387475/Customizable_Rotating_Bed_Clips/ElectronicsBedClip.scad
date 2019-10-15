/**
  * A basic clip for holding the bed underneath the kossel.
  **/
// How much 'roundness' do you want to the cylinders?
gQuality=200;

// What screw do you want to use to fasten this?
gMetricScrewSize=3;

// What is the diameter of the shaft used to bolt this down?
gShaftDiameter=12;

// How tall do we want the entire bed clip to be?
gShaftHeight=10;

// The lip that holds the electronics - how much of the shaft does it use?
gExposedLipHeight=3;

// How wide into the bed does the clip extend?
gExposedLipWidth=20;

// How thick should we make the remainder of the shaft to hold the spring?  This is useful for keeping the clamp tight against the frame.  You may need a washer against your screw.
gSpringDiameter=5;

module ScrewClearance(metricSize, height, center=false)
{
	cylinder(r=(metricSize*1.1)/2,h=height, center=center, $fn=gQuality);
}

difference()
{
	// The actual L clamp
	union()
	{
		cylinder(r=gShaftDiameter/2,h=gShaftHeight,center=true, $fn=gQuality);
		translate([-gExposedLipWidth/2,0,(-gShaftHeight+gExposedLipHeight)/2])
		cube([gExposedLipWidth,gShaftDiameter,gExposedLipHeight],center=true);
	}

	ScrewClearance(gMetricScrewSize, height=2000, center=true);
	translate([0,0,gExposedLipHeight])
	cylinder(r=gSpringDiameter/2, h=gShaftHeight,center=true, $fn=gQuality);
}

