//Config values
/* [Layout] */
//How many cans fit on the bottom row
NumberOfCansOnBottom = 4;
//How thick should it be between the cans (in mm)
DividerThickness = 5;
//How deep should it be along the height of the can (in mm)
DividerDepth = 60;  //Full can height is 121.92


BetweenCanShape = 1; //[0:square edges, 1:smooth curve, 2:faceted curve]


/* [Details] */
//Some other can size? (in mm)
CanRadius = 31.75;





//######## Between Can Options
//VERSION0 is flat surfaces
VERSION0 = BetweenCanShape == 0;
//VERSION1 is smooth curves, same size as cans
VERSION1 = BetweenCanShape == 1;
//VERSION2 is faceted curves, same size as cans, see facetCurveCount to adjust
VERSION2 = BetweenCanShape == 2;
//#####End Between Can Options


//Height of square edges option
SquareEdgesHeight = 10;

//THESE OPTIONS WORK PRETTY WELL
//Faceted curve number
facetCurveCount = 18; //[10, 12, 18, 24]


//######## End Options

//Version 0 has edges that extend past the can
//Version 1 has edges that touch the can
ENDS_VERSION = 1;  //[0:extend past can, 1:edges stop at can]]
//#####End End Options


//###### applying option calculations
retainThickness = VERSION0 ? SquareEdgesHeight/2 : DividerThickness/2;
moveShitOver = [
			//Version 0:
			0,
			//Verison 1:
			VERSION0
				?	CanRadius-sqrt(((CanRadius-retainThickness)*(CanRadius-retainThickness))
					+(CanRadius*CanRadius))
				: -CanRadius * sin(60) / 2 - retainThickness
			];
width = NumberOfCansOnBottom * CanRadius * 2
				+ moveShitOver[ENDS_VERSION]*2;


/* [Smoothness] */
$fn = 100;
/* [Hidden] */
OVERLAP=0.1;

////Setup
//canCenters = [for (i = [0:NumberOfCansOnBottom])
//{
//	
//}
//];


CombineAll();

module CombineAll()
{
	difference()
	{
		//Positive
		union()
		{
			if (VERSION0) {
				MainPiece(SquareEdgesHeight);
			}


			if (VERSION1) {
				assign (offset = CanRadius * sin(60) / 2)
				{
				intersection()
				{
					translate(v=[0, offset, 0])
						MainPiece(CanRadius);
					AllCanShapes(-DividerThickness, bottom = false, overlap = false);
				}
				intersection()
				{
					translate(v=[0, -offset, 0])
						MainPiece(CanRadius);
					AllCanShapes(-DividerThickness, top = false, overlap = false);
				}
				}
			}


			if (VERSION2) {
				assign (offset = CanRadius * sin(60) / 2)
				intersection()
				{
					translate(v=[0, offset, 0])
						MainPiece(CanRadius);
					AllCanShapes(-DividerThickness, bottom = false, overlap = false, $fn = facetCurveCount);
				}
				intersection()
				{
					translate(v=[0, -offset, 0])
						MainPiece(CanRadius);
					AllCanShapes(-DividerThickness, top = false, overlap = false, $fn = facetCurveCount);
				}
			}
		}
		
		//Negative
		union()
		{
			AllCanShapes(DividerThickness);
		}
	}
}

module AllCanShapes(thicknessToRetain, bottom = true, top = true, overlap = true)
{
	translate(v = [moveShitOver[ENDS_VERSION], 0, 0])
		AllCanShapes_Version0(thicknessToRetain, bottom, top, overlap = overlap);
}
module AllCanShapes_Version0(thicknessToRetain, bottom = true, top = true, overlap = true)
{
	retain = thicknessToRetain/2;

	if (top)
		CanShapes([CanRadius, -CanRadius * sin(60) - retain, 0], NumberOfCansOnBottom, overlap = overlap);
	if (bottom)
		CanShapes([CanRadius*2, CanRadius * sin(60) + retain, 0], NumberOfCansOnBottom-1, overlap = overlap);
}


module MainPiece(height)
{
	difference()
	{
		//Positive
		union()
		{
			translate(v=[0, -height/2, 0])
				cube(size = [width, height, DividerDepth]);
		}
		
		//Negative
		union()
		{
		}
	}
}

module CanShapes(v, number, overlap = true)
{
	difference()
	{
		//Positive
		union()
		{
			translate(v=v){
				for (i = [0:number-1]) {
					translate(v=[i*2*CanRadius, 0, overlap ? -OVERLAP : 0])
						cylinder(h=DividerDepth + (overlap ? 2*OVERLAP : 0), r=CanRadius);
				}
			}
		}
		
		//Negative
		union()
		{
		}
	}
}
