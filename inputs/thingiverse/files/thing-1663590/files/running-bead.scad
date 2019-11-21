//Author: Sometimes Cake
//Date: 5/11/2014
//Modified Date: 2/6/2016 - modified for customizer changes.

//Modified by Daniel K. Schneider 6/7/2016
// Added: Resolution and CutAway parameters
// Changed parameter names
// Changed the way the dimeions are computed

/* [Running/Walking] */
RunningDistance=5; //[2:100]
RunningDuration=25; //[10:600]
/* [Dimensions] */
CutAway=0.5; //[0.5,0.7,0.8,1,1.5,2,3,4]]
HoleDiameter=3; //[1:5]
ScaleFactor=1; //[0.5,1,1.5,2,2.5,3]

/* [Hidden] */
$fn = 100; //sets the smoothness of the whole
AverageSpeed = RunningDistance / RunningDuration * 60;
Resolution   = ln(AverageSpeed*AverageSpeed*AverageSpeed)*2.5;
BeadDiameter = log(RunningDuration)*10;  //One hour running is about 1.7cm bead
SkewFactor   = log(RunningDistance) ; // log10, so running 10km = 1

echo ("RunningDistance=", RunningDistance);
echo ("RunningDuration=", RunningDuration );
echo ("AverageSpeed=", AverageSpeed);
echo ("Resolution= ", Resolution );
echo ("BeadDiameter= ", BeadDiameter );
echo ("SkewFactor= ", SkewFactor );

scale ([ScaleFactor,ScaleFactor,ScaleFactor]) {
     difference() {
	  scale ([1,1,SkewFactor])
	       sphere (BeadDiameter/2, $fn=Resolution);
	  
	  // Dig the hole
	  translate([0,0,(BeadDiameter*3)*(-1)])
	  cylinder (BeadDiameter*6,HoleDiameter/2, HoleDiameter/2);
	  
	  // cut off a little bit on top to make it more printable
	  translate([0,0,SkewFactor*BeadDiameter/2-CutAway])
	  cylinder (BeadDiameter/2, BeadDiameter, BeadDiameter);
	  
	  // cut off a little bit at the bottom to make it more printable
	  # translate([0,0,-1*SkewFactor*BeadDiameter/2 - BeadDiameter/2 + CutAway])
	  cylinder (BeadDiameter/2, BeadDiameter, BeadDiameter);
     }
}
     

/* 
All size measurement are in mm. Running is in km's and minutes.
Runners do a km in 5-6 minutes. Fast ones in 7. Walkers need 12-15 minutes.
Marathon:
RunningDistance = 42.195;     //[4:100]
RunningDuration = 123;     //[15:600]
Typical Jogging:
RunningDistance = 10;     //[4:100]
RunningDuration = 60;     //[15:600]
*/
