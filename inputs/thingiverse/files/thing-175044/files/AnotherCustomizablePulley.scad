// Another Customizable Pulley
// by Hari Wiguna, Oct 2013

// Total thickness of the whole pulley
PulleyHeight = 10; 

// Center to pulley surface
PulleyRadius = 11; 

// From pulley surface to rim surface
RimHeight = 5; 

// How wide are the rims
RimWidth = 1;

ValleyWidth = RimHeight/2; // Set to RimHeight for a 45 degree valley
PulleySurface = PulleyHeight - (2*RimWidth) - (2*ValleyWidth);
RimRadius = PulleyRadius + RimHeight;

// Hole size
HoleDiameter = 2.96;

// Adjust for best fit. Smaller = tighter fit
HoleClearance = 0.1;

HoleRadius = (HoleDiameter / 2) + HoleClearance;

// Number of segments (higher = smoother)
$fn=180;	

rotate_extrude(convexity = 10)
	Silhuette();

module Silhuette()
{
	polygon( points=[
		[HoleRadius,0],
		[RimRadius,0],
		[RimRadius,RimWidth],
		[PulleyRadius,RimWidth+ValleyWidth],
		[PulleyRadius,RimWidth+ValleyWidth+PulleySurface],
		[RimRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth],
		[RimRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth+RimWidth],
		[HoleRadius,RimWidth+ValleyWidth+PulleySurface+ValleyWidth+RimWidth],
		[HoleRadius,0]] );
}