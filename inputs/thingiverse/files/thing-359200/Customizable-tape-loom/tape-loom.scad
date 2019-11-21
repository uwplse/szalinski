//Tape loom
//By Johan Bengtsson qwerty_42@hotmail.com

/* [Basics] */

//the nymber of slits, number of holes will be numSlits+1 and maximum number of threads 2*numSlits+1
numSlits=10; 

//the hole diameter and slit width [mm], must be > 0
threadSize=2; 

//the height of each slit [mm]
slitHeight=50;

//thickness of the entire unit [mm]
thickness=4;


/* [Advanced] */

//the wall thickness between slits and holes [% of hole diameter], must be > 0
wallThickness=50;

//radius for all edges around the holes and slits [mm]
edgeRoundness=0.5;

//extra width of the frame, may be 0 for no extra width [mm]
frameWidth=3;

//extra height of the frame, may be 0 for no extra height [mm]
frameHeight=10; 


/* [Hidden] */

barWidth=threadSize*(1+wallThickness/50);

edgeDiameter=edgeRoundness*2;

preview_tab="a";

//makes the customizer preview faster than the final rendering by using lower quality
if (preview_tab=="")
	tape_loom($fa=5,$fs=.1);
else
	tape_loom($fa=5,$fs=.3);


module tape_loom()
{
	difference()
	{
		cube([(barWidth+threadSize)*numSlits+barWidth+frameWidth*2,slitHeight+(barWidth+frameHeight)*2,thickness],center=true);
		for (i=[0:numSlits])
		{
			translate([(i-numSlits/2)*(barWidth+threadSize),0,0])
			{
				rotate_extrude()
				intersection()
				{
					hole_2d();
					translate([0,-thickness,0]) square([threadSize,thickness*2]);
				}
			}
		}
		for (i=[1:numSlits])
		{
			translate([(i-numSlits/2-0.5)*(barWidth+threadSize),0,0])
			{
				translate([0,slitHeight/2-threadSize/2,0])
				rotate_extrude()
				intersection()
				{
					hole_2d();
					translate([0,-thickness,0]) square([threadSize,thickness*2]);
				}
				translate([0,-slitHeight/2+threadSize/2,0])
				rotate_extrude()
				intersection()
				{
					hole_2d();
					translate([0,-thickness,0]) square([threadSize,thickness*2]);
				}
				rotate([90,0,0]) linear_extrude(height=slitHeight-threadSize,center=true)
					hole_2d();
			}
			
		}
	}
}


module hole_2d()
{
	difference()
	{
		square([threadSize+edgeRoundness*2,thickness+1],center=true);
		translate([threadSize/2+edgeRoundness+1,0,0]) square([edgeRoundness*2+2,thickness-edgeDiameter],center=true);
		translate([-threadSize/2-edgeRoundness-1,0,0]) square([edgeRoundness*2+2,thickness-edgeDiameter],center=true);
		translate([threadSize/2+edgeRoundness,thickness/2-edgeRoundness,0]) circle(r=edgeRoundness);
		translate([threadSize/2+edgeRoundness,-thickness/2+edgeRoundness,0]) circle(r=edgeRoundness);
		translate([-threadSize/2-edgeRoundness,thickness/2-edgeRoundness,0]) circle(r=edgeRoundness);
		translate([-threadSize/2-edgeRoundness,-thickness/2+edgeRoundness,0]) circle(r=edgeRoundness);
	}
}