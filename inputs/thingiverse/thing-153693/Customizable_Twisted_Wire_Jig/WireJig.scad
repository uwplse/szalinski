// preview[view:north, tilt:top]

center = 0; //[0:No Center, 1:Center]
wireRad = 1;
jigRad = 7.5;
jigHeight=30;
numStrand = 3; //[3:20]
// Smoothness of the stl
$fn=50;

difference()
{
	cylinder(h=jigHeight, r=jigRad);

	union()
	{
		for (i=[1:1:numStrand])
		{
			if (center)
			{
				rotate([-atan((jigRad-(wireRad/(sin(180/numStrand))+wireRad*(1-cos(180/numStrand))))/jigHeight),0,i*360/numStrand])
				translate([0,wireRad/(sin(180/numStrand))+wireRad*(1-cos(180/numStrand)),0])
				cylinder(h=jigHeight*4, r=wireRad, center=false);
			}
			else
			{
				rotate([-atan((jigRad-(wireRad/(cos(180/numStrand))))/jigHeight),0,i*360/numStrand])
				translate([0,wireRad/(sin(180/numStrand)),0])
				cylinder(h=jigHeight*4, r=wireRad, center=false);
			}
		}
		if (center)
		{
			cylinder(h=jigHeight*4, r=wireRad, center=true);
		}
	}
}