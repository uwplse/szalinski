//	Ultimaker Print Core Holder
//	Copyright (C) 2019 Herb Weiner <herbw@wiskit.com>. Creative Commons by Attribution (CC-BY-SA).

/* [General Settings] */
//	Unit of Measure for all Numeric Entries
units =						25.4;		//	[25.4:inches,1.0:mm,10.0:cm]
//	Number of Slots Horizontally
nHoriz =					3;
//	Number of Slots Vertically
nVert =						2;

/* [Parameters for Hook] */
//	Where to place hook
hookPlacement =				1;			//	[0:No Hook,1:Left Side,2:Right Side,3:Back -- REQUIRES SUPPORT]
//	Thickness of Side Panel used for Hanging Print Core Holder
hookPanelThickness =		0.25;
//	Vertical Overhang of Hook
hookOverhang =				0.175;

module GoAwayCustomizer ()
{
// This module is here to stop Customizer from picking up the variables below
}

//	The following variables affect the geometry of the Print Core Holder, and should not require change.

Inches = 25.4;  //  Inches to mm

InsideWidth =			0.69 * Inches;
InsideDepth =			1.67 * Inches;
InsideHeight =			2 * Inches;

OutsideExtension =		0.25 * Inches;
ExtensionElevation =	0.635 * Inches;
ExtensionHeight =		1.268 * Inches;

WallThickness =			0.14 * Inches;
BackThickness =			0.24 * Inches;
TopLip =				0.255 * Inches;
TopThickness =			0.125 * Inches;
TopDepth =				1.575 * Inches;
BottomThickness =		0.185 * Inches;

BottomCutoutWidth =		0.25 * Inches;
BottomCutoutDepth =		0.675 * Inches;
BottomCutoutDiameter =	0.37 * Inches;

TopCutoutWidth =		0.265 * Inches;
TopCutoutDepth =		0.475 * Inches;

RoundingRadius =		0.125 * Inches;

vSpace =				0.5 * Inches;

hookThickness =			0.125 * Inches;

oneHeight =				InsideHeight + TopLip + TopThickness + BottomThickness + vSpace;

//	The following variable is a small value to eliminate ambiguity with the use of the OpenSCAD Difference Function.

delta = 0.01;

module roundedRectangle (width, height, thickness, r1, r2, r3, r4)
{
	hull ()
	{
		if (r1 > 0)
			translate ([r1, r1, 0]) cylinder (r = r1, h = thickness, $fn = 360);
		else
			cube ([delta, delta, thickness]);

		if (r2 > 0)
			translate ([r2, height - r2, 0]) cylinder (r = r2, h = thickness, $fn = 360);
		else
			translate ([0, height - delta, 0]) cube ([delta, delta, thickness]);

		if (r3 > 0)
			translate ([width - r3, height - r3, 0]) cylinder (r = r3, h = thickness, $fn = 360);
		else
			translate ([width - delta, height - delta, 0]) cube ([delta, delta, thickness]);

		if (r4 > 0)
			translate ([width - r4, r4, 0]) cylinder (r = r4, h = thickness, $fn = 360);
		else
			translate ([width - r4, 0, 0]) cube ([delta, delta, thickness]);
	}
}

module insideCorner (radius, thickness, rotation)
{
	rotate (rotation)
	{
		if (rotation == 90)
		{
			translate ([0, -radius, 0])
			difference ()
			{
				cube ([radius, radius, thickness]);
				translate ([0, 0, -delta]) cylinder (r = radius, h = thickness + 2 * delta, $fn = 360);
			}
		}
		else if (rotation == 180)
		{
			translate ([-radius, -radius, 0])
			difference ()
			{
				cube ([radius, radius, thickness]);
				translate ([0, 0, -delta]) cylinder (r = radius, h = thickness + 2 * delta, $fn = 360);
			}
		}
		else if (rotation == 270)
		{
			translate ([-radius, 0, 0])
			difference ()
			{
				cube ([radius, radius, thickness]);
				translate ([0, 0, -delta]) cylinder (r = radius, h = thickness + 2 * delta, $fn = 360);
			}
		}
		else
		{
			//	Assume rotation == 0
			difference ()
			{
				cube ([radius, radius, thickness]);
				translate ([0, 0, -delta]) cylinder (r = radius, h = thickness + 2 * delta, $fn = 360);
			}
		}
	}
}

module coreHolder (nH, nV)
{
	totalThickness = nH * (InsideWidth + WallThickness) + WallThickness;
	totalHeight = nV * oneHeight - vSpace;
	difference ()
	{
		//	Outside Cube
		union ()
		{
			translate ([0, OutsideExtension, 0]) cube ([totalThickness, InsideDepth + BackThickness, totalHeight]);

			for (j = [0 : 1: nV - 1])
			{
				translate ([0, 0, j * oneHeight])
				rotate ([0, -90, 0])
				{
					//	Lower Extension
					translate ([0, 0, -(totalThickness)]) roundedRectangle (ExtensionElevation, OutsideExtension, totalThickness, 0, 0, 0, RoundingRadius);

					//	Lower Inside Radius
					translate ([ExtensionElevation, OutsideExtension - RoundingRadius, -(totalThickness)]) insideCorner (RoundingRadius, totalThickness, 90);

					//	Upper Extension
					translate ([ExtensionHeight, 0, -(totalThickness)]) roundedRectangle (oneHeight -vSpace - ExtensionHeight, OutsideExtension, totalThickness, RoundingRadius, 0, 0, RoundingRadius);

					//	Upper Inside Radius
					translate ([ExtensionHeight - RoundingRadius, OutsideExtension - RoundingRadius, -(totalThickness)]) insideCorner (RoundingRadius, totalThickness, 0);
				}
			}
		}

		for (i = [0 : 1 : nH - 1]) 
		{
			//	Inside Cutout
			translate ([WallThickness + i * (InsideWidth + WallThickness), -delta, -delta]) cube ([InsideWidth, InsideDepth + OutsideExtension - InsideWidth / 2, totalHeight + 2 * delta]);

			//	Rounded Back
			translate ([InsideWidth / 2 + WallThickness + i * (InsideWidth + WallThickness), InsideDepth + OutsideExtension - InsideWidth / 2, BottomThickness]) cylinder (d = InsideWidth, h = totalHeight + 2 * delta, $fn = 360);
		}
	}

	for (i = [0 : 1 : nH - 1]) 
	{
		for (j = [0 : 1: nV - 1])
		{
			translate ([0, 0, j * oneHeight])
			{
				difference ()
				{
					//	Bottom Shelf
					translate ([i * (InsideWidth + WallThickness), 0, 0]) cube ([InsideWidth + 2 * WallThickness, TopDepth + BackThickness + OutsideExtension, BottomThickness]);

					//	Bottom Cutout Slot
					translate ([(InsideWidth + 2 * WallThickness - BottomCutoutWidth) / 2 + i * (InsideWidth + WallThickness), -delta, -delta]) cube ([BottomCutoutWidth, BottomCutoutDepth + delta, BottomThickness + 2 * delta]);

					//	Bottom Cutout Cylinder
					translate ([(InsideWidth + 2 * WallThickness) / 2 + i * (InsideWidth + WallThickness), BottomCutoutDepth + delta, 0]) cylinder (d = BottomCutoutDiameter, h = 2 * (BottomThickness + 2 * delta), center = true, $fn = 360);
				}

				difference ()
				{
					//	Top Shelf
					translate ([i * (InsideWidth + WallThickness), InsideDepth + OutsideExtension - TopDepth, BottomThickness + InsideHeight]) cube ([InsideWidth + 2 * WallThickness, TopDepth + BackThickness, TopThickness]);

					//	Top Cutout Slot
					translate ([(InsideWidth + 2 * WallThickness - TopCutoutWidth) / 2 + i * (InsideWidth + WallThickness), InsideDepth + OutsideExtension - TopDepth - delta, BottomThickness + InsideHeight -delta])
					{
						cube ([TopCutoutWidth, TopCutoutDepth + delta, TopThickness + 2 * delta]);
						translate ([TopCutoutWidth / 2, TopCutoutDepth + delta, 0]) cylinder (d = TopCutoutWidth, h = TopThickness + 2 * delta, $fn = 360);
					}
				}
			}
		}
	}
}

module hook ()
{
	totalThickness = nHoriz * (InsideWidth + WallThickness) + WallThickness;
	totalHeight = nVert * oneHeight - vSpace;

	if (hookPlacement == 1)
	{
		translate ([-(hookPanelThickness * units + hookThickness), OutsideExtension, totalHeight - hookThickness]) cube ([hookPanelThickness * units + hookThickness, InsideDepth + BackThickness, hookThickness]);
		translate ([-(hookPanelThickness * units + hookThickness), OutsideExtension, totalHeight - hookThickness - hookOverhang * units]) cube ([hookThickness, InsideDepth + BackThickness, hookOverhang * units]);
	}
	else if (hookPlacement == 2)
	{
		translate ([totalThickness, OutsideExtension, totalHeight - hookThickness]) cube ([hookPanelThickness * units + hookThickness, InsideDepth + BackThickness, hookThickness]);
		translate ([totalThickness + hookPanelThickness * units, OutsideExtension, totalHeight - hookThickness - hookOverhang * units]) cube ([hookThickness, InsideDepth + BackThickness, hookOverhang * units]);
	}
	else if (hookPlacement == 3)
	{
		translate ([0, InsideDepth + BackThickness + OutsideExtension, totalHeight - hookThickness]) cube ([totalThickness, hookPanelThickness * units + hookThickness, hookThickness]);
		translate ([0, InsideDepth + BackThickness + OutsideExtension + hookPanelThickness * units, totalHeight - hookThickness - hookOverhang * units]) cube ([totalThickness, hookThickness, hookOverhang * units]);
	}
}

coreHolder (nHoriz, nVert);
hook ();
