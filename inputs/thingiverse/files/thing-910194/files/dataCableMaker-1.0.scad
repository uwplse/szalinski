// Customize by adjusting the following variables
// All measurements in mm
// preview[view:north west, tilt:top]

/* [Header Shell] */

// The number of pins you want your cable shell to accommodate per column.
pins=8;

// Single (e.g. arduino uno) or Double column (arduino mega or beagleboard).
doubleColumn=0; //[0:Single Column, 1:Double Column]

// Choose whether wire separators (a wall between each conductor) will be printed. NOTE: Cura might not print the walls, check your layer view.  If Cura won't print the walls, I've found that slic3r and pronterface will.
wireSeparators=1; //[1:With Separators, 0:No Separators]

// Desired height of the header shell body.  ALL MEASUREMENTS ARE "mm"
height=10;

// Desired thickness of the shell walls.
wallThickness=1;

// MEASURED thickness of the plastic bar in the male header or plastic shell in the female header, assumed to be square for each wire (typical value is 2.5mm)
header=2.5;

//Typical female headers (for socket) require an extra mm in Y.  This accounts for that.
type=0; //[0:Plug, 1:Socket]

// Include an orientation indicator bump (automatically appears on correct shell, header or strain relief).
indicatorBump=1; //[1:With Indicator,0:Without Indicator]

// Orientation indicator position.  Choosing right or left will select which way the indicator faces.
indicatorSide=1; //[1:Rightward Orientation,0:Leftward Orientation]

// We need to account for nozzle diameter.  Enter the value for your printer here.  
nozzleDiameter=0.5;

/* [Strain Relief Shell] */

// Choose whether to include a separate strain relief shell.
strainRelief=1; //[1:Include Strain Relief Shell,0:No Strain Relief Shell]

// Enter desired radius for the exit hole from the strain relief shell.  Cat5 is generally 2.5 - 3 mm radius.  
cableRadius=2.85;

// Desired height of the strain relief shell.
strainHeight=20;

// Adjustment factors to perfect the fit between the strain relief shell and the header shell.  Lower numbers decrease the size of the inner cut (tighten), larger numbers increase the size of the inner cut (loosen).  Experiment until it is just right. 
cutAdjustmentX=-0.2;
cutAdjustmentY=-0.2;


/* [Hidden] */
//==== Don’t edit after this unless you want to change the way the script works ====
//==== basic calculations ==========================================================


outerBodyX=(2*wallThickness)+header+nozzleDiameter;
outerBodyY=(2*wallThickness)+(header*pins)+nozzleDiameter;
outerBodyZ=height;
innerBodyX=outerBodyX-(2*wallThickness);
innerBodyY=outerBodyY-(2*wallThickness);
innerBodyZ=height+2;

doubleOuterBodyX=(2*wallThickness)+(2*header)+nozzleDiameter;
doubleInnerBodyX=doubleOuterBodyX-(2*wallThickness);

innerCutTranslateX=wallThickness;
innerCutTranslateY=wallThickness;
innerCutTranslateZ=-1;

orientationIndicatorX=1;
orientationIndicatorY=2;
orientationIndicatorZ=height/2;

outerHullX=outerBodyX+(2*wallThickness)+(2*nozzleDiameter);
outerHullY=outerBodyY+(2*wallThickness)+(2*nozzleDiameter);
outerHullZ=orientationIndicatorZ;
innerHullX=outerBodyX+(2*nozzleDiameter);
innerHullY=outerBodyY+(2*nozzleDiameter);
innerHullZ=outerHullZ;

doubleOuterHullX=doubleOuterBodyX+(2*wallThickness)+(2*nozzleDiameter);
doubleInnerHullX=doubleOuterBodyX+(2*nozzleDiameter);

//==== the object ==================================================================

finalAssembly();

// draw main body
module mainBody()
{
	
	difference()
	{
		cube ([outerBodyX, outerBodyY+type, outerBodyZ]);
		translate([innerCutTranslateX, (innerCutTranslateY), innerCutTranslateZ]) 
		{
			cube ([innerBodyX, innerBodyY+type, innerBodyZ]);
		}
	}
}

// draw main body -- double column of pins
module mainBodyDouble()
{
	difference()
	{
		cube ([doubleOuterBodyX, outerBodyY+type, outerBodyZ]);
		translate([innerCutTranslateX, innerCutTranslateY, innerCutTranslateZ]) 
		{
			cube ([doubleInnerBodyX, innerBodyY+type, innerBodyZ]);
		}
	}
}

// orientation indicator on header shell (no strain relief)
module orientationIndicatorBump()
{
	if (indicatorBump==1)
	{
		color ("coral")
		{
			if (indicatorSide==1)
			{
				// orientation indicator bump
				translate([(orientationIndicatorX*-1), (outerBodyY-orientationIndicatorY), 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			} else {
						// orientation indicator bump
				translate([(orientationIndicatorX*-1), 0, 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			}
		}
	}
}

// orientation indicator on strain relief shell
module orientationIndicatorBumpStrainRelief()
{
	if (indicatorBump==1)
	{
		color ("coral")
		{
			if (indicatorSide==1 && doubleColumn==0)
			{
				translate([((outerBodyX+cableRadius)+(orientationIndicatorX*-1)), (outerHullY-orientationIndicatorY+type), 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			}


			if (indicatorSide==0 && doubleColumn==0)
			{
				translate([((outerBodyX+cableRadius)+(orientationIndicatorX*-1)), type, 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			}

			if (indicatorSide==1 && doubleColumn==1)
			{
				translate([((outerBodyX+cableRadius+header)+(orientationIndicatorX*-1)), (outerHullY-orientationIndicatorY+type), 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			}


			if (indicatorSide==0 && doubleColumn==1)
			{
				translate([((outerBodyX+cableRadius+header)+(orientationIndicatorX*-1)), type, 0])
				{
					cube([orientationIndicatorX, orientationIndicatorY, orientationIndicatorZ]);
				}
			}
		}
	}
}

// if no wireseparators printed, the bar keeps the header in correct position
// single column version
module blockingBar()
{
	// internal blocking bar for lodging/glueing the header against
	translate([wallThickness, 0, 0])
	{
		color ("gold") cube([(innerBodyX/4), (outerBodyY+type), (outerBodyZ-header)]);
	}
}

// double column version of blocking bar
module blockingBarDouble()
{
	// internal blocking bar for lodging/glueing the header against
	translate([(wallThickness+innerBodyX-nozzleDiameter), 0, 0])
	{
		color ("gold") cube([(innerBodyX/4), (outerBodyY+type), (outerBodyZ-header)]);
	}
}

//wire Separators
module wireSeparators()
{
	start=wallThickness+(type/2);
	increment=header;
	end=outerBodyY-nozzleDiameter;

	for (wall=[start:increment:end] )
	{
		translate([0, wall, 0]){color("Orchid") cube([outerBodyX, nozzleDiameter, (outerBodyZ-header)], center=false);}
	}

}

//wire Separators -- double column of pins
module wireSeparatorsDouble()
{
	start=wallThickness+(type/2);
	increment=header;
	end=outerBodyY-nozzleDiameter;

	union()
	{
		for (wall=[start:increment:end] )
		{
			translate([0, wall, 0]){color("Orchid") cube([doubleOuterBodyX, nozzleDiameter, (outerBodyZ-header)], center=false);}
		}
		translate([((doubleOuterBodyX-nozzleDiameter)/2),0,0]){color("Orchid") cube([nozzleDiameter, outerBodyY, (outerBodyZ-header)], center=false);}
	}
}

// Strain relief shell -- single column
module strainReliefShell()
{
	//move to the side of the header shell
	translate([(outerBodyX+cableRadius),0,0]) 
	{
		difference()
		{
			union()
			{	
				hull() 
				{
					translate([0,0,0]) cube([outerHullX,outerHullY+type,outerHullZ]);
					translate([(outerHullX/2),(outerHullY/2)+(type/2),(strainHeight-3)]) cylinder(r=(cableRadius+wallThickness+nozzleDiameter),h=1);
				}
				translate([(outerHullX/2),(outerHullY/2)+(type/2),0]) cylinder(r=(cableRadius+wallThickness+nozzleDiameter),h=strainHeight);

			}

			union()
			{	
				translate([(wallThickness-cutAdjustmentX),(wallThickness-cutAdjustmentY),-1]) cube([(innerHullX+(2*cutAdjustmentX)),(innerHullY+(2*cutAdjustmentY)+type),(innerHullZ)]);
				hull() 
				{
					translate([(wallThickness-cutAdjustmentX),(wallThickness-cutAdjustmentY),(innerHullZ-2)]) cube([(innerHullX+(2*cutAdjustmentX)),(innerHullY+(2*cutAdjustmentY)+type),1]);
					translate([(wallThickness+(innerHullX/2)),(wallThickness+(innerHullY/2)+(type/2)),(strainHeight-4)]) cylinder(r=(cableRadius+nozzleDiameter),h=1);
				}
				translate([(wallThickness+(innerHullX/2)),(wallThickness+(innerHullY/2)+(type/2)),strainHeight-4]) cylinder(r=(cableRadius+nozzleDiameter),h=strainHeight);
			}
		}
	}
}

// Strain relief shell -- double column
module strainReliefShellDouble()
{
	//move to the side of the header shell
	translate([(doubleOuterBodyX+cableRadius),0,0]) 
	{
		difference()
		{
			union()
			{	
				hull() 
				{
					translate([0,0,0]) cube([doubleOuterHullX,outerHullY+type,outerHullZ]);
					translate([(doubleOuterHullX/2),(outerHullY/2)+(type/2),(strainHeight-3)]) cylinder(r=(cableRadius+wallThickness+nozzleDiameter),h=1);
				}
				translate([(doubleOuterHullX/2),(outerHullY/2)+(type/2),0]) cylinder(r=(cableRadius+wallThickness+nozzleDiameter),h=strainHeight);
			}

			union()
			{	
				translate([(wallThickness-cutAdjustmentX),(wallThickness-cutAdjustmentY),-1]) cube([(doubleInnerHullX+(2*cutAdjustmentX)),(innerHullY+(2*cutAdjustmentY)+type),innerHullZ]);
				hull() 
				{
					translate([(wallThickness-cutAdjustmentX),(wallThickness-cutAdjustmentY),(innerHullZ-2)]) cube([(doubleInnerHullX+(2*cutAdjustmentX)),(innerHullY+(2*cutAdjustmentY)+type),1]);
					translate([(wallThickness+(doubleInnerHullX/2)),(wallThickness+(innerHullY/2)+(type/2)),(strainHeight-4)]) cylinder(r=(cableRadius+nozzleDiameter),h=1);
				}
				translate([(wallThickness+(doubleInnerHullX/2)),(wallThickness+(innerHullY/2)+(type/2)),(strainHeight-4)]) cylinder(r=(cableRadius+nozzleDiameter),h=strainHeight);
			}
		}
	}
}

// put the parts together
module finalAssembly()
{
	if (wireSeparators==0 && strainRelief==0 && doubleColumn==0)
	{
		union()
		{
			mainBody();
			blockingBar();
			orientationIndicatorBump();
		}
	}
	
	if (wireSeparators==1 && strainRelief==0 && doubleColumn==0)
	{
		union()
		{
			mainBody();
			orientationIndicatorBump();
			wireSeparators();
		}
	}
	
	if (wireSeparators==0 && strainRelief==1 && doubleColumn==0)
	{
		union()
		{
			mainBody();
			blockingBar();
			strainReliefShell();
			orientationIndicatorBumpStrainRelief();

		}
	}
	
	if (wireSeparators==1 && strainRelief==1 && doubleColumn==0)
	{
		union()
		{
			mainBody();
			wireSeparators();
			strainReliefShell();
			orientationIndicatorBumpStrainRelief();
		}
	}
	
	if (wireSeparators==0 && strainRelief==0 && doubleColumn==1)
	{
		union()
		{
			mainBodyDouble();
			blockingBar();
			blockingBarDouble();
			orientationIndicatorBump();
		}
	}
	
	if (wireSeparators==1 && strainRelief==0 && doubleColumn==1)
	{
		union()
		{
			mainBodyDouble();
			orientationIndicatorBump();
			wireSeparatorsDouble();
		}
	}
	
	if (wireSeparators==0 && strainRelief==1 && doubleColumn==1)
	{
		union()
		{
			mainBodyDouble();
			blockingBar();
			blockingBarDouble();
			strainReliefShellDouble();
			orientationIndicatorBumpStrainRelief();
		}
	}
	
	if (wireSeparators==1 && strainRelief==1 && doubleColumn==1)
	{
		union()
		{
			mainBodyDouble();
			wireSeparatorsDouble();
			strainReliefShellDouble();
			orientationIndicatorBumpStrainRelief();
		}
	}
	
}

