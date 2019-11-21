
//Bearing OD (mm)
OuterDiameter = 42;

//Bearing ID (mm)
InnerDiameter = 20;

//Bearing Width (mm)
width = 12;

//Resolution
resolution = 200; // [100:Rough,200:Medium,400:Great, 5000:Bananas]

//Space between components (mm)
gap = 0.5;

//Radius of the roller bearings (mm)
BearingRadius = 2;

// Convex or concave rollers?
RollerShape = "Concave"; //[Convex, Concave]

//Angled offset of the bearings (mm)
angleOffset = .7;

// Section to inspect interior
Section = "No"; //[No, Yes]

// ignore variable values
// reallocated variable/names 
thickness = width;
ID = InnerDiameter;
OD = OuterDiameter;

halfT = thickness / 2;
OR = OD / 2;
IR = ID / 2;

ballR = BearingRadius;
ballRA = ballR + angleOffset;
ballRB = ballR - angleOffset;
ballRunR = ((OR - IR) / 2) + IR;
ballAngleRAW = asin((((ballR) * 2) + 1.5) / ballRunR);
iMAX = (360 / ballAngleRAW) - ((360 / ballAngleRAW) % 1);

outerIR = ballRunR + gap + ballR;
outerIRA = outerIR + (2 * angleOffset);
outerIRB = outerIR - (2 * angleOffset);

innerOR = ballRunR - gap - ballR;
innerORA = innerOR - angleOffset;
innerORB = innerOR + angleOffset;

echo(innerOR, innerORA - innerOR, innerOR - innerORB);
echo(outerIR, outerIRA - outerIR, outerIR - outerIRB);
echo((outerIR - innerOR)/2 + innerOR, ballRunR);

ballAngle = 360 / iMAX;

fn = resolution;

difference(){
	if (RollerShape == "Concave")
	{
		createHalf();
			rotate([0,180,180])
				translate([0,0,-thickness])
					createHalf();
	}
	else
	{
		createHalf();
			rotate([0,180,180])
				translate([0,0,0])
					createHalf();
	}
	
	if (Section == "Yes")
	{	translate([0,-OR,-thickness])
			cube([OR + 1,OD,thickness * 3]);}
}

//----------------MODULES-------------------//

module createHalf(){
		innerRing(); 
		outerRing();
		balls();
}


module balls(){
	for (i  = [0 : 360 / ballAngle] )
	{
   	rotate([0,0, ballAngle * i]) 
		translate([ballRunR, 0, 0])
    		cylinder(h = halfT, r1 = ballRA, r2 = ballRB, $fn = fn, centre = true);
	}
}

module outerRing(){
	difference()
		{cylinder (h = halfT, r = OR, $fn = fn, centre = true);

		translate([0,0,-halfT]) 
			cylinder (h = thickness * 1.5, r1 = outerIRA, r2 = outerIRB, $fn = fn, centre = true);
	}
}

module innerRing(){
	difference()
		{cylinder (h = halfT, r1 = innerORA, r2 = innerORB, $fn = fn, centre = true);

		translate([0,0, -halfT])
			cylinder (h = thickness * 1.5, r = IR, $fn = fn, centre = true);}
}



