//default options are good for Vifa NE65W

/* [Sphere Body] */
//Set to true if manually providing sphere diameter
useManualSphereInternalDiameter = "true";  //[true,false] 
//Internal sphere diameter
manualSphereInternalDiameter = 130;
//Sphere volume in liters (ignored if doing manual sphere diameter)
sphereVolumeLiters = 1.5;
sphereWallThickness = 5;
markingThickness = 0.5;
trenchDepth = 2;

/* [Speaker Hole] */
//When in doubt - make a bit bigger (mm)
speakerHoleDiameter = 53; 
//Inset area surround speaker hole (mm)
speakerMountDiameter = 67;
//How far speaker mount is inset into sphere (mm)
speakerMountCountersink = 8.5;
holeAngle = 52;
//Makes a notch to allow extra room for speaker terminal
makeTerminalNotch = "false"; //[true,false] 
terminalNotchOvalWidth = 24.5;
terminalNotchOvalHeight = 20;
terminalNotchInset = 2.2;
terminalNotchRotation = 180;

/* [Screw Holes] */
//diagonally opposing holes this distance apart (mm)
speakerScrewHoleSpacing = 58.2; 
numberOfSpeakerScrewHoles = 3; 
//3.25 good for #6 machine screws (mm)
speakerScrewHoleDiameter = 3.25;  

/* [Bass Port and Bottom] */
makeBassPort = "true"; //[true,false] 
//Use an online tool to calculate - don't guess!
portInternalDiameter = 20;
//Use an online tool to calculate - don't guess!
portLength = 70;
portWallThickness = 8;
//Diameter of flat area on bottom if not doing Bass Port (for printing)
flatBottomOfPrintDiameterIfNoBassPort = 20;

/* [Wire Holes] */
//Set to 0 if unwanted
wireHole1Diameter = 2.5;
wireHole1Angle = 0;
//Set to 0 if unwanted
wireHole2Diameter = 2.5;
wireHole2Angle = 270;


/* [Hidden] */

compensateForCounterSinkWithExtraThickness = true;

sphereInternalDiameter = (useManualSphereInternalDiameter != "true") ? pow((sphereVolumeLiters * 1000000) / (4/3 * 3.14), 1/3) * 2 : manualSphereInternalDiameter;

echo("Internal Diameter:", sphereInternalDiameter);

markingFreeDiameter = speakerHoleDiameter + 2;
sphereDiameter = sphereInternalDiameter + sphereWallThickness;
sphereRadius = sphereDiameter / 2;
mountReinforceExtraDiameter = speakerMountCountersink / 4;
mountReinforcementCompensation = ((!compensateForCounterSinkWithExtraThickness) ? 0 : speakerMountCountersink);

$fn = 75;

mainBody();
if (makeBassPort == "true") bassPort(); else flatBottomPrintSurface();
mountReinforcement();

module mainBody() {
	difference() {
		sphereWithMarkings();
		mainTrench();
		speakerHole();
		sphere(sphereRadius - sphereWallThickness);
		if (makeBassPort == "true") bassHole();
		wireHoles();
		mountCounterSink();
		if (makeTerminalNotch == "true") terminalNotch();
		screwCutOuts(holeAngle, speakerScrewHoleSpacing, numberOfSpeakerScrewHoles,
		 speakerScrewHoleDiameter);
	}
}

module screwCutOuts(rotation, distance, numberOfHoles, speakerHoleDiameter)
{
	if (numberOfHoles != 0) { 
		rotate ([rotation,0,0]) translate([0, 0, (sphereInternalDiameter / 3) - 1]) 
		{
			for (i = [0 : 360 / numberOfHoles : 360])
			{
				rotate([0,0,i + 45])
					translate([0, distance / 2, 0])
						cylinder(r = speakerHoleDiameter / 2,
						 	h = sphereInternalDiameter / 4);
			}
		}
	}
}


module terminalNotch() {

	rotate ([holeAngle,0,0])
	rotate ([0,0,terminalNotchRotation])
	translate ([0,((speakerHoleDiameter / -2) + terminalNotchOvalHeight / 2) - terminalNotchInset, (sphereInternalDiameter / 2) * .6])
		scale([terminalNotchOvalWidth / terminalNotchOvalHeight, 1, 1])  cylinder (r =  terminalNotchOvalHeight / 2, h = sphereWallThickness + markingThickness + (sphereInternalDiameter / 2) * .4);
}

module speakerHole(){
	rotate ([holeAngle,0,0])
	{
		cylinder(r=speakerHoleDiameter/2, h = sphereRadius + markingThickness + 1);
	}
}

module mountReinforcement() {
	mountDistance = sqrt(pow(sphereRadius,2) - pow((speakerHoleDiameter / 2), 2));
	difference(){
		{
			rotate ([holeAngle,0,0])
			translate ([0,0,(mountDistance + markingThickness) - speakerMountCountersink])
			rotate ([0,180,0])
			cylinder(r=(speakerMountDiameter/2) + mountReinforceExtraDiameter, h = (sphereWallThickness - speakerMountCountersink) + mountReinforcementCompensation);
		}
		speakerHole();
		if (makeTerminalNotch == "true") terminalNotch();
		screwCutOuts(holeAngle, speakerScrewHoleSpacing, numberOfSpeakerScrewHoles,
			speakerScrewHoleDiameter);
	}
}


module mountCounterSink() {

	mountDistance = sqrt(pow((sphereRadius),2)
		- pow((speakerHoleDiameter / 2), 2));
	rotate ([holeAngle,0,0])
	translate ([0,0,(mountDistance + markingThickness) - speakerMountCountersink])
		cylinder(r=speakerMountDiameter/2, h = sphereWallThickness * 2);

}


module bassPort() {
	difference() {
		rotate ([0,180,0])
		{
			translate([0,0,sphereRadius - portLength])
			cylinder(r=(portInternalDiameter/2) + portWallThickness / 2, h = portLength);
		}
		bassHole();
	}
}


module flatBottomPrintSurface() {
	rotate ([0,180,0])
	{
		translate([0,0,sphereRadius - sphereWallThickness])
		cylinder(r=(flatBottomOfPrintDiameterIfNoBassPort/2), h = sphereWallThickness);
	}
}


module bassHole() {
	rotate ([0,180,0])
	{
		translate([0,0,sphereRadius - (portLength + 1)])
		cylinder(r=portInternalDiameter/2, h = portLength + 2);
	}
}

module wireHoles() {
	rotate ([wireHole1Angle,0,0])
	{
		cylinder(r=wireHole1Diameter/2, h = sphereRadius + markingThickness + 1);
	}
	rotate ([wireHole2Angle,0,0])
	{
		cylinder(r=wireHole2Diameter/2, h = sphereRadius + markingThickness + 1);
	}
}


module sphereWithMarkings() {
		sphere(sphereRadius);
		markings();
}

module mainTrench() {
	difference() {
	cylinder(r=sphereRadius + markingThickness, h=sphereRadius / 40, center=true, $fa = 5);
	cylinder(r=sphereRadius - (trenchDepth), h=sphereRadius / 40, center=true);}
}

module markings() {
		bands();
		rotate([0,180,0]) bands();
		noMarkingsAroundSpeaker();
}

module bands() {
	band(sphereRadius / 45, sphereRadius / 3.3, 28);
	band(sphereRadius / 2.7, sphereRadius / 6, 22);
	band(sphereRadius / 1.75, sphereRadius / 5.5, 41);
	band(sphereRadius / 1.3, sphereRadius / 5.5, 27);
}

module noMarkingsAroundSpeaker() {
		intersection() {
			difference() {
				sphere(sphereRadius + markingThickness);
				sphere(sphereRadius - sphereWallThickness);
			}
			rotate ([holeAngle,0,0])
			{ 
				cylinder(r=markingFreeDiameter/2, h = (sphereRadius + markingThickness));
			}

		}

}

module band(location, height, increment) {
	difference() {

		intersection() {
			sphere(sphereRadius + markingThickness);
			translate([0, 0, location])
			cylinder(r=sphereRadius + 1, h=height);
		}

		for ( i = [increment : increment : 360] )
		{
    		rotate( [0, 0, i])
			cube ([sphereRadius*2,sphereRadius / 34,sphereRadius*2]);
		}

	}
}

