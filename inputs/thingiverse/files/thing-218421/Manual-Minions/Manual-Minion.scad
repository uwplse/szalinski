// minion

use <MCAD/regular_shapes.scad>;
use <write/Write.scad>;

// preview[view:south, tilt:side]

/* [Size and Shape] */
//Minion Name
minionName = "Your Name Here";
// Part to show
part = 0; //[0:One Piece Minion, 1:Front Piece, 2:Back Piece, 3:Base and Legs Piece, 6: Plated]
// Height of minion
bodyLen = 10; // [10:40]
// Radius of head (which controls body width, etc.)
radius = 25; // [25:75]

/* [Legs] */

// Left leg forward/back
legLF = 0; // [45:Forward, 0:Straight, -45:Back]
// Left leg lean
legLL = 0; // [-5:5]
// Right leg forward/back
legRF = 0; // [45:Forward, 0:Straight, -45:Back]
// Right leg lean
legRL = 0; // [-5:5]

/* [Goggles/Eyes] */

// How many eyes?
numEyes = 2; //[1:3]
// Open Top eyelid (degrees). 90 is wide open, 0 is shut.
openTop = 60; //[0:90]
// Open Bottom eyelid (degrees). 90 is wide open, 0 is shut.
openBottom = 90; //[0:90]
// Goggle spacing
goggleSpacing = 1.5; //[1.0:1.9]
// How low do the googles go?
goggleDown = 5; // [0:20]
// How thick is the rim of the goggles?
goggleRim = 5; // [1:10]
// How much bigger are goggles than eyes?
goggleBigger = 1; // [0:10]
// How thick is the goggle band?
goggleBandThickness = 2;
// How tall is the goggle band?
goggleBandHeight = 5; //[1:10]
// Look left/right
lookLR = 0; //[-45:45]
// Look up/down
lookUD = 0; //[-32:32]
// How deep are the goggles?
goggleLen = 1; //[1:20]

/* [Mouth] */

// Mouth open
mouthOpen = 5; //[0:10]
//What expression is the Minion making?
expression = 0; // [0:Smile, 1:Scream, 2:Sad]
//How wide is the mouth?
mouthHorizontalScaleF = 5; //[3:11
mouthHorizontalScale = mouthHorizontalScaleF/10;
//How tall is the mouth?
mouthVerticalScaleF = 5; //[3:11
mouthVerticalScale = mouthVerticalScaleF / 10;

/* [Hair] */

// Hair cut
hair_type = 0; //[0:None, 1:Tufts, 2:Star, 3:Mohawk]
// hair length
hairLength = 3; //[1:10]
// Hair thickness
hairRad = 2; //[2:4]
// Hair spacing X
hairSpacingX = 20; //[15:30]
// Hair spacing Y
hairSpacingY = 20; //[15:30]

/* [Arms] */
// Left arm angle
armAngleL = 170; // [10:170]
// Left elbow bend
armAngleL2 = -30; //[-90:0]
// Left arm up or down
armUp = 0; //[0:Up, 180:Down]
// Right arm angle
armAngleR = 90; // [10:170]
// Right elbow bend
armAngleR2 = -45; //[-90:0]
// Right arm up or down
armUp2 = 0; //[0:Up, 180:Down]

/* [Left Hand] */

// Left hand prop
LProp = 1; // [0:None, 1:Rocket, 2:Bomb]
// Scale left prop
LPropScale = 1; //[1:4]
// Rotate X
LPropRotX = 22; //[0:45]
// Rotate Y
LPropRotY = 22; //[0:45]

/* [Right Hand] */

// Right hand prop
RProp = 2; // [0:None, 1:Rocket, 2:Bomb]
// Scale right prop
RPropScale = 1; //[1:4]
// Rotate X
RPropRotX = 22; //[0:45]
// Rotate Y
RPropRotY = 22; //[0:45]

/* [Thicknesses] */
// Clothing thickness
cloth = 2;
// Base height
baseHeight = 10;
// Clearance between plugs and sockets
clearance = 1;

/* [Hidden] */

tongue = 0; // no tongue, too complex to explain to people

// Width of minion
radiusB = radius*1.1; // big butt

width=2*radius;
echo("width ",width);
echo("radius ",radius);

// Length of minion's legs
legLen = 5+bodyLen/5;
//echo("legLen",legLen);

realLeg = legLen+radiusB/2+4;

bodyHeight = bodyLen + 2*radius + legLen + baseHeight;
echo("bodyHeight",bodyHeight);

// Eyes

//echo("goggleRim",goggleRim);
// Spacing between eyes (if more than one)
eyeSpacing = (radius/numEyes)*goggleSpacing + goggleRim;
//echo("eyeSpacing",eyeSpacing);
// Eye radius
eyeSize = eyeSpacing/2-goggleBigger-goggleRim;
//echo("eyeSize",eyeSize);
// How big is the pupil?
pupil = eyeSize/2;
//echo("goggleBandHeight",goggleBandHeight);

//echo(str("OpenTop ",openTop," OpenBottom ",openBottom));

//echo(str("LookUD ",lookUD," LookLR ",lookLR));

// Mouth

// Arms

//echo("armAngles",armAngleL, armAngleR, armAngleL2, armAngleR2);
armRadius=radius/6;
//echo("arm radius ",armRadius);
beltHeight = 2*armRadius;
//echo("belt height ", beltHeight);
armLen = radius * 0.7;
armRad = radius/6;
forearmLen = armLen * 0.9;
forearmRad = armRad * 0.9;

$fn=32;

lowerCenterZ = legLen+radius;
//echo("lowerCenterZ",lowerCenterZ);
goggleSize = eyeSpacing/2;
//echo("goggleSize",goggleSize);
offset = (numEyes/2 - 0.5)*eyeSpacing;
//echo("offset",offset);
height=bodyHeight+radius*2+legLen;
//echo("height",height);
upperCenterZ = height-radius;
//echo("upperCenterZ",upperCenterZ);
gogglePos = upperCenterZ-goggleDown-lowerCenterZ;
//echo("gogglePos",gogglePos);
torso = bodyHeight*.3;
//echo("torso",torso);

//bodyLen=upperCenterZ-lowerCenterZ;
//echo("bodyLen",bodyLen);
// Belt position
beltHeight = bodyLen/3;
//echo("beltHeight",beltHeight);
// Arm position
armHeight = bodyLen*.25;
//echo("arm height ",armHeight);
// Mouth position
mouthHeight = torso+(gogglePos-eyeSize)/3;
//echo("mouthHeight",mouthHeight);

// hair

hairLen = radius*hairLength/25;

//hairLen = radius*rands(1,2,1,seed[22])[0]/5;

//echo("hairLen",hairLen);

// Hand Propos arrays, [0] is left hand, [1] is right hand

propNum = [LProp, RProp];
propScale = [LPropScale, RPropScale];
propRotX = [LPropRotX, RPropRotX];
propRotY = [LPropRotY,RPropRotY];

numProps = 2; // Increase as you add props
/*
//propNum = rands(-numProps,numProps+1,2,seed[26]); // what prop to draw in each hand
propScale = rands(1,4,2,seed[27]); // Scale by this to keep things interesting
propRotX = rands(0,45,2,seed[28]); // rotate X/Y to flop about wildly
propRotY = rands(0,45,2,seed[29]);
*/
propSubX = 45/2; // subtract from angle, so it's +/- 45 degrees in range
propSubY = 45/2;

echo("prop 0 ", propNum[0], propRotX[0], propRotY[0], propScale[0]);
echo("prop 1 ", propNum[1], propRotX[1], propRotY[1], propScale[1]);

// modules

module hemisphere(r) {
	difference() {
		sphere(r);
		translate([0,0,-r]) cylinder(r=r,h=r);
		}
	}

module finger(l,r) {
	linear_extrude(height = l, center = false, convexity = 10, twist = -180, $fn=8)
		translate([r/2, 0, 0]) circle(r = r, $fn=8);
	//cylinder(r=r,h=l);
	translate([-r/2,0,l]) sphere(r);
	}

//finger(10,2);

module hand(right) {
	color("black") {
		scale([1,1.5,1.5]) {
			sphere(radius/6);
			translate([0,0,-radius/6]) cylinder(r=radius/6+1,h=radius/6);
			}
		rotate([-30,0,0]) finger(radius/2,radius/8);
		finger(radius/2,radius/8);
		rotate([45,0,0]) finger(radius/2,radius/8);
		}
	translate([0,0,1.5*radius/6]) handProp(right);
	}

module foreArm(angle, right) {
	color("yellow") sphere(armRad);
	rotate([angle,0,0]) {
		color("yellow") cylinder(r=forearmRad, h=forearmLen);
		translate([0,0,forearmLen]) hand(right);
		}
	}

module arm(angle,angle2,right) {
	// shoulder
	color("yellow") sphere(armRad);
	// join into body
	color("yellow") rotate([90,0,0]) cylinder(r1=armRad, r2=radius/3, h=radius/4);
	// and draw arm
	rotate([angle,0,0]) {
		color("yellow") cylinder(r=armRad, h=armLen);
		translate([0,0,armLen]) foreArm(angle2, right);
		}
	}

module arms(angle) {
	// join arms into body
	rotate([90,0,0]) cylinder(r=radius/6,h-2*radius,center=true);
	translate([0,radius+armRadius,0]) {
		rotate([0,armUp,0]) mirror([1,0,0]) mirror([0,0,0]) arm(-armAngleL,-armAngleL2,0);
		}
	translate([0,-radius-armRadius,0]) {
		rotate([0,armUp2,0]) mirror([1,0,0]) mirror([0,1,0]) arm(-armAngleR,-armAngleR2,1);
		}
	}

// Clothes, drawn relative to lowerCenterZ.
module clothes() {
	// shoulder straps
	translate([0,0,torso*.7]) {
		difference() {
			union() { // straps
				rotate([30,0,0]) scale([1,1.2,1]) cylinder(r=radiusB+cloth,h=7);
				rotate([-30,0,0]) scale([1,1.2,1]) cylinder(r=radiusB+cloth,h=7);
				}
			rotate([180,0,0]) translate([0,0,-armHeight-armRadius]) cylinder(r=radiusB*1.5,h=torso+radiusB/2);
			}
		}
	scale([1,1,-.5]) hemisphere(radiusB+cloth);
	difference() {
		cylinder(r=radiusB+cloth,h=torso+2*armRadius);
		translate([0,0,armHeight+torso]) cube([8*armRadius,2*(radiusB+cloth),8*armRadius],center=true);
		}
	// ADD
	// pocket
	// logo
	}

module body() {
	difference() {
		union() {
			//echo(str("HEAD bodyLen ",bodyLen," radius ",radius));
			translate([0,0,upperCenterZ-lowerCenterZ]) {
				color("yellow") hemisphere(radius);
				color("black") rotate([0,0,-lookLR]) hair(hair_type);
				}
			color("yellow") cylinder(r1=radiusB,r2=radius,h=bodyHeight);
			color("yellow") scale([1,1,.5]) sphere(radius);
			}
		translate([0,0,mouthHeight]) rotate([0,0,-lookLR/2])
			scale([1,mouthVerticalScale,mouthHorizontalScale]) mouth(expression);
		}
	translate([0,0,mouthHeight]) rotate([0,0,-lookLR/2]) teeth();

	translate([0,0,gogglePos]) goggles();

	color("black") cylinder(r=radius*.8,h=upperCenterZ-lowerCenterZ);
	translate([0,0,torso+armRadius]) arms();
	color("blue") clothes();
	}

module eye(part=0) {
	// goggle cylinder
	if ((part==1)||(part==0)) {
		color("grey") cylinder(h=max(radius+2,radius+goggleLen+eyeSize/4), r=goggleSize+goggleRim/2, center = false);
		}
	// hole through cylinder
	if ((part==2)||(part==0)) cylinder(h=max(radius+2,radius+goggleLen+eyeSize/2+1), r=goggleSize-goggleRim/2, center = false);
	// eyeball, etc., in goggle
	if ((part==3)||(part==0)) {
		color("yellow") cylinder(r=goggleSize+.01,h=radius);
		translate([0,0,radius]) {
			scale([1,1,0.5]) {
				color("yellow") rotate([0,-openTop,0]) rotate([0,-90,0]) hemisphere(eyeSize+2);
				color("yellow") rotate([0,-openBottom,180]) rotate([0,-90,0]) hemisphere(eyeSize+2);
				}
			scale([1,1,0.5]) difference() {
				color("white") sphere(eyeSize);
				color("black") rotate([lookLR,lookUD,0]) translate([0,0,eyeSize]) cylinder(r=pupil,h=eyeSize,center=true);
				}
			}
		}
	}

module goggles() {
	//echo("offset",offset);
		rotate([0,0,-lookLR]) {
		color("grey") difference() {
			union() { // band and goggles
				cylinder(r=radius+goggleBandThickness, h=goggleBandHeight, center=true);
				for (eye=[0:numEyes-1]) {
					translate([0,-offset+eye*eyeSpacing,0]) rotate([0,90,0]) eye(1);
					}
				}
			for (eye=[0:numEyes-1]) { // minus holes in goggles
				translate([0,-offset+eye*eyeSpacing,0]) rotate([0,90,0]) eye(2);
				}
			}
		for (eye=[0:numEyes-1]) { // plus eyeballs
			translate([0,-offset+eye*eyeSpacing,0]) rotate([0,90,0]) eye(3);
			}

		//	translate([0,eyeSpacing,0]) rotate([0,90,0]) eye();
		//	mirror([0,1,0]) translate([0,eyeSpacing,0]) rotate([0,90,0]) eye();
		}
	}

module smile() {
	translate([0,0,radius*.4]) rotate([0,0,-lookLR/2]) rotate([0,-90,180]) difference() {
		cylinder(r=radius*.5,h=2*radius);
		translate([radius/2,0,-1]) cylinder(r=radius*.7, h=2*radius+2);
		}
	}

// subtract mouth from body
module mouth(expression) {
	//echo("LookLR ", lookLR);
	if (expression==0) {
		//echo("happy!", radius);
		smile();
		}
	if (expression==1) {
		//echo("scared!", radius/2, radius);
		rotate([0,90,0]) scale([.5,1,1]) cylinder(r=radius/2,h=2*radius);
		}
	if (expression==2) {
		translate([0,0,bodyHeight/10]) scale([1,1,-1]) smile();
		}
	}

// add teeth to body
module teeth() {
	color("white") difference() {
		union() {	// teeth are rings within the head
			translate([0,0,mouthOpen]) cylinder(r=(radiusB+radius)/2-4,h=30);
			rotate([180,0,0]) translate([0,0,mouthOpen]) cylinder(r=(radiusB+radius)/2-4,h=30);
			}
		for (a=[0:10:179]) { // minus grooves between teeth
			rotate([0,0,a]) cube([2*radiusB,0.5,60], center=true);
			}
		}
	// if ((mouthOpen>7)&&(rand>0)&&(expression!=2)) {
	// 	//echo("TONGUE!!!!");
	// 	color("red") rotate([0,0,-lookLR/2]) scale([1,mouthHorizontalScale,0.25*mouthVerticalScale]) rotate([0,90,0])
	// 		finger(radius+tongue, radius/4);
	// 	}
	}

module stubby() {
	//echo(str("stubby hair radius ",hairRad));
	for (x=[hairSpacingX/2:hairSpacingX:45]) {
		for (y=[-45:hairSpacingY:45]) {
			//assign (d=sqrt(x*x+y*y) {
				rotate([x,y-20,0])
					translate([0,0,radius-5]) finger(hairLen-hairLen*sqrt(x*x+y*y)/45,hairRad);
				//}
			}
		}
	}

module tworows() {
	//echo(str("stubby hair radius ",hairRad));
	for (y=[-45:hairSpacingY/2:45]) {
		rotate([hairSpacingX,y-20,0])
			translate([0,0,radius-5]) finger(hairLen*2-hairLen*2*sqrt(hairSpacingX*hairSpacingX+y*y)/45,hairRad);
		}
	}

module mohawk() {
	//echo(str("mohawk hair radius ",hairRad));
	for (y=[-45:hairSpacingY/8:45]) {
		rotate([0,y-20,0])
			translate([0,0,radius-5]) rotate([0,0,y]) finger(hairLen*4-hairLen*2*sqrt(hairSpacingX*hairSpacingX+y*y)/45,hairRad);
		}
	}

module starfish() {
	hr=5*hairRad;
	//echo(str("stubby hair radius ",hr));
	for (y=[-25:hairSpacingY:45]) {
		rotate([hairSpacingX,y,0])
			translate([0,0,radius-hr+hairRad]) rotate([0,90,0]) rotate([0,0,-90])
				hemicylinder(r=hr,h=hairRad);
		}
	}

module hemicylinder(r,h) {
	difference() {
		cylinder(r=r,h=h);
		translate([-r,0,-1]) cube([2*r,r,h+2]);
		}
	}

//hemicylinder(10,1);

// hair, relative to top of head
module hair(hair_type) {
	// ADD HAIR HERE
	if (hair_type==1) {
		stubby();
		mirror([0,1,0]) stubby();
		}
	if (hair_type==2) {
		tworows();
		mirror([0,1,0]) tworows();
		}
	if (hair_type==3) mohawk();
	if (hair_type==4) {
		starfish();
		mirror([0,1,0]) starfish();
		}
	}

// leg
module leg(forward) {
	//echo("realLeg",realLeg);
	cylinder(r1=radius/4,r2=radius/3, h=realLeg);
	scale([3,1,1]) translate([radius*.17,0,0])
		cylinder(r1=radius/4,r2=radius/8,h=realLeg/4);
	if (forward>40) {
		translate([0,0,realLeg/4]) rotate([180,forward,0])
			cylinder(r=radius/6, h=realLeg*sin(forward));
		}
	if (forward<-40) {
		translate([realLeg,0,-realLeg*sin(forward)/2]) rotate([180,forward,0])
			translate([-realLeg/3,0,-.2*realLeg]) scale([2,1.5,1]) cylinder(r2=radius/4,r1=radius/8, h=baseHeight);
		}
	}

module legPosition(forward, left, pins) {
	translate([0,0,lowerCenterZ]) rotate([left,-forward,0]) translate([0,0,-lowerCenterZ]) {
		leg(forward);
		if (pins==1) {
			//echo("PINS");
			translate([0,0,realLeg]) {
				rotate([0,forward,0]) translate([0,0,-radius/6]) cylinder(r=radius/6, h=radius/2);
				//sphere(r=radius/6);
				}
			}
		if (pins==2) {
			//echo("HOLES");
			translate([0,0,realLeg]) {
				rotate([0,forward,0]) translate([0,0,-radius/6]) cylinder(r=radius/6, h=radius/2);
				//sphere(r=radius/6+clearance);
				}
			}
		}
	}

// legs
// pins 0 means draw legs
// pins=1 means to draw just the pins

module legs(pins) {
	color("black") {
		translate([0,radius/2,0]) rotate([0,0,15]) legPosition(legLF,legLL, pins);
		translate([0,-radius/2,0]) rotate([0,0,-15]) legPosition(legRF, legRL, pins);
		}
	}

module plateLegs() {
	difference() {
		union() {
			base();
			color("grey") legs(1); // pins
			difference() {
				legs(0); // legs
				translate([0,0, lowerCenterZ]) rotate([0,lookUD,0]) {
					body();
					}
				}
			}
		translate([-50,-50,-baseHeight-40]) cube([100,100,40]);
		}
	}

pinLen = 5;

module legHoles() {
	translate([legLen*sin(legLF),radius/2,legLen+radiusB/2])
		cylinder(r=radius/6+clearance,h=pinLen*2+2*clearance,center=true);
	translate([legLen*sin(legRF),-radius/2,legLen+radiusB/2])
		cylinder(r=radius/6+clearance,h=pinLen*2+2*clearance,center=true);
}

module base() {
	color("yellow") translate([0,0,-baseHeight]) cylinder(r1=2*radius+baseHeight,r2=2*radius,h=baseHeight);
	color("black") translate([.75*width,0,-baseHeight]) scale([2,2,2.5*baseHeight+2]) rotate([0,0,90]) write(minionName,center=true);
	//color("black") translate([-.5*width,0,0]) rotate([0,0,-90]) scale([4,4,2]) write(str(MinionNumber),center=true);
	}

/////////////////////////////////////////////////////////////////////
/////////////////////////////// PROPS ///////////////////////////////
/////////////////////////////////////////////////////////////////////

module handProp(right=1) {
	pn = floor(propNum[right]);

	echo("hand prop", pn, right, propRotX[right], propRotY[right]);

	// add new props here. Important: after adding new props, increase the range of the
	// randomly generated propNum (above) to include the new prop.
	rotate([propRotX[right]-propSubX,propRotY[right]-propSubY,-90]) {
		if (pn==1) scale(propScale[right]) handRocket();
		if (pn==2) scale(propScale[right]) handBomb();
		}
	}

module handRocket() {
	rocketR = 10;
	rocketL = 40;
	color("grey") translate([10,0,0]) rotate([90,0,0]) {
		cylinder(r=rocketR,h=rocketL,center=true);
		translate([0,0,rocketL/2]) cylinder(r1=rocketR,h=rocketL/3);
		translate([0,0,-rocketL/2-rocketL/4]) cylinder(r1=rocketR,r2=rocketR/2,h=rocketL/4);
		}
	}

module handBomb() {
	rocketR = 10;
	rocketL = 40;
	color("grey") translate([10,0,0]) rotate([90,0,0]) {
		cylinder(r=rocketR,h=rocketL,center=true);
		translate([0,0,rocketL/2]) hemisphere(rocketR); // front end
		translate([0,0,rocketL/2+rocketR]) cylinder(r=rocketR/3, h=rocketL/20); // tip
		translate([0,0,-rocketL/2]) rotate([180,0,0]) hemisphere(rocketR); // back end
		translate([0,0,-rocketL*.75]) {
			difference() {
				union() {
					cube([2*rocketR,2,rocketL/2], center=true);
					rotate([0,0,90]) cube([2*rocketR,2,rocketL/2], center=true);
					}
				cylinder(r=rocketR/3, h=rocketL/2+1,center=true);
				}
			}
		}
	}

module minion() {

	//%color("black") translate([0,0,-75]) rotate([90,0,0]) scale([10,10,2]) write(str(MinionNumber),center=true);

	difference() {
		rotate([0,0,-90]) translate([0,0,baseHeight]) {
			translate([0,0, lowerCenterZ]) rotate([0,lookUD,0]) {
				body();
				}
			legs();
			base();
			}
		translate([0,0,-width/2]) cube([4*bodyHeight,4*bodyHeight,width],center=true);
		}
	}

module minionAssembled(chop) {
	difference() {
		translate([0,0,baseHeight]) {
			translate([0,0, lowerCenterZ+clearance]) rotate([0,lookUD,0]) {
				plateBody();
				}
			plateLegs();
			}
		if(chop) translate([0,-100,0]) cube([200,200,200]);
		}
	}

module plateBody() {
	difference() {
		body();
		translate([0,0, -(lowerCenterZ)]) rotate([0,lookUD,0]) legHoles();
		}
	}

module minionPlate() {
	difference() {
		union() {
			translate([0,-width*3,0])rotate([0,90]) plateBody();
			translate([0,width*3,0]) rotate([0,90]) rotate([0,0,180]) plateBody();
			}
		#translate([0,0,-width/2]) cube([3*bodyHeight,10*bodyHeight,width],center=true);
		}
	translate([0,0,baseHeight]) plateLegs();
	}

module minionPlate(t) {
	difference() {
		rotate([0,90,0]) rotate([0,0,t]) plateBody();
		translate([-bodyHeight,-2*bodyHeight,-6*radiusB]) cube([4*bodyHeight,4*bodyHeight,6*radiusB]);
		}
	}

module minionPlated() {
	spacing = 2*bodyHeight;
	translate([0,0,baseHeight]) plateLegs();
	translate([0,spacing,0]) minionPlate(0);
	translate([0,-spacing,0]) minionPlate(180);
	}

if (part==0) minion();
if (part==1) minionPlate(180);
if (part==2) minionPlate(0);
if (part==3) plateLegs();
if (part==4) plateBody();
if (part==5) minionAssembled(0);
if (part==6) minionPlated();
if (part==7) minionAssembled(1); // cross section

//eye(3);
//body();
//translate([0,0,gogglePos])
//goggles();
//hair(4);
//mouth(1);

//minionPlate();


