/* [Hidden] */
// Value to keep display model manifold after difference().  For preview purposes only.
m = .015;
// Resolution - Detail level.
$fn = 75;

// Parametric Outer Mount - Version 3

// Note:  Code is formatted to utilize Thingiverse's Customizer and OpenSCAD's Customizer Plugin.

/* [1 - Object] */
// Object Height (in mm)
objectHeight = 8;
// Width of Arms
armW = 46;
// Diamond Plate Width
dPlateW = 125;
// Tolerance - Tolerance Percentage
tolerancePct = 3;

/* [2 - Inner Mount Screw Cutouts] */
// Distance between Inner Mount Screw Hole Centers
innerMountScrewDistance = 165.1; // [100:.1:400]
// Inner Mount Screw Shaft Diameter
innerMountScrewSDM = 5; // [1:.1:10]
// Inner Mount Screw Head Diameter
innerMountScrewHDM = 7.5; // [1:.1:10]
// Inner Mount Screw Head Height
innerMountScrewHHM = 2; // [1:.1:10]
// Inner Mount Screw Nut Recess
innerMountScrewRecess = "Countersink"; // ["Countersink","Nut","None"]
// Inner Mount Screw Nut Recess Position
innerMountScrewRecessPosition = "Top"; // ["Top","Bottom"]

/* [3 - Outer Mount Screw Cutouts] */
// Distance between Outer Mount Screw Hole Centers
outerMountScrewDistance = 330.2; // [200:.1:500]
// Outer Mount Screw Shaft Diameter
outerMountScrewSDM = 5; // [1:.1:10]
// Outer Mount Screw Head Diameter
outerMountScrewHDM = 7.5; // [1:.1:10]
// Outer Mount Screw Head Height
outerMountScrewHHM = 2; // [1:.1:10]
// Outer Mount Screw Nut Recess
outerMountScrewRecess = "Countersink"; // ["Countersink","Nut","None"]
// Outer Mount Screw Nut Recess Position
outerMountScrewRecessPosition = "Top"; // ["Top","Bottom"]

// Distance from origin to center of Outer Mount Screw Hole
outerMountOffset = outerMountScrewDistance / 2;
// Distance from origin to center of Inner Mount Screw Hole
innerMountOffset = innerMountScrewDistance / 2;
// Tolerance Multiplier
tolerance = 1 + (tolerancePct / 100);
// Apply tolerance to Outer Mount Screw Shaft Diameter
outerMountScrewSD = outerMountScrewSDM * tolerance + m;
// Apply tolerance to Outer Mount Screw Head Diameter
outerMountScrewHD = outerMountScrewHDM * tolerance + m;
// Apply tolerance to Outer Mount Screw Head Height
outerMountScrewHH = outerMountScrewHHM + tolerance + m;
// Apply tolerance to Inner Mount Screw Shaft Diameter
innerMountScrewSD = innerMountScrewSDM * tolerance + m;
// Apply tolerance to Inner Mount Screw Head Diameter
innerMountScrewHD = innerMountScrewHDM * tolerance + m;
// Apply tolerance to Inner Mount Screw Head Height
innerMountScrewHH = innerMountScrewHHM + tolerance + m;

difference()
{
	solidMount(); // Create 3D model.
	screwHoles(); // Use this 3D model to punch holes in the first.
} // End difference()

module solidMount() // Create 3D model.
{
	linear_extrude(objectHeight)
	{
		// Center "Diamond Plate"
		rotate([0,0,45])
			square(dPlateW,center=true);
		// Center Rectangle = 2 "Arms"
		square([outerMountScrewDistance,armW],center=true);
		// Center 2nd Perpendicular Rectangle - 2 More "Arms"
		rotate([0,0,90])
			square([outerMountScrewDistance,armW],center=true);
		// Round End Of Each "Arm"
		for(i=[0:90:360])
		{
			rotate([0,0,i])
				translate([outerMountOffset,0,0])
					circle(d=armW,center=true);
		} // End for(i)
	} // End linear_extrude()
} // End solidMount()

// Create cutout 3d model by creating the cutouts for each "arm" then rotating them into position.
module screwHoles()
{
	for(i=[0:90:270])
	{
		rotate([0,0,i])
		{
			// Set The Rotation Angle To 180 So The Recess Cutout Is Flipped If It Is On Top Of The Mount
			innerRecessRotate = innerMountScrewRecessPosition == "Top" ? 180 : 0;
			outerRecessRotate = outerMountScrewRecessPosition == "Top" ? 180 : 0;
			// Calculate The Z Offset Of The Recess Cutout
			innerMountZOffset = innerRecessRotate == 180 ?  (objectHeight - (innerMountScrewHH / 2)) + m: innerMountScrewHH / 2 - m;
			outerMountZOffset = outerRecessRotate == 180 ?  (objectHeight - (outerMountScrewHH / 2)) + m: outerMountScrewHH / 2 - m;
			
			// Outer Mount Shaft
			translate([outerMountOffset,0,objectHeight/2])
				cylinder(d=outerMountScrewSD,h=objectHeight+m,center=true);
			// Inner Mount Shaft
			translate([innerMountOffset,0,objectHeight/2])
				cylinder(d=innerMountScrewSD,h=objectHeight+m,center=true);
			// Cutout Recess If Any For Outer Mounts
			if(outerMountScrewRecess!="None")
			translate([outerMountOffset,0,outerMountZOffset])
					rotate([outerRecessRotate,0,0])
						cutRecess("outer");
			// Cutout Recess If Any For Inner Mounts
			if(innerMountScrewRecess!="None")
				translate([innerMountOffset,0,innerMountZOffset])
					rotate([innerRecessRotate,0,0])
						cutRecess("inner");
		} // End rotate()
	} // End for(i)
} // End screwHoles()

// Cutout Recess
module cutRecess(holeSet)
{
	if(holeSet=="outer")
	{
		if(outerMountScrewRecess=="Countersink")
		{
			cylinder(d1=outerMountScrewHD,d2=outerMountScrewSD,h=outerMountScrewHH,center=true);
		}
		// If The Recess Is A Nut Cutout
		else
		{
			cylinder(d=outerMountScrewHD,h=outerMountScrewHH,$fn=6,center=true);
		} // End if()
	}
	else
	{
		// If Inner Hole Set
		if(innerMountScrewRecess=="Countersink")
		{
			cylinder(d1=innerMountScrewHD,d2=innerMountScrewSD,h=innerMountScrewHH,center=true);
		}
		// If The Recess Is A Nut Cutout
		else
		{
			cylinder(d=innerMountScrewHD,h=innerMountScrewHH,$fn=6,center=true);
		} // End if()
	} // End if()
} // End cutRecess()
