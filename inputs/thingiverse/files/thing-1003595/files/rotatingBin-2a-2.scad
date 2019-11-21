// Released under the Creative Commons: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) license.
// http://creativecommons.org/licenses/by-sa/3.0/
// Attribution may be made by linking to:  http://www.thingiverse.com/thing:1003595

//Choose which part to render, or both at once (provides a combined file, plus the bin and wheel separately).
part="both"; // [wheel:Wheel Only,bin:Bin Only,both:Wheel and Bin]

//All measurements in mm unless otherwise indicated.  This is the diameter of the wheel that will hold the bins.  Limit it to a size that fits your bed.
maxDiameter=140;

//There is a central hub to which the bins lock.  This is the outer diameter of that hub.  
hubDiameter=35;

//5/16" allthread is 7.937 mm.  Set this to the diameter of your support rod.
rodDiameter=7.937;

//Wall height for each bin.  Also the central hub height.  Note, the bins will total 3 mm more than this due to the bottom catch which slots into the space between wheel spokes, but the top of the bin will line up even with the top of the hub.
binHeight=25;

//The central cylinder for the support rod can be higher than the bin level.  This will let the wheels provide their own spacing and support.  You can also use nuts to separate the wheels.  With nuts the wheels spin perfectly independently. To omit the post, set this to the binHeight.
rodPostHeight=50;

//Number of bins per wheel, each bin the same size.  If you set this to 1, it will fail.  If you want a lot of sectors, you will probably need a wider hub diameter to make the locking tab work correctly.  Also, when "both" parts are selected with a higher number of sectors, the openSCAD preview might fail, but it will still compile fine.
sectors=6;

//A portion of the bin may extend beyond the max diameter of the bin wheel giving the entire assembly the shape of a flower and providing extra space in the bins.  This will also give the bin a shape somewhat like a flower petal, hence the variable name.
petalProtrusion=10;

//PERCENTAGE measurement. The bin protrusion petal is defined by a cylinder with a radius equal to the distance between two points on the bin wall, both of which are equidistant from the center (this chord can range from "0%" (no petal), to 100% where it will be as long as the chord at the most distant position on the wheel circle.  At larger values, the bin front wall might not reach the height of the sidewalls, so check those corners. 
petalDiameter=40; //[0:100]

//The front wall of the bin can be notched for easy grip, or almost completely eliminated if you want a tray to just toss things in without much of a front wall.  That notch is cut with a cylinder laid on its side.  The larger the radius, the more the front can be cut away, but note that this is also controlled by the notch depth variable -- i.e, a very wide cylinder that only shaves off 1mm is not going to make a wide cut.
notchDiameter=40;

//When cutting the notch, this variable will define how deeply the cylinder defined above is plunged into the front of the bin.  The depth is measured from the top of the bin wall.  You could even make a hole by making the notch depth larger than the notch diameter.
notchDepth=10;

//This attempts to account for side ooze based on the nozzle diameter, but it can also be used more generally.  Setting this number lower will result in a tighter fit; setting it higher in a looser fit.
nozzleDiameter=0.5;


/* [Hidden] */
// preview[view:south, tilt:top]

$fn=100;

//account for top cap with a +6mm overall height and -2mm for a global Z height shift
rodPostHeightValue=rodPostHeight-4;

railLength=maxDiameter/2;
wheelRadius=railLength;
hubRadius=hubDiameter/2;
rodRadius=rodDiameter/2;
nozzleRadius=nozzleDiameter/2;
binInnerRadius=hubRadius+nozzleRadius+0.5;


sectorDegrees=360/sectors;

// the outer wall of a bin has a lenght of radius minus centeral hub.  At any position on that  
// length there is a cord that would be the diameter of a circle that mostly fits inside the bin.

heightOfChordPoint=27+(wheelRadius*petalDiameter/100);

// Now that we know which chord we want, we'll calculate it's length.
// chord formula:  chord=2*(radius)*sin(1/2*sectorDegrees)

smallCircleDiameter=2*heightOfChordPoint*sin(1/2*sectorDegrees);

// we'll use the diameter of the small circle as the radius for the petal so we can get a wider lens
// I know this variable assignment not necessary, but I have it here for my reference

petalRadius=smallCircleDiameter/2;

// To get the just a lens, we have to adjust the center with relationship to the outer diameter desired
// after adding the bin protrusion.

petalTranslateX=(wheelRadius+petalProtrusion)-petalRadius;

// http://mathworld.wolfram.com/CircularSegment.html
// s=binOuterArcLenght; R=maxDiameter/2; angle=sectorsDegrees, we want "a"
// a=2*R*sin(1/2*angle)

// this is the cord at the widest point of the bin on the line formed by the outside edge of the wheel.
wheelChord=2*wheelRadius*sin(1/2*sectorDegrees);

// we want to know the petalChord at position r, r=R-petalProtrusion where R is the radius of the petal circle.
// if the petalChord <= wheelChord, all is well, otherwise the side walls get extended and we don't know where to cut offset
// the sidewall chamfer. We can't just use the outside circular wheel trim because the the petal center is shifted relative to the wheel
// radius and the chamfer gets chopped at the wheel radius, which is too short because of the extended sidewalls of the bin which
// go beyond the wheel radius.
// We can use the regaular wheel trip if the petal chord is <= wheel chord at the outside edge, but must use a different one based on the 
// petal circle if the petal chord is > wheel chord.
// petalChord=2*petalRadius*sin(1/2*sectorDegrees);
// http://mathworld.wolfram.com/Circle-CircleIntersection.html
// d= X-position of petal center


petalCenterX=( pow(petalRadius,2)-pow(petalRadius,2)+pow(wheelRadius,2))/(2*petalTranslateX );

// this is the chord where the petal circle and the wheel circle intersect.
sharedChord=(1/petalTranslateX)*sqrt( (-petalTranslateX+petalRadius-wheelRadius)*(-petalTranslateX-petalRadius+wheelRadius)*(-petalTranslateX+petalRadius+wheelRadius)*(petalTranslateX+petalRadius+wheelRadius) );

finalAssembly();

module finalAssembly()
{
	if (part=="wheel")
	{
		if (sectors%2>0)
		{
			wheelAssemblyA();
		} else {
			wheelAssemblyB();
		}
		
	} else if (part=="bin")
	{
		rotate([0,0,90]) binAssembly();
		
	} else if (part=="both")
	{
		if (sectors%2>0)
		{
			wheelAssemblyA();
		} else {
			wheelAssemblyB();
		}
		rotate([0,0,90]) binAssembly();
	} else 
	{
		cylinder(r=10, h=10);
		echo ("==================================================================");
		echo ("Error -- you must choose to print one or the other parts, or both.");
		echo ("==================================================================");
	}
}

// --------------------------
// wheel part
	
module wheelAssemblyA() //for odd number of sectors, go all the way to 360
{
	difference()
	{
		union()
		{
			for (i=[-sectorDegrees/2:sectorDegrees:360+(sectorDegrees/2)])
			{
				rotate([0,0,i]) rail();
			}

			outerRing();
			innerRing();
		}	
		basicWheelCuts();
	}
}

module wheelAssemblyB() //for even number of sectors stop at (360-sectorDegrees) else you double up on one rail
{
	difference()
	{
		union()
		{
			for (i=[-sectorDegrees/2:sectorDegrees:360])
			{
				rotate([0,0,i]) rail();
			}

			outerRing();
			innerRing();
		}
		
		basicWheelCuts();
	}
}

module rail()
{
	color("red") 
	translate([-1,0,0]) union()
	{
		translate([-4,0,0]) cube(size=[10,railLength,2]);
		translate([0,0,0])  cube(size=[2,railLength-6.5,7]);
		
		difference()  //rail support
		{
			union()
			{
				//inside hub wall support
				translate([0,rodRadius,0]) cube(size=[2,(hubRadius-rodRadius),binHeight-4]);
				
				//block for curved support outside hub wall
				translate([0,hubRadius-1,0]) cube(size=[2,(wheelRadius-hubRadius-10),binHeight-4]);
			}
			
			translate([-1,hubRadius+binHeight-4,binHeight+7])
			union()
			{
				translate([0,0,0]) rotate([0,90,0]) cylinder(r=binHeight, h=4);
				color("blue") translate([0,-binHeight,0]) cube(size=[4,wheelRadius,wheelRadius]);
				color("pink") translate([0,0,-binHeight]) cube(size=[4,wheelRadius,wheelRadius]);
			}
		}
		
		difference()  //rounded rail end
		{
			translate([0,railLength-8,0]) rotate([0,90,0]) cylinder(r=8, h=2);
			translate([0,railLength-8,-10]) cylinder(r=10, h=10);
		}
	}
}



module outerRing()
{
	color("blue")
	difference()
	{
		translate([0,0,0])  cylinder(r=wheelRadius, h=2);
		translate([0,0,-1]) cylinder(r=wheelRadius-5, h=4);
	}
}	

module outerRingTrim()
{
	difference()
	{
		translate([0,0,-1]) cylinder(r=wheelRadius+petalProtrusion+10, h=10);
		translate([0,0,-2]) cylinder(r=wheelRadius, h=12);
	}	
}

module innerRing()
{

	union()
	{
		//Post cap flare out
		difference()
		{
			translate([0,0,rodPostHeightValue]) cylinder(r=rodRadius+4.5, h=5);
			translate([0,0,rodPostHeightValue]) rotate_extrude(convexity=10) translate([(rodDiameter+3.5),0,0]) circle(r=5); 
		}
		
		//friction reducing ring at top of post cap
		difference()
		{
			translate([0,0,rodPostHeightValue+5]) cylinder(r=rodRadius+4.5, h=1);
			translate([0,0,rodPostHeightValue+5]) cylinder(r=rodRadius+2.5, h=2);
		}
		
		cylinder(r=rodRadius+2.5, h=rodPostHeightValue); //central post wall
		
		//hub
		difference()
		{
			cylinder(r=hubRadius, h=binHeight+2);
			translate([0,0,-1]) cylinder(r=hubRadius-2, h=binHeight+4);
		}
	}
}

module hubNotches()
{
	rotate([0,0,sectorDegrees/2]) union()
	{
		translate([-(2.75+nozzleRadius),hubRadius-4.5,-0.1]) cube(size=[5.5+nozzleDiameter,(wheelRadius-hubRadius-5),8+nozzleRadius]);
		translate([0,hubRadius-4.5,-0.1]) cylinder(r=(5.5+nozzleDiameter)/2, h=2.2);
	}

}

module basicWheelCuts()
{
	union()
	{
		outerRingTrim();  // trim rail edges that stick out of outer ring
		translate([0,0,-1]) cylinder(r=rodRadius+nozzleRadius+0.1, h=rodPostHeightValue+20);  //central hole
		for (i=[0-(sectorDegrees/2):sectorDegrees:360+(sectorDegrees/2)])
		{
			rotate([0,0,i]) hubNotches();
		}
	}
}

// --------------------------
// bin part

module binAssembly()
{
	union()
	{
		chamferBin();
		difference()
		{
			binBasicShape();
			translate([0,0,2]) binBasicShapeCut();
		}
		
		translate([0,0,-1]) baseCatch();
		
		// locking tab to fit in ring notches
		color("pink") translate([hubRadius-4,-(4-nozzleRadius)/2,-1]) cube(size=[6,4-nozzleRadius,6]);
	}
}

module binBasicShape()
{
	difference()
	{
		union()
		{
			translate([0,0,2]) cylinder(r=wheelRadius, h=binHeight);
			translate([petalTranslateX,0,2]) cylinder(r=(petalRadius), h=binHeight);
		}
		
		union()
		{
			binCenterHole(0);
			binAngularTrim(0);
		}
	}
}

module binBasicShapeCut()
{
	union()
	{
		difference()
		{
			union()
			{
				translate([0,0,2]) cylinder(r=wheelRadius-1.5, h=binHeight);
				translate([petalTranslateX,0,2]) cylinder(r=petalRadius-1.5, h=binHeight);
			}
			
			union()
			{
				binCenterHole(1.5);
				binAngularTrim(1.5);
			}
		}

		binThumbNotch();
	}
}


module binCenterHole(adjustR)
{
	translate([0,0,-1]) cylinder(r=binInnerRadius+adjustR, h=binHeight+4);
}

module binAngularTrim(offset)
{
	// with center true, it is much easier to do the rotations, but the translate requirs undoing half of every dimension
	rotate([0,0,sectorDegrees/2])  translate([0,(wheelRadius)-1.5-offset,(binHeight/2)+2])	cube(size=[maxDiameter*2,maxDiameter,binHeight+2], center=true);
	rotate([0,0,-sectorDegrees/2]) translate([0,(-wheelRadius)+1.5+offset,(binHeight/2)+2])	cube(size=[maxDiameter*2,maxDiameter,binHeight+2], center=true);

}

module chamferBin()
{
	//rotate ([0,0,0]) //compensate for the difference in rotation between bin chamfers
	difference()
	{
		union()
		{
			//inside circular chamfer
			translate([0,0,3.5]) rotate_extrude(convexity=10) translate([binInnerRadius+1.5,0,0]) polygon([[0,0],[0,4],[4,0]]); 

			//outside circular chamfer

			difference()
			{
				translate([0,0,3.5]) rotate_extrude(convexity=10) translate([wheelRadius-1.5,0,2]) polygon([[0,0],[-4,0],[0,4]]);
				translate([petalTranslateX,0,0]) cylinder(r=petalRadius-1.5, h=binHeight);
			}
			
			difference()
			{
				translate([petalTranslateX,0,3.5]) rotate_extrude(convexity=10) translate([petalRadius-1.5,0,2]) polygon([[0,0],[-4,0],[0,4]]);
				translate([0,0,2]) cylinder(r=wheelRadius-1.5, h=binHeight);
			}
			
			intersection()
			{
				translate([0,0,3.5]) rotate_extrude(convexity=10) translate([wheelRadius-1.5,0,2]) polygon([[0,0],[-4,0],[0,4]]);
				translate([petalTranslateX,0,3.5]) rotate_extrude(convexity=10) translate([petalRadius-1.5,0,2]) polygon([[0,0],[-4,0],[0,4]]);
			}
			
			difference()
			{
				union()
				{
					//negative X strait chamfer with bin centered longitudinally on positive X axis
					color ("pink") rotate([0, 0, -sectorDegrees/2]) translate([binInnerRadius+1,-2,7.5]) rotate([0,90,0]) translate([0,5,0])  linear_extrude(height=wheelRadius-hubRadius+petalProtrusion) polygon([[0,0],[4,4],[4,0]]);
					
					//positive X strait chamfer with bin centered longitudinally on positive X axis
					color ("gray") rotate([0, 0, sectorDegrees/2])  translate([binInnerRadius+1,-2,7.5]) rotate([0,90,0]) translate([0,-5,0]) linear_extrude(height=wheelRadius-hubRadius+petalProtrusion) polygon([[4,0],[4,4],[0,4]]);
				}
				
				if (sharedChord<=wheelChord)
				{
					outerRingTrim();
				} else {
					petalOuterRingTrim();
				}
			}
		}
		
		union()
		{
			binAngularTrim(0);
			binCenterHole(0);
		}
	}
}

module petalOuterRingTrim()
{
	color("orange") rotate([0,0,90])  translate([0,-petalTranslateX,1.9]) 
	difference()
	{
		cylinder(r=(maxDiameter), h=8);
		union()
		{
			translate([0,0,-1]) cylinder(r=petalRadius, h=10);
			translate([-maxDiameter,0,-1]) cube([maxDiameter*2,maxDiameter,10]);
		}
	}
}

module binThumbNotch()
{
	difference()
	{
		color("pink") translate([hubRadius+10,0,binHeight+2+notchDiameter/2-notchDepth]) rotate([0,90,0]) cylinder(r=notchDiameter/2, h=maxDiameter);
		union()
		{
			cylinder(r=hubRadius+10, h=maxDiameter);
			binAngularTrim(1.5);
		}
	}
}

module baseCatch()
{
	color("purple")
	difference()
	{
		difference()
		{
			translate([0,0,0]) cylinder(r=wheelRadius-5.5-nozzleRadius, h=3);
			translate([0,0,-1]) cylinder(r=binInnerRadius, h=binHeight+5);
		}
		
		translate([0,0,-binHeight/2]) binAngularTrim(nozzleRadius+4.5);
	}
}
