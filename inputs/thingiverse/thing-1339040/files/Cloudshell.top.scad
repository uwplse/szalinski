// Cloudshell top cover mod
include <puzzlecutlib.scad>

stampSize = [500,500,100];//size of cutting stamp (should cover 1/2 of object)

cutSize = 4;	//size of the puzzle cuts

xCut1 = [-26,26 , -95];   //locations of puzzle cuts relative to X axis center
yCut1 = [-62,-7, 20, 40];	   //for Y axis

kerf = -0.1;	//supports +/- numbers (greater value = tighter fit)
				//using a small negative number may be useful to assure easy fit for 3d printing
				//using positive values useful for lasercutting
				//negative values can also help visualize cuts without seperating pieces

//cutInTwo();	//cuts in two along y axis

module drawCover()
{
    translate([60, 80, 0])
        linear_extrude(height = 3, center = true)
            import(file = "Cloudshell.top.dxf");
}

module sliceFirstQuarter()
{
  translate([6,-6,0])
    xMaleCut() yMaleCut() drawCover();
}

module sliceSecondQuarter()
{
  translate([-6,-6,0])
    xMaleCut() yFemaleCut() drawCover();
}

module sliceThirdQuarter()
{
  translate([6,6,0])
    xFemaleCut() yMaleCut() drawCover();
}

module sliceFourthQuarter()
{
  translate([-6,6,0])
    xFemaleCut() yFemaleCut() drawCover();
}

module cutInFour()
{
	translate([6,-6,0])
		xMaleCut() yMaleCut() drawCover();

	translate([-6,-6,0])
		xMaleCut() yFemaleCut() drawCover();

	translate([6,6,0])
		xFemaleCut() yMaleCut() drawCover();

	translate([-6,6,0])
		xFemaleCut() yFemaleCut() drawCover();
}

module cutInTwo()
{
	translate([5,0,0])
		yMaleCut() drawCover();

	translate([-5,0,0])
		yFemaleCut() drawCover();
}

module sliceFirstHalf()
{
    translate([0,-6,0])
        xMaleCut() drawCover();
}

module sliceSecondHalf()
{
    translate([0,0,0])
		  xFemaleCut() drawCover();
}

//sliceFirstHalf();
//sliceSecondHalf();

//rotate([90, 270, 0])
  sliceFirstQuarter();
  sliceSecondQuarter();
  sliceThirdQuarter();
  sliceFourthQuarter();
