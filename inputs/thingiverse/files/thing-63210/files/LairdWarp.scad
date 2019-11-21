use <utils/build_plate.scad>
use <MCAD/regular_shapes.scad>

/*

SpaceWarp-compatible 3D printed rollercoaster

inspired by http://www.angelfire.com/journal/scottmills/SpaceWarp/spacewarp.html

Parts to buy:
- 1/2 inch carbon steel balls: 1/2" Carbon Steel Balls http://www.amazon.com/gp/product/B004PX9KO0/

Optional:
- Support poles: steel rods 12" long, 5mm diameter
- Cross poles 3", 5", etc, 3mm diameter
- Rail of Spacewarp is 1/8th in nylon tubing = 3.175mm ("oil pressure guage tubing")

Changes from SpaceWarp:
- Optionally use 5mm printed cross-pieces. SpaceWarp uses 3mm steel bars
- Use 1.75 or 3mm filament instead of SpaceWarp rail
- Added some new designs (e.g. full circle clip

*/

$fn=32*1;

/* [Main] */

// Part
part = 1000; // [0:base, 1:cross tie, 2:vertical bar, 3:horizontal bar, 4:base clip, 5:B2B Clip, 6:Full Circle Tie, 7:Cross Bar, 8:Tee Bar, 9:loop, 10:loop end, 11:loop clip, 1000:assembled, 1001:loop assembled, 2000:Plate of clips, 2001:Plate of vertical bars, 2002:Loop Plate, 2003:Plate base and Clips]

/* Hidden from Customizer - 12:switch base, 13:switch arm, 14:lift spiral, 1002:lift assembled, 2004:lift plate */

// Diameter of ball (12.7 = half inch)
ballDiameter = 12.7;
// Diameter of filament used for rails
railDiameter = 1.8; //[1.8:1.75mm filament, 3:3mm filament, 3.125:SpaceWarp rail]
// Diameter of connectors
railDiameterB = 5; 
// Diameter of vertical bars
railDiameterV = 5;
// Track Diameter (5/8 in = 15.875, fits around 1/2 in balls nicely.)
trackDiameter = 15.875;
// Ears
ear = 1; //[0:No ears, 1:Ears]
// Gap between adjacent parts (to account for extra material, etc.)
gap = 0.3;

/* [Specific Parts] */

// Base: spacing between holes
gridSpacing = 21; // 7/8 inch is SpaceWarp
// Base: How many grid points on X axis
gridX = 3;
// Base: How many grid points on Y axis
gridY = 9;
// Base: how deep is the grid (in mm)?
gridH = 10;
// Cross Bar: Length (number of grid lengths)
barLen = 2; 
// Vertical Bar: Height
vBarHeight = 200;
// Vertical Bar: Bump Thickness
bumpHeight = 1;
// TooBar Cross Len (in grid lengths)
teeLen = 1;

/* [Clip Dimensions] */

// Clip closure, 0=closed loop, 0.01 
clearanceFactor = 0.1; //[0.01:Tight, 0.1:Medium, 0.2:Loose]
// Proportion of smaller gaps
smaller = 0.6;
// Thickness of cross pieces
crossHeight = 2;
// Length of support areas
supportHeight = 5;
// Thickness of support areas
supportThickness = 1;

/* [Build Plate] */

// How large to make "plates" of arranged parts, in X dimension
plateX = 200;
// and in Y dimension
plateY = 100;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/* Calculations */

bumpSpacing = supportHeight + bumpHeight + gap + gap;
echo("bump spacing", bumpSpacing);

g=0.02*1;

ballIRadius = ballDiameter/2;
ballRadius = ballIRadius + gap;
railIRadius = railDiameter/2;
railRadius = railIRadius + gap;
railIRadiusB = railDiameterB / 2;
railRadiusB = railIRadiusB + gap;
railIRadiusV = railDiameterV / 2;
railRadiusV = railIRadiusV + gap;
trackRadius = trackDiameter/2;
trackR=(trackRadius+ballRadius)/2;
trackOffset = ballRadius + railRadius;
blockWidth = trackR*1.5;

clearance = railRadius*clearanceFactor;
clearanceB = railRadiusB*clearanceFactor;

spiralHeight = 8*ballRadius;	// for lift spiral

// ADD:
// - Lift mechanism
// - Vertical 'pump' to lift balls

echo("part ",part);

// main
if (part==0) translate([gridSpacing*gridY/2,-gridSpacing*gridX/2]) rotate([0,0,90]) 
	base();
if (part==1) crossTie(1);
if (part==2) translate([-vBarHeight/2,0,0]) rotate([0,0,90]) verticalBarForPrinting(vBarHeight);
if (part==3) hArmClip(barLen);
if (part==4) baseClip();
if (part==5) B2BClip(barLen);
if (part==6) fullCircle(1);
if (part==7) crossBar(barLen);
if (part==8) teeBar(barLen, teeLen);
if (part==9) loop(2*ballRadius);	// loop
if (part==10) loopEnd();
if (part==11) loopClip();
if (part==12) switchBase();
if (part==13) switchArm();
if (part==14) liftSpiral();

if (part==1000) assembled(75);
if (part==1001) loopAssembled(2*ballRadius); // assembled ball loop
if (part==1002) liftAssembled();

if (part==2000) plateClips();
if (part==2001) plateVBars(vBarHeight);
if (part==2002) loopPlate(2*ballRadius);
if (part==2003) plateBase();
if (part==2004) liftPlated();

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

/* PLATES OF ARRANGED COMPONENtS */

module assembled(vbh) {
	rotate([0,0,-90]) translate([0,-gridSpacing*gridY/2,0]) union() {
		base();
		translate([-gridSpacing*gridX-gap,0,0]) base();
		translate([gridSpacing/2-railIRadiusV,gridSpacing/2-railIRadiusV,0]) 
			verticalBar(vbh);
		translate([gridSpacing*1.5-railIRadiusV,gridSpacing/2-railIRadiusV,0]) 
			verticalBar(vbh);
		translate([gridSpacing/2-railIRadiusV,gridSpacing*4.5-railIRadiusV,0]) 
			verticalBar(vbh);
		translate([gridSpacing*1.5-railIRadiusV,gridSpacing*4.5-railIRadiusV,0]) 
			verticalBar(vbh);	translate([gridSpacing/2,gridSpacing*1.5,0]) rotate([0,0,180]) baseClip();
		translate([gridSpacing/2,gridSpacing*1.5,gridH]) rotate([180,0,180]) baseClip();
		translate([gridSpacing/2,gridSpacing/2,gridH+2*bumpSpacing]) hArmClip(1);
		translate([gridSpacing*.85,gridSpacing/2,gridH+2*bumpSpacing+railRadiusB]) 
			rotate([90,0,90]) hArmClip(4);
		translate([gridSpacing*1.5,gridSpacing/2,gridH+3*bumpSpacing]) hArmClip(2);
		for (y=[gridSpacing:gridSpacing:gridSpacing*3]) 
			translate([gridSpacing*.85+railIRadiusB,y,2*trackR+gridH+2*bumpSpacing+railIRadiusB]) 
				rotate([90,90,0]) crossTie(1);
		
		translate([gridSpacing*.85+railIRadiusB,4*gridSpacing,2*trackR+gridH+2*bumpSpacing+railIRadiusB]) 
				rotate([90,90+45,0]) fullCircle(1);
	
		translate([gridSpacing/2,gridSpacing*4.5,gridH+2*bumpSpacing]) hArmClip(1);
		}
	}

module plateClips () {
	translate([-60,-50,0]) union() {
		for (y = [0:gridSpacing*.9:plateY]) {
			translate([0,y,0]) hArmClip(1,0);
			translate([gridSpacing+10,y,0]) hArmClip(2,0);
			translate([3*gridSpacing+20,y,0]) B2BClip(1,0);
			translate([4*gridSpacing+20,y,0]) crossTie(0);
			translate([5*gridSpacing+12,y,0]) crossTie(0);
			translate([6*gridSpacing+4,y,0]) crossTie(0);
			}
		translate([-gridSpacing*.3,gridSpacing*1.3,0]) rotate([0,0,-90]) crossBar(1);
		translate([-gridSpacing,2*gridSpacing,0]) rotate([0,0,90]) crossBar(2);
		}
	}

module plateVBars(vbh) {
	translate([-vBarHeight/2,-50,0]) 
		for (y = [0:gridSpacing:plateY]) {
			translate([0,y,0]) rotate([0,0,90]) verticalBarForPrinting(vbh);
			}
	}

module plateBase() {
	translate([gridSpacing*gridY/2,-gridSpacing*gridX/2]) rotate([0,0,90]) union() {
		base();
		for (y=[0:gridSpacing*2:gridSpacing*(gridY-2)])
			translate([-1*(railRadiusV+5),y+gridSpacing,0]) 
				rotate([0,0,90]) baseClip();
		}
	}

/* PARTS */

module base() {
	color("grey") difference() {
		cube([gridSpacing*gridX,gridSpacing*gridY,gridH]);
		for (x = [gridSpacing/2:gridSpacing:gridSpacing*gridX]) {
			for (y = [gridSpacing/2:gridSpacing:gridSpacing*gridY]) {
				translate([x,y,-g]) cylinder(r=railRadiusV,h=gridH+g+g);
				}
			}
		for (x = [gridSpacing/2:gridSpacing:gridSpacing*gridX]) {
			translate([x-railRadiusV,-g,-g]) cube([2*railRadiusV,gridSpacing*gridY+g+g,railRadiusV+g]);
			translate([x-railRadiusV,-g,gridH-railRadiusV-g]) cube([2*railRadiusV,gridSpacing*gridY+g+g,railRadiusV+g+g]);
			translate([x-railRadiusV,-g,0]) cube([railRadiusV*2,railRadiusV,gridH+g+g]);
			translate([x-railRadiusV,gridSpacing*gridY-railRadiusV,0]) cube([railRadiusV*2,railRadiusV+g,gridH+g+g]);
			}
		for (y = [gridSpacing/2:gridSpacing:gridSpacing*gridY]) {
			translate([-g,y-railRadiusV,-g]) cube([gridSpacing*gridX+g+g,2*railRadiusV,railRadiusV+g]);
			translate([-g,y-railRadiusV,gridH-railRadiusV]) cube([gridSpacing*gridX+g+g,2*railRadiusV,railRadiusV+g+g]);
			translate([-g,y-railRadiusV,0]) cube([railRadiusV,railRadiusV*2,gridH+g+g]);
			translate([gridSpacing*gridX-railRadiusV,y-railRadiusV,0]) cube([railRadiusV+g,railRadiusV*2,gridH+g+g]);
			}
		}
	}

// Clip is the shape of a clip. ClipCore is the inside, to be subtracted.
// Make a clip by difference() {clip(); clipCore()}.

module clip(h, r, rel) {
	cylinder(h=h, r=r+supportThickness);
	if (rel) translate([r*1.5,0,0]) cylinder(h=h, r=r*smaller+supportThickness);
	}
		

module clipCore(h, r, rel) {
	w = r+supportThickness;
	translate([0,0,-1]) {
		cylinder(h=h+2, r=r);
		if (rel) translate([r*1.5,0,0]) cylinder(h=h+2, r=r*smaller);
		translate([-2*w+supportThickness+clearance,-w,0]) cube([w,2*w,h+2]);
		}
	}

module fullCircle(pre) {
	//if (pre) #sphere(r=ballIRadius);
	color("red") difference() {
		union() {
			rotate([0,0,45]) translate([trackR*2,0,0.02]) rotate([0,0,180]) 
				translate([1.5*railRadiusB,0,0]) cylinder(h=crossHeight, r=4);
			difference() {
				cylinder(r=trackOffset+supportHeight, h=crossHeight);
				translate([0,0,-1]) cylinder(r=trackOffset+supportHeight-3, h=crossHeight+2);
				rotate([0,0,180]) translate([railRadius,railRadius,-1]) cube([2*trackR-railRadius,2*trackR-railRadius,supportHeight+2]);
				}
			for (a = [0:90:359]) {
				rotate ([0,0,a]) translate([trackOffset,0,0.02]) difference() {
					clip(supportHeight, railRadius, 1);
					}
				}
			intersection() {
				rotate([0,0,45]) translate([trackR*2,0,0.02]) rotate([0,0,180]) difference() {
					clip(supportHeight, railRadiusB, 1);
					}
				//cylinder(r=trackOffset+supportHeight-gap*2+railRadiusB*1.75, h=supportHeight);
				}
			}
		translate([0,0,-1]) cylinder(r=ballRadius+gap,h=supportHeight+2);
			for (a = [0:90:359]) {
				rotate ([0,0,a]) translate([trackOffset,0,0.02]) {
					clipCore(supportHeight, railRadius, 1);
					}
				}
			rotate([0,0,45]) translate([trackR*2,0,0.02]) rotate([0,0,180]) difference() {
				clipCore(supportHeight, railRadiusB, 1);
				}
		}
	}

module crossBar(l) {
	w = railRadiusB+2*supportThickness;
	translate([-l*gridSpacing,0,railIRadiusB]) rotate([0,90,0]) cylinder(r=railIRadiusB, h=l*gridSpacing*2);
	translate([-l*gridSpacing,0,0]) ear(5);
	translate([l*gridSpacing,0,0]) ear(5);
	rotate([0,0,90]) translate([-3*railRadiusB+supportThickness,0,0]) difference() {
			clip(supportHeight, railIRadiusB,1);
			clipCore(supportHeight, railIRadiusB,1);
			//translate([-3*railIRadiusB+supportThickness,-w,-1]) // not qute right
			//	cube([w, 2*w, supportHeight+2]);
			}
	}


// Cross Tie holds rails in place. Pre=1 shows preview stuff (ball, rails)
//
// TODO: use clip and clipCore in crossTie. Low priority.

module crossTie(pre) {
color("red") difference() {
	union() {
		intersection() {
			union() {
				rotate([0,0,-45]) {
					translate([trackOffset,0,g]) // left clip
						cylinder(h=supportHeight-.04, r=railRadius+supportThickness);
					translate([trackOffset+railRadius*1.5,0,g]) // left clip flex
						cylinder(h=supportHeight-g-g, r=railRadius*smaller+supportThickness);
					}
				rotate([0,0,45]) {
					translate([trackOffset,0,0.02]) // right clip
						cylinder(h=supportHeight-.04, r=railRadius+supportThickness);
					translate([trackOffset+railRadius*1.5,0,g]) // right clip flex
						cylinder(h=supportHeight-g-g, r=railRadius*smaller+supportThickness);
					}
				translate([trackR*2,0,0.02]) 
					cylinder(h=supportHeight-.04, r=railRadiusB+supportThickness);
				translate([trackR*2-railRadiusB*1.5,0,g]) 
					cylinder(h=supportHeight-g-g, r=railRadiusB*smaller+supportThickness);
				}
			cylinder(r=trackR*2+railRadiusB-clearanceB-gap, h=supportHeight);
			}
		intersection() {
			translate([0,-blockWidth/2,g]) 
				cube([trackRadius*2-railDiameter*1.26,blockWidth,crossHeight-2*g]);
			cylinder(r=trackR*1.2, h=supportHeight);
			}
		translate([trackR,-supportThickness,0]) cube([ballRadius,supportThickness*2,crossHeight]);
		}
	if (pre) #sphere(r=ballRadius);
	cylinder(h=supportHeight, r=ballRadius+clearance);
	rotate([0,0,-45]) { // left rail
		if (pre) {
			#translate([trackOffset,0,-gridSpacing/2]) cylinder(h=gridSpacing, r=railRadius);
			}
		else {
			translate([trackOffset,0,-gridSpacing/2]) cylinder(h=gridSpacing, r=railRadius);
			}
		translate([trackOffset+railRadius*1.5,0,0]) cylinder(h=supportHeight, r=railRadius*smaller);
		}
	rotate([0,0,45]) {	// right rail
		if (pre) {
			#translate([trackOffset,0,-gridSpacing/2]) cylinder(h=gridSpacing, r=railRadius);
			}
		else {
			translate([trackOffset,0,-gridSpacing/2]) cylinder(h=gridSpacing, r=railRadius);
			}
		translate([trackOffset+railRadius*1.5,0,0]) cylinder(h=supportHeight, r=railRadius*smaller);
		}
	translate([trackR*2,0,-supportHeight]) cylinder(h=3*supportHeight, r=railIRadiusB);
	translate([trackR*2-railRadiusB*1.4,0,-supportHeight]) 
		cylinder(h=3*supportHeight, r=railRadiusB*smaller);
	}
}

module verticalBar(vbh) {
	color("white") union() {
		translate([railIRadiusV,railIRadiusV,0]) 
			cylinder(r=railIRadiusV, h=vbh);
		//translate ([0,0,gridH-railRadiusV]) cube([2*railIRadiusV,2*railIRadiusV,vBarHeight]);
		for (z = [gridH+bumpSpacing:2*bumpSpacing:vbh-2*bumpSpacing]) {
			translate([0,0,z+supportHeight+gap]) cube([2*railIRadiusV,2*railIRadiusV,bumpHeight]);
			}
		translate([railIRadiusV,railIRadiusV,0]) cylinder(r=railIRadiusV,h=gridH-railRadiusV+gap+gap);
		translate ([-gridSpacing/2+railIRadiusV+gap,0,gridH-railRadiusV+gap]) 
			cube([gridSpacing-2*gap,2*railIRadiusV,railIRadiusV]);
		}
	}

module ear(s) {
	if (ear) cylinder(r=s, h=0.3);
	}

// Clip two bases together
module baseClip() {
	color("red") {
		cylinder(r=railIRadiusV,h=gridH/2-gap);
		translate([gridSpacing,0,0]) cylinder(r=railIRadiusV,h=gridH/2-gap);
		translate([0,-railIRadiusV+gap,0]) cube([gridSpacing,2*railIRadiusV-gap-gap,railRadiusV-gap]);
		}
	}

// clip onto vertical bar
module hArmClip(n, rel) {
	difference() {
		union() {
			translate([0,0,railIRadiusB]) rotate([0,90,0]) cylinder(r=railIRadiusB,h=n*gridSpacing);
			clip(gridH/2,railIRadiusV,rel);
			translate([n*gridSpacing,0,0]) rotate([0,0,180]) clip(gridH/2,railIRadiusV,rel);			}
		translate([0,0,-g]) clipCore(gridH/2,railIRadiusV,rel);
//(r=railIRadiusV,h=gridH/2+g+g);
		//translate([0,0,-g]) cylinder(r=railIRadiusV,h=gridH/2+g+g);
		translate([n*gridSpacing,0,-g]) rotate([0,0,180]) clipCore(gridH/2,railIRadiusV,rel);
		//translate([-(2*railIRadius)-railIRadiusV-gap+clearance,-(railIRadiusV+supportThickness),-g]) 
		//	cube([2*supportThickness,2*(railIRadiusV+supportThickness),gridH/2+g+g]);
		//#translate([n*gridSpacing+railIRadiusV-clearance,-(railRadiusV+supportThickness),-g]) 
		//	cube([2*supportThickness,2*(railRadiusV+supportThickness),gridH/2+g+g]);
		}
	}

module verticalBarForPrinting(vbh) {
	rotate([90,0,0]) verticalBar(vbh);
	translate([railIRadiusV,0,0]) ear(10);
	translate([railIRadiusV,-vbh,0]) ear(10);
	}

module B2BClip(n) {
	difference() {
		union() {
			translate([0,0,railIRadiusB]) rotate([0,90,0]) cylinder(r=railIRadiusB,h=n*gridSpacing);
			cylinder(r=railIRadiusB+supportThickness,h=gridH/2);
			translate([n*gridSpacing-gap,0,0]) ear(5);
			}
		translate([0,0,-g]) cylinder(r=railIRadiusB,h=gridH/2+g+g);
		translate([-2*supportThickness-railIRadiusB+clearance,-(railRadiusB+supportThickness),-g]) 
			cube([2*supportThickness,2*(railRadiusB+supportThickness),gridH/2+g+g]);
		}
	}

// T-bar. Useful for running curves around a vertical bar, by clipping Cross Ties to the ends of the T-Bar.

module teeBar(n, n2) {
	difference() {
		union() {
			translate([0,0,railIRadiusV]) rotate([0,90,0]) 
				cylinder(r=railIRadiusB,h=n*gridSpacing);
			cylinder(r=railIRadiusB+supportThickness,h=gridH/2);
			translate([n*gridSpacing-gap,n2*gridSpacing,0]) ear(5);
			translate([n*gridSpacing-gap,-n2*gridSpacing,0]) ear(5);
			translate([n*gridSpacing-gap,n2*gridSpacing,railIRadiusB]) rotate([90,0,0])
				cylinder(r=railIRadiusB, h=2*n2*gridSpacing);
			}
		translate([0,0,-g]) cylinder(r=railIRadiusV,h=gridH/2+g+g);
		translate([-2*supportThickness-railIRadiusB+clearance,-(railRadiusB+supportThickness),-g]) 
			cube([2*supportThickness,2*(railRadiusB+supportThickness),gridH/2+g+g]);
		}
	}

module loopEnd(pre) {
	translate([0,0,supportHeight/2]) 
		cylinder_tube(supportHeight, ballRadius+2*(gap+supportThickness), supportThickness, center = true);
	if (pre) {
		translate([0,0,supportHeight]) #crossTie(0);
		}
	translate([trackR*2,0,0]) cylinder(r=railIRadiusB, h=3*supportHeight);
	translate([ballRadius+gap+supportThickness+gap,-supportThickness,0]) 
		#cube([trackR*2-ballRadius-gap-railRadiusB, 2*supportThickness, supportHeight]);
	}

// 180 degree loop radius r

module loop(r) {
	echo(str("Loop radius ",r,"."));
	difference() {
		torus2(r,ballRadius+gap+supportThickness);
		torus2(r,ballRadius+gap);
		translate([-5*ballRadius-supportThickness-gap,0,-ballRadius-gap-supportThickness-1]) 
			cube([10*ballRadius+2*supportThickness+2*gap,6*ballRadius,2*(ballRadius+supportThickness+gap+2)]);
		}
	translate([r,supportHeight/2,0]) rotate([-90,0,0]) 
		cylinder_tube(supportHeight, ballRadius+gap+supportThickness, supportThickness, center = true);
	translate([-r,supportHeight/2,0]) rotate([-90,0,0]) 
		cylinder_tube(supportHeight, ballRadius+gap+supportThickness, supportThickness, center = true);
	}

module loopClip () {
	difference() {
		union() {
			clip(supportHeight, ballRadius+gap+supportThickness, 0);
			translate([1.5*ballRadius+gap+supportThickness,0,0]) rotate([0,0,180]) 
				clip(supportHeight, railIRadiusV, 0);
			}
		union() {
			clipCore(supportHeight, ballRadius+gap+supportThickness, 0);
			translate([1.5*ballRadius+gap+supportThickness,0,0]) rotate([0,0,180]) 
				clipCore(supportHeight, railIRadiusV, 0);
			}
		}
	}

// loop parts, plated

module loopAssembled(r) {
	color("blue") loop(r);
	translate([r,gap,0]) rotate([-90,0,0]) loopEnd(1);
	translate([-r,gap,0]) rotate([-90,0,0]) loopEnd(1);
	color("red") translate([supportHeight/2,-r,0]) rotate([90,0,-90]) loopClip();
	}

module loopPlate(r) {
	translate([0,0,supportHeight]) rotate([-90,0,0]) loop(r);
	translate([r,2*r,0]) loopEnd(0);
	translate([-r,2*r,0]) loopEnd(0);
	translate([0,4*r,0]) loopClip();
	}

module switchBase() {
	angle = 30; // should be a global parameter
	hangle = angle/2;
	d = ballRadius*sin(hangle);
	echo(str("sin ",sin(hangle)," cos ",cos(hangle)," tan ",tan(hangle)));
	translate([0,0,ballRadius+gap+supportThickness]) {
		difference() {
			union() {
				#sphere(ballIRadius);
				rotate([90,0,0]) rotate([0,0,360/16]) translate([0,0,d])
					octagon_tube(4*ballRadius, ballRadius+gap+supportThickness, supportThickness);
				rotate([0,0,180-angle]) rotate([90,0,0]) rotate([0,0,360/16]) 
					octagon_tube(4*ballRadius, ballRadius+gap+supportThickness, supportThickness);
				rotate([0,0,180+angle]) rotate([90,0,0]) rotate([0,0,360/16]) 
					octagon_tube(4*ballRadius, ballRadius+gap+supportThickness, supportThickness);
				}
			translate([-100,-100,0]) cube([200,200,ballRadius+gap+supportThickness+2]);
			}
		}
	}

/*

module liftSpiral() {
	translate([1.5*ballRadius,0,0*3.75*ballRadius]) #sphere(ballIRadius);
	linear_extrude(height = 100, center = false, convexity = 10, twist = 2*360) difference() {
		circle(r=ballRadius*1.5);
		translate([ballRadius*1.5,0,0]) scale([1,4,1]) circle(r=ballRadius+gap);
		translate([-ballRadius*1.5,0,0]) scale([1,2,1]) circle(r=ballRadius+gap);
		}
	}

module liftSpiral2() {
	translate([1.5*ballRadius,0,0*3.75*ballRadius]) #sphere(ballIRadius);
	linear_extrude(height = 100, center = false, convexity = 10, twist = 2*360) difference() 	{
		translate([ballRadius*2,0,0]) circle(r=ballRadius*2);
		translate([ballRadius*1.5,0,0]) scale([1,4,1]) circle(r=ballRadius+gap);
		}
	}
*/

module liftSpiral() {
	difference() {
		cylinder(r=ballRadius*2, h=spiralHeight);
		translate([0,0,-g]) linear_extrude(height = spiralHeight+2*g, center = false, convexity = 10, twist = 360) {
			translate([ballRadius*1.5,0,0]) scale([1,1.7,1]) circle(ballRadius+gap, $fn=16);
			translate([-ballRadius*1.5,0,0]) scale([1,1.7,1]) circle(ballRadius+gap, $fn=16);
			}
		translate([0,ballRadius,0]) sphere(railRadiusB);
		translate([0,-ballRadius,0]) sphere(railRadiusB);
		translate([0,0,0]) sphere(ballRadius/2-gap-supportThickness);
		}
	translate([0,ballRadius,spiralHeight]) sphere(railIRadiusB);
	translate([0,-ballRadius,spiralHeight]) sphere(railIRadiusB);
	translate([0,0,spiralHeight]) sphere(ballRadius/2-gap-supportThickness);
	}

// Make lift ramp h high

module liftRamp(h) {
	difference() {
		//translate([-ballRadius/2,1.5*ballRadius,0]) cube([ballRadius,2*ballRadius,0]);
		translate([1.5*ballRadius,0,0]) 
			union() {
				cylinder_tube(h, ballRadius+gap+supportThickness, supportThickness, false);
				translate([ballRadius*.2,-(ballRadius+gap+supportThickness),0]) cube([ballRadius,(ballRadius+gap+supportThickness)*2,h]);
				}
		translate([1.5*ballRadius,0,-1]) cylinder(r=ballRadius+gap, h=spiralHeight+2);
		translate([0,0,-1]) cylinder(r=ballRadius*2+gap, h=spiralHeight+2);
		translate([1.7*ballRadius-1,0,ballRadius+gap]) rotate([0,90,0]) 
			cylinder(r=ballRadius+gap, h=ballRadius+2);
		translate([1.7*ballRadius-1,0,ballRadius+gap+h/2]) rotate([0,90,0]) 
			cylinder(r=ballRadius+gap, h=ballRadius+2);
		}
	}

module liftBase() {
	cylinder(r=ballRadius*2, h=ballRadius);
	translate([0,0,ballRadius]) rotate([0,0,45]) {
		translate([0,ballRadius,0]) sphere(railRadiusB);
		translate([0,-ballRadius,0]) sphere(railRadiusB);
		translate([0,0,0]) sphere(ballRadius/2-gap-supportThickness);
		}
	translate([1.7*ballRadius,-(ballRadius+gap+supportThickness),0]) 
		cube([ballRadius,(ballRadius+gap+supportThickness)*2,ballRadius]);
	//liftRamp(ballRadius);
	}

module liftAssembled() {
	translate([0,0,-ballRadius-gap]) liftBase();
	//color("white") translate([1.5*ballRadius,0,ballRadius]) sphere(ballIRadius);
	rotate([0,0,45]) liftSpiral();
	translate([0,0,spiralHeight+gap]) rotate([0,0,45]) liftSpiral();
	liftRamp(spiralHeight);
	//translate([0,0,spiralHeight+gap]) liftRamp();
	}
