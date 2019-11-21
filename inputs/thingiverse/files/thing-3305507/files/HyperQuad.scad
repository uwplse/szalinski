selectedPart = "Arm"; // [Arm,TopCenterPlate,BottomCenterPlate,Leg,Foot,CameraMount,Assembly,ExplodedView]



/* [Hidden] */
eps = 0.01;
bigSize = 1000;


// printability corrections; values should be zero for real object dimensions
USE_PRINT_CORRECTIONS = true;
correction_rNutHoleFC = USE_PRINT_CORRECTIONS ? 0.2 : 0.0;
correction_rNutHoleSC = USE_PRINT_CORRECTIONS ? 0.1 : 0.0;


// for final render choose higher number
fnFactor = 30; //10; //30;


// generic fillet
rFillet = 3.0/2;


// view mode
V_ASSEMBLY = 1;
V_EXPLODED_VIEW = 2;


// exploded view
offsetExplodedView = 10.0;


// generic clearance
clearance = 3.0;


// arrow
lArrow = 10.0;
wArrow = 13.0;
oArrow = 2.0;
rArrow = 1.0;


// battery strap
wBatteryStrap = 15.0;


// screw properties
rScrewHoleM3 = 3.2/2;
rScrewHoleHeadM3 = 6.5/2;
rKnurlNutM3 = 3.9/2;
lKnurlNutM3 = 4.5;
hNutM3 = 2.3;
rNutM3 = 6.1/2;
hClearanceNutM3 = 0.4;
rClearanceNutM3 = 0.3;
screwHoleFlesh = 2.0*rScrewHoleM3;


// knurl nut usage (true=KnurlNuts, false=M3Nuts)
useKnurlNutsForArm = false;
useKnurlNutsForFC = false;


/* [Motor] */
//(Turnigy D2206-2300KV)
rMotor = 14.0;
hMotor = 19.5; 
rMotorMountScrew = rScrewHoleM3;
distMotorMountHoles1 = 19.0;
distMotorMountHoles2 = 16.0;
rRotor = 4.45;
clearanceRotorHole = 0.5;
rMotorCable = 2.0/2;


/* [Flight Controller] */
distanceFCHoles = 30.5;
rFCHole = rScrewHoleM3;
depthFCNutHole = 2.0;


/* [Power Distribution Board] */
pdbOffsetXT60 = 30.0;
pdbWidthXT60 = 8.0;
pdbLengthXT60 = 16.0;
pdbThickness = 4.0;


/* [FPV] */
distanceFPVHoles = 10.0;
rFPVScrewHole = 1.25;
heightCamera = 30.0;
extensionCameraMount = 20.0;


/* [Speed Controller] */
distanceSCHoles = 20.0;
rSCScrewHole = 1.1;
rSCNut = 2.4;
depthSCNutHole = 2.0;


/* [Quadcopter] */
sizeQuad = 350;
tMotorHolder = 6.0;
hCenterSpace = 22; // increase to get more space 
tCenterPlate = 4.0;
extraWidthCenterPlate = 0; // increase to get more space 
extraWidthArm = 10.0;
armFlesh = 3.0;
tLegPlate = 3.0;
lLeg = 70.0;
lLegFoot = 8.0;
rLegFoot = 4.0;
offsetLegFoot = 55;
rFoot = 12;
hFootCutOff = 0.4*rFoot;



// handy variables
rMotorHolderOuter = (max(distMotorMountHoles1,distMotorMountHoles2)+2*screwHoleFlesh)/2;
rFC = sqrt(2)*distanceFCHoles/2+rFCHole+rScrewHoleM3;
knurlNutFlesh = max(rScrewHoleHeadM3,screwHoleFlesh);
distanceArmHoles = 2*rMotorHolderOuter+extraWidthArm-2*(knurlNutFlesh+rKnurlNutM3);
xCenterOffsetArmHole1 = rFC+clearance+screwHoleFlesh+rScrewHoleM3+extraWidthCenterPlate/2;
xCenterOffsetArmHole2 = xCenterOffsetArmHole1+distanceArmHoles/2*tan(60);
yCenterOffsetArmHole2 = distanceArmHoles/2;
lBissectriceTriangle = distanceArmHoles*1/2*sqrt(3);
rInnerTriangle = distanceArmHoles*1/6*sqrt(3);
xCenterOffsetTriangle = xCenterOffsetArmHole1+lBissectriceTriangle-rInnerTriangle;
rArmHoleOuter = rKnurlNutM3+knurlNutFlesh;
xCenterOffsetMotorHolder = sizeQuad/2-rMotorHolderOuter;
distanceCenterTriangleToArmEnd = sizeQuad/2-xCenterOffsetTriangle-2*rMotorHolderOuter;
xStartFancyModule = xCenterOffsetArmHole2+knurlNutFlesh+rKnurlNutM3;
lengthModuleSpace = xCenterOffsetMotorHolder-rMotorHolderOuter-xStartFancyModule;
echo("lengthModuleSpace",lengthModuleSpace);
avgSideLengthModuleTriangle = (rMotorHolderOuter+extraWidthArm+extraWidthArm)/2 - 2*armFlesh;
lengthBissectriceModuleTriangle = avgSideLengthModuleTriangle*1/2*sqrt(3);
lengthModule = 2*armFlesh+2*lengthBissectriceModuleTriangle;
echo("lengthModule",lengthModule);
nrOfModules = round(lengthModuleSpace/lengthModule);
echo("nrOfModules",nrOfModules);
correctedLengthModule = lengthModuleSpace/nrOfModules;
echo("correctedLengthModule",correctedLengthModule);
correctedLengthBissectriceModuleTriangle = (correctedLengthModule-2*armFlesh)/2;
angleLeg = atan(offsetLegFoot/lLeg);




module drawBox(width,height,thickness,radiusCorner)
{
	translate([radiusCorner,radiusCorner,0]) minkowski()
	{
		cube([width-2*radiusCorner,height-2*radiusCorner,thickness/2]);
		cylinder(thickness/2,radiusCorner,radiusCorner, $fn=50);
	}
}


module drawArrowHole()
{
	translate([0,0,-bigSize/2]) cylinder(bigSize,rArrow,rArrow,$fn=50);
}


module drawArrow()
{
	hull()
	{
		translate([-lArrow/2,0,0]) drawArrowHole();
		translate([0,wArrow/2,0]) drawArrowHole();
		translate([-oArrow,0,0]) drawArrowHole();
	}
	hull()
	{
		translate([-lArrow/2,0,0]) drawArrowHole();
		translate([-oArrow,0,0]) drawArrowHole();
		translate([0,-wArrow/2,0]) drawArrowHole();
	}
}


module drawFilletHole(prmLength=bigSize)
{
	translate([0,0,-eps]) cylinder(prmLength,rFillet,rFillet,$fn=50);
}


module drawSlotHole(prmLength)
{
	hull()
	{
		translate([-prmLength/2+rFillet,0,0]) drawFilletHole(tCenterPlate+2*eps);
		translate([prmLength/2-rFillet,0,0]) drawFilletHole(tCenterPlate+2*eps);
	}
}


module drawScrewHole()
{
	cylinder(bigSize,rScrewHoleM3,rScrewHoleM3,true,$fn=50);
}


module drawScrewHoleHead()
{
	cylinder(bigSize,rScrewHoleHeadM3,rScrewHoleHeadM3,$fn=50);
}


module drawMotorMountScrewHole()
{
	translate([0,0,-eps]) cylinder(tMotorHolder+2*eps,rMotorMountScrew,rMotorMountScrew,$fn=50);
}


module drawFPVScrewHole()
{
	cylinder(bigSize,rFPVScrewHole,rFPVScrewHole,true,$fn=50);
}


module drawKnurlNutHole(prmLength)
{
	translate([0,0,-eps]) cylinder(prmLength+2*eps,rKnurlNutM3,rKnurlNutM3,$fn=50);
}


module drawM3NutHole()
{
	r = rNutM3+rClearanceNutM3;
	h = hNutM3+hClearanceNutM3;	
	hull()
	{
		cylinder(h,r,r,$fn=6);
		translate([4*r,0,0]) cylinder(h,r,r,$fn=6);
	}
}


module drawFCMount()
{
	for (angle=[0:90:270])
	{
		rotate([0,0,angle]) translate([distanceFCHoles/2,distanceFCHoles/2,0]) 
		{
			drawScrewHole();
			translate([0,0,tCenterPlate-depthFCNutHole]) rotate([0,0,-45]) cylinder(bigSize,rNutM3+correction_rNutHoleFC,rNutM3+correction_rNutHoleFC,$fn=6);
		}
	}
}


module drawSCMount()
{
	for (angle=[0:90:270])
	{
		rotate([0,0,angle]) translate([distanceSCHoles/2,distanceSCHoles/2,0]) 
		{
			translate([0,0,-eps]) cylinder(bigSize,rSCScrewHole,rSCScrewHole,true,$fn=50);
			translate([0,0,tCenterPlate-depthSCNutHole]) rotate([0,0,-45]) cylinder(bigSize,rSCNut+correction_rNutHoleSC,rSCNut+correction_rNutHoleSC,$fn=6);
		}
	}
}


module drawXT60()
{
	w = pdbWidthXT60+rFillet;
	l = pdbLengthXT60+rFillet;
	translate([-w/2,-l/2,-eps]) drawBox(w,l,tCenterPlate+2*eps,rFillet);
}


module drawMotorMountFancyHole()
{
	r = (rMotorHolderOuter+rRotor)/2;
	offsetY = rFillet;
	hull()
	{
		translate([r,-offsetY,0]) drawFilletHole(tMotorHolder+2*eps);
		translate([r,offsetY,0]) drawFilletHole(tMotorHolder+2*eps);
	}
}


module drawMotorMountHoles()
{
	offset1 = distMotorMountHoles1/2*cos(45);
	translate([-offset1,offset1,0]) drawMotorMountScrewHole();
	translate([offset1,-offset1,0]) drawMotorMountScrewHole();

	offset2 = distMotorMountHoles2/2*cos(45);
	translate([offset2,offset2,0]) drawMotorMountScrewHole();
	translate([-offset2,-offset2,0]) drawMotorMountScrewHole();

	translate([0,0,-eps]) cylinder(tMotorHolder+2*eps,rRotor+clearanceRotorHole,rRotor+clearanceRotorHole,$fn=2*fnFactor);
	for (angle=[0:90:270])
	{
		rotate([0,0,angle]) drawMotorMountFancyHole();
	}
}


module drawArmTriangleFancyHole()
{
	r = (hCenterSpace-2*screwHoleFlesh)/2;
	rMin = 2*rMotorCable;
	translate([0,0,screwHoleFlesh+r]) rotate([0,90,0]) cylinder(0.6*lBissectriceTriangle+armFlesh/2,r,r,$fn=4*fnFactor);
}


function getArmWidth(prmXPos) = -extraWidthArm/lengthModuleSpace*prmXPos + 2*rMotorHolderOuter+extraWidthArm;


function getArmHeight(prmXPos) = (tMotorHolder-hCenterSpace)/lengthModuleSpace*prmXPos+hCenterSpace;


module drawLeftModuleTriangle(prmXPos)
{
	xOffset1 = armFlesh/2+rFillet;
	xOffset2 = armFlesh/2+correctedLengthBissectriceModuleTriangle-rFillet;
	yOffset = getArmWidth(prmXPos+xOffset2)/2-armFlesh-rFillet;
	hull()
	{
		translate([xOffset1,yOffset,0]) drawFilletHole();
		translate([xOffset1,-yOffset,0]) drawFilletHole();
		translate([xOffset2,0,0]) drawFilletHole();
	}
}


module drawRightModuleTriangle(prmXPos)
{
	xOffset1 = correctedLengthModule-armFlesh/2-rFillet;
	xOffset2 = correctedLengthModule-correctedLengthBissectriceModuleTriangle-armFlesh/2+rFillet;
	yOffset = getArmWidth(prmXPos+xOffset2)/2-armFlesh-rFillet;
	hull()
	{
		translate([xOffset1,yOffset,0]) drawFilletHole();
		translate([xOffset1,-yOffset,0]) drawFilletHole();
		translate([xOffset2,0,0]) drawFilletHole();
	}
}


module drawTopModuleTriangle(prmXPos)
{
	factor = 1.8;

	xOffset1 = factor*armFlesh+2*rFillet;
	yOffset1 = getArmWidth(prmXPos+xOffset1)/2-armFlesh-rFillet;

	xOffset2 = correctedLengthModule-factor*armFlesh-2*rFillet;
	yOffset2 = getArmWidth(prmXPos+xOffset2)/2-armFlesh-rFillet;

	xOffset3 = correctedLengthModule/2;
	yOffset3 = armFlesh+rFillet;
	hull()
	{
		translate([xOffset1,yOffset1,0]) drawFilletHole();
		translate([xOffset2,yOffset2,0]) drawFilletHole();
		translate([xOffset3,yOffset3,0]) drawFilletHole();
	}
}


module drawModule(prmXPos,prmIsLastModule)
{
	drawLeftModuleTriangle(prmXPos);
	drawRightModuleTriangle(prmXPos);
	drawTopModuleTriangle(prmXPos);
	mirror([0,1,0]) drawTopModuleTriangle(prmXPos);

	rMin = 1.6*rMotorCable;
	r1 = max((getArmHeight(prmXPos)-2*screwHoleFlesh)/2, rMin);
	r2 = max((getArmHeight(prmXPos+correctedLengthModule)-2*screwHoleFlesh)/2, rMin);
	lengthCylinder = prmIsLastModule ? correctedLengthModule/2+armFlesh : correctedLengthModule;
	hull()
	{
		translate([-eps,0,screwHoleFlesh+r1]) rotate([0,90,0]) cylinder(eps,r1,r1,$fn=2*fnFactor);	
		translate([lengthCylinder+eps,0,screwHoleFlesh+r2]) rotate([0,90,0]) cylinder(eps,r2,r2,$fn=2*fnFactor);	
	}
}


module drawArmFancyTriangleHole(prmLength=bigSize)
{
	hull()
	{		
		offset = lBissectriceTriangle-rInnerTriangle-1.2*screwHoleFlesh-rScrewHoleM3;		
		for (angle=[0:120:240])
		{
			translate([xCenterOffsetTriangle,0,0]) rotate([0,0,angle+180]) translate([offset,0,0]) drawFilletHole(prmLength);
		}
	}
}
 

module drawArm()
{
	difference() 
	{
		union()
		{
			translate([xCenterOffsetMotorHolder,0,0]) cylinder(tMotorHolder,rMotorHolderOuter,rMotorHolderOuter,$fn=4*fnFactor);

			hull()
			{
				translate([xCenterOffsetArmHole1,0,0]) cylinder(hCenterSpace,rArmHoleOuter,rArmHoleOuter,$fn=50);
				translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) cylinder(hCenterSpace,rArmHoleOuter,rArmHoleOuter,$fn=50);
				translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) cylinder(hCenterSpace,rArmHoleOuter,rArmHoleOuter,$fn=50);
			}

			hull()
			{
				translate([xCenterOffsetArmHole2,-rMotorHolderOuter-extraWidthArm/2,0]) cube([eps,2*rMotorHolderOuter+extraWidthArm,hCenterSpace]);
				translate([xCenterOffsetMotorHolder,-rMotorHolderOuter,0]) cube([eps,2*rMotorHolderOuter,tMotorHolder]);
			}
		}
		union()
		{
			translate([xCenterOffsetMotorHolder,0,0]) 
			{
				drawMotorMountHoles();
				translate([0,0,tMotorHolder]) cylinder(bigSize,rMotorHolderOuter+eps,rMotorHolderOuter+eps,$fn=4*fnFactor);
			}

			if (useKnurlNutsForArm)
			{
				translate([xCenterOffsetArmHole1,0,0]) drawKnurlNutHole(hCenterSpace);
				translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) drawKnurlNutHole(hCenterSpace);
				translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) drawKnurlNutHole(hCenterSpace);
			}
			else
			{
				translate([xCenterOffsetArmHole1,0,0]) drawScrewHole();
				translate([xCenterOffsetArmHole1,0,screwHoleFlesh]) rotate([0,0,180]) drawM3NutHole();
				translate([xCenterOffsetArmHole1,0,hCenterSpace-screwHoleFlesh-hClearanceNutM3]) mirror([0,0,1]) rotate([0,0,180]) drawM3NutHole();

				translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) drawScrewHole();
				translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,screwHoleFlesh]) rotate([0,0,90]) drawM3NutHole();
				translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,hCenterSpace-screwHoleFlesh-hClearanceNutM3]) mirror([0,0,1]) rotate([0,0,90]) drawM3NutHole();

				translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) drawScrewHole();
				translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,screwHoleFlesh]) rotate([0,0,-90]) drawM3NutHole();
				translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,hCenterSpace-screwHoleFlesh-hClearanceNutM3]) mirror([0,0,1]) rotate([0,0,-90]) drawM3NutHole();
			}

			drawArmFancyTriangleHole();

			for (angle=[0:120:240])
			{
				translate([xCenterOffsetTriangle,0,0]) rotate([0,0,angle]) drawArmTriangleFancyHole();
			}

			for (nr=[1:1:nrOfModules])
			{
				translate([xStartFancyModule+(nr-1)*correctedLengthModule,0,0]) drawModule((nr-1)*correctedLengthModule, nr==nrOfModules);
			}
		}
	}
}


module drawPlateRounding()
{
	r = sqrt(xCenterOffsetArmHole2*xCenterOffsetArmHole2+yCenterOffsetArmHole2*yCenterOffsetArmHole2)+rScrewHoleM3+screwHoleFlesh;
	difference() 
	{
		union()
		{
			translate([0,0,-eps]) cylinder(hCenterSpace+2*eps,bigSize,bigSize,$fn=8*fnFactor);
		}
		union()
		{
			translate([0,0,-2*eps]) cylinder(hCenterSpace+4*eps,r,r,$fn=8*fnFactor);
		}
	}
}


function getWidthBasePlate() = 2*xStartFancyModule;

function getRadiusBasePlateCorner() = getWidthBasePlate()/2-(2*rMotorHolderOuter+extraWidthArm)/2;

function getInnerRadiusBasePlate() = sqrt(2)*getWidthBasePlate()/2-getRadiusBasePlateCorner();


module drawCenterPlate()
{
	w = getWidthBasePlate();
	r = getRadiusBasePlateCorner();

	difference() 
	{
		union()
		{
			translate([-w/2,-w/2,0]) cube([w,w,tCenterPlate]);
		}
		union()
		{
			for (angle=[0:90:270])
			{
				rotate([0,0,angle]) 
				{
					translate([xCenterOffsetArmHole1,0,0]) drawScrewHole();
					translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) drawScrewHole();
					translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) drawScrewHole();

					translate([-w/2,-w/2,0]) cylinder(bigSize,r,r,$fn=4*fnFactor,true);

					drawArmFancyTriangleHole();
				}
			}
			rotate([0,0,-135]) drawArrow();
			drawPlateRounding();

			for (angle=[0:90:270])
			{
				rotate([0,0,angle+45]) translate([distanceFCHoles/2,distanceFCHoles/2,0]) 
				{
					drawScrewHole();
				}
			}

			offsetX = distanceFCHoles/2+wBatteryStrap/2+rNutM3+rClearanceNutM3+2*clearance;
			offsetXY = distanceFCHoles/2*sqrt(2)/2;
			for (angle=[0:90:270])
			{
				rotate([0,0,angle]) 
				{
					translate([offsetXY,offsetXY,0]) rotate([0,0,-45]) translate([offsetX,0,0]) drawSlotHole(wBatteryStrap);
					translate([offsetXY,offsetXY,0]) rotate([0,0,-45]) translate([-offsetX,0,0]) drawSlotHole(wBatteryStrap);
				}
			}
		}
	}
}


module drawTopCenterPlate()
{
	r = getInnerRadiusBasePlate()-rFPVScrewHole-screwHoleFlesh;

	difference() 
	{
		union()
		{
			drawCenterPlate();
		}
		union()
		{
			lSlot = distanceFCHoles-2*rFillet-3*screwHoleFlesh;
			offset1 = r-rFPVScrewHole-screwHoleFlesh-rFillet;
			offset2 = offset1-screwHoleFlesh-2*rFillet;
			rFancyHole = 0.6*distanceFCHoles/4;
			for (angle=[0:90:270])
			{
				rotate([0,0,angle+45]) translate([r,0,0]) 
				{
					translate([0,distanceFPVHoles/2,0]) drawFPVScrewHole();
					translate([0,-distanceFPVHoles/2,0]) drawFPVScrewHole();
				}

				rotate([0,0,angle+45]) translate([offset1,0,0]) rotate([0,0,90]) drawSlotHole(lSlot);
				rotate([0,0,angle+45]) translate([offset2,0,0]) rotate([0,0,90]) drawSlotHole(lSlot);

				rotate([0,0,angle+45]) translate([distanceFCHoles/2,0,0]) cylinder(bigSize,rFancyHole,rFancyHole,$fn=2*fnFactor,true);
			}
		}
	}
}


module drawBottomCenterPlate()
{
	difference() 
	{
		union()
		{
			drawCenterPlate();
		}
		union()
		{
			rotate([0,0,-135]) translate([pdbOffsetXT60,0,0]) drawXT60();

			rotate([0,0,45]) 
			{
				drawFCMount();
				drawSCMount();
			}

			offsetX = distanceFCHoles/2+wBatteryStrap/2+rNutM3+rClearanceNutM3+2*clearance;
			rFancyHole = min(wBatteryStrap/2, distanceFCHoles/2-screwHoleFlesh);
			rotate([0,0,-45]) translate([offsetX,0,0]) cylinder(bigSize,rFancyHole,rFancyHole,$fn=2*fnFactor,true);
			rotate([0,0,45]) translate([offsetX,0,0]) cylinder(bigSize,rFancyHole,rFancyHole,$fn=2*fnFactor,true);
			rotate([0,0,135]) translate([offsetX,0,0]) cylinder(bigSize,rFancyHole,rFancyHole,$fn=2*fnFactor,true);
		}
	}
}


module drawInnerLeg(prmWithTopCut=true)
{
	if (prmWithTopCut)
	{
		translate([0,0,-tLegPlate-eps]) drawArmFancyTriangleHole();
	}
	difference()
	{
		union()
		{
			translate([0,0,-tLegPlate]) hull()
			{
				drawArmFancyTriangleHole(eps);
				translate([xCenterOffsetTriangle+offsetLegFoot,0,-lLeg+tLegPlate+lLegFoot]) 
				{
					rotate([0,-angleLeg,0]) cylinder(eps,eps,eps,$fn=2*fnFactor);
				}
			}
		}
		union()
		{
			translate([-bigSize/2,-bigSize/2,-bigSize-tLegPlate-lLeg+lLegFoot+15]) cube([bigSize,bigSize,bigSize]);
		}
	}
}


module drawLeg()
{
	difference() 
	{
		union()
		{
			hull()
			{
				translate([0,0,-tLegPlate]) hull()
				{
					translate([xCenterOffsetArmHole1,0,0]) cylinder(tLegPlate,rArmHoleOuter,rArmHoleOuter,$fn=50);
					translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) cylinder(tLegPlate,rArmHoleOuter,rArmHoleOuter,$fn=50);
					translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) cylinder(tLegPlate,rArmHoleOuter,rArmHoleOuter,$fn=50);
				}
				translate([xCenterOffsetTriangle+offsetLegFoot,0,-lLeg+lLegFoot]) 
				{
					rotate([0,-angleLeg,0]) cylinder(eps,rLegFoot,rLegFoot,$fn=2*fnFactor);
				}
			}
			translate([xCenterOffsetTriangle+offsetLegFoot,0,-lLeg+lLegFoot]) rotate([0,-angleLeg,0]) translate([0,0,-lLegFoot]) cylinder(lLegFoot,rLegFoot,rLegFoot,$fn=2*fnFactor);
		}
		union()
		{
			translate([xCenterOffsetArmHole1,0,0]) drawScrewHole();
			translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,0]) drawScrewHole();
			translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,0]) drawScrewHole();

			translate([xCenterOffsetArmHole1,0,-bigSize-tLegPlate]) drawScrewHoleHead();
			translate([xCenterOffsetArmHole2,yCenterOffsetArmHole2,-bigSize-tLegPlate]) drawScrewHoleHead();
			translate([xCenterOffsetArmHole2,-yCenterOffsetArmHole2,-bigSize-tLegPlate]) drawScrewHoleHead();
			
			drawInnerLeg();

			difference() 
			{
				union()
				{			
					hull()
					{
						drawInnerLeg(false);
						translate([xCenterOffsetTriangle+offsetLegFoot,0,(-lLeg+lLegFoot)/2]) cylinder(eps,eps,eps,$fn=1);
					}

					hull()
					{
						drawInnerLeg(false);
						translate([xCenterOffsetTriangle+offsetLegFoot/2,offsetLegFoot/2,(-lLeg+lLegFoot)/2]) cylinder(eps,eps,eps,$fn=1);
					}

					hull()
					{
						drawInnerLeg(false);
						translate([xCenterOffsetTriangle+offsetLegFoot/2,-offsetLegFoot/2,(-lLeg+lLegFoot)/2]) cylinder(eps,eps,eps,$fn=1);
					}
				}
				union()
				{	
					translate([-bigSize/2,-bigSize/2,-20]) cube([bigSize,bigSize,bigSize]);
				}
			}
		}
	}
}


module drawFoot()
{
	difference() 
	{
		union()
		{
			sphere(rFoot, $fn=100);
		}
		union()
		{
			translate([-bigSize/2,-bigSize/2,rFoot-hFootCutOff]) cube([bigSize,bigSize,bigSize]);
			translate([0,0,rFoot-hFootCutOff-lLegFoot]) cylinder(bigSize,rLegFoot,rLegFoot,$fn=2*fnFactor);
		}
	}
}


module drawCameraMount()
{
	hCameraMount = heightCamera-hCenterSpace; 
	wCameraMount = distanceFPVHoles+2*(rFPVScrewHole+screwHoleFlesh);
	lCameraMount = extensionCameraMount+2*(rFPVScrewHole+screwHoleFlesh);
	lCameraMount2 = 2*(rFPVScrewHole+screwHoleFlesh);
	rFancy = min((lCameraMount-2*lCameraMount2)/2,(wCameraMount-2*screwHoleFlesh)/2);
	difference() 
	{
		union()
		{
			translate([0,-wCameraMount/2,0]) drawBox(lCameraMount,wCameraMount,tCenterPlate,rFillet);
			translate([0,-wCameraMount/2,tCenterPlate-eps]) drawBox(lCameraMount2,wCameraMount,hCameraMount-tCenterPlate+eps,rFillet);
		}
		union()
		{
			translate([lCameraMount2/2,-distanceFPVHoles/2,tCenterPlate-eps]) drawFPVScrewHole();
			translate([lCameraMount2/2,distanceFPVHoles/2,tCenterPlate-eps]) drawFPVScrewHole();
			translate([lCameraMount-lCameraMount2/2,-distanceFPVHoles/2,tCenterPlate-eps]) drawFPVScrewHole();
			translate([lCameraMount-lCameraMount2/2,distanceFPVHoles/2,tCenterPlate-eps]) drawFPVScrewHole();
			translate([lCameraMount/2,0,0]) cylinder(bigSize,rFancy,rFancy,true,$fn=2*fnFactor);
		}
	}
}


module drawAssembly(prmViewType=V_ASSEMBLY)
{
	offsetZ = (prmViewType==V_EXPLODED_VIEW)?offsetExplodedView:0;

	color("darkgrey") translate([0,0,tCenterPlate+hCenterSpace]) translate([0,0,2*offsetZ]) drawTopCenterPlate();

	for (angle=[0:90:90])
	{
		color("green") translate([0,0,tCenterPlate+hCenterSpace]) translate([0,0,offsetZ]) mirror([0,0,1]) rotate([0,0,angle]) drawArm();
	}
	for (angle=[180:90:270])
	{
		color("red") translate([0,0,tCenterPlate+hCenterSpace]) translate([0,0,offsetZ]) mirror([0,0,1]) rotate([0,0,angle]) drawArm();
	}

	color("darkgrey") drawBottomCenterPlate();

	for (angle=[0:90:270])
	{
		color("orange") rotate([0,0,angle]) translate([0,0,-offsetZ]) drawLeg();
		color("Grey") rotate([0,0,angle]) translate([xCenterOffsetTriangle+offsetLegFoot,0,-lLeg+lLegFoot]) translate([0,0,-3*offsetZ]) rotate([0,-angleLeg,0]) translate([0,0,-lLegFoot]) drawFoot();
	}
}


module drawExplodedView()
{
	drawAssembly(V_EXPLODED_VIEW);
}


module drawSelectedPart()
{
	if (selectedPart=="Arm") {
		drawArm();
	} else if (selectedPart=="TopCenterPlate") {
		drawTopCenterPlate();
	} else if (selectedPart=="BottomCenterPlate") {
		drawBottomCenterPlate();
	} else if (selectedPart=="Leg") {
		mirror([0,0,1]) drawLeg();
	} else if (selectedPart=="Foot") {
		mirror([0,0,1]) drawFoot();
	} else if (selectedPart=="CameraMount") {
		drawCameraMount();
	} else if (selectedPart=="Assembly") {
		drawAssembly();
	} else if (selectedPart=="ExplodedView") {
		drawExplodedView();
	}
}


// tests
//drawMotorMountHoles();
//drawModule(0);
//drawAssembly();
//drawExplodedView();
//drawCenterPlate();
//drawSC();
//drawInnerLeg();
//drawLeg();
//drawFoot();


// parts
//drawArm();
//drawTopCenterPlate();
//drawBottomCenterPlate();
//mirror([0,0,1]) drawLeg();
//mirror([0,0,1]) drawFoot();
//drawCameraMount();


// thingiverse customizer
drawSelectedPart();




