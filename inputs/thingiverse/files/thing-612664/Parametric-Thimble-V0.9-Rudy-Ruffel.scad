// ************* Credits part *************
//            "Parametric Thimble" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//********************** License ******************
//**        "Parametric Thimble" by rr2s         **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
// ************* Declaration part *************
/* [Global] */

/* [Dimension] */
// (Measure the diameter of your finger at your fingernail. Your finger is not cylindrical take the largest measurement.) 
DiameterFinger = 18;
// (Note the wall thickness Must be supperior to diameter of the holes. If not you will have a sieve.)
ThicknessWall = 2;
// (Height of your Thimble)
HeightThimble = 20;

/* [Holes] */
// (Diameter holes.Warning not to put a number too small because the calculation is too long. Or the number of elements is too large and openscad bug.)
DimaeterHoles = 1.5;
//(Spacing Distance vertical holes for the top sphere. This parameters are for position the holes. Depending on your settings you will have to change.)
DHT		= 0.8;
//(Spacing Distance Circular holes Top sphere.This parameters are for position the holes. Depending on your settings you will have to change.)
HCD		= 2;
//(Spacing Distance Circular holes  for cylinder.This parameters are for position the holes. Depending on your settings you will have to change.)
HCDL	= 1.8;  	
//(Distance Holes Vertical for cylinder.This parameters are for position the holes. Depending on your settings you will have to change.)
HVD		= 0.8;  	

/* [Settings] */
// (Diameter of the torus. (bead to the base))
DiameterTorus = 4;
// (Would you like a torus at the base)
TorusBas = "true";//[true,false]
// (Would you like a reinforcement at the base)
RenfortBase = "true";//[true,false]
//// (Would you like a vase or pot. If yes = false.)
SphereTop = "true"; //[true,false]
// (Resolution of the cylinder, the dome top and torus. Warning not to put a number too big because the calculation is too long or openscad bug.)
Resolution = 45;// [20:150]
// (Resolution of the holes.Warning not to put a number too big because the calculation is too long or openscad bug.)
RexolutionHolle = 10;// [5:40]

/* [Hidden] */
// ************* private variable *************
	TH					= ThicknessWall;
	H					= HeightThimble;
	R					= Resolution;
	RH					= RexolutionHolle;
	RT					= DiameterTorus/2; // radius Torus
	RD  				= DiameterFinger/2; // radius Finger
	RDH					= RD-(RD*20/100);
// With Thickness
	RDTH				= RD+TH;    // radius finger + ThicknessWall
	RDHTH				= RDTH-(RDTH*20/100); // 20% less than the radius of the finger with TH
	HTH					= H+TH; // Height + TH
// Holes
	RCH 				= DimaeterHoles/2;  // Radius Cut Holes
	ZZ 					= RDHTH-RDTH;// For tangent
	TC 					= -90-atan(H/ZZ);// calculation tangente cylinder

  // Holes sphere Top
		NombreHoleRadiusTop  = round (RDHTH/(RCH*2+DHT));
		AngleHoleSphereTop = 45/NombreHoleRadiusTop;
 // Holes sphere Around
		nbTrouPerimetre = round(((RDTH-RCH*2.5)*2)*3.14/(RCH*2+HCDL));
		AngleDeRotTrouPerimetre = 360/nbTrouPerimetre;
		nbTrouVertical = (HTH/2)/(RCH*2+HVD)-0.5;
		DVX = ((RDTH-RDHTH)/2)/nbTrouVertical;


// ************* execution part *************
if (SphereTop   == "true"){ End();}
else{ rotate([180,0,0]) End();}


// ************* Fonction construction *************
module End(){
	difference(){
		Base();
		CutFinger();
		CutGround();
	}
}
module Base(){
	union(){
		CutHolleAround();
		if (SphereTop   == "true"){ FullSphereTop();}
		if (RenfortBase == "true"){ BourletBas();}
		if (TorusBas    == "true"){ BaseTorus();}
	}
}

module CutHolleAround(){
	difference(){
		BaseCylinder();
		HoleAround();
	}

}

// ************* Part base and Torus *************
module BaseCylinder(){
		cylinder(h=HTH	,r1=RDTH ,r2=RDHTH ,center=true,$fn = R);
}
module BaseTorus(){
	translate([0, 0,-HTH/2+RT*0.94]) 
	rotate_extrude(convexity = 10, $fn = R)
	translate([RDTH+-RT/3, 0,0])
	circle(r = RT, $fn = R);
}
module BourletBas(){
	if (TorusBas == "true"){
		translate([0,0,-HTH/3+RT/2]) cylinder(h=HTH/3,r1=RDTH+RT/2.2,r2=RDHTH*1.2 ,center=true,$fn = R);
		translate([0,0,-HTH/3+RT/2+(HTH/1.5)-HTH/2.09]) cylinder(h=HTH/20,r1=RDHTH*1.2,r2=RDHTH*1.142,center=true,$fn = R);
	}else{
		translate([0,0,-HTH/3]) cylinder(h=HTH/3,r1=RDTH+RT/2.2,r2=RDHTH*1.2 ,center=true,$fn = R);
		translate([0,0,-HTH/3+(HTH/1.5)-HTH/2.09]) cylinder(h=HTH/20,r1=RDHTH*1.2,r2=RDHTH*1.142,center=true,$fn = R);

	}
}

// ************* Part Cut *************
module CutGround(){
	translate([0 , 0, -HTH/2]) cube(size = [RD*3,RD*3,1], center = true);
}
module CutFinger(){
translate([0 , 0, -1]) cylinder(H+1,RD,RDH,center=true,$fn = R);
}

// ************* Part sphere top and holes sphere top *************
module FullSphereTop(){
	difference(){
	translate([0 , 0, HTH	/2+-RDHTH*1.735]) SphereTop();
	translate([0 , 0,-HTH	*2/2+HTH/2])  cube(size = [RDHTH*6,RDHTH*6,HTH	*2], center = true);
	}
}
module SphereTop(){
	difference(){
		sphere(r =RDHTH*2.004,$fn = R);
		translate([0,0,RDHTH*2])  sphere(r =RCH ,$fn = RH);
		for ( i = [1 : NombreHoleRadiusTop] ){
			for ( j = [0 : (round (((RCH*HCD*i)*2*3.14)/(RCH*2)))-1] ){
				rotate([0,AngleHoleSphereTop*i,j*360/round (((RCH*HCD*i)*2*3.14)/(RCH*2))])
 				translate([0,0,RDHTH*2])  
				sphere(r =RCH ,$fn = RH);		
			}
		}
	}
}

// ************* Part Cut Hole Cylinder *************
module HoleAround(){
	for ( i = [0 : nbTrouVertical] ){
			for ( j = [1 : nbTrouPerimetre] ){
				rotate([0,TC,AngleDeRotTrouPerimetre*j])
				translate([RDTH+ZZ*0.55,0,((RCH*2+HVD)*i)-1]) 
				sphere(r =RCH,$fn = RH);
			}
	}
}
