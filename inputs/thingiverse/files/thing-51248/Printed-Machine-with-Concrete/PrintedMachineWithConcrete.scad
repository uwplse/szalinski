// COPYRIGHT 2013 JESHUA LACOCK
// ALL RIGHTS RESERVED

//use <Thread_Library.scad>
use <MCAD/involute_gears.scad>

//Note: use *either* Combined Stand or Seperate Stands A and B; Assembly is for viewing only
part = "Gear_A"; // [Gear_A:Gear A Only,Gear_B:Gear B Only,Worm_Gear:Worm Gear Only,Motor_Stand:Motor Stand Only,Motor_Worm:Motor Worm Only,Combined_Stand_1:Combined Stand 1 Only,Combined_Stand_2:Combined Stand 2 Only,Stand_A:Separate A Stand Only,Stand_B:Separate B Stand Only,Bushing:Shaft Bushing Only,Concrete_Form:Concrete Form Only,Assembly:Show Complete Assembly]

//Ball Bearing Specs
bearingOutsideDiameter = 35.0;
bearingInsideDiameter = 15.0;
bearingWidth = 11.0;

//Choose hex for thing:53451 printed bearings
shaftType = "No"; //[No:Round,Yes:Hex (for Gear Bearing)]

motorShaftLength = 50;
motorShaftDiamter = 8;

motorStandThickness = 10;
motorStandHeight = 150;
motorStandBoltSpacing = 56.3;
motorStandBoltSlotsWidth = 6;
motorStandBoltSlotStartHeight = 60;
motorStandSlotHeight = 80;
//Minimum is 18
motorStandShaftWidth = 26;

concreteFormWidth = 170;
concreteFormLength = 150;
concreteFormHeight = 135;
concreteFormWallWidth = 3;

//Fit tolerance, note it is better to do light sanding than have a loose fit, the larger the number, the more lose the fit
fitBuffer = 0.1;

module privateVars() {
	//This simply hides the rest of the variables from Customizer
}

numberTeeth=50;
pitchRadius=40;
wormLength=20;
radius=10;
pitch=2*3.1415*pitchRadius/numberTeeth;
angle=360*$t;
offset=7.5;
axleLength = 140.0;
distance=radius+pitchRadius+0.0*pitch;
reductionFactor = 0.75;
lower = -20.0;
bushingWidth = 5.0;
bearingsSpacingWidth = 55.0;
shaftRadius = ((bearingInsideDiameter / 2));
fudge = 0.1;

interation = 0;

if (part == "Gear_A") {
	drawGear1();
} else if (part == "Gear_B") {
	drawGear2();
} else if (part == "Worm_Gear") {
	drawWorm();
} else if (part == "Combined_Stand_1") {
	drawCombinedStand1();
} else if (part == "Combined_Stand_2") {
	drawCombinedStand2();
} else if (part == "Stand_A") {
	drawStandA();
} else if (part == "Stand_B") {
	drawStandB();
} else if (part == "Motor_Stand") {
	drawMotorStand();
} else if (part == "Motor_Worm") {
	drawMotorWorm();
} else if (part == "Bushing") {
	drawBushing();
} else if (part == "Concrete_Form") {
	drawConcreteForm();
} else if (part == "Assembly") {
	drawAssembly();
}	

//

module worm() {
	trapezoidThread( 
		length=wormLength, 			// axial length of the threaded rod
		pitch=pitch,				 // axial distance from crest to crest
		pitchRadius=radius, 		// radial distance from center to mid-profile
		threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch
							// std value for Acme or metric lead screw is 0.5
		profileRatio=0.5,			 // ratio between the lengths of the raised part of the profile and the pitch
							// std value for Acme or metric lead screw is 0.5
		threadAngle=pitchRadius, 			// angle between the two faces of the thread
							// std value for Acme is 29 or for metric lead screw is 30
		RH=true, 				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
		clearance=0.1, 			// radial clearance, normalized to thread height
		backlash=0.1, 			// axial clearance, normalized to pitch
		stepsPerTurn=24 			// number of slices to create per turn
		);
}

module wormGear() {

	  rotate([0,0,offset-angle/numberTeeth])
		gear ( 
			number_of_teeth=numberTeeth,
			circular_pitch=360*pitchRadius/numberTeeth,
			pressure_angle=20,
			clearance = 0,
			gear_thickness=10,
			rim_thickness=10,
			rim_width=5,
			hub_thickness=0,
			hub_diameter=30,
			bore_diameter=0,
			circles=6,
			backlash=0.1,
			twist=-2,
			involute_facets=0,
			flat=false);
}


module keyedWorm(mirrored) {

	color("blue") {

		render() {		
			union() {
		
				translate([0,0,0]) {
				
					difference() {
						translate([0,0,-wormLength/2 + 0])
						rotate([0,0,180+angle])
							worm();

						translate([0,0,-(wormLength/2)-1]) {
							cylinder(h = wormLength+5, r=(shaftRadius*reductionFactor) + (fitBuffer * 4));
						}	
					}
				}
				
				translate([0,bearingInsideDiameter/3,1.62]) {
					cube(size = [10,2.5+fitBuffer,wormLength+3.2], center = true);
				}
			}
		}
	}	
}


module wormKey(mirrored) {
	render();
	difference() {
		translate([0,0,-(wormLength/2)+5]) {
			color("lightgreen")
			cylinder(h = wormLength+5, r=(shaftRadius*reductionFactor) - (fitBuffer * 3.1));
		}
		
		translate([0,bearingInsideDiameter/3,0]) {
				cube(size = [10,2.5 + (fitBuffer * 3.1),wormLength+18], center = true);
		}
	}
}


module bushing(width) {
   render() {
      difference() {
         cylinder(h = width, r=(bearingInsideDiameter/2) * 1.5, center = true );
         cylinder(h = width + 1, r=(bearingInsideDiameter/2)+fitBuffer, center = true );      
      }
   }
}


module solidBushing(width) {
    cylinder(h = width, r=(bearingInsideDiameter/2) * 1.5, center = true );
}


module bearing() {
   color("Silver") {
      cylinder(h = bearingWidth, r=(bearingOutsideDiameter/2)+fitBuffer );
   }
}


module bearingStand(height, merge, sideCenter = 100.0, mountWidth = 40, mountLength = 110) {

	cylinderRadius = (bearingOutsideDiameter/2) + 4.0;
	fillet = 5;
	basePlateThickness = 10;

	translate([0, (cylinderRadius + height/2) - fillet, 101.5]) {
		render();
		minkowski() {
			cube(size = [25-(fillet*2), height, bearingsSpacingWidth-(fillet*2)-2], center = true);
			rotate([90,0,0]) {
				cylinder(r=fillet,h=1);
			}
		}
	}

	translate([1,(fillet/2),104]) {
		render();
		minkowski() {
			cylinder(h = bearingsSpacingWidth - (fillet*2), r=cylinderRadius, center = true);

			translate([-(fillet/2),-(fillet/2),-(fillet/2)]) {
				sphere(fillet, $fn=10);
			}	
		}
	}

	if (! merge) {

		translate([0,(cylinderRadius + height + basePlateThickness/2) - fillet,sideCenter]) {
		
			render();
			minkowski() {
				cube(size = [mountWidth-(fillet*2),basePlateThickness,mountLength-(fillet*2)], center = true);
				rotate([90,0,0]) {
					cylinder(r=fillet,h=1);
				}
			}
		}
	}
}


module bearingStandFeet(height, sideCenter = 100.0, mountWidth = 40, mountLength = 110, height2, sideCenter2 = 100.0, mountWidth2 = 40, mountLength2 = 110) {

	cylinderRadius = (bearingOutsideDiameter/2) + 4.0;
	fillet = 5;
	basePlateThickness = 10;

	minkowski() {
		union() {
			translate([21.5,0,0]) {
				translate([0,(cylinderRadius + height + basePlateThickness/2) - fillet,sideCenter]) {
					cube(size = [mountWidth,basePlateThickness,mountLength], center = true);
				}
			}
			
			translate([-37,-50,24]) {
				rotate([0,90,0]) {
					translate([0,(cylinderRadius + height2 + basePlateThickness/2) - fillet,sideCenter2]) {
						cube(size = [mountWidth2,basePlateThickness,mountLength2], center = true);
					}
				}
			}
		}
	
		rotate([90,0,0]) {
			cylinder(r=fillet,h=1);
		}
	}
}


module shortStandHoles() {

	union() {
		translate([20,0,73.9]) {				
			bearing();
		}
	
		translate([20,0,73.9 + bearingsSpacingWidth - bearingWidth + 1]) {
			bearing();
		}
		
		translate([20,0,(axleLength - 80.1)]) {
			cylinder(h = axleLength - 30.1, r=shaftRadius+(fitBuffer * 6));
		}						
	}

}


module tallStandHoles() {

	translate([-37,-50,24]) {
		rotate([0,90,0]) {

			union() {
				translate([0,0,74]) {		    
					bearing();
				}
			
				translate([0,0,73.0 + bearingsSpacingWidth - bearingWidth + 1]) {			
					bearing();
				}
				
				translate([0,0,18.27]) {
					cylinder(h = axleLength -30.1, r=shaftRadius+(fitBuffer * 6));
				}
			}
		}
	}
}


module shortStand(merge) {

	color("Indigo") {					

		translate([21.5,0,0]) {
			bearingStand(32, merge, 104.5, 43, 123);
		}
	}
}


module tallStand(merge) {

	color("Purple") {
		translate([-37,-50,24]) {
			rotate([0,90,0]) {
				bearingStand(82, merge, 96, 38, 118);
			}
		}
	}
}


module drawStands(merge, drawShortStand = false, drawTallStand = false) {

	fillet = 5;

	union() {

		if (merge) {
	
			if ((drawShortStand) && (drawTallStand)) {
				render();
				difference() {
				
					render();
					
					union() {
						shortStand(merge);	
						tallStand(merge);
						bearingStandFeet(32, 104.5, 43, 123, 82, 96, 38, 118);
					}
				
					union() {
						shortStandHoles();
						tallStandHoles();
					}
				}
			}
		}
		else {
		
			if (drawShortStand) {
				color("Indigo") {
				
					render();
					difference() {
	
						shortStand(merge);
						shortStandHoles();
					}				
				}
			}
		
			if (drawTallStand) {
				color("Purple") {
				
					render();
					difference() {
						tallStand(merge);
						tallStandHoles();
					}
				}
			}
		}
	}
}


module bracket(d, size_)
{
  size = -(size_/2);
  union()
  {
    linear_extrude(height=d)
      polygon([[size,-size],[size,size],[-size,size],[size,-size]]);
  }
}

module motorStand(d, height_, slotSpacing_, slotWidth_, slotBaseHeight_, slotHeight_, footWidth, shaftWidth_, shaftHeight_)
{

	width_ = slotSpacing_ * 1.5;
	shaftHeight_ = (slotHeight_ * 0.75) + 5;
	
	scaleFactor = 3.54330708661417;

	width = (width_ * scaleFactor) / 2;
	slotWidth = slotWidth_ * scaleFactor;
	slotSpacing = ((slotSpacing_ / 2) * scaleFactor) + slotWidth/2;
	slotBaseHeight = (slotBaseHeight_ * scaleFactor);
	height = (height_ / 2) * scaleFactor;
	slotHeight =  slotHeight_ * scaleFactor;
	
	shaftWidth = (shaftWidth_ / 2) * scaleFactor;
	shaftHeight =  height - ((shaftHeight_ ) * scaleFactor);
	
	bracketHeight = slotBaseHeight_ - 5;

	union() {

		scale([25.4/90, -25.4/90, 1]) union()
		{
			difference()
			{
			   linear_extrude(height=d)
				 polygon([[width,height],[-width,height],[-width,-(height-17.71625)],[-(width - 0.359958),-(height-14.145999)],[-(width-1.392324),-(height-10.820566)],[-(width-3.025833),-(height-7.811218)],[-(width-5.163386),-(height-5.189219)],[-(width-7.811523),-(height-3.025833)],[-(width-10.820566),-(height-1.392324)],[-(width-14.145999),-(height-0.359958)],[-(width-15),-height],[-(width-16),-height],[-shaftWidth,-(height-0.359958)],[-(shaftWidth-3.325601),-(height-1.392324)],[-(shaftWidth-6.334971),-(height-3.025833)],[-(shaftWidth-8.95689),-(height-5.189219)],[-(shaftWidth-11.120137),-(height-7.811218)],[-(shaftWidth-12.753492),-(height-10.820566)],[-(shaftWidth-13.785733),-(height-14.145999)],[-(shaftWidth-14.14564),-(height-17.71625)],[-(shaftWidth-14.14564),-(shaftHeight+17.71625)],[-(shaftWidth-14.505601),-(shaftHeight+14.145999)],[-(shaftWidth-15.537984),-(shaftHeight+10.820566)],[-(shaftWidth-17.171538),-(shaftHeight+7.811218)],[-(shaftWidth-19.335015),-(shaftHeight+5.189219)],[-(shaftWidth-21.957163),-(shaftHeight+3.025833)],[-(shaftWidth-24.966734),-(shaftHeight+1.392324)],[-(shaftWidth-28.292476),-(shaftHeight+0.359958)],[-(shaftWidth-31.86314),-shaftHeight],[(shaftWidth-31.86314),-shaftHeight],[(shaftWidth-28.292889),-(shaftHeight+0.359958)],[(shaftWidth-24.967456),-(shaftHeight+1.392324)],[(shaftWidth-21.958108),-(shaftHeight+3.025833)],[(shaftWidth-19.336109),-(shaftHeight+5.189219)],[(shaftWidth-17.172723),-(shaftHeight+7.811218)],[(shaftWidth-15.539214),-(shaftHeight+10.820566)],[(shaftWidth-14.506848),-(shaftHeight+14.145999)],[(shaftWidth-14.14689),-(shaftHeight+17.71625)],[(shaftWidth-14.14689),-(height-17.71625)],[(shaftWidth-13.786983),-(height-14.145999)],[(shaftWidth-12.754742),-(height-10.820566)],[(shaftWidth-11.121387),-(height-7.811218)],[(shaftWidth-8.95814),-(height-5.189219)],[(shaftWidth-6.336221),-(height-3.025833)],[(shaftWidth-3.326851),-(height-1.392324)],[shaftWidth,-(height-0.359958)],[57.754375,-height],[(width-15),-height],[(width-14.145999),-(height-0.359958)],[(width-10.820566),-(height-1.392324)],[(width-7.811523),-(height-3.025833)],[(width-5.163386),-(height-5.189219)],[(width-3.025833),-(height-7.811218)],[(width-1.392324),-(height-10.820566)],[(width - 0.359958),-(height-14.145999)],[width,-(height-17.71625)],[width,height]]);
			   translate([0, 0, -fudge])
				 linear_extrude(height=d+2*fudge)
				   polygon([[slotSpacing,(height-slotBaseHeight)-slotHeight],[(slotSpacing-slotWidth),(height-slotBaseHeight)-slotHeight],[(slotSpacing-slotWidth),(height-slotBaseHeight)],[slotSpacing,(height-slotBaseHeight)],[slotSpacing,(height-slotBaseHeight)-slotHeight]]);
			   translate([0, 0, -fudge])
				 linear_extrude(height=d+2*fudge)
				   polygon([[-(slotSpacing-slotWidth),(height-slotBaseHeight)-slotHeight],[-slotSpacing,(height-slotBaseHeight)-slotHeight],[-slotSpacing,(height-slotBaseHeight)],[-(slotSpacing-slotWidth),(height-slotBaseHeight)],[-(slotSpacing-slotWidth),(height-slotBaseHeight)-slotHeight]]);
			}
		}
		
		translate([0, -(height_/2) + d/2, (d/2) + footWidth/2]) {
			cube(size = [width_,d,footWidth], center = true);
		}
		
		translate([d/2, -(height_/2) + d/2 + (bracketHeight/2), (d/2) + bracketHeight/2]) {
			rotate([0,-90,0]) {
				bracket(d, bracketHeight);
			}
		}
		
		translate([width_/2, -(height_/2) + d/2 + (bracketHeight/2), (d/2) + bracketHeight/2]) {
			rotate([0,-90,0]) {
				bracket(d, bracketHeight);
			}
		}
		
		translate([-((width_/2) - d), -(height_/2) + d/2 + (bracketHeight/2), (d/2) + bracketHeight/2]) {
			rotate([0,-90,0]) {
				bracket(d, bracketHeight);
			}
		}
	}
}


module set(interation, mirrored, doubleBearingMount = true, drawGear1 = false, drawGear2 = false, drawWorm1 = false, drawWorm2 = false, drawTallStand = false, drawShortStand = false, drawBearings = false, drawBushings = false, drawMotorStand = false, drawPlasterForm = false, combineStands = false) {

	if (interation != 0) {

		if (drawWorm1) {
			translate([0,0,5]) {
				keyedWorm(mirrored);
			}
		}
	}
	
	if (drawBearings) {
		translate([0,0,52.4]) {		    
			bearing();
		}
	}
	
	if (drawBearings) {
		translate([0,0,52.0 + bearingsSpacingWidth - bearingWidth + 1]) {			
			bearing();
		}
	}
	
	if (drawBushings) {
		translate([0,0,52.4 -(bushingWidth/2)])
		{
			bushing(bushingWidth);
		}
	}
	
	if (drawGear1) {
		color("green") {
			union() {
				translate([0,0,axleLength-20]) {
					wormGear();
				}
				translate([0,0,(axleLength - 1.6) - 20]) {
					solidBushing(20.5);
				}
			
				translate([0,0,18.27]) {
					if (shaftType == "Yes") {
						cylinder(h = axleLength -30.1, r=shaftRadius-(fitBuffer * 1.25),$fn=6);
					}
					else {
						cylinder(h = axleLength -30.1, r=shaftRadius-(fitBuffer * 1.25));					
					}
				}
			
				wormKey();
			}
		}
	}
		
	if (interation != 0) {
		if (drawGear2) {
			union() {
				color("orange") {
					translate([-5,-distance,7]) {
						rotate([0,90,0]) {							
							wormGear();
							
							color("Purple") {
								translate([0,0,-(0.2)]) {
								  solidBushing(20.3);
								}
							}
							
							translate([0,0,-(axleLength - 30.1)]) {
								if (shaftType == "Yes") {
									cylinder(h = axleLength - 30.1, r=shaftRadius-(fitBuffer * 1.25),$fn=6);
								}
								else {
									cylinder(h = axleLength - 30.1, r=shaftRadius-(fitBuffer * 1.25));								
								}
							}
							
							translate([0,0,-(axleLength - 16.3)]) {
								rotate([0,0,180]) {
									wormKey();
								}
							}
						
						}
					}
				}
			}
		}
	}
	
	translate([25.5,-distance,axleLength+5])
	rotate([0,90,180+angle]) {	
		color("blue") {
			if (drawWorm2) {
				translate([20,0,16.8]) {
					//worm();
					//wormKey();
				}			

			}
		}
		
		color("Blue") {
			if (drawWorm2) {
				translate([20,0,21.8]) {
					keyedWorm(mirrored);
			}
		}
			
		}
	
		if (drawBearings) {
			translate([20,0,73.9]) {				
				bearing();
			}
		}

		if (drawBearings) {		
			translate([20,0,73.9 + bearingsSpacingWidth - bearingWidth + 1]) {
				bearing();
			}
		}

		if (drawBushings) {		
			translate([20,0,73.9 -(bushingWidth/2)])
			{
				bushing(bushingWidth);
			}
		}
	
		if	(doubleBearingMount) {
			
			drawStands(combineStands, drawShortStand, drawTallStand);
		}
		else {
			drawStands(combineStands, drawShortStand, drawTallStand);
		}
		
	}
}


module doubleSet(firstSet, mirrored) {

	if (firstSet) {
	   set(0, mirrored, drawGear1 = true, drawGear2 = true, drawWorm1 = true, drawWorm2 = true, drawTallStand = true, drawShortStand = true, drawBearings = true, drawBushings = true, drawMotorStand = true, drawPlasterForm = true);
	}
	else {
	   set(1, mirrored, drawGear1 = true, drawGear2 = true, drawWorm1 = true, drawWorm2 = true, drawTallStand = true, drawShortStand = true, drawBearings = true, drawBushings = true, drawMotorStand = true, drawPlasterForm = true);
	}

	translate([-120,0,118]) {
		mirror([1,0,0]) {
			set(1, mirrored, drawGear1 = true, drawGear2 = true, drawWorm1 = true, drawWorm2 = true, drawTallStand = true, drawShortStand = true, drawBearings = true, drawBushings = true, drawMotorStand = true, drawPlasterForm = true);
		}
	}
}


module drawGear1() {
	rotate([0,180,0]) {
		set(1, mirrored, drawGear1 = true);
	}
}


module drawGear2() {
	rotate([0,90,0]) {
		set(1, mirrored, drawGear2 = true);
	}
}


module drawWorm() {
	rotate([0,180,0]) {
		set(1, mirrored, drawWorm1 = true);
	}
}

module drawBushing() {
	bushing(bushingWidth);
}

module drawCombinedStand1() {
	rotate([90,0,0]) {
		set(1, false, drawTallStand = true, drawShortStand = true, combineStands = true);
	}
}

module drawCombinedStand2() {
	rotate([90,0,0]) {
		mirror([0,0,1]) {
			set(1, false, drawTallStand = true, drawShortStand = true, combineStands = true);
		}
	}
}

module drawStandA() {
	rotate([90,0,0]) {
		set(1, false, drawTallStand = true, combineStands = false);
	}
}

module drawStandB() {
	rotate([90,0,0]) {
		set(1, false, drawShortStand = true, combineStands = false);
	}
}


module drawMotorStand() {
	color("Gray") {
		rotate([90,0,0]) {
		   motorStand(motorStandThickness, motorStandHeight, motorStandBoltSpacing, motorStandBoltSlotsWidth, motorStandBoltSlotStartHeight, motorStandSlotHeight, motorStandHeight/2, motorStandShaftWidth);
		}
	}
}

module drawMotorWorm() {

	difference() {

		union() {
			cylinder(h = motorShaftLength, r=shaftRadius);
			worm();
		}
		
		translate([0,0,(wormLength/2)]) {
			cylinder(h = motorShaftLength+(fudge * 2), r=(motorShaftDiamter/2)+(fitBuffer * 4));
		}
	}
}

module drawConcreteForm() {
	color("Darkgray") {
		difference() {
			cube(size = [concreteFormWidth, concreteFormLength, concreteFormHeight], center = true);
			cube(size = [concreteFormWidth-concreteFormWallWidth, concreteFormLength-concreteFormWallWidth, concreteFormHeight+(fudge*2)], center = true);
		}
	}
}

module drawMotor() {
	color("DarkSlateGray") {
		cylinder(h = motorStandBoltSpacing*1.25, r=(motorStandBoltSpacing * 1.5) / 2, center = true);
	}
	
	color("Silver") {
		translate([0,0,-20]) {
			cylinder(h = motorStandBoltSpacing*1.25, r=motorShaftDiamter / 2, center = true);
		}
	}
}

module drawAssembly() {

	setLength = 118;

	translate([14,110,9]) {
		drawConcreteForm();
	}

	translate([75,-(setLength * 4),15]) {
		drawMotorStand();
	}

	rotate([90,0,0]) {
		translate([75,50.25, ((setLength * 3) + 68)]) {
			rotate([0,-90,0]) {
				drawGear2();
			}
		}
	}
	
	rotate([90,0,0]) {
		translate([75,50.25, ((setLength * 3) + 66)]) {
			drawMotorWorm();
			
			translate([0,0,(motorStandBoltSpacing * 1.25)+27]) {
				drawMotor();
			}
		}
	}

	rotate([90,0,0]) {
	//	drawMotor();
	}

	translate([75,50,50]) {
	
		rotate([90,0,0]) {
		
			doubleSet(true, false);
		
			translate([0,0,setLength * 2]) {
				doubleSet(false, true);
			}
		}	
	}
}


////////////////////////////////  Thread_Library ////////////////////////////////
////////////////////  http://www.thingiverse.com/thing:8793  ////////////////////

module threadPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob, threadAngleTop, threadAngleBottom)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	polyPoints=[
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za ],
		[Xa+ radiusa*cos(+angleZ),		Ya+ radiusa*sin(+angleZ),		Za + radiusa*tipRatioa ],
		[Xa ,						Ya ,						Za+ radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa ,						Ya ,						Za ],
		[Xa ,						Ya ,						Za+ radiusa*sin(threadAngleBottom) ],
	
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb ],
		[Xb+ radiusb*cos(angleZ+twistZ),	Yb+ radiusb*sin(angleZ+twistZ),	Zb+ radiusb*tipRatiob ],
		[Xb ,						Yb ,						Zb+ radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb ,						Yb ,						Zb ],
		[Xb ,						Yb ,						Zb+ radiusb*sin(threadAngleBottom)] ];
	
	polyTriangles=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 4, 9, 3 ], [ 9, 8, 3 ], [ 3, 8, 2 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	
	polyhedron( polyPoints, polyTriangles );
}

module shaftPiece(Xa, Ya, Za, Xb, Yb, Zb, radiusa, radiusb, tipRatioa, tipRatiob, threadAngleTop, threadAngleBottom)
{	
	angleZ=atan2(Ya, Xa);
	twistZ=atan2(Yb, Xb)-atan2(Ya, Xa);

	threadAngleTop=15;
	threadAngleBottom=-15;

	shaftRatio=0.5;

	polyPoints1=[
		[Xa,						Ya,						Za + radiusa*sin(threadAngleBottom) ],
		[Xa,						Ya,						Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio,				Ya*shaftRatio ,				Za + radiusa*(tipRatioa+sin(threadAngleTop)) ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za ],
		[Xa*shaftRatio ,				Ya*shaftRatio ,				Za + radiusa*sin(threadAngleBottom) ],
	
		[Xb,						Yb,						Zb + radiusb*sin(threadAngleBottom) ],
		[Xb,						Yb,						Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*(tipRatiob+sin(threadAngleTop)) ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb ],
		[Xb*shaftRatio ,				Yb*shaftRatio ,				Zb + radiusb*sin(threadAngleBottom) ] ];
	
	polyTriangles1=[
		[ 0, 1, 6 ], [ 0, 6, 5 ], 					// tip of profile
		[ 1, 7, 6 ], [ 1, 2, 7 ], 					// upper side of profile
		[ 0, 5, 4 ], [ 4, 5, 9 ], 					// lower side of profile
		[ 3, 4, 9 ], [ 9, 8, 3 ], [ 2, 3, 8 ], [ 8, 7, 2 ], 	// back of profile
		[ 0, 4, 3 ], [ 0, 3, 2 ], [ 0, 2, 1 ], 			// a side of profile
		[ 5, 8, 9 ], [ 5, 7, 8 ], [ 5, 6, 7 ]  			// b side of profile
		 ];
	

	// this is the back of the raised part of the profile
	polyhedron( polyPoints1, polyTriangles1 );
}

module trapezoidThread(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{

	numberTurns=length/pitch;
		
	steps=stepsPerTurn*numberTurns;

	trapezoidRatio=				2*profileRatio*(1-backlash);

	function	threadAngleTop(i)=	threadAngle/2;
	function	threadAngleBottom(i)=	-threadAngle/2;

	function 	threadHeight(i)=		pitch*threadHeightToPitch;

	function	pitchRadius(i)=		pitchRadius;
	function	minorRadius(i)=		pitchRadius(i)-0.5*threadHeight(i);
	
	function 	X(i)=				minorRadius(i)*cos(i*360*numberTurns);
	function 	Y(i)=				minorRadius(i)*sin(i*360*numberTurns);
	function 	Z(i)=				pitch*numberTurns*i;

	function	tip(i)=			trapezoidRatio*(1-0.5*sin(threadAngleTop(i))+0.5*sin(threadAngleBottom(i)));

	// this is the threaded rod

	if (RH==true)
	translate([0,0,-threadHeight(0)*sin(threadAngleBottom(0))])
	for (i=[0:steps-1])
	{
		threadPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);

		shaftPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);
	}

	if (RH==false)
	translate([0,0,-threadHeight(0)*sin(threadAngleBottom(0))])
	mirror([0,1,0])
	for (i=[0:steps-1])
	{
		threadPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);

		shaftPiece(
			Xa=				X(i/steps),
			Ya=				Y(i/steps),
			Za=				Z(i/steps),
			Xb=				X((i+1)/steps),
			Yb=				Y((i+1)/steps), 
			Zb=				Z((i+1)/steps), 
			radiusa=			threadHeight(i/steps), 
			radiusb=			threadHeight((i+1)/steps),
			tipRatioa=			tip(i/steps),
			tipRatiob=			tip((i+1)/steps),
			threadAngleTop=		threadAngleTop(i), 
			threadAngleBottom=	threadAngleBottom(i)
			);
	}

	rotate([0,0,180/stepsPerTurn])
	cylinder(
		h=length+threadHeight(1)*(tip(1)+sin( threadAngleTop(1) )-1*sin( threadAngleBottom(1) ) ),
		r1=minorRadius(0)-clearance*threadHeight(0),
		r2=minorRadius(0)-clearance*threadHeight(0),
		$fn=stepsPerTurn
			);
}

module trapezoidThreadNegativeSpace(
	length=45,				// axial length of the threaded rod
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{

	translate([0,0,-countersunk*pitch])	
	cylinder(
		h=2*countersunk*pitch, 
		r2=pitchRadius+clearance*pitch+0.25*pitch,
		r1=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,
		$fn=24
			);

	translate([0,0,countersunk*pitch])	
	translate([0,0,-pitch])
	trapezoidThread(
		length=length+0.5*pitch, 				// axial length of the threaded rod 
		pitch=pitch, 					// axial distance from crest to crest
		pitchRadius=pitchRadius+clearance*pitch, 	// radial distance from center to mid-profile
		threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
									// std value for Acme or metric lead screw is 0.5
		profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
									// std value for Acme or metric lead screw is 0.5
		threadAngle=threadAngle,			// angle between the two faces of the thread
									// std value for Acme is 29 or for metric lead screw is 30
		RH=true, 						// true/false the thread winds clockwise looking along shaft
									// i.e.follows  Right Hand Rule
		clearance=0, 					// radial clearance, normalized to thread height
		backlash=-backlash, 				// axial clearance, normalized to pitch
		stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
			);	

	translate([0,0,length-countersunk*pitch])
	cylinder(
		h=2*countersunk*pitch, 
		r1=pitchRadius+clearance*pitch+0.25*pitch,
		r2=pitchRadius+clearance*pitch+0.25*pitch+2*countersunk*pitch,$fn=24,
		$fn=24
			);
}

module trapezoidNut(
	length=45,				// axial length of the threaded rod
	radius=25,				// outer radius of the nut
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,			// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,			// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,			// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{
	difference() 
	{
		cylinder(
			h=length,
			r1=radius, 
			r2=radius,
			$fn=6
				);
		
		trapezoidThreadNegativeSpace(
			length=length, 					// axial length of the threaded rod 
			pitch=pitch, 					// axial distance from crest to crest
			pitchRadius=pitchRadius, 			// radial distance from center to mid-profile
			threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
										// std value for Acme or metric lead screw is 0.5
			profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
										// std value for Acme or metric lead screw is 0.5
			threadAngle=threadAngle,			// angle between the two faces of the thread
										// std value for Acme is 29 or for metric lead screw is 30
			RH=true, 						// true/false the thread winds clockwise looking along shaft
										// i.e.follows  Right Hand Rule
			countersunk=countersunk,			// depth of 45 degree countersunk entries, normalized to pitch
			clearance=clearance, 				// radial clearance, normalized to thread height
			backlash=backlash, 				// axial clearance, normalized to pitch
			stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
				);	
	}
}

