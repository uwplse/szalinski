// @pabile 20180511
// U bracket openscad parametric customizeable customizer

// @asermar remix 20180515
// Added function Drills for evently distribute drills along uwidth every holeSpace distance

uthick = 5; // bracket thickness
ulength = 25; // thickness of thing to insert inside bracket
uwidth = 150; // width of bracket arm;
udepth = 25; // height of bracket arm
screwhole = 3; // radius
driverhole = 5; // radius 

holeSpace = 25; // space between 2 holes.

module bracket()
{
	difference()
	{
		minkowski()
		{
			cube (size = [((uthick*2)+ulength)-2,uwidth-2,udepth+uthick-2]);
			sphere(1);
		}

		translate ([uthick-1,-2,uthick])
		{
			cube (size = [ulength,uwidth+1,udepth]);
		}
	}
}

// drillLenght, drillCount, drillActual
// Evently distribute drills along a space
// dL (dillLenght) = Space where the drills will be spaced
// dC (drillCount) = Number of drills to place
// dA (drillActual) = Number of the drill which coordinates I need just now
function Drills(dL, dC, dA) = (dL / (dC )) * (dA + 1);

difference() {
	bracket();
	// how many holes
	holes = uwidth / holeSpace;
	if (holes <= 1)
	{
		// The size of the pices is less than holeSpace, so only 1 hole, at middle
		// screw hole
		translate ([0,(uwidth/2)-1,(udepth/2)+(uthick/2)]) 
		{
			rotate (a=[0,90,0])
				cylinder (uthick*2,screwhole,screwhole,center=true,$fn=200);
		}

		// driver hole
		translate ([uthick-2,(uwidth/2)-1,(udepth/2)+(uthick/2)])
		{
			rotate (a=[0,90,0]) 
				cylinder (ulength*2,driverhole,driverhole,center=false,$fn=200);
		}
	}
	else
	{
		for (i=[0:holes - 2])
		{
			translate ([0,Drills(uwidth, holes, i),(udepth/2)+(uthick/2)]) 
			{
				rotate (a=[0,90,0])
					cylinder (uthick*2,screwhole,screwhole,center=true,$fn=200);
			}
			// driver hole
			translate ([uthick-2,Drills(uwidth, holes, i),(udepth/2)+(uthick/2)])
			{
				rotate (a=[0,90,0]) 
					cylinder (ulength*2,driverhole,driverhole,center=false,$fn=200);
			}
		}
	}
}

