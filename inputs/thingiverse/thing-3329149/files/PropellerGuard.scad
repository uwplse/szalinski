/* [Hidden] */
eps = 0.01;
bigSize = 1000;


// generic fillet
rFillet = 3.0/2;


/* [Motor Mount] */
radiusMotorMountScrew = 1.6;
screwHoleFlesh = 3.2;
distanceMotorMountHoles1 = 19.0;
distanceMotorMountHoles2 = 16.0;


/* [Propeller Guard] */
diameterPropeller = 229.0; //152.0; //229.0; //254.0;
nrOfSpokes = 3;
nrOfRibs = 1;
heightSpokeRib = 6.0;
widthSpokeRib = 4.0;
heightPropellerGuard = 40; //0.0; // 40.0;
thicknessPropellerGuard = 3.0;
anglePropellerGuard = 90.0;
clearancePropellerGuard = 10.0;
radiusPropellerGuardFillet = 8.0;
propellerGuardHoleFlesh = 2.0;




// handy variables
rMotorHolderOuter = (max(distanceMotorMountHoles1,distanceMotorMountHoles2)+2*screwHoleFlesh)/2;
rMotorHolderInner = (min(distanceMotorMountHoles1,distanceMotorMountHoles2)-2*screwHoleFlesh)/2;



function toRadians(prmDegrees) = PI/180*prmDegrees;

function toDegrees(prmRadians) = 180/PI*prmRadians;


module drawMotorMountScrewHole()
{
	cylinder(bigSize,radiusMotorMountScrew,radiusMotorMountScrew,true,$fn=50);
}


module drawFilletHole()
{
	cylinder(bigSize,rFillet,rFillet,true,$fn=50);
}


module drawMotorMountFancyHole()
{
	r = (distanceMotorMountHoles1+distanceMotorMountHoles2)/4;
	offsetY = rFillet;
	hull()
	{
		translate([r,-offsetY,0]) drawFilletHole();
		translate([r,offsetY,0]) drawFilletHole();
	}
}


module drawMotorMountHoles()
{
	offset1 = distanceMotorMountHoles1/2*cos(45);
	translate([-offset1,offset1,0]) drawMotorMountScrewHole();
	translate([offset1,-offset1,0]) drawMotorMountScrewHole();

	offset2 = distanceMotorMountHoles2/2*cos(45);
	translate([offset2,offset2,0]) drawMotorMountScrewHole();
	translate([-offset2,-offset2,0]) drawMotorMountScrewHole();

	cylinder(bigSize,rMotorHolderInner,rMotorHolderInner,true,$fn=50);
	for (angle=[0:90:270])
	{
		rotate([0,0,angle]) drawMotorMountFancyHole();
	}
}


module drawSpokeRibFillet(prmBottomFillets,prmTopFillets)
{
	rSpokeRibFillet = 0.4*widthSpokeRib/(sqrt(2)-1);
	w = 2*rSpokeRibFillet+widthSpokeRib;
	factor = 0.95;

	difference()
	{
		union()
		{
			if (prmBottomFillets)
			{
				translate([-w/2,-w/2,0]) cube([w/2,w,heightSpokeRib]);
			}
			if (prmTopFillets)
			{
				translate([0,-w/2,0]) cube([w/2,w,heightSpokeRib]);
			}
		}
		union()
		{
			if (prmBottomFillets)
			{
				translate([-w/2,w/2,-eps]) cylinder(heightSpokeRib+2*eps,rSpokeRibFillet,rSpokeRibFillet,$fn=50);	
				translate([-w/2,-w/2,-eps]) cylinder(heightSpokeRib+2*eps,rSpokeRibFillet,rSpokeRibFillet,$fn=50);	
			}

			if (prmTopFillets)
			{
				translate([factor*w/2,w/2,-eps]) hull() 
				{
					cylinder(heightSpokeRib+2*eps,rSpokeRibFillet,rSpokeRibFillet,$fn=50);	
					translate([2*rSpokeRibFillet,-rSpokeRibFillet,0]) cube([eps,2*rSpokeRibFillet,heightSpokeRib+2*eps]);
				}
				translate([factor*w/2,-w/2,-eps]) hull() 
				{
					cylinder(heightSpokeRib+2*eps,rSpokeRibFillet,rSpokeRibFillet,$fn=50);	
					translate([2*rSpokeRibFillet,-rSpokeRibFillet,0]) cube([eps,2*rSpokeRibFillet,heightSpokeRib+2*eps]);
				}
			}
		}						
	}	
}


module drawPropellerGuardFillet()
{
	difference()
	{
		union()
		{
			translate([0,0,-bigSize/2]) cube([2*radiusPropellerGuardFillet,2*radiusPropellerGuardFillet,bigSize]);
		}
		union()
		{
			translate([0,0,0]) cylinder(bigSize+2*eps,radiusPropellerGuardFillet,radiusPropellerGuardFillet,$fn=50,true);
		}						
	}
}


module drawPropellerGuardRib(prmRadius)
{
	rOuter = prmRadius+widthSpokeRib/2;
	rInner = prmRadius-widthSpokeRib/2;
	difference() 
	{
		union()
		{
			cylinder(heightSpokeRib,rOuter,rOuter,$fn=50);
		}
		union()
		{
			translate([0,0,-eps]) cylinder(heightSpokeRib+2*eps,rInner,rInner,$fn=50);
		}
	}
}


module drawPropellerGuard()
{
	usePropellerGuardFillet = heightPropellerGuard > heightSpokeRib+radiusPropellerGuardFillet;
	hPropellerGuard = usePropellerGuardFillet?heightPropellerGuard:heightSpokeRib;
	difference() 
	{
		union()
		{
			cylinder(heightSpokeRib,rMotorHolderOuter,rMotorHolderOuter,$fn=50);

			rInner = diameterPropeller/2+clearancePropellerGuard;
			rOuter = rInner+thicknessPropellerGuard;
			angle = 90-anglePropellerGuard/2;
			rFancyPreffered = 0.35*(hPropellerGuard-heightSpokeRib-propellerGuardHoleFlesh)/2;
			rFancy = (rFancyPreffered < 2.0)?0:rFancyPreffered;
			l = toRadians(anglePropellerGuard)*rInner;
			minDistance = widthSpokeRib;
			nrOfHoles = floor((l-minDistance)/(minDistance+2*rFancy));
			distance = (l-2*rFancy*nrOfHoles)/(1+nrOfHoles);
			startAngle = angle+toDegrees((distance+rFancy)/rInner);
			angleIncrement = toDegrees((distance+2*rFancy)/rInner);
			filletStartAngle = angle+toDegrees((radiusPropellerGuardFillet)/rInner);
			// spoke
			rSpoke = (rInner+rOuter)/2;
			l2 = toRadians(anglePropellerGuard)*rSpoke;
			spokeDistance = (l2-widthSpokeRib)/(nrOfSpokes-1);
			spokeStartAngle = angle+toDegrees((widthSpokeRib/2)/rSpoke);
			spokeAngleIncrement = toDegrees(spokeDistance/rSpoke);
			spokeStartAngleFillets = ((nrOfSpokes-1)*spokeAngleIncrement)/2;

			difference() 
			{
				union()
				{
					difference() 
					{
						union()
						{
							cylinder(hPropellerGuard,rOuter,rOuter,$fn=50);
						}
						union()
						{
							translate([0,0,-eps]) cylinder(hPropellerGuard+2*eps,rInner,rInner,$fn=50);
							for (nr=[1:1:nrOfHoles])
							{
								rotate([0,0,startAngle+angleIncrement*(nr-1)]) translate([0,0,heightSpokeRib+(hPropellerGuard-heightSpokeRib-propellerGuardHoleFlesh)/2]) rotate([-90,0,0]) cylinder(bigSize,rFancy,rFancy,$fn=50,true);
							}
							for (nr=[1:1:nrOfHoles-1])
							{
								rotate([0,0,startAngle+angleIncrement*(nr-1)+angleIncrement/2]) translate([0,0,hPropellerGuard-propellerGuardHoleFlesh-rFancy]) rotate([-90,0,0]) cylinder(bigSize,rFancy,rFancy,$fn=50,true);
								rotate([0,0,startAngle+angleIncrement*(nr-1)+angleIncrement/2]) translate([0,0,heightSpokeRib+rFancy]) rotate([-90,0,0]) cylinder(bigSize,rFancy,rFancy,$fn=50,true);
							}
							if (usePropellerGuardFillet)
							{
								translate([0,0,hPropellerGuard-radiusPropellerGuardFillet]) rotate([0,0,filletStartAngle]) rotate([-90,0,0]) rotate([0,0,-180]) drawPropellerGuardFillet();
								translate([0,0,hPropellerGuard-radiusPropellerGuardFillet]) rotate([0,0,180-filletStartAngle]) rotate([-90,0,0]) rotate([0,0,-90]) drawPropellerGuardFillet();
							}
						}
					}

					distRib = (rInner-rMotorHolderOuter)/(nrOfRibs+1);
					for (nr=[1:1:nrOfRibs])
					{
						rRib = rMotorHolderOuter+distRib*nr;
						drawPropellerGuardRib(rRib);
						for (s=[1:1:nrOfSpokes])
						{
							rotate([0,0,-spokeStartAngleFillets+spokeAngleIncrement*(s-1)]) translate([rRib,0,0]) drawSpokeRibFillet(true,true);
						}
					}

					for (s=[1:1:nrOfSpokes])
					{
						rotate([0,0,-spokeStartAngleFillets+spokeAngleIncrement*(s-1)]) translate([rMotorHolderOuter-widthSpokeRib/2,0,0]) drawSpokeRibFillet(false,true);
						rotate([0,0,-spokeStartAngleFillets+spokeAngleIncrement*(s-1)]) translate([rInner+widthSpokeRib/2,0,0]) drawSpokeRibFillet(true,false);
					}
				}
				union()
				{
					rotate([0,0,angle]) translate([-bigSize,-bigSize/2,-bigSize/2]) cube([bigSize,bigSize,bigSize]);
					rotate([0,0,-angle]) translate([-bigSize,-bigSize/2,-bigSize/2]) cube([bigSize,bigSize,bigSize]);
				}
			}


			difference() 
			{
				union()
				{
					for (nr=[1:1:nrOfSpokes])
					{
						rotate([0,0,-spokeStartAngle-spokeAngleIncrement*(nr-1)]) translate([-widthSpokeRib/2,0,0]) hull()
						{
							translate([0,rSpoke,0]) cube([widthSpokeRib,eps,heightSpokeRib]);
							cube([widthSpokeRib,eps,heightSpokeRib]);
						}
					}
				}
				union()
				{
					cylinder(heightSpokeRib,rMotorHolderOuter-eps,rMotorHolderOuter-eps,$fn=50);
				}
			}						
		}
		union()
		{
			rotate([0,0,90]) drawMotorMountHoles();
			translate([0,0,heightSpokeRib]) cylinder(bigSize,rMotorHolderOuter+eps,rMotorHolderOuter+eps,$fn=50);
		}
	}
}



// tests
//drawMotorMountHoles();
//drawPropellerGuardFillet();
//drawSpokeRibFillet(true,true);


// parts
drawPropellerGuard();




