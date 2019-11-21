// Set the total width of the bottle opener
width = 40; //[30:50]
// Set the height of the opening
openingHeight = 15; //[5:30]
// Set the width of the openers frame
frameWidth = 5; //[3:10]
// Set the thickness of the frame of the opener
thickness = 2; //[2:10]
// Set the height of the neck of the opener
neckHeight = 20; //[15:30]
// Set the width of the neck of the opener
neckWidth = 10; //[5:15]
// Set the radius of the small cavity
smallPinCircle = 2.5; // 
// Set the height of the small cavity
smallPinLoc = 3; // 
// Set the radius of the big cavity
bigPinCircle = 5; //
// Set the height of the big cavity
bigPinLoc = 1.5; // 
// Set the radius of the grip
gripWidth = 7.5; // [5:15]
// Set the length of the grip
gripLength = 70; // [40:150]

/* [hidden] */

$fn = 50;

union()
{
	linear_extrude(height = thickness)
	union()
	{
		intersection()
		{
			difference()
			{
				translate([frameWidth*2,frameWidth*2,0])circle(frameWidth*2);
				translate([frameWidth*2,frameWidth*2,0])circle(frameWidth);
			}
			polygon(points = [ [0,0], [0, frameWidth*2], [frameWidth*2,frameWidth*2], [frameWidth*2,frameWidth], [frameWidth*2,0] ], paths = [[0,1,2,3,4]] );
		}
		polygon(points = [ [0,frameWidth*2], [frameWidth,frameWidth*2], [frameWidth*2,openingHeight+(frameWidth)], [frameWidth,openingHeight+(frameWidth)] ], paths = [[0,1,2,3]] );
		polygon(points = [ [frameWidth*2,0], [width-(frameWidth*2),0], [width-(frameWidth*2),frameWidth], [frameWidth*2,frameWidth] ], paths = [[0,1,2,3]] );
		intersection()
		{
			difference()
			{
				translate([width-frameWidth*2,frameWidth*2,0])circle(frameWidth*2);
				translate([width-frameWidth*2,frameWidth*2,0])circle(frameWidth);
			}
			polygon(points = [ [width,0], [width, frameWidth*2], [width-frameWidth*2,frameWidth*2], [width-frameWidth*2,frameWidth], [width-frameWidth*2,0] ], paths = [[0,1,2,3,4]] );
		}
		polygon(points = [ [width,frameWidth*2], [width-frameWidth,frameWidth*2], [width-frameWidth*2,openingHeight+(frameWidth)], [width-frameWidth,openingHeight+(frameWidth)] ], paths = [[0,1,2,3]] );
		difference()
		{
			polygon(points = [ [frameWidth,openingHeight+frameWidth], [width-frameWidth,openingHeight+frameWidth], [width/2+neckWidth/2,openingHeight+frameWidth+neckHeight], [width/2-neckWidth/2,openingHeight+frameWidth+neckHeight] ], paths = [[0,1,2,3]] );
			intersection()
			{
				translate([frameWidth*2+smallPinCircle,openingHeight+frameWidth-smallPinCircle/3,0])circle(smallPinCircle);
				polygon(points = [ [frameWidth,openingHeight+frameWidth], [width-frameWidth,openingHeight+frameWidth], [width/2+neckWidth/2,openingHeight+frameWidth+neckHeight], [width/2-neckWidth/2,openingHeight+frameWidth+neckHeight] ], paths = [[0,1,2,3]] );
			}
			intersection()
			{
				translate([width-frameWidth*2-smallPinCircle,openingHeight+frameWidth-smallPinCircle/smallPinLoc,0])circle(smallPinCircle);
				polygon(points = [ [frameWidth,openingHeight+frameWidth], [width-frameWidth,openingHeight+frameWidth], [width/2+neckWidth/2,openingHeight+frameWidth+neckHeight], [width/2-neckWidth/2,openingHeight+frameWidth+neckHeight] ], paths = [[0,1,2,3]] );
			}
			intersection()
			{
				translate([width/2,openingHeight+frameWidth-bigPinCircle/bigPinLoc,0])circle(bigPinCircle);
				polygon(points = [ [frameWidth,openingHeight+frameWidth], [width-frameWidth,openingHeight+frameWidth], [width/2+neckWidth/2,openingHeight+frameWidth+neckHeight], [width/2-neckWidth/2,openingHeight+frameWidth+neckHeight] ], paths = [[0,1,2,3]] );
			}
		}
	}
	translate([width/2,openingHeight+frameWidth+neckHeight,thickness/2])rotate(a=-90, v=[1,0,0])cylinder(h = gripLength, r = gripWidth);
}