//	Customizeable Shower Head
//	D. Scott Nettleton
//	Feb 5, 2013

// Diameter of the Shower Head (in inches)
headDiameter = 3.5;
headRadiusmm = headDiameter*12.7;
//Length of the Shower Head (in inches)
headLength = 3;
lengthmm = headLength*25.4;
// Smoother forms take longer to calculate
smoothness = 65; // [13:Low Poly, 65: Faceted, 101:Smooth, 151:Pristine]
// How many rows of jets should be created?
concentricCircles = 2; // [1:30]
// How many jets should be in each circle?
jetsPerRow = 10;	//	[1:30]
//	Select a Shape for the Water Nozzles
jetType = 0; //	[0:Standard,1:Spreader,2:Fan,3:Cross]
// How wide should the opening be for each jet? (in inches)
jetApertureDiameter = 0.0625;
jetApertureRadius = jetApertureDiameter*12.7;

translate([0,lengthmm/2,headRadiusmm])
rotate(a=-90,v=[1,0,0])
difference() {
	union() {
		intersection() {
			translate([0,0,-2]) cylinder(h=10.1275,r1=19,r2=19, $fn=smoothness);
			translate([-16.25,-16.25,-2]) cube(size=[32.5, 32.5, 10.12775]);
		}
		translate([0,0,-lengthmm-2]) cylinder(h=lengthmm, r1=headRadiusmm, r2=19, $fn=smoothness);
		difference() {
			union() {//	Cap
				difference() {
					translate([0,0,-lengthmm-2]) scale([1,1,0.25]) sphere(r=headRadiusmm, $fn=smoothness);
					cube(size=[headRadiusmm*2,headRadiusmm*2,lengthmm*2+3.8], center=true);
				}
				//	Jets go here
				for (i = [1:concentricCircles], j = [0:jetsPerRow-1]) {
						rotate(a=360*j/jetsPerRow+540*i/concentricCircles, v=[0,0,1])
						translate([i*(headRadiusmm-3)/(concentricCircles+1),0,-lengthmm-3.5-0.25*sqrt(headRadiusmm*headRadiusmm-(i*(headRadiusmm-3)/(concentricCircles+1))*(i*(headRadiusmm-3)/(concentricCircles+1)))]) {
							jetSpout();
						}
				}//	End for each jet
			}//End Cap union
			//	Jets go here
			for (i = [1:concentricCircles], j = [0:jetsPerRow-1]) {
					rotate(a=360*j/jetsPerRow+540*i/concentricCircles, v=[0,0,1])
					translate([i*(headRadiusmm-3)/(concentricCircles+1),0,-lengthmm-3.5-0.25*sqrt(headRadiusmm*headRadiusmm-(i*(headRadiusmm-3)/(concentricCircles+1))*(i*(headRadiusmm-3)/(concentricCircles+1)))]) {
						jetAperture();
					}
			}//	End for each jet
		}//	End Jets diff
	}//	End union
	union() {
		englishThreads(0.32, 0.379215, 0.389215, 0.057, 14, 1);
		translate([0,0,-lengthmm+23]) cylinder(h=lengthmm-18, r1=6.35, r2=6.35, $fn=smoothness);
		translate([0,0,-lengthmm+18]) cylinder(h=5.01, r1=nozzleWidth, r2=6.35, $fn=smoothness);
		translate([0,0,-lengthmm+15]) cylinder(h=3.01, r1=nozzleWidth, r2=nozzleWidth, $fn=smoothness);
		translate([0,0,-lengthmm-2]) cylinder(h=17, r1=headRadiusmm-3, r2=nozzleWidth, $fn=smoothness);
		difference() {
			translate([0,0,-lengthmm-2]) scale([1,1,0.2]) sphere(r=headRadiusmm-3, $fn=smoothness);
			cube(size=[headRadiusmm*2,headRadiusmm*2,lengthmm*2+3.799],center=true);
		}//End difference
	}//End union
}//	End Difference

module jetSpout() {
	if (jetType == 0) {
		standardJetSpout(jetApertureRadius, 5);
	}
	else if (jetType == 1) {
		spreaderJetSpout(jetApertureRadius, 5);
	}
	else if (jetType == 2) {
		scale([2,1,1]) standardJetSpout(jetApertureRadius,5);
	}
	else if (jetType == 3) {
		union() {
			scale([2,1,1]) standardJetSpout(jetApertureRadius,5);
			rotate(a=90,v=[0,0,1]) scale([2,1,1]) standardJetSpout(jetApertureRadius,5);
		}
	}
}

module jetAperture() {
	if (jetType == 0) {
		standardJetAperture(jetApertureRadius, 5);
	}
	else if (jetType == 1) {
		spreaderJetAperture(jetApertureRadius, 5);
	}
	else if (jetType == 2) {
		scale([4,1,1]) standardJetAperture(jetApertureRadius,5);
	}
	else if (jetType == 3) {
		union() {
			scale([4,1,1]) standardJetAperture(jetApertureRadius,5);
			rotate(a=90,v=[0,0,1]) scale([4,1,1]) standardJetAperture(jetApertureRadius,5);
		}
	}
}

module standardJetSpout(apertureRadius=0.6, height) {
	cylinder(h=height, r1=apertureRadius+0.75, r2=apertureRadius+1.5, $fn=12);
}

module standardJetAperture(apertureRadius=0.6, spoutHeight) {
	translate([0,0,-0.001]) cylinder(h=spoutHeight*1.3, r1=apertureRadius, r2=apertureRadius*2, $fn=12);
}

module spreaderJetSpout(apertureRadius, spoutHeight) {
	translate([0,0,spoutHeight/2])
	scale([apertureRadius*3,apertureRadius*3,spoutHeight/2]) sphere(r=1, $fn=12);
}

module spreaderJetAperture(apertureRadius, spoutHeight) {
	difference() {
		cylinder(h=spoutHeight*1.5, r1=apertureRadius*2, r2=apertureRadius*2, $fn=12);
		cylinder(h=spoutHeight*0.75, r1=apertureRadius, r2=apertureRadius, $fn=12);
		for (c = [0:2]) {
			rotate(a=360*c/3, v=[0,0,1])
				translate([apertureRadius*0.75, -apertureRadius/2,0])
					cube(size=[apertureRadius*2,apertureRadius,spoutHeight*0.75]);
		}
	}
}

module englishThreads(length, radius, radius2, threadDepth=0.25, tpi=14, leftRight=0) {
	mirror([leftRight,0,0]) {
		if (radius == radius2) {
			scale([25.4,25.4,25.4]) {
				linear_extrude(height=length, twist=360*length*tpi, $fn=30, center=false) {
					translate([threadDepth, 0, 0]) {
						circle(r=radius-threadDepth);
					}
				}//	End linear extrusion
			}//End scale
		}
		else {
			taperedExtrude(length*25.4, radius*25.4, radius2*25.4, threadDepth*25.4, 14/25.4);
		}
	}//	End mirror
}//	End module englishThreads

module taperedExtrude(height, radius, radius2, threadDepth, teethPerUnit, layerThickness=0.05) {
	union() {
		for (i= [0 : layerThickness : height]) {
			rotate(a=(i/height)*(360*height*teethPerUnit), v=[0,0,1]) translate([threadDepth,0,i]) cylinder(h=layerThickness+.00001, r1=(1-i/height)*radius+(i/height)*radius2-threadDepth, r2=(1-i/height)*radius+(i/height)*radius2-threadDepth, $fn=32);
		}
	}//	End union
}//End module taperedExtrude


nozzleWidth = 0.45*12.7;